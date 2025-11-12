package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // 🚨 KIỂM TRA LẠI: Đảm bảo URL, USER và PASSWORD là chính xác 100%
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=HotelManagerNo7Test;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "sa";
    private static final String PASSWORD = "1234"; 

    // Sửa: Thêm "throws SQLException" để thông báo lỗi kết nối ra bên ngoài
    public static Connection getConnection() throws SQLException { 
        Connection conn = null;
        try {
            // Tải driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Tạo kết nối. Nếu lỗi ở đây, nó sẽ nhảy xuống catch(SQLException)
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            
        } catch (ClassNotFoundException e) {
            // Ném lỗi khi không tìm thấy Driver JAR
            throw new SQLException("❌ DRIVER ERROR: Không tìm thấy JDBC Driver SQL Server. Hãy kiểm tra file JAR.", e);
        } catch (SQLException e) {
            // Ném lỗi kết nối CSDL (Sai User/Pass, Server chưa bật,...)
            throw e; 
        }
        return conn; // Chỉ trả về nếu kết nối thành công
    }
}