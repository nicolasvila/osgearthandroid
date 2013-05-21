package osgearth.Example;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import osgearth.Example.R;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

public class PickerActivity extends Activity{
    private ListView listView;
    
    private String layer;
    private String id;
    private double lat;
    private double lon;
    private String description;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        Bundle b = getIntent().getExtras();
        if( b != null ){
        	layer = b.getString("layer");
        	id = b.getString("id");
	        lat = b.getDouble("lat");
	        lon = b.getDouble("lon");
	        description = b.getString("description");
        }
        
        setContentView(R.layout.pickerlayout);
        listView = (ListView)findViewById(R.id.pickerresults);

        updateView();
    }

    private void updateView(){
        List<PickerType> responseItems = this.getPickerResponseItems();
        TextView textView = (TextView) findViewById(R.id.nopickerresults);
        if(responseItems != null && responseItems.size() > 0){
            listView.setVisibility(View.VISIBLE);
            textView.setVisibility(View.GONE);
            PickerAdapter adapter = new PickerAdapter( this, responseItems );
            listView.setAdapter(adapter);
        }else{
            listView.setVisibility(View.GONE);
            textView.setVisibility(View.VISIBLE);
        }
    }

    private List<PickerType> getPickerResponseItems() {
    	List<PickerType> responseItems = new ArrayList<PickerType>();
    	PickerType test = new PickerType( this.layer, this.id, this.lat, this.lon, this.description );
    	responseItems.add(test);
    	
		return responseItems;
	}

	@Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }
}
