package osgearth.Example;

import java.util.TreeMap;

import layers.ImageLayer;

import android.app.Application;

public class GVPTApp extends Application {
	public static final String PREFERENCE_KEY_IMAGE_LAYERS = "image_layers_preference";
	public static final String PREFERENCE_KEY_OVERLAYS = "visible_overlays";
	public static final String PREFERENCE_KEY_FEEDBACK = "provider_feedback";
	
	public static final String PREFERENCE_KEY_POSTES = "over_pos";
	public static final String PREFERENCE_KEY_ARMARIOS = "over_arm";
	public static final String PREFERENCE_KEY_CABOSA = "over_ca";

	public TreeMap<String, ImageLayer> ilMap = new TreeMap<String, ImageLayer>();
	public TreeMap<String, Boolean> activeOverlays = new TreeMap<String, Boolean>();
}
