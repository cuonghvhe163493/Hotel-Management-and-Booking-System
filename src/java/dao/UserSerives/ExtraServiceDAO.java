/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.UserSerives;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import model.ExtraService;
import model.HotelService;
import utils.DBConnection;
/**
 *
 * @author Legion
 */
public class ExtraServiceDAO {
    
    public List<ExtraService> getServices(
        String nameKeyword,
        Double minPrice,
        Double maxPrice,
        String serviceType,
        int page,
        int pageSize
    ) {
        List<ExtraService> services = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT extra_service_id, service_name, service_description, service_price, status, service_start_time, service_end_time, created_at, updated_at, service_type " +
            "FROM [Extra_Services] WHERE 1=1 "
        );

        // Dynamic filters
        if (nameKeyword != null && !nameKeyword.isEmpty()) {
            sql.append("AND service_name LIKE ? ");
        }
        if (minPrice != null) {
            sql.append("AND service_price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND service_price <= ? ");
        }
        if (serviceType != null && !serviceType.isEmpty()) {
            sql.append("AND service_type = ? ");
        }
        
        sql.append("ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            if (conn == null) {
                System.out.println("❌ Không thể kết nối tới Database.");
                return null;
            }
              int index = 1;

            if (nameKeyword != null && !nameKeyword.isEmpty()) {
                ps.setString(index++, "%" + nameKeyword + "%");
            }
            if (minPrice != null) {
                ps.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(index++, maxPrice);
            }
            if (serviceType != null && !serviceType.isEmpty()) {
                ps.setString(index++, serviceType);
            }

            // Pagination params
            int offset = (page - 1) * pageSize;
            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ExtraService s = new ExtraService();
                    s.setExtraServiceId(rs.getInt("extra_service_id"));
                    s.setServiceName(rs.getString("service_name"));
                    s.setServiceDescription(rs.getString("service_description"));
                    s.setServicePrice(rs.getDouble("service_price"));
                    s.setServiceStartTime(rs.getDate("service_start_time"));
                    s.setServiceStartTime(rs.getDate("service_end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setCreatedAt(rs.getDate("created_at"));
                    s.setUpdatedAt(rs.getDate("updated_at"));
                    s.setServiceType(rs.getString("service_type"));
                    services.add(s);
                }
            }
           
            return services;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    public ExtraService getExtraServiceById(
        int id
    ) {
        String sql = "SELECT extra_service_id, service_name, service_description, service_price, status, service_start_time, service_end_time, created_at, updated_at, service_type " +
                "FROM [Extra_Services] WHERE extra_service_id = ? ";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            if (conn == null) {
                System.out.println("❌ Không thể kết nối tới Database.");
                return null;
            }

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ExtraService s = new ExtraService();
                    s.setExtraServiceId(rs.getInt("extra_service_id"));
                    s.setServiceName(rs.getString("service_name"));
                    s.setServiceDescription(rs.getString("service_description"));
                    s.setServicePrice(rs.getDouble("service_price"));
                    s.setServiceStartTime(rs.getDate("service_start_time"));
                    s.setServiceStartTime(rs.getDate("service_end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setCreatedAt(rs.getDate("created_at"));
                    s.setUpdatedAt(rs.getDate("updated_at"));
                    s.setServiceType(rs.getString("service_type"));
                    return s;
                }
            }
           
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}
