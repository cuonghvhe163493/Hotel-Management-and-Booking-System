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
   public boolean createService(String serviceName, String description, double price) {
    // FIX: Loại bỏ tham số boolean và thêm giá trị '0' (false) vào lệnh INSERT
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

// 🔹 UPDATE SERVICE
public boolean updateService(int serviceId, String serviceName, String description, double price) {
    // FIX: Loại bỏ tham số boolean và không cần cập nhật cột đó
    String sql = "UPDATE dbo.Services SET service_name=?, description=?, price=?, updated_at=GETDATE() WHERE service_id=?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, serviceName);
        ps.setString(2, description);
        ps.setDouble(3, price);
        ps.setInt(4, serviceId); // serviceId là tham số thứ 4
        
        return ps.executeUpdate() > 0;
    } catch (SQLException e) { /* ... */ return false; }
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