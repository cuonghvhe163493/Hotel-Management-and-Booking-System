package dao.HotelAdministration;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Service; // Dùng model.Service
import utils.DBConnection;

public class ServiceDAO {
    
    // Helper method to map ResultSet to Service object
    private Service extractServiceFromResultSet(ResultSet rs) throws SQLException {
        // Dựa trên DDL, các cột là: service_id, service_name, description, is_included (bit), price
        return new Service(
            rs.getInt("service_id"),
            rs.getString("service_name"),
            rs.getString("description"),
            rs.getBoolean("is_included"), // Lấy giá trị BIT
            rs.getDouble("price"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
    }

    // 🔹 1. Lấy tất cả các Service
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

    // 🔹 2. Tạo Service mới (CREATE)
    public boolean createService(String serviceName, String description, boolean isIncluded, double price) {
        String sql = "INSERT INTO dbo.Services (service_name, description, is_included, price, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, GETDATE(), GETDATE())";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, serviceName);
            ps.setString(2, description);
            ps.setBoolean(3, isIncluded); // 1 = included, 0 = not included
            ps.setDouble(4, price);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in createService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // 🔹 3. Cập nhật Service (UPDATE)
    public boolean updateService(int serviceId, String serviceName, String description, boolean isIncluded, double price) {
        String sql = "UPDATE dbo.Services SET service_name=?, description=?, is_included=?, price=?, updated_at=GETDATE() WHERE service_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, serviceName);
            ps.setString(2, description);
            ps.setBoolean(3, isIncluded);
            ps.setDouble(4, price);
            ps.setInt(5, serviceId);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in updateService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 🔹 4. Xóa Service (DELETE)
    public boolean deleteService(int serviceId) {
        // Lưu ý: Cần kiểm tra khóa ngoại (dbo.Room_Services, dbo.Extra_Services)
        String sql = "DELETE FROM dbo.Services WHERE service_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in deleteService: " + e.getMessage());
            e.printStackTrace();
             // Nếu lỗi Khóa ngoại (547), ném RuntimeException
            if (e.getErrorCode() == 547 || e.getMessage().contains("REFERENCE constraint")) { 
                throw new RuntimeException("FK_VIOLATION"); 
            }
            return false;
        }
    }
}