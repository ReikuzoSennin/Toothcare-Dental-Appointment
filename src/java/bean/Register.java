package bean;

import java.io.Serializable;

public class Register implements Serializable{
    private String name, password, email, phone;
    private int areaid;
    
    public Register() {
        this.name = "";
        this.password = "";
        this.email = "";
        this.phone = "";
        this.areaid = 0;
    }

    public Register(String name, String email, String password, String phone, int addr) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.areaid = addr;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public int getAreaID() {
        return areaid;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setAreaID(int areaid) {
        this.areaid = areaid;
    }
}
