//
//  DemoScene.h
//  osgearthDemos
//
//

#pragma once

#include "osgPlugins.h"
#include <osgViewer/Viewer>

//
#include <osgDB/FileUtils>


#include <osgEarth/Viewpoint>
#include <osgEarthUtil/EarthManipulator>
#include <osgEarthUtil/AutoClipPlaneHandler>
#include <osgEarthUtil/ObjectLocator>
#include <osgEarthUtil/SkyNode>
#include <osgEarthUtil/EarthManipulator>
#include <osgEarthUtil/ExampleResources>

#include <osgEarthDrivers/kml/KML>
#include <osgEarthDrivers/wms/SceneGraphChanges>

#include "EarthMultiTouchManipulator.h"
#include "GLES2ShaderGenVisitor.h"

#include <jni.h>

//

#ifndef ANDROID
#import <UIKit/UIKit.h>//to acces app delegate
#else
typedef void UIView;
#endif

class DemoScene : public osg::Referenced
{
public:
    DemoScene(JNIEnv * env, jobject gjo);
    
    void init(const std::string& file, osg::Vec2 viewSize, UIView* view=0);
    
    void frame();
    
    //return the view
    osgViewer::Viewer* getViewer(){
        return _viewer.get();
    }
    
    void addModel(std::string address);
    void setBaseLayerWMS(std::string url);
    void setBaseLayerTMS(std::string url);
    void setBaseLayerXYZ(std::string url);
    void addLayer(std::string url, std::string layer, std::string style, int minLevel);
    void removeLayer(std::string name);

    void onMove(float x, float y);
    osg::Matrixd* getWorldCoords( osg::Node* node );
    
    osgEarth::Util::MapNode* getMapNode();
    JNIEnv * _genv;
    jobject _gjo;


protected:
    virtual ~DemoScene();
    
    //
    // implemented by new file in each target so we can recycle
    // all the base code for each app
    void initDemo(const std::string& file);
    
protected:
    
    osg::ref_ptr<osgViewer::Viewer> _viewer;
    osgEarth::Util::EarthManipulator* _manip;
    osgUtil::GLES2ShaderGenVisitor* _gles2ShaderGen;
    osg::ref_ptr<osgEarth::MapNode> _mapNode;
    osgEarth::Drivers::KMLOptions* _kml_options;
    osg::ref_ptr<osg::Group> _root;
    SceneGraphChanges* _changesQueue;
};


