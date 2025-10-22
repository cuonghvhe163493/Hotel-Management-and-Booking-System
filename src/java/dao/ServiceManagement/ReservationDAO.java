/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.ServiceManagement;


import utils.DBConnection;
import java.sql.*;

/**
 *
 * @author admin
 */
public class ReservationDAO extends DBConnection{
     /** Trả về true nếu user có ít nhất 1 booking phòng còn hiệu lực */
    public boolean hasActiveReservation(int userId) {
        String sql = "SELECT 1 FROM Reservation " +
                     "WHERE UserID = ? " +
                     "  AND Status IN ('CONFIRMED','CHECKIN') " +
                     "  AND (CheckOutDate IS NULL OR CheckOutDate > GETDATE())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // có dòng nào => có booking active
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Integer getActiveReservationId(int userId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
