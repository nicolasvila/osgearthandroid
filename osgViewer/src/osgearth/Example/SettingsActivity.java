package osgearth.Example;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import layers.ImageLayer;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;

public class SettingsActivity extends PreferenceActivity {
	private ListPreference imageLayers;
	private Preference providerFeedbackButton;

	private GVPTApp app;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		app = (GVPTApp) getApplication();
		
        PreferenceManager.setDefaultValues(getBaseContext(), R.xml.preferences, false);
		addPreferencesFromResource(R.xml.preferences);

		imageLayers = (ListPreference) findPreference(GVPTApp.PREFERENCE_KEY_IMAGE_LAYERS);

		ArrayList<CharSequence> names = getAvailableLayers();

		imageLayers.setEntries(names.toArray(new CharSequence[names.size()]));
		imageLayers.setEntryValues(names.toArray(new CharSequence[names.size()]));
		imageLayers.setDefaultValue(names.get(0));

		providerFeedbackButton = (Preference)findPreference(GVPTApp.PREFERENCE_KEY_FEEDBACK);
		providerFeedbackButton.setOnPreferenceClickListener(
					new Preference.OnPreferenceClickListener() {
						@Override
						public boolean onPreferenceClick(Preference arg0) {
							String recipient = getString(R.string.email_android_developer);
	        	
							String uriText = "mailto:"+recipient;
							String subject = "PTIN VirtualGlobe - ";
							subject += "User Feedback ";
							Date d = Calendar.getInstance().getTime(); 
							subject += "[" + d.toString() + "]";
							uriText += "?subject=" + subject;

							Uri uri = Uri.parse(uriText);

							Intent sendIntent = new Intent(Intent.ACTION_SENDTO);
							sendIntent.setData(uri);
							startActivity(Intent.createChooser(sendIntent, "Send email")); 

							return true;
						}
					});
	}
	
	public ArrayList<CharSequence> getAvailableLayers(){
		//async task to get JSON with available layers
		ArrayList<ImageLayer> imga = new ArrayList<ImageLayer>();
		ArrayList<CharSequence> res = new ArrayList<CharSequence>();
		
		ImageLayer i1 = new ImageLayer("ReadyMap", "http://readymap.org/readymap/tiles/1.0.0/7/", "tms");
		imga.add(i1);
		res.add(i1.getName());
		app.ilMap.put(i1.getName(), i1);
		
		ImageLayer i2 = new ImageLayer("OpenStreetMap", "http://readymap.org/readymap/tiles/1.0.0/35/", "tms");
		imga.add(i2);
		res.add(i2.getName());
		app.ilMap.put(i2.getName(), i2);
		
		ImageLayer i3 = new ImageLayer("Pelican NASA Blue Marble", "http://demo.pelicanmapping.com/rmweb/data/bluemarble-tms/tms.xml", "tms");
		imga.add(i3);
		res.add(i3.getName());
		app.ilMap.put(i3.getName(), i3);
		
		ImageLayer i4 = new ImageLayer("MetaCarta", "http://tilecache.osgeo.org/wms-c/Basic.py/1.0.0/", "tms");
		imga.add(i4);
		res.add(i4.getName());
		app.ilMap.put(i4.getName(), i4);
		
		return res;
	}
}