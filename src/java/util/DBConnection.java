package util;

import java.sql.*;

public class DBConnection {
    public static Connection createConnection() {
        Connection con = null;
        String url = "jdbc:derby://localhost:1527/dental; create=true;";
        String username = "app";
        String password = "app";
        try {
            try {
                Class.forName("com.apache.derby.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            con = DriverManager.getConnection(url, username, password);
            System.out.println("Printing Connection Object "+con);
        } catch (Exception e) {
            e.printStackTrace();
        } return con;
    }
}
