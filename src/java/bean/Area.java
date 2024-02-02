package bean;

import java.io.Serializable;

public class Area implements Serializable {
    private String area_name, post_office, postcode;
    private int areaid;
    
    public Area() {
        this.area_name = "";
        this.post_office = "";
        this.postcode = "";
        this.areaid = 0;
    }

    public Area(String area_name, String post_office, String postcode, int areaid) {
        this.area_name = area_name;
        this.post_office = post_office;
        this.postcode = postcode;
        this.areaid = areaid;
    }

    public String getArea_name() {
        return area_name;
    }

    public String getPost_office() {
        return post_office;
    }

    public String getPostcode() {
        return postcode;
    }
    
    public int getAreaID() {
        return areaid;
    }

    public void setArea_name(String area_name) {
        this.area_name = area_name;
    }

    public void setPost_office(String post_office) {
        this.post_office = post_office;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }
    
    public void setAreaID(int areaid) {
        this.areaid = areaid;
    }
}
