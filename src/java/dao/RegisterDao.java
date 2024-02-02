package dao;

import java.sql.*;
import util.DBConnection;
import bean.Register;

public class RegisterDao {
    Connection con = DBConnection.createConnection();
    PreparedStatement stmt;
    String query;
    ResultSet rs;
    
    public String registerUser(Register bean) {
        String name = bean.getName();
        String email = bean.getEmail();
        String password = bean.getPassword();
        
        int areaID = bean.getAreaID();
        String phone = bean.getPhone();
        
        try {
            query = "INSERT INTO users (name, email, password, areaID, phone) VALUES (?,?,?,?,?)";
            stmt = con.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setInt(4, areaID);
            stmt.setString(5, phone);
            stmt.executeUpdate();
            return "SUCCESS";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "FAILED";
    }
    public String existUser(String email) {        
        try {
            query = "SELECT * FROM users WHERE email=?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            while(rs.next()) {
                String emailDB = rs.getString("email");
                if(email.equals(emailDB)) {
                    return "SUCCESS";
                }
            }          
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "FAILED";
    }
}
