package osgearth.Example;

import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class LocationHandler{
	private osgViewer mainActivity;
	
	private static final int TWO_MINUTES = 1000 * 60 * 2;
	private LocationManager locationManager;
	private Location currentLocation;
	private LocationListener locationListener;
	private String provider;
	private boolean menuReturned = false;
	
	public LocationHandler(osgViewer mainActivity){
		this.mainActivity = mainActivity;
		
		locationManager = (LocationManager) mainActivity.getSystemService(Context.LOCATION_SERVICE);
        locationListener = new MyLocationListener();
        
        checkProvider();
	}
    
    public void checkProvider(){
    	if(!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) && 
    			!locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)){
    		menuProvider();
    	}
    	else{
    		String choosenProvider = chooseProvider(Criteria.ACCURACY_FINE, Criteria.POWER_LOW, false, false);
    		provider = locationManager.isProviderEnabled(choosenProvider)?
    				choosenProvider:
    					locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)?
    							LocationManager.GPS_PROVIDER:
    								LocationManager.NETWORK_PROVIDER;

    		locationManager.requestLocationUpdates(provider, 0, 0, locationListener);
    	}
    }
    
    public class MyLocationListener implements LocationListener{
    	public void onLocationChanged(Location location) {treatNewLocation(location);}

    	public void onStatusChanged(String provider, int status, Bundle extras) {}

    	public void onProviderEnabled(String provider) {}

    	public void onProviderDisabled(String provider) {}
    }
    
    public String chooseProvider(final int accuracyRequired, final int powerRequired, 
    		boolean bearingRequired, boolean costAllowed){
    	
    	Criteria crta = new Criteria(); 
        crta.setAccuracy(accuracyRequired); 
        crta.setAltitudeRequired(false); 
        crta.setBearingRequired(bearingRequired); 
        crta.setCostAllowed(costAllowed); 
        crta.setPowerRequirement(powerRequired); 

        return locationManager.getBestProvider(crta, true);
    }

    public synchronized void treatNewLocation(Location location){
    	if(isBetterLocation(location)){
    		currentLocation = location;
    		
    	}
    }
    
    protected synchronized boolean isBetterLocation(Location location) {
    	if (currentLocation == null) {return true;}

    	long timeDelta = location.getTime() - currentLocation.getTime();
    	boolean isSignificantlyNewer = timeDelta > TWO_MINUTES;
    	boolean isSignificantlyOlder = timeDelta < -TWO_MINUTES;
    	boolean isNewer = timeDelta > 0;
    	if (isSignificantlyNewer) {
    		return true;
    	} else if (isSignificantlyOlder) {return false;}

    	int accuracyDelta = (int) (location.getAccuracy() - currentLocation.getAccuracy());
    	boolean isLessAccurate = accuracyDelta > 0;
    	boolean isMoreAccurate = accuracyDelta < 0;
    	boolean isSignificantlyLessAccurate = accuracyDelta > 200;

    	boolean isFromSameProvider = isSameProvider(location.getProvider(), currentLocation.getProvider());

    	if (isMoreAccurate) {
    		return true;
    	} else if (isNewer && !isLessAccurate) {
    		return true;
    	} else if (isNewer && !isSignificantlyLessAccurate && isFromSameProvider) {
    		return true;
    	}
    	return false;
    }

    private boolean isSameProvider(String provider1, String provider2) {
    	if (provider1 == null) {return provider2 == null;}
    	return provider1.equals(provider2);
    }
    
    public void menuProvider(){
    	final Dialog dialog = new Dialog(mainActivity);
    	dialog.setContentView(R.layout.location_provider_menu);
    	dialog.setTitle("Unable to detect a location service.");
    	dialog.setCancelable(false);

    	Button locationSettings = (Button) dialog.findViewById(R.id.lp_sett_button);
    	locationSettings.setOnClickListener(new OnClickListener() {
    		@Override
    		public void onClick(View v) {
    			dialog.dismiss();
    			menuReturned = true;
    			mainActivity.startActivityForResult(new Intent(android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS), 0);
    		}
    	});

    	Button locationCancel = (Button) dialog.findViewById(R.id.lp_cancel_button);
    	locationCancel.setOnClickListener(new OnClickListener() {
    		@Override
    		public void onClick(View v) {
    			dialog.dismiss();
    		}
    	});
    	dialog.show();
    }
    
    public boolean getMenuReturned(){
    	return this.menuReturned;
    }
    
    public void setMenuReturned(boolean menuReturned){
    	this.menuReturned = menuReturned;
    }
}

//TODO ver se dá para beneficiar do lastKnowLocation
//TODO detectar se um location provider não está a funcionar (ex. GPS indoors) e tentar mudar para o outro
//TODO definir janela de tempo necessária para os updates