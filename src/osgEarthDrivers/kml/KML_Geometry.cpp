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
#include "KML_Geometry"
#include "KML_Point"
#include "KML_LineString"
#include "KML_LinearRing"
#include "KML_Polygon"
#include "KML_MultiGeometry"
#include "KML_Model"
#include <osgEarth/StringUtils>
#include <osg/Geometry>
#include <osg/ShapeDrawable>
#include <osg/LineWidth>

#include "GLES2ShaderGenVisitor.h"
#include <osgEarthUtil/ObjectLocator>

using namespace osgEarth_kml;

void 
KML_Geometry::build( const Config& parentConf, KMLContext& cx, Style& style)
{
    const ConfigSet& children = parentConf.children();
    for( ConfigSet::const_iterator i = children.begin(); i != children.end(); ++i )
    {
        buildChild( *i, cx, style );
    }
}

void
KML_Geometry::buildChild( const Config& conf, KMLContext& cx, Style& style)
{
    if ( conf.key() == "point" )
    {
        KML_Point g;
        g.parseStyle(conf, cx, style);
        g.parseCoords(conf, cx);
        _geom = g._geom.get();
    }
    else if ( conf.key() == "linestring" )
    {
        KML_LineString g;
        g.parseStyle(conf, cx, style);
        g.parseCoords(conf, cx);
        _geom = g._geom.get();
    }
    else if ( conf.key() == "linearring" || conf.key() == "gx:latlonquad" )
    {
        KML_LinearRing g;
        g.parseStyle(conf, cx, style);
        g.parseCoords(conf, cx);
        _geom = g._geom.get();
    }
    else if ( conf.key() == "polygon" )
    {
        KML_Polygon g;
        g.parseStyle(conf, cx, style);
        g.parseCoords(conf, cx);
        _geom = g._geom.get();
    }
    else if ( conf.key() == "multigeometry" )
    {
        KML_MultiGeometry g;
        g.parseStyle(conf, cx, style);
        g.parseCoords(conf, cx);
        const ConfigSet& mgChildren = conf.children();
        
        for( ConfigSet::const_iterator i = mgChildren.begin(); i != mgChildren.end(); ++i )
        {
            const Config& mgChild = *i;
            Style subStyle = style;
            KML_Geometry subGeom;
            subGeom.parseStyle( mgChild, cx, subStyle );
            subGeom.buildChild( mgChild, cx, style );
            if ( subGeom._geom.valid() )
                dynamic_cast<MultiGeometry*>(g._geom.get())->getComponents().push_back( subGeom._geom.get() );
        }
        //g.parseCoords(conf.child("multigeometry"), cx);
        _geom = g._geom.get();
    }
    else if ( conf.key() == "model" )
    {
        KML_Model g;
        g.parseStyle(conf, cx, style);
        g.parseCoords(conf, cx);
        _geom = g._geom.get();
    }
}

void
KML_Geometry::parseCoords( const Config& conf, KMLContext& cx )
{
    const Config& coords = conf.child("coordinates");
    StringVector tuples;
	OE_WARN << "KML_GEOMETRY: COORDS: " << coords.value() << std::endl;
    StringTokenizer( coords.value(), tuples, " ", "", true, true );
	int n = 0;
	int c = 0;
	osg::Vec3d ini, fim;
		osg::ref_ptr<osg::Geometry> beam( new osg::Geometry); 
		osg::ref_ptr<osg::Vec3Array> points = new osg::Vec3Array;
    for( StringVector::const_iterator s=tuples.begin(); s != tuples.end(); ++s )
    {
	OE_WARN << "KML_GEOMETRY: TUPLES " << c << ": " << *s << std::endl;
        StringVector parts;
        StringTokenizer( *s, parts, ",", "", true, true );
        if ( parts.size() >= 2 )
        {
            osg::Vec3d point;
            point.x() = as<double>( parts[0], 0.0 );
            point.y() = as<double>( parts[1], 0.0 );
            if ( parts.size() >= 3 ) {
                point.z() = as<double>( parts[2], 0.0 );
            }
            _geom->push_back(point);

		osg::Vec3d p;
		cx._mapNode->getMap()->getSRS()->transformToWorld(point, p);
		points->push_back(p); c++;
	    
/**if(n==0){
		ini=point;
		n++;
	    }
	    else{
		fim=point;
		n = 0;		
		OE_WARN << "KML_Geometry: trying to make line" << std::endl;

		OE_WARN << "KML_Geometry: between points: " << ini.x() << " "  << ini.y() << " "  << ini.z() << ";" <<
						fim.x() << " " << fim.y() << " " << fim.z() << std::endl;

		osg::Vec3d pos1, pos2;
		cx._mapNode->getMap()->getSRS()->transformToWorld(ini, pos1);
		cx._mapNode->getMap()->getSRS()->transformToWorld(fim, pos2);

		OE_WARN << "KML_Geometry: in world " << cx._mapNode->getMap()->getSRS()->getName() << ": " << pos1.x() << " "  << pos1.y() << " " << pos1.z() << ";" <<
						pos2.x() << " " << pos2.y() << " " << pos2.z() << std::endl;*/

		//osgEarth::Util::ObjectLocatorNode* locatorNode = new osgEarth::Util::ObjectLocatorNode(cx._mapNode->getMap());
		//locatorNode->getLocator()->setPosition(ini);
		//locatorNode->addChild(geode.get());
	    //}
		
        }
    }
		osg::ref_ptr<osg::Vec4Array> color = new osg::Vec4Array; 
		color->push_back(osg::Vec4(0.0,0.0,0.0,1.0)); 
		beam->setVertexArray(points.get()); 
		beam->setColorArray(color.get()); 
		beam->setColorBinding(osg::Geometry::BIND_OVERALL);
		beam->addPrimitiveSet(new osg::DrawArrays(GL_LINE_STRIP,0,c));
		
		osg::StateSet* stateset = new osg::StateSet;
		osg::LineWidth* linewidth = new osg::LineWidth();
		linewidth->setWidth(2.0f);
		stateset->setAttributeAndModes(linewidth,osg::StateAttribute::ON);
		stateset->setMode(GL_LIGHTING,osg::StateAttribute::OFF);
		beam->setStateSet(stateset);

		osg::ref_ptr<osg::Geode> geode = new osg::Geode;
		geode->addDrawable(beam.get());

		osgUtil::GLES2ShaderGenVisitor* gles2ShaderGen = new osgUtil::GLES2ShaderGenVisitor();
		gles2ShaderGen->apply(*geode.get());
		cx._mapNode->addChild(geode.get());
}

void
KML_Geometry::parseStyle( const Config& conf, KMLContext& cx, Style& style )
{
    _extrude = conf.value("extrude") == "1";
    _tessellate = conf.value("tessellate") == "1";

    std::string am = conf.value("altitudemode");

    // clampToGround is the default. We will be draping the geometry UNLESS tessellate is
    // set to true.
    if ( (am.empty() || am == "clampToGround") && _tessellate )
    {
        AltitudeSymbol* af = style.getOrCreate<AltitudeSymbol>();
        af->clamping() = AltitudeSymbol::CLAMP_TO_TERRAIN;
        _extrude = false;
    }

    // "relativeToGround" means the coordinates' Z values are relative to the Z of the
    // terrain at that point. NOTE: GE flattens rooftops in this mode when extrude=1,
    // which seems wrong..
    else if ( am == "relativeToGround" )
    {
        AltitudeSymbol* af = style.getOrCreate<AltitudeSymbol>();
        af->clamping() = AltitudeSymbol::CLAMP_RELATIVE_TO_TERRAIN;
    }

    // "absolute" means to treat the Z values as-is
    else if ( am == "absolute" )
    {
        AltitudeSymbol* af = style.getOrCreate<AltitudeSymbol>();
        af->clamping() = AltitudeSymbol::CLAMP_ABSOLUTE;
    }

    if ( _extrude )
    {
        ExtrusionSymbol* es = style.getOrCreate<ExtrusionSymbol>();
        es->flatten() = false;
    }
}
