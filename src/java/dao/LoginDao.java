package dao;

import java.sql.*;
import util.DBConnection;
import bean.Login;
import bean.User;

public class LoginDao {
    Connection con = DBConnection.createConnection();
    PreparedStatement stmt;
    String query;
    ResultSet rs;
    
    public String authenticateUser(Login login) {
        String email = login.getEmail();
        String password = login.getPassword();
        
        try {
            query = "SELECT * FROM users";
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();
            while(rs.next()) {
                String emailDB = rs.getString("email");
                String passwordDB = rs.getString("password");
                if(email.equals(emailDB) && password.equals(passwordDB)) {
                    return "SUCCESS";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Invalid Credentials";
    }
    public User getUser(Login login) {
        String email = login.getEmail();
        String password = login.getPassword();
        
        User bean = new User();
        try {
            query = "SELECT * FROM users WHERE email=? AND password=?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            while(rs.next()) {
                String nameDB = rs.getString("name");
                String emailDB = rs.getString("email");
                String phoneDB = rs.getString("phone");
                String typeDB = rs.getString("usertype");
                int idDB = rs.getInt("userid");
                int areaID = rs.getInt("areaID");
                
                String query2 = "SELECT A.AREAID, A.AREA_NAME, A.POST_OFFICE, P.POSTCODE, S.STATE_NAME FROM Area A INNER JOIN Postcode P ON P.postcode = A.postcode INNER JOIN State S ON S.state_code = P.state_code WHERE A.areaid = ?";
                PreparedStatement stmt2 = con.prepareStatement(query2);
                stmt2.setInt(1, areaID);
                ResultSet rs2 = stmt2.executeQuery();
                while(rs2.next()) {
                    String areaDB = rs2.getString("area_name");
                    String postofficeDB = rs2.getString("post_office");
                    String postcodeDB = rs2.getString("postcode");
                    String stateDB = rs2.getString("state_name");
                    bean.setArea(areaDB);
                    bean.setPostoffice(postofficeDB);
                    bean.setPostcode(postcodeDB);
                    bean.setState(stateDB);
                }
                bean.setName(nameDB);
                bean.setEmail(emailDB);
                bean.setPhone(phoneDB);
                bean.setUserType(typeDB);
                bean.setId(idDB);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }
}
