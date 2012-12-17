package osgearth.Common;

import android.util.Log;

public class osgNativeLib {
	
	static {
//		Log.w("osgNativeLib", "About to load lib");
//        System.loadLibrary("osgNativeLib");
//        Log.w("osgNativeLib", "Lib loaded");
    }

   /**
    * @param width the current view width
    * @param height the current view height
    */
    public static native void 		init(int width, int height);
    public static native void 		step();
    public static native void 		touchBeganEvent(int touchid, float x,float y);
    public static native void 		touchMovedEvent(int touchid, float x,float y);
    public static native void 		touchEndedEvent(int touchid, float x,float y, int tapcount);
    public static native void 		keyboardDown(int key);
    public static native void 		keyboardUp(int key);
    public static native void 		clearEventQueue();

}
