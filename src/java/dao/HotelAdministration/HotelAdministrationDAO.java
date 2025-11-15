package dao.HotelAdministration;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
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
    
    //  Lấy số lượng Receptionists 
    public int getReceptionistCount() {
        String query = "SELECT COUNT(*) FROM dbo.Users WHERE LOWER(role) = 'hotel_manager'"; 
        return executeCountQuery(query, "getReceptionistCount");
    }

    //  Lấy số lượng Customers 
    public int getCustomerCount() {
        String query = "SELECT COUNT(*) FROM dbo.Users WHERE LOWER(role) = 'customer'"; 
        return executeCountQuery(query, "getCustomerCount");
    }

    //  Lấy số lượng phòng còn trống
    public int getAvailableRoomsCount() {
        String query = "SELECT COUNT(*) FROM dbo.Rooms WHERE LOWER(room_status) = 'available'";
        return executeCountQuery(query, "getAvailableRoomsCount");
    }

    //  Lấy số lượng phòng đã đặt
    public int getOccupiedRoomsCount() {
        String query = "SELECT COUNT(*) FROM dbo.Rooms WHERE LOWER(room_status) = 'occupied'";
        return executeCountQuery(query, "getOccupiedRoomsCount");
    }

    //  Lấy điểm đánh giá trung bình
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
    
    // Trong dao/HotelAdministration/HotelAdministrationDAO.java

// 🟢 PHƯƠNG THỨC MỚI: Lấy số lượng đơn đặt chỗ theo trạng thái (Pending, Completed, etc.)
public Map<String, Integer> getBookingStatusCounts() {
    Map<String, Integer> counts = new HashMap<>();
    // Truy vấn SELECT status, COUNT(*) FROM dbo.Bookings GROUP BY status
    String sql = "SELECT status, COUNT(*) AS status_count FROM dbo.Bookings GROUP BY status";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            counts.put(rs.getString("status"), rs.getInt("status_count"));
        }
    } catch (SQLException e) {
        System.err.println("❌ SQL Error in getBookingStatusCounts: " + e.getMessage());
        e.printStackTrace();
    }
    return counts;
}
// Trong dao/HotelAdministration/HotelAdministrationDAO.java

// 🟢 PHƯƠNG THỨC MỚI: Lấy số lượng phòng theo loại và trạng thái
public Map<String, Map<String, Integer>> getRoomOccupancyByType() {
    // Key ngoài: room_type (Suite, Single, Double), Key trong: 'Total', 'Occupied'
    Map<String, Map<String, Integer>> roomData = new HashMap<>();

    // Truy vấn tổng hợp để lấy tổng số và số lượng occupied cho từng loại
    String sql = "SELECT room_type, " +
                 "COUNT(room_id) AS Total, " +
                 "SUM(CASE WHEN LOWER(room_status) = 'occupied' THEN 1 ELSE 0 END) AS Occupied " +
                 "FROM dbo.Rooms " +
                 "GROUP BY room_type";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            String type = rs.getString("room_type");
            int total = rs.getInt("Total");
            int occupied = rs.getInt("Occupied");
            
            Map<String, Integer> counts = new HashMap<>();
            counts.put("Total", total);
            counts.put("Occupied", occupied);
            
            roomData.put(type, counts);
        }
    } catch (SQLException e) {
        System.err.println("❌ SQL Error in getRoomOccupancyByType: " + e.getMessage());
        e.printStackTrace();
    }
    return roomData;
}
}