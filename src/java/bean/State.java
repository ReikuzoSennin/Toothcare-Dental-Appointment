package bean;

import java.io.Serializable;

public class State implements Serializable {
    private String state_code, state_name;
    
    public State() {
        this.state_code = "";
        this.state_name = "";
    }
    
    public State(String code, String name) {
        this.state_code = code;
        this.state_name = name;
    }

    public String getState_code() {
        return state_code;
    }

    public String getState_name() {
        return state_name;
    }

    public void setState_code(String code) {
        this.state_code = code;
    }

    public void setState_name(String name) {
        this.state_name = name;
    }
}
