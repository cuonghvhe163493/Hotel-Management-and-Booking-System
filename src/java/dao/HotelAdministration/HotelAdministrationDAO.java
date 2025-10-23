package dao.HotelAdministration;

import java.sql.*;
import utils.DBConnection;

public class HotelAdministrationDAO {
    
    private int executeCountQuery(String query, String methodName) {
        int count = 0;
        Connection conn = null;
        
        try {
            conn = DBConnection.getConnection(); 
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1); 
                }
            }
        } catch (SQLException e) {
            System.err.println("Database: SQL Server");
            System.err.println("❌ CRITICAL SQL ERROR in " + methodName + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return count;
    }
    
    // 🔹 Lấy số lượng Receptionists (Dùng LOWER)
    public int getReceptionistCount() {
        String query = "SELECT COUNT(*) FROM dbo.Users WHERE LOWER(role) = 'hotel_manager'"; 
        return executeCountQuery(query, "getReceptionistCount");
    }

    // 🔹 Lấy số lượng Customers (Dùng LOWER)
    public int getCustomerCount() {
        String query = "SELECT COUNT(*) FROM dbo.Users WHERE LOWER(role) = 'customer'"; 
        return executeCountQuery(query, "getCustomerCount");
    }

    // 🔹 Lấy số lượng phòng còn trống
    public int getAvailableRoomsCount() {
        String query = "SELECT COUNT(*) FROM dbo.Rooms WHERE LOWER(room_status) = 'available'";
        return executeCountQuery(query, "getAvailableRoomsCount");
    }

    // 🔹 Lấy số lượng phòng đã đặt
    public int getOccupiedRoomsCount() {
        String query = "SELECT COUNT(*) FROM dbo.Rooms WHERE LOWER(room_status) = 'occupied'";
        return executeCountQuery(query, "getOccupiedRoomsCount");
    }

    // 🔹 Lấy điểm đánh giá trung bình
    public double getAverageRating() {
        double avgRating = 0.0;
        String query = "SELECT AVG(rating) FROM dbo.Feedback"; 
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