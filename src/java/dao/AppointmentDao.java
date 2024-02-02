package dao;

import java.sql.*;
import util.DBConnection;
import bean.Appointment;
import bean.User;
import java.util.List;
import java.util.ArrayList;

public class AppointmentDao {
    Connection con = DBConnection.createConnection();
    String query;
    PreparedStatement stmt;
    ResultSet rs;
    
    public String insertAppointment(Appointment app, int id) {
        int userid = id;
        int dentistid = app.getDoctor();
        String date = app.getDate();
        String time = app.getTime();
        String message = app.getMessage();
        try {
            query="INSERT INTO appointment (dentistid, userid, date, time, message) VALUES (?,?,?,?,?)";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, dentistid);
            stmt.setInt(2, userid);
            stmt.setString(3, date);
            stmt.setString(4, time);
            stmt.setString(5, message);
            stmt.executeUpdate();
            
            return "SUCCESS";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "FAILED";
    }
    public String deleteAppointment(int id) {
        int userid = id;
        
        try {
            query="DELETE FROM appointment WHERE userid=?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, userid);
            stmt.executeUpdate();
            
            return "SUCCESS";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "FAILED";
    }
    public Appointment hasAppointment(User user) {
        String email = user.getEmail();
        Appointment app = new Appointment();
        try {
            query = "SELECT U.NAME, U.EMAIL, U.PHONE, A.DENTISTID, A.MESSAGE, A.DATE, A.TIME FROM APPOINTMENT A INNER JOIN USERS U ON A.USERID = U.USERID WHERE EMAIL=?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            while(rs.next()) {
                app.setName(rs.getString("name"));
                app.setEmail(rs.getString("email"));
                app.setPhone(rs.getString("phone"));
                app.setDoctor(rs.getInt("dentistid"));
                app.setMessage(rs.getString("message"));
                app.setDate(rs.getString("date"));
                app.setTime(rs.getString("time"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return app;
    }
    public List<Appointment> getAppointmentList(int id) {
        List<Appointment> list = new ArrayList<>();
        
        try {
            query = "SELECT DENTISTID FROM DENTIST WHERE USERID=?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            while(rs.next()) {
                int dentistid = rs.getInt("dentistid");
                query = "SELECT U.NAME, U.EMAIL, U.PHONE, A.DATE, A.TIME, A.MESSAGE FROM APPOINTMENT A INNER JOIN USERS U ON U.USERID = A.USERID WHERE A.DENTISTID = ?";
                stmt = con.prepareStatement(query);
                stmt.setInt(1, dentistid);
                rs = stmt.executeQuery();
                while(rs.next()) {
                    Appointment app = new Appointment();
                    app.setName(rs.getString("name"));
                    app.setEmail(rs.getString("email"));
                    app.setPhone(rs.getString("phone"));
                    app.setDoctor(id);
                    app.setMessage(rs.getString("message"));
                    app.setDate(rs.getString("date"));
                    app.setTime(rs.getString("time"));
                    list.add(app);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
