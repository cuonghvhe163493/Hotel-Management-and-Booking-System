package dao.HotelAdministration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User; 
import utils.DBConnection; 

public class ChangeUserStatusDAO {
    
   
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User(); 
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        user.setAccountStatus(rs.getString("account_status"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setDateOfBirth(rs.getDate("date_of_birth"));
        return user;
    }
    
   
    public List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();
        
        String query = "SELECT * FROM dbo.Users WHERE role = 'customer' ORDER BY user_id ASC";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                customers.add(extractUserFromResultSet(rs)); 
            }
        } catch (SQLException e) {
            System.out.println(" Lỗi khi lấy tất cả khách hàng: " + e.getMessage());
           
        }
        return customers;
    }
    
 
    public User getUserById(int userId) {
       
        String query = "SELECT * FROM dbo.Users WHERE user_id = ?"; 
        User user = null;
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println(" Lỗi khi lấy user theo ID: " + e.getMessage());
        }
        return user;
    }
    
  
    public boolean updateAccountStatus(int userId, String newStatus) {
        
        String sql = "UPDATE dbo.Users SET account_status = ?, updated_at = GETDATE() WHERE user_id = ? AND role = 'customer'";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newStatus);
            stmt.setInt(2, userId);
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println(" Cập nhật trạng thái User ID " + userId + " thành: " + newStatus);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println(" Lỗi khi cập nhật trạng thái tài khoản: " + e.getMessage());
        }
        return false;
    }
}