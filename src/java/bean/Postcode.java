package bean;

import java.io.Serializable;

public class Postcode implements Serializable {
    private String postcode, state_code;
    
    public Postcode() {
        this.postcode = "";
        this.state_code = "";
    }

    public Postcode(String postcode, String state_code) {
        this.postcode = postcode;
        this.state_code = state_code;
    }

    public String getPostcode() {
        return postcode;
    }

    public String getState_code() {
        return state_code;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public void setState_code(String state_code) {
        this.state_code = state_code;
    }
}
