package layers;

public class ImageLayer {
	private String name;
	private String url;
	private String driver;
	private String profile;
	
	public ImageLayer(String name, String url, String driver){
		this.name = name;
		this.url = url;
		this.driver = driver;
		this.profile = null;
	}
	
	public ImageLayer(String name, String url, String driver, String profile){
		this.name = name;
		this.url = url;
		this.driver = driver;
		this.profile = profile;
	}

	public String getName() { return name; }

	public void setName(String name) { this.name = name; }

	public String getUrl() { return url; }

	public void setUrl(String url) { this.url = url; }

	public String getDriver() { return driver; }

	public void setDriver(String driver) { this.driver = driver; }
	
	public String getProfile() { return profile; }

	public void setProfile(String profile) { this.profile = profile; }

}
