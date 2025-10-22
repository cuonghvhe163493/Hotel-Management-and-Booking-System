/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.ServiceManagement;

import model.Service;
import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class SerivceDetailDAO extends DBConnection {

    /* -------- COUNT -------- */
    public int countServices(String search) {
        String sql
                = "SELECT COUNT(*) "
                + "FROM Services s "
                + "WHERE (? = '' OR s.name LIKE ? OR s.code LIKE ? OR s.description LIKE ?)";
        String q = (search == null) ? "" : search.trim();

        try (Connection con = DBConnection.getConnection(); 
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, q);
            ps.setString(2, "%" + q + "%");
            ps.setString(3, "%" + q + "%");
            ps.setString(4, "%" + q + "%");

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("countServices failed", e);
        }
    }

    /* -------- LIST + PHÂN TRANG -------- */
    public List<Service> getServicesWithPagination(String search, int page, int pageSize) {
        String sql
                = "SELECT s.service_id, s.code, s.name, s.description, s.unit, "
                + "       s.tax_class, s.is_active, s.created_at "
                + "FROM Services s "
                + "WHERE (? = '' OR s.name LIKE ? OR s.code LIKE ? OR s.description LIKE ?) "
                + "ORDER BY s.name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        String q = (search == null) ? "" : search.trim();
        int offset = Math.max(0, (page - 1) * pageSize);
        List<Service> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); 
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, q);
            ps.setString(2, "%" + q + "%");
            ps.setString(3, "%" + q + "%");
            ps.setString(4, "%" + q + "%");
            ps.setInt(5, offset);
            ps.setInt(6, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("getServicesWithPagination failed", e);
        }
        return list;
    }

    /* -------- FIND BY ID -------- */
    public Service findById(long id) {
        String sql
                = "SELECT s.service_id, s.code, s.name, s.description, s.unit, "
                + "       s.tax_class, s.is_active, s.created_at "
                + "FROM Services s WHERE s.service_id = ?";

        try (Connection con = DBConnection.getConnection(); 
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("findById failed", e);
        }
        return null;
    }

    /* -------- MAP RESULTSET -------- */
    private Service mapRow(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setServiceId(rs.getLong("service_id"));
        s.setCode(rs.getString("code"));
        s.setName(rs.getString("name"));
        s.setDescription(rs.getString("description"));
        s.setUnit(rs.getString("unit"));
        s.setTaxClass(rs.getString("tax_class"));
        s.setActive(rs.getBoolean("is_active"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            s.setCreatedAt(ts.toInstant().atOffset(ZoneOffset.UTC));
        }
        return s;
    }

    public List<Service> findRelated(long currentId, int limit) {
        String sql
                = "SELECT TOP (?) service_id, code, name, description, unit, "
                + "       tax_class, is_active, created_at "
                + "FROM Services "
                + "WHERE service_id <> ? "
                + // loại bỏ chính nó
                "ORDER BY NEWID()";                        // random thứ tự (SQL Server)

        List<Service> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setLong(2, currentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service s = new Service();
                    s.setServiceId(rs.getLong("service_id"));
                    s.setCode(rs.getString("code"));
                    s.setName(rs.getString("name"));
                    s.setDescription(rs.getString("description"));
                    s.setUnit(rs.getString("unit"));
                    s.setTaxClass(rs.getString("tax_class"));
                    s.setActive(rs.getBoolean("is_active"));

                    Timestamp ts = rs.getTimestamp("created_at");
                    if (ts != null) {
                        s.setCreatedAt(ts.toInstant().atOffset(ZoneOffset.UTC));
                    }

                    list.add(s);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("findRelated failed", e);
        }

        return list;
    }

    public Long getMinPriceCents(long serviceId) {
        String sql
                = "SELECT CAST(MIN(unit_price * 100) AS BIGINT) AS min_price_cents "
                + "FROM Service_Prices "
                + "WHERE service_id = ?";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Object val = rs.getObject("min_price_cents");
                    if (val != null) {
                        return ((Number) val).longValue();
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("getMinPriceCents failed", e);
        }

        return null; // Không có giá nào
    }

}
