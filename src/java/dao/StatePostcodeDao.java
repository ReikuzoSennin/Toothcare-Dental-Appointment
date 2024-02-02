package dao;

import java.sql.*;
import util.DBConnection;
import java.util.List;
import java.util.ArrayList;
import bean.State;
import bean.Postcode;
import bean.Area;

public class StatePostcodeDao {
    Connection con = DBConnection.createConnection();
    PreparedStatement stmt;
    String query;
    ResultSet rs;
    
    public List<State> getAllState() {
        List<State> list = new ArrayList<>();
        
        try {
            query = "SELECT * FROM state";
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();
            
            while(rs.next()) {
                State state = new State();
                state.setState_code(rs.getString("state_code"));
                state.setState_name(rs.getString("state_name"));
                list.add(state);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Postcode> getPostcodeByStateCode(String code) {
        List<Postcode> list = new ArrayList<>();
        try {
            query = "SELECT * FROM postcode WHERE state_code=?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, String.valueOf(code));
            rs = stmt.executeQuery();
            
            while(rs.next()) {
                Postcode postcode = new Postcode();
                postcode.setPostcode(rs.getString("postcode"));
                postcode.setState_code(rs.getString("state_code"));
                list.add(postcode);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Area> getAreaByPostcode(String code) {
        List<Area> list = new ArrayList<>();
        try {
            query = "SELECT * FROM area WHERE postcode=?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, String.valueOf(code));
            rs = stmt.executeQuery();
            
            while(rs.next()) {
                Area area = new Area();
                area.setAreaID(rs.getInt("areaID"));
                area.setArea_name(rs.getString("area_name"));
                area.setPost_office(rs.getString("post_office"));
                area.setPostcode(rs.getString("postcode"));
                list.add(area);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
