package dao.HotelAdministration;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Voucher; 
import utils.DBConnection;
import java.util.Calendar;
import java.util.Date; 

public class VoucherDAO {
    
   
    private Voucher extractVoucherFromResultSet(ResultSet rs) throws SQLException {
     
        return new Voucher(
            rs.getInt("voucher_id"),
            rs.getString("code"),
            rs.getString("description"),
            rs.getString("discount_type"), 
            rs.getDouble("discount_value"),
            rs.getDouble("min_spend"),
            rs.getDate("start_date"),
            rs.getDate("end_date"),
            rs.getInt("usage_limit"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
    }

    
    public List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Vouchers ORDER BY voucher_id ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                vouchers.add(extractVoucherFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in getAllVouchers: " + e.getMessage());
            e.printStackTrace();
        }
        return vouchers;
    }
    
   
    public boolean createVoucher(String code, double discountValue, String description) {
        String discountType = (discountValue <= 1.0 && discountValue > 0) ? "percentage" : "fixed"; 
        
       
        String sql = "INSERT INTO dbo.Vouchers (code, description, discount_type, discount_value, min_spend, start_date, end_date, usage_limit, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, 0.00, GETDATE(), DATEADD(year, 1, GETDATE()), 100, GETDATE(), GETDATE())"; // min_spend = 0.00, usage_limit = 100
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, code);
            ps.setString(2, description);
            ps.setString(3, discountType);
            ps.setDouble(4, discountValue);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in createVoucher: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

   
    public boolean updateVoucher(int voucherId, String code, double discountValue, String description) {
        String discountType = (discountValue <= 1.0 && discountValue > 0) ? "percentage" : "fixed"; 
        
       
        String sql = "UPDATE dbo.Vouchers SET code=?, description=?, discount_type=?, discount_value=?, min_spend=0.00, updated_at=GETDATE() WHERE voucher_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, code);
            ps.setString(2, description);
            ps.setString(3, discountType);
            ps.setDouble(4, discountValue);
            ps.setInt(5, voucherId); 

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in updateVoucher: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
  
    public boolean deleteVoucher(int voucherId) {
        String sql = "DELETE FROM dbo.Vouchers WHERE voucher_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in deleteVoucher: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}