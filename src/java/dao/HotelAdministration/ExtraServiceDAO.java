package dao.HotelAdministration;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ExtraService; // Dùng model.ExtraService
import utils.DBConnection;
import java.util.Date;
import model.Reservation;

public class ExtraServiceDAO {
    
    // Helper method to map ResultSet to ExtraService object
    private ExtraService extractExtraServiceFromResultSet(ResultSet rs) throws SQLException {
        // Dựa trên DDL, các cột là: extra_service_id, reservation_id, service_name, service_description, service_price, status
        return new ExtraService(
            rs.getInt("extra_service_id"),
            rs.getInt("reservation_id"),
            rs.getString("service_name"),
            rs.getString("service_description"),
            rs.getDouble("service_price"),
            rs.getTimestamp("service_start_time"),
            rs.getTimestamp("service_end_time"),
            rs.getString("status"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
    }

    // 🔹 1. Lấy tất cả các Extra Service
    public List<ExtraService> getAllExtraServices() {
        List<ExtraService> services = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Extra_Services ORDER BY extra_service_id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                services.add(extractExtraServiceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getAllExtraServices: " + e.getMessage());
            e.printStackTrace();
        }
        return services;
    }

    // 🔹 2. Tạo Extra Service mới (CREATE)
    public boolean createExtraService(int reservationId, String serviceName, String description, double price, Date startTime, Date endTime) {
        // Trạng thái mặc định là 'pending'
        String sql = "INSERT INTO dbo.Extra_Services (reservation_id, service_name, service_description, service_price, service_start_time, service_end_time, status, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 'pending', GETDATE(), GETDATE())";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reservationId);
            ps.setString(2, serviceName);
            ps.setString(3, description);
            ps.setDouble(4, price);
            ps.setTimestamp(5, new java.sql.Timestamp(startTime.getTime()));
            ps.setTimestamp(6, new java.sql.Timestamp(endTime.getTime()));

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in createExtraService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // 🔹 3. Cập nhật Extra Service (UPDATE)
    public boolean updateExtraService(int serviceId, int reservationId, String serviceName, String description, double price, Date startTime, Date endTime, String status) {
        String sql = "UPDATE dbo.Extra_Services SET reservation_id=?, service_name=?, service_description=?, service_price=?, service_start_time=?, service_end_time=?, status=?, updated_at=GETDATE() WHERE extra_service_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reservationId);
            ps.setString(2, serviceName);
            ps.setString(3, description);
            ps.setDouble(4, price);
            ps.setTimestamp(5, new java.sql.Timestamp(startTime.getTime()));
            ps.setTimestamp(6, new java.sql.Timestamp(endTime.getTime()));
            ps.setString(7, status);
            ps.setInt(8, serviceId);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in updateExtraService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 🔹 4. Xóa Extra Service (DELETE)
    public boolean deleteExtraService(int serviceId) {
        String sql = "DELETE FROM dbo.Extra_Services WHERE extra_service_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in deleteExtraService: " + e.getMessage());
            e.printStackTrace();
            // Ném lỗi Khóa ngoại nếu cần
            if (e.getErrorCode() == 547 || e.getMessage().contains("REFERENCE constraint")) { 
                throw new RuntimeException("FK_VIOLATION"); 
            }
            return false;
        }
    }
    
    public List<Reservation> getAllReservations() {
    List<Reservation> reservations = new ArrayList<>();
    // Chỉ lấy các đặt chỗ đang hoạt động (confirmed, checked_in, completed)
    // SỬA: Lấy tất cả các cột cần thiết, bao gồm cả cột nullable (voucher_id)
    String sql = "SELECT * FROM dbo.Reservations WHERE status IN ('confirmed', 'completed', 'checked_in') ORDER BY reservation_id DESC";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            
            // Xử lý cột nullable (voucher_id) để tránh lỗi NumberFormatException
            Integer voucherId = rs.getObject("voucher_id") != null ? rs.getInt("voucher_id") : null;
            
            // Tạo đối tượng Reservation
            reservations.add(new Reservation(
                rs.getInt("reservation_id"),
                rs.getInt("customer_id"),
                rs.getInt("room_id"),
                voucherId, // Dùng Integer cho cột nullable
                rs.getDate("check_in_date"),
                rs.getDate("check_out_date"),
                rs.getInt("number_of_people"),
                rs.getInt("number_of_rooms"),
                rs.getString("status"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
            ));
        }
    } catch (SQLException e) {
        System.err.println("❌ SQL Error in getAllReservations: " + e.getMessage());
        e.printStackTrace();
        // Nếu lỗi, nên kiểm tra log server (Console) để biết lỗi chính xác là gì.
    }
    return reservations;
}
}
