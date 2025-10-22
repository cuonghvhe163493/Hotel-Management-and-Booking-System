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
public class ExtraServiceBookingDAO extends DBConnection {

    public boolean addExtraServiceToReservation(int reservationId, int extraServiceId, int quantity, java.math.BigDecimal unitPrice) {
        if (quantity <= 0) {
            quantity = 1;
        }

        String sql = "INSERT INTO ReservationExtraService "
                + "(ReservationID, ExtraServiceID, Quantity, UnitPrice) "
                + "VALUES (?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            ps.setInt(2, extraServiceId);
            ps.setInt(3, quantity);
            ps.setBigDecimal(4, unitPrice);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
