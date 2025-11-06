/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.UserSerives;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import model.HotelService;
import utils.DBConnection;
/**
 *
 * @author Legion
 */
public class ServiceDAO {
    public List<HotelService> getServices(
        String nameKeyword,
        Double minPrice,
        Double maxPrice,
        String serviceType,
        int page,
        int pageSize
    ) {
        List<HotelService> services = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT service_id, service_name, description, is_included, price, created_at, updated_at, service_type " +
            "FROM Services WHERE 1=1 "
        );

        // Dynamic filters
        if (nameKeyword != null && !nameKeyword.isEmpty()) {
            sql.append("AND service_name LIKE ? ");
        }
        if (minPrice != null) {
            sql.append("AND price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND price <= ? ");
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
                    HotelService s = new HotelService();
                    s.setServiceId(rs.getInt("service_id"));
                    s.setServiceName(rs.getString("service_name"));
                    s.setDescription(rs.getString("description"));
                    s.setIsIncluded(rs.getBoolean("is_included"));
                    s.setPrice(rs.getDouble("price"));
                    s.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    s.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
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
    
}
