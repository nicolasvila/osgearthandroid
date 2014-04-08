package osgearth.Example;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;
import osgearth.Example.R;

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
