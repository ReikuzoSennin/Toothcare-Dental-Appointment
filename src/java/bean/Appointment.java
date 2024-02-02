package bean;

import java.io.Serializable;
import java.time.*;

public class Appointment implements Serializable{
    private String name, email, phone, message, date, time;
    private int doctor;
    
    public Appointment() {
        this.name = "";
        this.email = "";
        this.phone = "";
        this.doctor = 0;
        this.message = "";
        this.date = null;
        this.time = null;
    }

    public Appointment(String name, String email, String phone, int doctor, String message, String date, String time) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.doctor = doctor;
        this.message = message;
        this.date = date;
        this.time = time;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public int getDoctor() {
        return doctor;
    }

    public String getMessage() {
        return message;
    }

    public String getDate() {
        return date.toString();
    }
    
    public String getTime() {
        return time.toString();
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

    public void setDoctor(int doctor) {
        this.doctor = doctor;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
}
