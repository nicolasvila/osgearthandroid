package osgearth.Example;

public class PickerType {
	private String layer;
	private String id;
	private double lon;
	private double lat;
	private String description;
	
	public PickerType(){
		this.layer = "";
		this.id = "";
		this.lon = -1;
		this.lat = -1;
		this.description = "";
	}
	
	public PickerType( String layer, String id, double lat, double lon, String description ){
		this.layer = layer;
		this.id = id;
		this.lon = lon;
		this.lat = lat;
		this.description = description;
	}

	public String getLayer() {
		return layer;
	}

	public void setLayer(String layer) {
		this.layer = layer;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getLon() {
		return lon;
	}

	public void setLon(double lon) {
		this.lon = lon;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}
	
}
