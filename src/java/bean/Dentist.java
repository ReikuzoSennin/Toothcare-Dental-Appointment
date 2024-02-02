package bean;

import java.io.Serializable;

public class Dentist implements Serializable {
    private String name, role, description, image;
    private int id;
    
    public Dentist() {
        this.name = "";
        this.role = "";
        this.description = "";
        this.image = "";
        this.id = 0;
    }

    public Dentist(String name, String role, String description, String image, int id) {
        this.name = name;
        this.role = role;
        this.description = description;
        this.image = image;
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public String getRole() {
        return role;
    }

    public String getDescription() {
        return description;
    }

    public String getImage() {
        return image;
    }

    public int getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setId(int id) {
        this.id = id;
    }
    
}
