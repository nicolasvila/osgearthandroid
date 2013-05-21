package osgearth.Common;

import osgearth.Example.PickerActivity;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class osgNativeLib {
	static public Activity mainActivity;

   /**
    * @param width the current view width
    * @param height the current view height
    */
    public static native void 		init(int width, int height);
    public static native void 		step();
    public static native void 		touchPicker(int touchid, float x,float y);
    public static native void 		touchPosition(int touchid, float x,float y);
    public static native void 		touchBeganEvent(int touchid, float x,float y);
    public static native void 		touchMovedEvent(int touchid, float x,float y);
    public static native void 		touchEndedEvent(int touchid, float x,float y, int tapcount);
    public static native void 		keyboardDown(int key);
    public static native void 		keyboardUp(int key);
    public static native void 		clearEventQueue();
    
    public static native void 		loadModel(String address);
    public static native void 		setBaseLayerWMS(String url);
    public static native void 		setBaseLayerTMS(String url);
    public static native void 		setBaseLayerXYZ(String url);
    
    public static native void 		addLayer(String url, String layer, String style, int minLevel);
    public static native void 		removeLayer(String layer);
    
    public static native void		loadAsyncReq(String req);
    
    public static void displayInfo(String layer, String id, double lat, double lon, String description){
    	System.out.println(lat + ";" + lon);
    	
    	Intent intent = new Intent(mainActivity, PickerActivity.class);
    	
    	Bundle b = new Bundle();
    	b.putString("layer", layer);
    	b.putString("id", id);
    	b.putDouble("lat", lat);
    	b.putDouble("lon", lon);
    	b.putString("description", description);
    	
    	intent.putExtras(b);
    	
    	mainActivity.startActivityForResult(intent, 1);
    }
    
    public static void newAsyncReq(String req){
    	System.out.println(req);
    }
}
