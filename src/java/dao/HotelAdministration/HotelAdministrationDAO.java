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
    
   
    public int getReceptionistCount() {
        String query = "SELECT COUNT(*) FROM dbo.Users WHERE LOWER(role) = 'hotel_manager'"; 
        return executeCountQuery(query, "getReceptionistCount");
    }


    public int getCustomerCount() {
        String query = "SELECT COUNT(*) FROM dbo.Users WHERE LOWER(role) = 'customer'"; 
        return executeCountQuery(query, "getCustomerCount");
    }

   
    public int getAvailableRoomsCount() {
        String query = "SELECT COUNT(*) FROM dbo.Rooms WHERE LOWER(room_status) = 'available'";
        return executeCountQuery(query, "getAvailableRoomsCount");
    }

   
    public int getOccupiedRoomsCount() {
        String query = "SELECT COUNT(*) FROM dbo.Rooms WHERE LOWER(room_status) = 'occupied'";
        return executeCountQuery(query, "getOccupiedRoomsCount");
    }

   
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
    
   
public Map<String, Integer> getBookingStatusCounts() {
    Map<String, Integer> counts = new HashMap<>();
   
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

public Map<String, Map<String, Integer>> getRoomOccupancyByType() {
  
    Map<String, Map<String, Integer>> roomData = new HashMap<>();

    
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