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

    //mainApp.setJavaVM(vm);

	return JNI_VERSION_1_6;
}

extern "C" {
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_init(JNIEnv * env, jobject obj, jint width, jint height);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_step(JNIEnv * env, jobject obj);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchPicker(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchPosition(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchBeganEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchMovedEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchEndedEvent(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y, jint tapcount);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_keyboardDown(JNIEnv * env, jobject obj, jint key);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_keyboardUp(JNIEnv * env, jobject obj, jint key);
    
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_clearEventQueue(JNIEnv * env, jobject obj);
    
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_loadModel(JNIEnv * env, jobject obj, jstring address);

    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_setBaseLayerWMS(JNIEnv * env, jobject obj, jstring url);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_setBaseLayerTMS(JNIEnv * env, jobject obj, jstring url);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_setBaseLayerXYZ(JNIEnv * env, jobject obj, jstring url);

    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_addLayer(JNIEnv * env, jobject obj, jstring url,
    		jstring layer, jstring style, jint minLevel);
    JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_removeLayer(JNIEnv * env, jobject obj, jstring layer);
};

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_init(JNIEnv * env, jobject obj, jint width, jint height){
	jobject jo = env->NewGlobalRef(obj);
	mainApp.setGlobalJObj(obj);
	mainApp.setJavaEnv(env);
    mainApp.initOsgWindow(0,0,width,height);
}
JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_step(JNIEnv * env, jobject obj){
    mainApp.draw();
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchPicker(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y){
    mainApp.touchPicker(touchid,x,y);
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_touchPosition(JNIEnv * env, jobject obj, jint touchid, jfloat x, jfloat y){
    mainApp.touchPosition(touchid,x,y);
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

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_loadModel(JNIEnv * env, jobject obj, jstring address)
{
	//Import Strings from JNI
	const char *nativeAddress = env->GetStringUTFChars(address, NULL);
	mainApp.loadModel(std::string(nativeAddress));

	//Release Strings to JNI
	env->ReleaseStringUTFChars(address, nativeAddress);
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_setBaseLayerWMS(JNIEnv * env, jobject obj, jstring url)
{
	//Import Strings from JNI
	const char *nativeUrl = env->GetStringUTFChars(url, NULL);
	mainApp.setBaseLayerWMS(std::string(nativeUrl));

	//Release Strings to JNI
	env->ReleaseStringUTFChars(url, nativeUrl);
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_setBaseLayerTMS(JNIEnv * env, jobject obj, jstring url)
{
	//Import Strings from JNI
	const char *nativeUrl = env->GetStringUTFChars(url, NULL);
	mainApp.setBaseLayerTMS(std::string(nativeUrl));

	//Release Strings to JNI
	env->ReleaseStringUTFChars(url, nativeUrl);
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_setBaseLayerXYZ(JNIEnv * env, jobject obj, jstring url)
{
	//Import Strings from JNI
	const char *nativeUrl = env->GetStringUTFChars(url, NULL);
	mainApp.setBaseLayerXYZ(std::string(nativeUrl));

	//Release Strings to JNI
	env->ReleaseStringUTFChars(url, nativeUrl);
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_addLayer(JNIEnv * env, jobject obj, jstring url,
		jstring layer, jstring style, jint minLevel)
{
	//Import Strings from JNI
	const char *nativeUrl = env->GetStringUTFChars(url, NULL);
	const char *nativeLayer = env->GetStringUTFChars(layer, NULL);
	const char *nativeStyle = env->GetStringUTFChars(style, NULL);

	mainApp.addLayer(std::string(nativeUrl), std::string(nativeLayer), std::string(nativeStyle), minLevel);

	//Release Strings to JNI
	env->ReleaseStringUTFChars(url, nativeUrl);
	env->ReleaseStringUTFChars(layer, nativeLayer);
	env->ReleaseStringUTFChars(style, nativeStyle);
}

JNIEXPORT void JNICALL Java_osgearth_Common_osgNativeLib_removeLayer(JNIEnv * env, jobject obj, jstring layer)
{
	//Import Strings from JNI
	const char *nativeLayer = env->GetStringUTFChars(layer, NULL);

	mainApp.removeLayer(std::string(nativeLayer));

	//Release Strings to JNI
	env->ReleaseStringUTFChars(layer, nativeLayer);
}
