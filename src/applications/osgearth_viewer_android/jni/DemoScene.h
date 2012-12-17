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

#include "EarthMultiTouchManipulator.h"
#include "GLES2ShaderGenVisitor.h"
//

#ifndef ANDROID
#import <UIKit/UIKit.h>//to acces app delegate
#else
typedef void UIView;
#endif

class DemoScene : public osg::Referenced
{
public:
    DemoScene();
    
    void init(const std::string& file, osg::Vec2 viewSize, UIView* view=0);
    
    void frame();
    
    //return the view
    osgViewer::Viewer* getViewer(){
        return _viewer.get();
    }
    
    //return the skynode
    /*osgEarth::Util::SkyNode* getSkyNode(){
        return _sky.get();
    }*/
    
protected:
    virtual ~DemoScene();
    
    //
    // implemented by new file in each target so we can recycle
    // all the base code for each app
    void initDemo(const std::string& file);
    
protected:
    
    osg::ref_ptr<osgViewer::Viewer> _viewer;
    
    //for convenience, not all demos use it
    //osg::ref_ptr<osgEarth::Util::SkyNode> _sky;
};


