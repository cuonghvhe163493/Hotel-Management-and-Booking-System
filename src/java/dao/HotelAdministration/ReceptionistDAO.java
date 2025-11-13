package dao.HotelAdministration;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User; 
import utils.DBConnection;

public class ReceptionistDAO {
    
    // Tên vai trò lễ tân trong DB
    private static final String RECEPTIONIST_ROLE = "hotel_manager";

    // Helper method (Dùng để ánh xạ ResultSet sang đối tượng User)
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setRole(rs.getString("role"));
        u.setAccountStatus(rs.getString("account_status"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setDateOfBirth(rs.getDate("date_of_birth"));
        return u;
    }

    // 🔹 1. Lấy tất cả Lễ tân
    public List<User> getAllReceptionists() {
        List<User> receptionists = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Users WHERE role = ? ORDER BY user_id ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, RECEPTIONIST_ROLE);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    receptionists.add(extractUserFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getAllReceptionists: " + e.getMessage());
            e.printStackTrace();
        }
        return receptionists;
    }

    // 🔹 2. Tạo tài khoản Lễ tân mới (CREATE)
    // Fields cần thiết: Username, Password, Email, Phone, Address
    public boolean createReceptionist(String username, String password, String email, String phone, String address) {
        
        // 1. Tạo bản ghi trong bảng Users (Cần trả về ID để tạo FK)
        String sqlUser = "INSERT INTO dbo.Users (username, password, email, role, account_status, phone, address, created_at, updated_at) "
                   + "OUTPUT INSERTED.user_id " // Lệnh SQL Server để lấy ID vừa tạo
                   + "VALUES (?, ?, ?, ?, 'active', ?, ?, GETDATE(), GETDATE())";
        
        // 2. Tạo bản ghi trong bảng Hotel_Managers (Khóa ngoại)
        String sqlManager = "INSERT INTO dbo.Hotel_Managers (manager_id, created_at, updated_at) VALUES (?, GETDATE(), GETDATE())";
        
        int userId = 0;
        Connection conn = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu giao dịch (Transaction)
            
            // --- A. INSERT VÀO USERS ---
            try (PreparedStatement psUser = conn.prepareStatement(sqlUser)) {
                psUser.setString(1, username);
                psUser.setString(2, password); 
                psUser.setString(3, email);
                psUser.setString(4, RECEPTIONIST_ROLE);
                psUser.setString(5, phone);
                psUser.setString(6, address);
                
                ResultSet rs = psUser.executeQuery();
                if (rs.next()) {
                    userId = rs.getInt(1);
                }
            }
            
            if (userId > 0) {
                // --- B. INSERT VÀO HOTEL_MANAGERS (Khóa ngoại) ---
                try (PreparedStatement psManager = conn.prepareStatement(sqlManager)) {
                    psManager.setInt(1, userId);
                    psManager.executeUpdate();
                }
            } else {
                 conn.rollback(); // Nếu không lấy được ID, hủy giao dịch
                 return false;
            }
            
            conn.commit(); // Hoàn tất giao dịch
            return true;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in createReceptionist: " + e.getMessage());
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
             try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
             try { if (conn != null) conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
    }
    
    // 🔹 3. Xóa Lễ tân (Giả định: Xóa khỏi Users sẽ tự động xóa khỏi Hotel_Managers nếu có ON DELETE CASCADE)
    public boolean updateReceptionist(int userId, String username, String email, String phone, String address, String password) {
        String sql = "UPDATE dbo.Users SET username=?, email=?, phone=?, address=?, password=?, updated_at=GETDATE() WHERE user_id=? AND role=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, password); // Cần truyền password cũ/mới
            ps.setInt(6, userId);
            ps.setString(7, RECEPTIONIST_ROLE); // Chỉ cập nhật nếu đúng vai trò

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in updateReceptionist: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 🟢 4. Cập nhật trạng thái tài khoản Lễ tân (Đặt lại Status)
    public boolean updateReceptionistStatus(int userId, String status) {
        // Trạng thái: 'active', 'suspended', 'banned'
        String sql = "UPDATE dbo.Users SET account_status=?, updated_at=GETDATE() WHERE user_id=? AND role=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, userId);
            ps.setString(3, RECEPTIONIST_ROLE); 

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in updateReceptionistStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 🟢 5. Xóa tài khoản Lễ tân (DELETE)
    public boolean deleteReceptionist(int userId) {
        // Chỉ xóa user nếu có vai trò là Lễ tân
        String sql = "DELETE FROM dbo.Users WHERE user_id = ? AND role = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setString(2, RECEPTIONIST_ROLE);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in deleteReceptionist: " + e.getMessage());
            e.printStackTrace();
            // Nếu lỗi Khóa ngoại (547)
            if (e.getErrorCode() == 547 || e.getMessage().contains("REFERENCE constraint")) { 
                throw new RuntimeException("FK_VIOLATION"); 
            }
            return false;
        }
    }
}