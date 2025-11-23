package dao.HotelAdministration;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Service; 
import utils.DBConnection;

public class ServiceDAO {
    
   
    private Service extractServiceFromResultSet(ResultSet rs) throws SQLException {
    
        return new Service(
            rs.getInt("service_id"),
            rs.getString("service_name"),
            rs.getString("description"),
            rs.getBoolean("is_included"), 
            rs.getDouble("price"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
    }

   
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Services ORDER BY service_id ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                services.add(extractServiceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getAllServices: " + e.getMessage());
            e.printStackTrace();
        }
        return services;
    }

   
   public boolean createService(String serviceName, String description, double price) {
   
    String sql = "INSERT INTO dbo.Services (service_name, description, price, is_included, created_at, updated_at) "
               + "VALUES (?, ?, ?, 0, GETDATE(), GETDATE())"; // Giá trị 0 là mặc định

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, serviceName);
        ps.setString(2, description);
        ps.setDouble(3, price);
        
        return ps.executeUpdate() > 0;
    } catch (SQLException e) { /* ... */ return false; }
}


public boolean updateService(int serviceId, String serviceName, String description, double price) {
   
    String sql = "UPDATE dbo.Services SET service_name=?, description=?, price=?, updated_at=GETDATE() WHERE service_id=?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, serviceName);
        ps.setString(2, description);
        ps.setDouble(3, price);
        ps.setInt(4, serviceId); 
        
        return ps.executeUpdate() > 0;
    } catch (SQLException e) { /* ... */ return false; }
}
    
    
    public boolean deleteService(int serviceId) {
     
        String sql = "DELETE FROM dbo.Services WHERE service_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in deleteService: " + e.getMessage());
            e.printStackTrace();
           
            if (e.getErrorCode() == 547 || e.getMessage().contains("REFERENCE constraint")) { 
                throw new RuntimeException("FK_VIOLATION"); 
            }
            return false;
        }
    }
}