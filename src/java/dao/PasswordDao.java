package dao;

import util.DBConnection;
import java.sql.*;
import bean.Password;

public class PasswordDao {
    Connection con = DBConnection.createConnection();
    String query;
    PreparedStatement stmt;
    ResultSet rs;
    
    public String changePassword(Password pass, int id) {
        String newpass = pass.getNewpassword();
        
        try {
            query = "UPDATE USERS SET password=? WHERE userid=?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, newpass);
            stmt.setInt(2, id);
            stmt.executeUpdate();
            return "SUCCESS";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "FAILED";
    }
    public String authenticatePassword(Password pass, int id) {
        String oldpass = pass.getOldpassword();
        
        try {
            query = "SELECT * FROM USERS";
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();
            while(rs.next()) {
                String passwordDB = rs.getString("password");
                int userDB = rs.getInt("userid");
                if(id==userDB && oldpass.equals(passwordDB))
                    return "SUCCESS";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Incorrect Password";
    }
}
