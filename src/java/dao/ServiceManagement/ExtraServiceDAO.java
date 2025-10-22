/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.ServiceManagement;

import utils.DBConnection;
import model.ExtraService;
import java.sql.*;
import java.util.*;

/**
 *
 * @author admin
 */
public class ExtraServiceDAO extends DBConnection {

    private ExtraService mapRow(ResultSet rs) throws SQLException {
        ExtraService s = new ExtraService();
        s.setExtraServiceId(rs.getInt("ExtraServiceID"));
        s.setReservationId(rs.getInt("ReservationID"));
        s.setServiceName(rs.getString("ServiceName"));
        s.setServiceDescription(rs.getString("ServiceDescription"));
        s.setServicePrice(rs.getDouble("ServicePrice"));
        s.setServiceStartTime(rs.getTimestamp("ServiceStartTime"));
        s.setServiceEndTime(rs.getTimestamp("ServiceEndTime"));
        s.setStatus(rs.getString("Status"));
        s.setCreatedAt(rs.getTimestamp("CreatedAt"));
        s.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return s;
    }

    public ExtraService getById(int id) {
        String sql = "SELECT * FROM ExtraService WHERE ExtraServiceID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy các dịch vụ liên quan (đơn giản: khác id hiện tại, mới nhất)
     */
    public List<ExtraService> findRelated(int exceptId, int limit) {
        String sql = "SELECT TOP " + limit + " * FROM ExtraService "
                + "WHERE ExtraServiceID <> ? "
                + "ORDER BY CreatedAt DESC";

        List<ExtraService> list = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, exceptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

//    public ExtraService getServiceById(int id) {
//         String sql = "SELECT * FROM ExtraService WHERE ExtraServiceID = ?";
//        try (Connection c = getConnection();
//             PreparedStatement ps = c.prepareStatement(sql)) {
//            ps.setInt(1, id);
////            try (ResultSet rs = ps.executeQuery()) {
////                if (rs.next()) return map(rs);
////            }
////        } catch (SQLException e) { e.printStackTrace(); }
//        return null;
//    }
    

    public int create(ExtraService s) {
        String sql = "INSERT INTO ExtraService "
                + "(ServiceName, ServiceDescription, ServicePrice, "
                + " ServiceStartTime, ServiceEndTime, Status, CreatedAt, UpdatedAt) "
                + "VALUES (?,?,?,?,?,?,SYSDATETIME(),NULL)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, s.getServiceName());
            ps.setString(2, s.getServiceDescription());
            ps.setBigDecimal(3, java.math.BigDecimal.valueOf(s.getServicePrice()));

            if (s.getServiceStartTime() != null) {
                ps.setTimestamp(4, new java.sql.Timestamp(s.getServiceStartTime().getTime()));
            } else {
                ps.setNull(4, java.sql.Types.TIMESTAMP);
            }

            if (s.getServiceEndTime() != null) {
                ps.setTimestamp(5, new java.sql.Timestamp(s.getServiceEndTime().getTime()));
            } else {
                ps.setNull(5, java.sql.Types.TIMESTAMP);
            }

            ps.setString(6, s.getStatus());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                return 0;
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
