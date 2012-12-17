#ifndef OSGMAINAPP_HPP_
#define OSGMAINAPP_HPP_

//Android log
#include <android/log.h>
#include <iostream>
#include <cstdlib>
#include <math.h>

//Standard libraries
#include <string>

//osg
#include <osgViewer/Viewer>


//Static plugins Macro
#include "osgPlugins.h"

//demoscene
#include "DemoScene.h"

#define  LOG_TAG    "osgNativeLib"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)



class OsgMainApp{
private:
    
    osg::ref_ptr<DemoScene> _scene;
    int _bufferWidth;
    int _bufferHeight;
    bool _initialized;
    
    //OsgAndroidNotifyHandler *_notifyHandler;

    //events for each touch phase, these are cleared each frame
    osg::ref_ptr<osgGA::GUIEventAdapter> _frameTouchBeganEvents;
    osg::ref_ptr<osgGA::GUIEventAdapter> _frameTouchMovedEvents;
    osg::ref_ptr<osgGA::GUIEventAdapter> _frameTouchEndedEvents;
    
public:
    OsgMainApp();
    ~OsgMainApp();

    //Initialization function
    void initOsgWindow(int x,int y,int width,int height);
    //Draw
    void draw();
    //Events
    void touchBeganEvent(int touchid,float x,float y);
    void touchMovedEvent(int touchid,float x,float y);
    void touchEndedEvent(int touchid,float x,float y,int tapcount=0);
    void keyboardDown(int key);
    void keyboardUp(int key);
    void clearEventQueue();

};


#endif /* OSGMAINAPP_HPP_ */
