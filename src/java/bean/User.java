package bean;

import java.io.Serializable;

public class User implements Serializable{
    private String name, email, phone, area, postoffice, postcode, state, userType;
    private int id;
    
    public User() {
        this.name = "";
        this.email = "";
        this.phone = "";
        this.area = "";
        this.postoffice = "";
        this.postcode = "";
        this.state = "";
        this.userType = "";
        this.id = 0;
    }

    public User(String name, String email, String phone, String area, String postoffice, String postcode, String state, String userType, int id) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.area = area;
        this.postoffice = postoffice;
        this.postcode = postcode;
        this.state = state;
        this.userType = userType;
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getArea() {
        return area;
    }

    public String getPostoffice() {
        return postoffice;
    }

    public String getPostcode() {
        return postcode;
    }

    public String getState() {
        return state;
    }

    public String getPhone() {
        return phone;
    }

    public String getUserType() {
        return userType;
    }

    public int getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public void setPostoffice(String postoffice) {
        this.postoffice = postoffice;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public void setId(int id) {
        this.id = id;
    }
}
