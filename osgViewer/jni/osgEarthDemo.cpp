//
//  osgEarthDemo.cpp
//  osgearthDemos
//

#include "DemoScene.h"
#include "GLES2ShaderGenVisitor.h"

#include <osgEarthUtil/AnnotationEvents>
#include <osgEarthUtil/AutoClipPlaneHandler>

#include <osgEarthAnnotation/AnnotationEditing>
#include <osgEarthAnnotation/AnnotationRegistry>
#include <osgEarthAnnotation/ImageOverlay>
#include <osgEarthAnnotation/ImageOverlayEditor>
#include <osgEarthAnnotation/CircleNode>
#include <osgEarthAnnotation/RectangleNode>
#include <osgEarthAnnotation/EllipseNode>
#include <osgEarthAnnotation/PlaceNode>
#include <osgEarthAnnotation/LabelNode>
#include <osgEarthAnnotation/LocalGeometryNode>
#include <osgEarthAnnotation/FeatureNode>
#include <osgEarthAnnotation/Decluttering>
#include <osgEarthAnnotation/HighlightDecoration>
#include <osgEarthAnnotation/ScaleDecoration>

#include <osgEarthSymbology/GeometryFactory>

#include <osgEarth/TerrainEngineNode>
#include <osgEarth/TerrainOptions>

#include <osgEarthDrivers/wms/SceneGraphChanges>

#include <osgEarth/Notify>

#include <osgUtil/Optimizer>

#include <osgEarth/EntityCache>
#include <osgViewer/ViewerEventHandlers>

#include "PickHandler.h"
#include "OsgMainApp.hpp"
#include "SceneGraphChangeCallback.hpp"

using namespace osgEarth;
using namespace osgEarth::Annotation;
using namespace osgEarth::Features;
using namespace osgEarth::Util;

osgEarth::Util::MapNode* DemoScene::getMapNode(){
	return _mapNode.get();
}

void DemoScene::initDemo(const std::string &file)
{
    OSG_ALWAYS << "----osgEarthDemo----" << std::endl;

    _viewer->setCameraManipulator(  new osgEarth::Util::EarthManipulator() );//new osgEarth::Util::EarthMultiTouchManipulator() );

    Map* map = new Map();
    _mapNode = new MapNode( map );
    setBaseLayerTMS("http://readymap.org/readymap/tiles/1.0.0/7/");

    _manip = dynamic_cast<osgEarth::Util::EarthManipulator*>(_viewer->getCameraManipulator());
    if ( _manip == 0L )
    {
        OSG_ALWAYS << "Helper used before installing an EarthManipulator" << std::endl;
    }

    _root = new osg::Group();
    _root->setThreadSafeRefUnref(true);

    osgUtil::Optimizer optimizer;

    EntityCache* entityCache = new EntityCache();
    _kml_options = new osgEarth::Drivers::KMLOptions();
    _kml_options->declutter() = true;
    _kml_options->entityCache = entityCache;

    _changesQueue = new SceneGraphChanges();
    SceneGraphChangeCallback* chcb = new SceneGraphChangeCallback();
    _root->setUserData( _changesQueue );
    _root->setUpdateCallback(chcb);

    osgUtil::GLES2ShaderGenVisitor* gles2ShaderGen = new osgUtil::GLES2ShaderGenVisitor();

    osg::Light* light = new osg::Light( 0 );
    light->setPosition( osg::Vec4(0, -1, 0, 0 ) );
    light->setAmbient( osg::Vec4(0.4f, 0.4f, 0.4f ,1.0) );
    light->setDiffuse( osg::Vec4(1,1,1,1) );
    light->setSpecular( osg::Vec4(0,0,0,1) );
    _root->getOrCreateStateSet()->setAttribute(light);
    
    //have to add these
    osg::Material* material = new osg::Material();
    material->setAmbient(osg::Material::FRONT, osg::Vec4(0.4,0.4,0.4,1.0));
    material->setDiffuse(osg::Material::FRONT, osg::Vec4(0.9,0.9,0.9,1.0));
    material->setSpecular(osg::Material::FRONT, osg::Vec4(0.4,0.4,0.4,1.0));
    _root->getOrCreateStateSet()->setAttribute(material);
    _root->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
    
    double hours = 12.0f;
    float ambientBrightness = 0.4f;
    osgEarth::Util::SkyNode* sky = new osgEarth::Util::SkyNode( _mapNode->getMap() );
    sky->setAmbientBrightness( ambientBrightness );
    sky->setDateTime( 1984, 11, 8, hours );
    sky->attach( _viewer, 0 );
    sky->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);

    _mapNode->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
    _root->addChild( _mapNode );
    _root->addChild( sky );

    osg::ref_ptr<PickHandler> picker = new PickHandler(_root, _genv, _gjo, _viewer.get());
    osgGA::GUIEventHandler* ptr = picker.get();

    optimizer.optimize(_mapNode.get());
    gles2ShaderGen->apply(*_root);

    _viewer->setSceneData( _root );
    _viewer->addEventHandler( ptr );

    _manip->setHomeViewpoint(osgEarth::Viewpoint("Home", osg::Vec3d(-8.39753f, 41.56094f, 0.0 ), 0.0, 0.0, 50 ));

    _viewer->realize();
}
