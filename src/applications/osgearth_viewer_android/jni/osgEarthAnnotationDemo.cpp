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
using namespace osgEarth::Util::Controls;


struct ToggleNodeHandler : public ControlEventHandler
{
    ToggleNodeHandler( osg::Node* node ) : _node(node) { }
    
    void onValueChanged( Control* control, bool value )
    {
        _node->setNodeMask( value ? ~0 : 0 );
    }
    
    osg::Node* _node;
};

//
//Implement init demo for this target
//
void DemoScene::initDemo(const std::string &file)
{
    OSG_ALWAYS << "----osgEarthAnnotationDemo----" << std::endl;
    
    // install our default manipulator (do this before calling load)
    _viewer->setCameraManipulator( new osgEarth::Util::EarthMultiTouchManipulator() );
    
    osg::Node* node = osgDB::readNodeFile("/storage/sdcard0/Download/tests/readymap.earth");
    if ( !node )
    {
        OSG_WARN << "Unable to load an earth file from the command line." << std::endl;
        return;
    }
    
    osg::ref_ptr<osgEarth::Util::MapNode> mapNode = osgEarth::Util::MapNode::findMapNode(node);
    if ( !mapNode.valid() )
    {
        OSG_WARN << "Loaded scene graph does not contain a MapNode - aborting" << std::endl;
        return;
    }
    
    // warn about not having an earth manip
    osgEarth::Util::EarthManipulator* manip = dynamic_cast<osgEarth::Util::EarthManipulator*>(_viewer->getCameraManipulator());
    if ( manip == 0L )
    {
        OSG_WARN << "Helper used before installing an EarthManipulator" << std::endl;
    }
    
    // a root node to hold everything:
    osg::Group* root = new osg::Group();
    root->addChild( mapNode.get() );
 
    
    // Group to hold all our annotation elements.
    osg::Group* annoGroup = new osg::Group();
    root->addChild( annoGroup );
    
    //A group for all the editors
    osg::Group* editorGroup = new osg::Group;
    root->addChild( editorGroup );
    editorGroup->setNodeMask( 0 );
    
    HBox* box = ControlCanvas::get(_viewer.get())->addControl( new HBox() );
    box->setChildSpacing( 5 );
    //Add a toggle button to toggle editing
    CheckBoxControl* editCheckbox = new CheckBoxControl( false );
    editCheckbox->addEventHandler( new ToggleNodeHandler( editorGroup ) );
    box->addControl( editCheckbox );
    LabelControl* labelControl = new LabelControl( "Edit Annotations" );
    labelControl->setFontSize( 24.0f );
    box->addControl( labelControl  );
    
    
    // Make a group for 2D items, and activate the decluttering engine. Decluttering
    // will migitate overlap between elements that occupy the same screen real estate.
    osg::Group* labelGroup = new osg::Group();
    Decluttering::setEnabled( labelGroup->getOrCreateStateSet(), true );
    annoGroup->addChild( labelGroup );
    
    // Style our labels:
    osgEarth::Symbology::Style labelStyle;
    labelStyle.getOrCreate<TextSymbol>()->alignment() = TextSymbol::ALIGN_CENTER_CENTER;
    labelStyle.getOrCreate<TextSymbol>()->fill()->color() = Color::Yellow;
    
    // A lat/long SRS for specifying points.
    const SpatialReference* geoSRS = mapNode->getMapSRS()->getGeographicSRS();
    
    //--------------------------------------------------------------------
    
    // A series of place nodes (an icon with a text label)
    {
        osgEarth::Symbology::Style pin;
        pin.getOrCreate<IconSymbol>()->url()->setLiteral( "./data/placemark32.png" );
        
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -74.00, 40.71), "New York"      , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -77.04, 38.85), "Washington, DC", pin));
        //labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -87.65, 41.90), "Chicago"       , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS,-118.40, 33.93), "Los Angeles"   , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -71.03, 42.37), "Boston"        , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS,-157.93, 21.35), "Honolulu"      , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, 139.75, 35.68), "Tokyo"         , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -90.25, 29.98), "New Orleans"   , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -80.28, 25.82), "Miami"         , pin));
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS,-117.17, 32.72), "San Diego"     , pin));
        
        // test with an LOD, just for kicks:
        osg::LOD* lod = new osg::LOD();
        lod->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, 14.68, 50.0), "Prague", pin), 0.0, 1e6);
        labelGroup->addChild( lod );
        
        
        labelGroup->addChild( new PlaceNode(mapNode, GeoPoint(geoSRS, -87.65, 41.90, 1000, ALTMODE_ABSOLUTE), "Chicago"       , pin));
    }

    osg::Light* light = new osg::Light( 0 );
    light->setPosition( osg::Vec4(0, -1, 0, 0 ) );
    light->setAmbient( osg::Vec4(0.4f, 0.4f, 0.4f ,1.0) );
    light->setDiffuse( osg::Vec4(1,1,1,1) );
    light->setSpecular( osg::Vec4(0,0,0,1) );
    root->getOrCreateStateSet()->setAttribute(light);
    root->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::ON | osg::StateAttribute::OVERRIDE);
    
    osg::Material* material = new osg::Material();
    material->setAmbient(osg::Material::FRONT, osg::Vec4(0.4,0.4,0.4,1.0));
    material->setDiffuse(osg::Material::FRONT, osg::Vec4(0.9,0.9,0.9,1.0));
    material->setSpecular(osg::Material::FRONT, osg::Vec4(0.4,0.4,0.4,1.0));
    root->getOrCreateStateSet()->setAttribute(material);
    
    _viewer->setSceneData( root );
}
