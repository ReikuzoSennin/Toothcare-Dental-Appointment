package bean;

import java.io.Serializable;

public class Login implements Serializable{
    private String email, password;
    
    public Login() {
        this.email = "";
        this.password = "";
    }

    public Login(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
