package osgearth.Example;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View.OnClickListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;

import osgearth.Common.EGLview;
import osgearth.Common.osgNativeLib;

public class osgViewer extends Activity implements View.OnKeyListener {
	
	private static final String TAG = "OSG Activity";
	//Ui elements
    EGLview mView;
    Button uiCenterViewButton;
   
    //Main Android Activity life cycle
    @Override protected void onCreate(Bundle icicle) {
    	
		Log.w("osgNativeLib", "About to load lib");
        System.loadLibrary("osgNativeLib");
        Log.w("osgNativeLib", "Lib loaded");
    	
        super.onCreate(icicle);
        setContentView(R.layout.ui_layout_gles);
        
        //get gl view
	    mView= (EGLview) findViewById(R.id.surfaceGLES);
		//mView.setOnTouchListener(this);
		mView.setOnKeyListener(this);
	    
		//get center camera button
	    uiCenterViewButton = (Button) findViewById(R.id.uiButtonCenter);
	    uiCenterViewButton.setOnClickListener(uiListenerCenterView);
	   
    }
    @Override protected void onPause() {
        super.onPause();
        mView.onPause();
    }
    @Override protected void onResume() {
        super.onResume();
        mView.onResume();
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
    		//int keyChar= event.getUnicodeChar();
    		//osgNativeLib.keyboardUp(keyChar);    		
    	}
    	
    	return true;
    }
   
    //Ui Listeners
    OnClickListener uiListenerCenterView = new OnClickListener() {
        public void onClick(View v) {
        	//Log.d(TAG, "Center View");
        	osgNativeLib.keyboardDown(32);
        	osgNativeLib.keyboardUp(32);
        }
    };

    //Menu
    
    //Android Life Cycle Menu
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
        case R.id.menuLoadObject:
        	Log.d(TAG,"Load Object");
        	//loadLayerAddress.show();
            return true;
        case R.id.menuCleanScene:
        	Log.d(TAG,"Clean Scene");
        	//osgNativeLib.clearContents();
            return true;
        case R.id.menuDeleteObject:
        	Log.d(TAG,"Delete a object");
        	/*String vNames[] = osgNativeLib.getObjectNames();
        	
        	//Remove Layer Dialog
    		AlertDialog.Builder removeLayerDialogBuilder = new AlertDialog.Builder(this);
    		removeLayerDialogBuilder.setTitle(R.string.uiDialogTextChoseRemove);
    		removeLayerDialogBuilder.setItems(vNames, new DialogInterface.OnClickListener() {
    			
    			@Override
    			public void onClick(DialogInterface dialog, int witch) {
    				// TODO Auto-generated method stub
    				osgNativeLib.unLoadObject(witch);
    			}
    		});
    		removeLayerDialog = removeLayerDialogBuilder.create();

    		if(vNames.length > 0)
    			removeLayerDialog.show();
        	*/
            return true;
        case R.id.menuChangeBackground:
        	Log.d(TAG,"Change background color");
        	//int[] test = new int [3];
        	/*test = osgNativeLib.getClearColor();
        	backgroundColor = Color.rgb(test[0], test[1], test[2]);
        	
        	ColorPickerDialog colorDialog;
        	new ColorPickerDialog(this, this, backgroundColor).show();
        	*/
            return true;
        case R.id.menuShowKeyboard:
        	Log.d(TAG,"Keyboard");
        	InputMethodManager mgr= (InputMethodManager)this.getSystemService(Context.INPUT_METHOD_SERVICE);
    		mgr.toggleSoftInput(InputMethodManager.SHOW_IMPLICIT, 0);
            return true;
        default:
            return super.onOptionsItemSelected(item);
        }
    }
}