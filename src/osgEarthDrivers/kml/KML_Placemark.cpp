/* -*-c++-*- */
/* osgEarth - Dynamic map generation toolkit for OpenSceneGraph
 * Copyright 2008-2012 Pelican Mapping
 * http://osgearth.org
 *
 * osgEarth is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */
#include "KML_Placemark"
#include "KML_Geometry"
#include "KML_Style"
#include "KMLNodeInfo"

#include "ClampObjectLocatorCallback.h"
#include "GLES2ShaderGenVisitor.h"

#include <osgEarthAnnotation/FeatureNode>
#include <osgEarthAnnotation/PlaceNode>
#include <osgEarthAnnotation/LabelNode>
#include <osgEarthAnnotation/ModelNode>
#include <osgEarthAnnotation/Decluttering>
#include <osgEarthAnnotation/LocalGeometryNode>

#include <osgEarthUtil/ObjectLocator>

#include <osg/Depth>
#include <osgDB/WriteFile>

#include <osg/Program>
#include <osg/Shader>

#include <sstream>

using namespace osgEarth_kml;
using namespace osgEarth::Features;
using namespace osgEarth::Annotation;

void 
KML_Placemark::build( const Config& conf, KMLContext& cx )
{
    Style masterStyle;

    if ( conf.hasValue("styleurl") )
    {
        // process a "stylesheet" style
        const Style* ref_style = cx._sheet->getStyle( conf.value("styleurl"), false );
        if ( ref_style )
            masterStyle = *ref_style;
    }
    else if ( conf.hasChild("style") )
    {
        // process an "inline" style
        KML_Style kmlStyle;
        kmlStyle.scan( conf.child("style"), cx );
        masterStyle = cx._activeStyle;
    }

    // parse the geometry. the placemark must have geometry to be valid. The 
    // geometry parse may optionally specify an altitude mode as well.
    KML_Geometry geometry;
    geometry.build(conf, cx, masterStyle);

    Geometry* allGeom = geometry._geom.get();
    if ( allGeom )
    {
        GeometryIterator giter( allGeom, false );
        while( giter.hasMore() )
        {
            Geometry* geom = giter.next();
            Style style = masterStyle;

            // KML's default altitude mode is clampToGround.
            AltitudeMode altMode = ALTMODE_RELATIVE;

            AltitudeSymbol* altSym = style.get<AltitudeSymbol>();
            if ( !altSym )
            {
                altSym = style.getOrCreate<AltitudeSymbol>();
                altSym->clamping() = AltitudeSymbol::CLAMP_RELATIVE_TO_TERRAIN;
            }
            else if ( !altSym->clamping().isSetTo(AltitudeSymbol::CLAMP_RELATIVE_TO_TERRAIN) )
            {
                altMode = ALTMODE_ABSOLUTE;
            }
            
            if ( geom && geom->getTotalPointCount() > 0 )
            {
                GeoPoint position(cx._srs.get(), geom->getBounds().center(), altMode);

                bool isPoly = geom->getComponentType() == Geometry::TYPE_POLYGON;
                bool isPoint = geom->getComponentType() == Geometry::TYPE_POINTSET;

                // check for symbols.
                ModelSymbol*    model = style.get<ModelSymbol>();
                IconSymbol*     icon  = style.get<IconSymbol>();
                TextSymbol*     text  = style.get<TextSymbol>();

                if ( !text && cx._options->defaultTextSymbol().valid() )
                    text = cx._options->defaultTextSymbol().get();

                // the annotation name:
                std::string name = conf.hasValue("name") ? conf.value("name") : "";
                if ( text && !name.empty() )
                {
                    text->content()->setLiteral( name );
                }

                AnnotationNode* featureNode = 0L;
                AnnotationNode* iconNode    = 0L;
                AnnotationNode* modelNode   = 0L;

                // one coordinate? It's a place marker or a label.
                if ( model || icon || text || geom->getTotalPointCount() == 1 )
                {
                    // load up the default icon if there we don't have one.
                    if ( !model && !icon )
                    {
                        icon = cx._options->defaultIconSymbol().get();
                        if ( icon )
                            style.add( icon );
                    }

                    // if there's a model, render that - models do NOT get labels.
                    if ( model )
                    {
			osg::Node* cnode = cx._options->entityCache->get(style.get<ModelSymbol>()->url()->eval());
			if(cnode == NULL){
				OE_WARN << "KML Cache " << " Model not found in cache. Loading..." << std::endl;
	                        ModelNode* node = new ModelNode( cx._mapNode, style, cx._dbOptions );
        	                node->setPosition( position );

				KMLNodeInfo* nodeInfo = new KMLNodeInfo(conf.value("id"), conf.value("id"), geom->getBounds().center(), conf.value("description"));

				osgEarth::Util::ObjectLocatorNode* locatorNode = new osgEarth::Util::ObjectLocatorNode(cx._mapNode->getMap(), nodeInfo);
				locatorNode->getLocator()->setPosition(geom->getBounds().center());
				locatorNode->addChild(node->_node.get());
				locatorNode->setUserData( nodeInfo );

				node->_node.get()->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
	
				osgUtil::GLES2ShaderGenVisitor* gles2ShaderGen = new osgUtil::GLES2ShaderGenVisitor();
				gles2ShaderGen->apply(*node->_node.get());
	
        	                if ( cx._options->modelScale() != 1.0f )
        	                {
        	                    float s = *cx._options->modelScale();
        	                    node->setScale( osg::Vec3f(s,s,s) );
        	                }
	
        	                if ( !cx._options->modelRotation()->zeroRotation() )
        	                {
        	                    node->setLocalRotation( *cx._options->modelRotation() );
        	                }
	
        	                modelNode = node;
				
				cx._options->entityCache->insert(style.get<ModelSymbol>()->url()->eval(), node->_node.get(), geom->getBounds().center());

				cx._groupStack.top().get()->setUserData( nodeInfo );
				cx._groupStack.top()->addChild( locatorNode );
			}
			else{
				if(!cx._options->entityCache->existsInPosition(style.get<ModelSymbol>()->url()->eval(), geom->getBounds().center())){
					OE_WARN << "KML Cache" << "Model found. Using instance in cache." << std::endl;
					KMLNodeInfo* nodeInfo = new KMLNodeInfo(conf.value("id"), conf.value("id"), geom->getBounds().center(), conf.value("description"));
					osgEarth::Util::ObjectLocatorNode* locatorNode = new osgEarth::Util::ObjectLocatorNode(cx._mapNode->getMap(), nodeInfo);
					locatorNode->getLocator()->setPosition(geom->getBounds().center());
					locatorNode->addChild(cnode);
					locatorNode->setUserData( nodeInfo );
	
					osgUtil::GLES2ShaderGenVisitor* gles2ShaderGen = new osgUtil::GLES2ShaderGenVisitor();
					gles2ShaderGen->apply(*cnode);
	
					cx._groupStack.top().get()->setUserData( nodeInfo );
					cx._groupStack.top()->addChild( locatorNode );
				}
				else{OE_NOTICE << "DEBUG: Already exists!" << std::endl;}
			}
                    }

                    else if ( !text && !name.empty() )
                    {
                        text = style.getOrCreate<TextSymbol>();
                        text->content()->setLiteral( name );
                    }

                    if ( icon )
                    {
                        iconNode = new PlaceNode( cx._mapNode, position, style, cx._dbOptions );
                    }

                    else if ( !model && text && !name.empty() )
                    {
                        // note: models do not get labels.
                        iconNode = new LabelNode( cx._mapNode, position, style );
                    }
                }

                // multiple coords? feature:
                if ( geom->getTotalPointCount() > 1 )
                {
                    ExtrusionSymbol* extruded = style.get<ExtrusionSymbol>();
                    AltitudeSymbol*  altitude = style.get<AltitudeSymbol>();

                    // Remove symbols that we have already processed so the geometry
                    // compiler doesn't get confused.
                    if ( model )
                        style.removeSymbol( model );
                    if ( icon )
                        style.removeSymbol( icon );
                    if ( text )
                        style.removeSymbol( text );

                    // analyze the data; if the Z coords are all 0.0, enable draping.
                    if ( /*isPoly &&*/ !extruded && altitude && altitude->clamping() != AltitudeSymbol::CLAMP_TO_TERRAIN )
                    {
                        bool zeroElev = true;
                        ConstGeometryIterator gi( geom, false );
                        while( zeroElev == true && gi.hasMore() )
                        {
                            const Geometry* g = gi.next();
                            for( Geometry::const_iterator ji = g->begin(); ji != g->end() && zeroElev == true; ++ji )
                            {
                                if ( !osg::equivalent(ji->z(), 0.0) )
                                    zeroElev = false;
                            }
                        }
                        if ( zeroElev )
                        {
                            altitude->clamping() = AltitudeSymbol::CLAMP_TO_TERRAIN;
                        }
                    }

                    // Make a feature node; drape if we're not extruding.
                    bool draped =
                        isPoly    && 
                        !extruded &&
                        (!altitude || altitude->clamping() == AltitudeSymbol::CLAMP_TO_TERRAIN);

                    // turn off the clamping if we're draping.
                    if ( draped && altitude )
                        altitude->clamping() = AltitudeSymbol::CLAMP_NONE;

                    GeometryCompilerOptions compilerOptions;

                    // Check for point-model substitution:
                    if ( style.has<ModelSymbol>() )
                    {
                        compilerOptions.instancing() = true;
                    }

                    Feature* feature = new Feature(geom, cx._srs.get(), style);
                    featureNode = new FeatureNode( cx._mapNode, feature, draped, compilerOptions );
                }


                // assemble the results:
                if ( (iconNode || modelNode) && featureNode )
                {
                    osg::Group* group = new osg::Group();
                    group->addChild( featureNode );
                    if ( iconNode )
                        group->addChild( iconNode );
                    if ( modelNode )
                        group->addChild( modelNode );

                    cx._groupStack.top()->addChild( group );

                    if ( iconNode && cx._options->declutter() == true )
                        Decluttering::setEnabled( iconNode->getOrCreateStateSet(), true );

                    if ( iconNode )
                        KML_Feature::build( conf, cx, iconNode );
                    if ( modelNode )
                        KML_Feature::build( conf, cx, modelNode );
                    if ( featureNode )
                        KML_Feature::build( conf, cx, featureNode );
                }

                else
                {
                    if ( iconNode )
                    {
                        if ( cx._options->iconAndLabelGroup().valid() )
                        {
                            cx._options->iconAndLabelGroup()->addChild( iconNode );
                        }
                        else
                        {
                            cx._groupStack.top()->addChild( iconNode );
                            if ( cx._options->declutter() == true )
                                Decluttering::setEnabled( iconNode->getOrCreateStateSet(), true );
                        }
                        KML_Feature::build( conf, cx, iconNode );
                    }
                    if ( modelNode )
                    {
                        cx._groupStack.top()->addChild( modelNode );
                        KML_Feature::build( conf, cx, modelNode );
                    }
                    if ( featureNode )
                    {
                        cx._groupStack.top()->addChild( featureNode );
                        KML_Feature::build( conf, cx, featureNode );
                    }
                }
            }
        }
    }
}
