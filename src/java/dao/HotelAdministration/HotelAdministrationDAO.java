package dao.HotelAdministration;

import java.sql.*;
import utils.DBConnection;

public class HotelAdministrationDAO {
    
    // Cấu trúc Try-Finally mới để xử lý lỗi kết nối
    private static int executeCountQuery(String query, String methodName) {
        int count = 0;
        Connection conn = null; // Khai báo Connection ngoài try
        
        try {
            conn = DBConnection.getConnection(); // Lấy kết nối
            
            // Khối Try-with-resources cho PreparedStatement
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1); 
                }
            }
        } catch (SQLException e) {
            // In ra lỗi SQL Server chi tiết để gỡ lỗi
            System.err.println("Database: SQL Server");
            System.err.println("❌ CRITICAL SQL ERROR in " + methodName + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return count;
    }
    
    // 🔹 Lấy số lượng Receptionists
    public static int getReceptionistCount() {
        // Đã sửa role = 'Receptionist'
        String query = "SELECT COUNT(*) FROM users WHERE role = 'Receptionist'"; 
        return executeCountQuery(query, "getReceptionistCount");
    }

    // 🔹 Lấy số lượng Customers
    public static int getCustomerCount() {
        // Đã sửa role = 'Customer'
        String query = "SELECT COUNT(*) FROM users WHERE role = 'Customer'"; 
        return executeCountQuery(query, "getCustomerCount");
    }

    // 🔹 Lấy số lượng phòng còn trống
    public static int getAvailableRoomsCount() {
        String query = "SELECT COUNT(*) FROM rooms WHERE room_status = 'available'";
        return executeCountQuery(query, "getAvailableRoomsCount");
    }

    // 🔹 Lấy số lượng phòng đã đặt
    public static int getBookedRoomsCount() {
        String query = "SELECT COUNT(*) FROM rooms WHERE room_status = 'occupied'";
        return executeCountQuery(query, "getBookedRoomsCount");
    }

    // 🔹 Lấy điểm đánh giá trung bình
    public static double getAverageRating() {
        double avgRating = 0.0;
        String query = "SELECT AVG(rating) FROM feedback";
        Connection conn = null; 
        
        try {
            conn = DBConnection.getConnection(); 
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    double result = rs.getDouble(1);
                    if (!rs.wasNull()) {
                        avgRating = result;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Database: SQL Server");
            System.err.println("❌ CRITICAL SQL ERROR in getAverageRating: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return avgRating; 
    }
}