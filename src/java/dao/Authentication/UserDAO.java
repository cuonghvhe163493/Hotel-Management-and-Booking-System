package dao.Authentication;

import java.sql.*;
import model.User;
import utils.DBConnection;
import java.util.Date;

public class UserDAO {

    
    private static User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setEmail(rs.getString("email"));
        u.setRole(rs.getString("role"));
        u.setAccountStatus(rs.getString("account_status"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setDateOfBirth(rs.getDate("date_of_birth"));
        return u;
    }
    
    
    public static User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM dbo.Users WHERE LOWER(username)=LOWER(?) AND password=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (conn == null) {
                System.out.println(" Không thể kết nối tới Database.");
                return null;
            }
            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println(" Login OK: " + rs.getString("username") + " | role=" + rs.getString("role"));
                
                return extractUserFromResultSet(rs);
            } else {
                System.out.println("️ Không tìm thấy user trong database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

   
    public static User getUserByEmail(String email) {
        String query = "SELECT * FROM dbo.Users WHERE LOWER(email)=LOWER(?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email.trim());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Sử dụng Helper
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    public static User getUserById(int userId) {
        String query = "SELECT * FROM dbo.Users WHERE user_id = ?"; 
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
              
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println(" Lỗi khi lấy user theo ID: " + e.getMessage());
        }
        return null;
    }

   
    public static boolean registerUser(String username, String password, String email) {
        String sql = "INSERT INTO dbo.Users (username, password, email, role, account_status, created_at, updated_at) "
                + "VALUES (?, ?, ?, 'customer', 'active', GETDATE(), GETDATE())";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (conn == null) { System.out.println(" Không thể kết nối Database khi đăng ký."); return false; }
            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());
            stmt.setString(3, email.trim());

            int rows = stmt.executeUpdate();
            if (rows > 0) { System.out.println(" Đã đăng ký mới user: " + email); return true; }
        } catch (SQLException e) {
            if (e.getMessage().contains("UNIQUE")) { System.out.println("️ Username hoặc Email đã tồn tại: " + email); } else { System.out.println("❌ Lỗi khi thêm user: " + e.getMessage()); }
        }
        return false;
    }

  
    public static boolean isUsernameExists(String username) {
        String sql = "SELECT user_id FROM dbo.Users WHERE LOWER(username)=LOWER(?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username.trim());
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) { System.out.println(" Lỗi khi kiểm tra username: " + e.getMessage()); }
        return false;
    }

  
    public static boolean isEmailExists(String email) {
        String sql = "SELECT user_id FROM dbo.Users WHERE LOWER(email)=LOWER(?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email.trim());
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) { System.out.println(" Lỗi khi kiểm tra email: " + e.getMessage()); }
        return false;
    }


    public static boolean registerUserFull(String username, String password, String email, String phone, String address, String dob) {
        String sql = "INSERT INTO dbo.Users (username, password, email, phone, address, date_of_birth, role, account_status, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'customer', 'active', GETDATE(), GETDATE())";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());
            stmt.setString(3, email.trim());
            stmt.setString(4, phone.trim());
            stmt.setString(5, address.trim());
            stmt.setString(6, dob);

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(" Lỗi khi đăng ký đầy đủ: " + e.getMessage());
        }
        return false;
    }

   
    public static boolean resetPassword(String username, String newPassword) {
        String sql = "UPDATE Users SET password = ?, updated_at = GETDATE() WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword.trim());
            stmt.setString(2, username.trim());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { System.out.println("❌ Lỗi khi cập nhật mật khẩu: " + e.getMessage()); }
        return false;
    }
    
   
    public static boolean checkUserCredentials(String username, String email, String phone) {
        String sql = "SELECT user_id FROM dbo.Users WHERE LOWER(username) = LOWER(?) AND LOWER(email) = LOWER(?) AND phone = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username.trim());
            stmt.setString(2, email.trim());
            stmt.setString(3, phone.trim());
            
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) { System.out.println(" Lỗi khi kiểm tra thông tin xác thực: " + e.getMessage()); }
        return false;
    }

   
    public static boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE dbo.Users SET password = ?, updated_at = GETDATE() WHERE LOWER(username) = LOWER(?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newPassword.trim()); 
            stmt.setString(2, username.trim());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) { System.out.println(" Lỗi khi cập nhật mật khẩu cuối cùng: " + e.getMessage()); }
        return false;
    }

   
    public static boolean updateUserProfile(int userId, String username, String email, String phone, String password) {
        String sql = "UPDATE dbo.Users "
                   + "SET username = ?, email = ?, phone = ?, password = ?, updated_at = GETDATE() "
                   + "WHERE user_id = ?"; 

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.setInt(5, userId); 

            int rows = ps.executeUpdate();
            System.out.println("[UpdateProfile] rows=" + rows + " for user_id=" + userId);
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error updating profile: " + e.getMessage());
            return false;
        }
    }
}