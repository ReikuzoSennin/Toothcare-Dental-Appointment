package dao;

import java.sql.*;
import util.DBConnection;
import java.util.List;
import java.util.ArrayList;
import bean.Dentist;
import bean.User;

public class DentistDao {
    Connection con = DBConnection.createConnection();
    String query;
    PreparedStatement stmt;
    ResultSet rs;
    
    public List<Dentist> getDentistList(String clause) {
        List<Dentist> list = new ArrayList();
        
        try {
            query = "SELECT U.NAME, D.DENTISTID, D.ROLE, D.DESCRIPTION, D.IMAGE FROM DENTIST D INNER JOIN USERS U ON D.USERID = U.USERID "+clause;
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();
            
            while(rs.next()) {
                Dentist dentist = new Dentist();
                dentist.setName(rs.getString("name"));
                dentist.setRole(rs.getString("role"));
                dentist.setDescription(rs.getString("description"));
                dentist.setImage(rs.getString("image"));
                dentist.setId(rs.getInt("dentistid"));
                list.add(dentist);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Dentist getDentist(User user) {
        int id = user.getId();
        
        Dentist bean = new Dentist();
        try {
            query = "SELECT U.NAME, D.DENTISTID, D.ROLE, D.DESCRIPTION, D.IMAGE FROM DENTIST D INNER JOIN USERS U ON D.USERID = U.USERID WHERE D.USERID=?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            while(rs.next()) {
                String nameDB = rs.getString("name");
                String roleDB = rs.getString("role");
                String descDB = rs.getString("description");
                String imageDB = rs.getString("image");
                int idDB = rs.getInt("dentistid");
                bean.setName(nameDB);
                bean.setRole(roleDB);
                bean.setDescription(descDB);
                bean.setImage(imageDB);
                bean.setId(idDB);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }
}
