package osgearth.Example;

import android.content.Context;
import android.text.Html;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.List;

import osgearth.Example.R;

public class PickerAdapter extends BaseAdapter
{
    private final PickerActivity context;
    private final List<PickerType> results;

    public PickerAdapter(PickerActivity context, List<PickerType> values) {
        super();
        this.context = context;
        this.results = values;
    }

    public int getViewTypeCount() {
        return 1;
    }

    public int getCount() {
        return results.size();
    }

    public Object getItem(int i) {
        return results.get(i);
    }

    public long getItemId(int i) {
        return 0L;
    }

    public boolean hasStableIds() {
        return true;
    }

    public int getItemViewType(int i) {
        return 1;
    }

    public boolean isEmpty() {
        return results.isEmpty();
    }

    public boolean areAllItemsEnabled() {
        return true;
    }

    public boolean isEnabled(int i) {
        return true;
    }

    public View getView(int position, View convertView, final ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.pickerrowlayout, parent, false);

        final PickerType item = results.get(position);
        
        TextView textViewLayer = (TextView) rowView.findViewById(R.id.pickerLayer);
        textViewLayer.setText(Html.fromHtml("<b>Layer: </b>" + item.getLayer()));
        
        TextView textViewId = (TextView) rowView.findViewById(R.id.pickerId);
        textViewId.setText(Html.fromHtml("<b>ID: </b>" +item.getId()));
        
        TextView textViewPosition = (TextView) rowView.findViewById(R.id.pickerPosition);
        textViewPosition.setText(Html.fromHtml("<b>Position: </b>" +item.getLat()+ "\t" +item.getLon()));
        
        WebView webViewDescription = (WebView) rowView.findViewById(R.id.pickerDescription);        
        webViewDescription.loadData("<html><body>"+item.getDescription()+"</body></html>", "text/html", null);

        return rowView;
    }
}
