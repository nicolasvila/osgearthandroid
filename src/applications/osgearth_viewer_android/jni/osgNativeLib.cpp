#include <string.h>
#include <jni.h>
#include <android/log.h>

#include <iostream>

#include "OsgMainApp.hpp"

OsgMainApp mainApp;

extern "C" jint JNI_OnLoad(JavaVM* vm, void* reserved)
{
    __android_log_write(ANDROID_LOG_ERROR, "OSGANDROID",
            "Entered JNI_OnLoad");
	return JNI_VERSION_1_6;
}

extern "C" {
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_init(JNIEnv * env, jobject obj, jint width, jint height);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_step(JNIEnv * env, jobject obj);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchBeganEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchMovedEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchEndedEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y, jint tapcount);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_keyboardDown(JNIEnv * env, jobject obj, jint key);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_keyboardUp(JNIEnv * env, jobject obj, jint key);
    
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_clearEventQueue(JNIEnv * env, jobject obj);
    
};

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_init(JNIEnv * env, jobject obj, jint width, jint height){
    mainApp.initOsgWindow(0,0,width,height);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_step(JNIEnv * env, jobject obj){
    mainApp.draw();
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchBeganEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y){
    mainApp.touchBeganEvent(touchid,x,y);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchMovedEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y){
    mainApp.touchMovedEvent(touchid,x,y);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchEndedEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y, jint tapcount){
    mainApp.touchEndedEvent(touchid,x,y,tapcount);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_keyboardDown(JNIEnv * env, jobject obj, jint key){
    mainApp.keyboardDown(key);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_keyboardUp(JNIEnv * env, jobject obj, jint key){
    mainApp.keyboardUp(key);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_clearEventQueue(JNIEnv * env, jobject obj)
{
    mainApp.clearEventQueue();
}
