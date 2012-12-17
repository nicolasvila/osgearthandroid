//
//  osgEarthDemo.cpp
//  osgearthDemos
//

#include "DemoScene.h"

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

using namespace osgEarth;
using namespace osgEarth::Annotation;
using namespace osgEarth::Features;
using namespace osgEarth::Util;
//using namespace osgEarth::Util::Controls;


//
//Implement init demo for this target
//
void DemoScene::initDemo(const std::string &file)
{
    OSG_ALWAYS << "----osgEarthDemo----" << std::endl;
    
    // install our default manipulator (do this before calling load)
    _viewer->setCameraManipulator(  new osgEarth::Util::EarthManipulator() );//new osgEarth::Util::EarthMultiTouchManipulator() );
    
    
    osg::Node* node = osgDB::readNodeFile("/storage/sdcard0/Download/tests/readymap.earth");//nexus7
    //osg::Node* node = osgDB::readNodeFile("/mnt/sdcard/download/tests/readymap.earth");//S2
    //osg::Node* node = osgDB::readNodeFile("/mnt/sdcard/download/data/boxman.osg");//S2
    //osg::Node* node = osgDB::readNodeFile("/mnt/sdcard/external_sd/tests/readymap.earth");//S2
    if ( !node )
    {
        OSG_ALWAYS << "Unable to load an earth file from the command line." << std::endl;
        return;
    }

    osg::ref_ptr<osgEarth::Util::MapNode> mapNode = osgEarth::Util::MapNode::findMapNode(node);
    if ( !mapNode.valid() )
    {
        OSG_ALWAYS << "Loaded scene graph does not contain a MapNode - aborting" << std::endl;
        return;
    }
    
    // warn about not having an earth manip
    osgEarth::Util::EarthManipulator* manip = dynamic_cast<osgEarth::Util::EarthManipulator*>(_viewer->getCameraManipulator());
    if ( manip == 0L )
    {
        OSG_ALWAYS << "Helper used before installing an EarthManipulator" << std::endl;
    }
    
    // a root node to hold everything:
    osg::Group* root = new osg::Group();
    root->addChild( mapNode.get() );

    osg::Light* light = new osg::Light( 0 );
    light->setPosition( osg::Vec4(0, -1, 0, 0 ) );
    light->setAmbient( osg::Vec4(0.4f, 0.4f, 0.4f ,1.0) );
    light->setDiffuse( osg::Vec4(1,1,1,1) );
    light->setSpecular( osg::Vec4(0,0,0,1) );
    //root->getOrCreateStateSet()->setAttribute(light);
    
    //have to add these
    osg::Material* material = new osg::Material();
    material->setAmbient(osg::Material::FRONT, osg::Vec4(0.4,0.4,0.4,1.0));
    material->setDiffuse(osg::Material::FRONT, osg::Vec4(0.9,0.9,0.9,1.0));
    material->setSpecular(osg::Material::FRONT, osg::Vec4(0.4,0.4,0.4,1.0));
    root->getOrCreateStateSet()->setAttribute(material);
    root->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
    
    double hours = 12.0f;
    float ambientBrightness = 0.4f;
    osgEarth::Util::SkyNode* sky = new osgEarth::Util::SkyNode( mapNode->getMap() );
    sky->setAmbientBrightness( ambientBrightness );
    sky->setDateTime( 1984, 11, 8, hours );
    //sky->attach( _viewer, 0 );
    //root->addChild( sky );
    
    
    //for some reason we have to do this as global stateset doesn't
    //appear to be in the statesetstack
    //root->getOrCreateStateSet()->setAttribute(_viewer->getLight());
    
    _viewer->setSceneData( root );

    _viewer->realize();
 
}
