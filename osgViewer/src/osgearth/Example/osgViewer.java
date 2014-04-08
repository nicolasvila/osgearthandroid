package osgearth.Example;

import java.io.File;
import java.util.TreeMap;

import layers.ImageLayer;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.os.Bundle;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

import osgearth.Common.EGLview;
import osgearth.Common.osgNativeLib;

public class osgViewer extends Activity implements View.OnKeyListener, OnSharedPreferenceChangeListener
{
	public SharedPreferences prefs;
	public TreeMap<String, ImageLayer> ilMap;
	
	private GVPTApp app;
	
	//Ui elements
    EGLview mView;
    Button uiCenterViewButton;
    
    AlertDialog loadLayerAddress;
    FileBrowser fileDialog;
    
    osgNativeLib nativeLib;
   
    //Main Android Activity life cycle
    @Override protected void onCreate(Bundle icicle) {
    	
    	String appPath = getApplication().getApplicationContext().getFilesDir().getAbsolutePath();
    	System.out.println(appPath);
    	Log.w("osgNativeLib", "About to load lib");
    	System.load(appPath+"/../lib/libosgNativeLib.so");
    	//System.loadLibrary("osgNativeLib");
    	Log.w("osgNativeLib", "Lib loaded");
    	
        super.onCreate(icicle);
        setContentView(R.layout.ui_layout_gles);
        
        app = (GVPTApp) getApplication();
        osgNativeLib.mainActivity = this;
        
        //get gl view
	    mView= (EGLview) findViewById(R.id.surfaceGLES);
		//mView.setOnTouchListener(this);
		mView.setOnKeyListener(this);
		
		prefs = PreferenceManager.getDefaultSharedPreferences(this.getApplicationContext());
		app.activeOverlays.put("over_arm", prefs.getBoolean("over_arm", false));
		app.activeOverlays.put("over_pos", prefs.getBoolean("over_pos", false));
		app.activeOverlays.put("over_ca", prefs.getBoolean("over_ca", false));
		prefs.registerOnSharedPreferenceChangeListener(this);
	    
		//get center camera button
	    uiCenterViewButton = (Button) findViewById(R.id.uiButtonCenter);
	    uiCenterViewButton.setOnClickListener(uiListenerCenterView);
	    
	    LayoutInflater factory = LayoutInflater.from(getApplicationContext());
	    final View textEntryView = factory.inflate(R.layout.dialog_text_entry, null);
	    AlertDialog.Builder loadLayerDialogBuilder = new AlertDialog.Builder(this);
	    loadLayerDialogBuilder.setIcon(R.drawable.web_browser);
	    loadLayerDialogBuilder.setTitle(R.string.uiDialogTextAddress);
	    loadLayerDialogBuilder.setView(textEntryView);
	    loadLayerDialogBuilder.setPositiveButton(R.string.uiDialogOk, new DialogInterface.OnClickListener() {

	    	@Override
	    	public void onClick(DialogInterface dialog, int which) {
	    		EditText address;
	    		address = (EditText) textEntryView.findViewById(R.id.uiEditTextInput);
	    		osgNativeLib.loadModel(address.getText().toString());
	    	}
	    });
	    loadLayerDialogBuilder.setNegativeButton(R.string.uiDialogCancel, new DialogInterface.OnClickListener() {

	    	@Override
	    	public void onClick(DialogInterface dialog, int which) {
	    	}
	    });

	    loadLayerAddress = loadLayerDialogBuilder.create();
	    
	    addActiveLayers();
    }
    
    @Override 
    protected void onPause() {
        super.onPause();
        //mView.onPause();
    }
    
    @Override 
    protected void onResume() {
        super.onResume();
        //mView.onResume();
    }
    
    @Override
	public boolean onKey(View v, int keyCode, KeyEvent event) {
		return true;
	}
    
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
    	return true;
    }
    
    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event){
    	switch (keyCode){
    	case KeyEvent.KEYCODE_BACK:
    		super.onDestroy();
    		this.finish();
    		break;
    	case KeyEvent.KEYCODE_SEARCH:
    		break;
    	case KeyEvent.KEYCODE_MENU:
    		this.openOptionsMenu();
    		break;
    	default:
    		int keyChar = event.getUnicodeChar();
    		osgNativeLib.keyboardDown(keyChar);
    		osgNativeLib.keyboardUp(keyChar);    		
    	}
    	
    	return true;
    }
   
    //Ui Listeners
    OnClickListener uiListenerCenterView = new OnClickListener() {
        public void onClick(View v) {
        	osgNativeLib.keyboardDown(32);
        	osgNativeLib.keyboardUp(32);
        }
    };

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.appmenu, menu);
        return super.onCreateOptionsMenu(menu);
    }
    
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle item selection
        switch (item.getItemId()) {
	        case R.id.menuMyLocation:
	            return true;
	        case R.id.menuSettings:
	        	this.startActivity(new Intent(this, SettingsActivity.class));
	            return true;
	        case R.id.menuKML:
	        	File mPath = new File(Environment.getExternalStorageDirectory() + "//DIR//");
	        	fileDialog = new FileBrowser(this, mPath, ".kml");
	            fileDialog.addFileListener(new FileBrowser.FileSelectedListener() {
	                public void fileSelected(File file) {
	                    Log.d(getClass().getName(), "selected file " + file.toString());
	                    osgNativeLib.loadModel(file.toString());
	                }
	            });
	            fileDialog.showDialog();
	        	return true;
	        case R.id.menuExit:
	    		this.finish();
	            return true;
	        default:
	            return super.onOptionsItemSelected(item);
        }
    }
    
    public void addActiveLayers(){
    	if(prefs.getBoolean("over_pos", false)){
    		osgNativeLib.addLayer("http://webgis.di.uminho.pt:8080/geoserver2/sig3d/wms", "sig3d:SIG3D_POSTES",
    				"osg_poste", 14);
    	}

    	if(prefs.getBoolean("over_arm", false)){
    		osgNativeLib.addLayer("http://webgis.di.uminho.pt:8080/geoserver2/sig3d/wms", "sig3d:SIG3D_ARMARIOS",
    				"osg_armario", 14);
    	}

    	if(prefs.getBoolean("over_ca", false)){
    		osgNativeLib.addLayer("http://webgis.di.uminho.pt:8080/geoserver2/sig3d/wms",
    				"sig3d:SIG3D_TAEREOS", "", 14);
    	}
    }

	@Override
	public void onSharedPreferenceChanged(SharedPreferences sharedPrefs, String key) {
		if (key == null) return;
		if( key.equals(GVPTApp.PREFERENCE_KEY_IMAGE_LAYERS) ){
			ImageLayer il = app.ilMap.get(prefs.getString(GVPTApp.PREFERENCE_KEY_IMAGE_LAYERS, ""));
			if(il != null){
				if(il.getDriver().equals("wms"))
					osgNativeLib.setBaseLayerWMS(il.getUrl());
				if(il.getDriver().equals("tms"))
					osgNativeLib.setBaseLayerTMS(il.getUrl());
				if(il.getDriver().equals("xyz"))
					osgNativeLib.setBaseLayerXYZ(il.getUrl());
			}
			System.out.println("change image layer to " + prefs.getString(GVPTApp.PREFERENCE_KEY_IMAGE_LAYERS, ""));
		}
		if( key.equals(GVPTApp.PREFERENCE_KEY_POSTES) ){
			if(prefs.getBoolean("over_pos", false)){
				osgNativeLib.addLayer("http://webgis.di.uminho.pt:8080/geoserver2/sig3d/wms", 
						"sig3d:SIG3D_POSTES", "osg_poste", 14);
			} else{
				osgNativeLib.removeLayer("sig3d:SIG3D_POSTES");
			}
			app.activeOverlays.put("over_pos", prefs.getBoolean("over_pos", false));
		}
			
		if( key.equals(GVPTApp.PREFERENCE_KEY_ARMARIOS) ){
			if(prefs.getBoolean("over_arm", false)){
				osgNativeLib.addLayer("http://webgis.di.uminho.pt:8080/geoserver2/sig3d/wms", 
						"sig3d:SIG3D_ARMARIOS", "osg_armario", 14);
			} else{
				osgNativeLib.removeLayer("sig3d:SIG3D_ARMARIOS");
			}
			app.activeOverlays.put("over_arm", prefs.getBoolean("over_arm", false));
		}
			
		if( key.equals(GVPTApp.PREFERENCE_KEY_CABOSA) ){
			if(prefs.getBoolean("over_ca", false)){
				osgNativeLib.addLayer("http://webgis.di.uminho.pt:8080/geoserver2/sig3d/wms", 
						"sig3d:SIG3D_TAEREOS", "", 14);
			} else{
				osgNativeLib.removeLayer("sig3d:SIG3D_TAEREOS");
			}
			app.activeOverlays.put("over_ca", prefs.getBoolean("over_ca", false));
		}
	}
}