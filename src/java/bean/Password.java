package bean;

import java.io.Serializable;

public class Password implements Serializable{
    private String oldpassword, newpassword, confirmpassword;
    
    public Password() {
        this.oldpassword = "";
        this.newpassword = "";
    }

    public Password(String oldpassword, String newpassword) {
        this.oldpassword = oldpassword;
        this.newpassword = newpassword;
    }

    public String getOldpassword() {
        return oldpassword;
    }

    public void setOldpassword(String oldpassword) {
        this.oldpassword = oldpassword;
    }

    public String getNewpassword() {
        return newpassword;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }
}
