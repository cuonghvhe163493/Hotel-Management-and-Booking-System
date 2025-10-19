package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=HotelManagerNo7Test;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "sa";  // Thay bằng user của bạn
    private static final String PASSWORD = "1234";  // Thay bằng mật khẩu thực tế

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Tải driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Tạo kết nối
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Kết nối SQL Server thành công!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Không tìm thấy JDBC Driver: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("❌ Lỗi kết nối CSDL: " + e.getMessage());
        }
        return conn;
    }
}
