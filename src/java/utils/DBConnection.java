package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=HotelManagerNo7Test";
    private static final String USER = "sa"; // Replace with your DB username
    private static final String PASSWORD = "1234"; // Replace with your DB password
    public static Connection connection;

    public static Connection getConnection() throws SQLException {
        if (connection == null) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
