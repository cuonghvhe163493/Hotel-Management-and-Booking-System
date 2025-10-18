/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.ServiceManagement;

import model.Service;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBConnection;

/**
 *
 * @author admin
 */
public class ServiceDAO extends DBConnection{
    
    public ServiceDAO() {
        super();
    }

    // Đếm tổng số service theo bộ lọc
    public int countService(String search, Integer included) {
        int count = 0;
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) " +
            "FROM dbo.Services s " +
            "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.service_name LIKE ? OR s.description LIKE ?) ");
            String like = "%" + search.trim() + "%";
            params.add(like);
            params.add(like);
        }

        if (included != null) {
            sql.append("AND s.is_included = ? ");
            params.add(included.intValue() == 1);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            // bind params
            int idx = 1;
            for (Object p : params) {
                if (p instanceof String) {
                    ps.setNString(idx++, (String) p);    // NVARCHAR
                } else if (p instanceof Boolean) {
                    ps.setBoolean(idx++, (Boolean) p);   // BIT
                } else {
                    ps.setObject(idx++, p);
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Lấy danh sách service có phân trang
    public List<Service> getServicesWithPagination(String search, Integer included, int page, int pageSize) {
        List<Service> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT s.service_id, s.service_name, s.description, s.is_included, s.price, s.created_at, s.updated_at " +
            "FROM dbo.Services s " +
            "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.service_name LIKE ? OR s.description LIKE ?) ");
            String like = "%" + search.trim() + "%";
            params.add(like);
            params.add(like);
        }

        if (included != null) {
            sql.append("AND s.is_included = ? ");
            params.add(included.intValue() == 1);
        }

        // SQL Server paging
        sql.append("ORDER BY s.created_at DESC, s.service_id DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");

        int safePage = page > 0 ? page : 1;
        int safeSize = pageSize > 0 ? pageSize : 10;
        int offset = (safePage - 1) * safeSize;
        params.add(offset);
        params.add(safeSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object p : params) {
                if (p instanceof String) {
                    ps.setNString(idx++, (String) p);
                } else if (p instanceof Boolean) {
                    ps.setBoolean(idx++, (Boolean) p);
                } else if (p instanceof Integer) {
                    ps.setInt(idx++, (Integer) p);
                } else {
                    ps.setObject(idx++, p);
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service s = map(rs);
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Chi tiết 1 service theo ID
    public Service getServiceDetailById(int serviceId) {
        String sql = "SELECT service_id, service_name, description, is_included, price, created_at, updated_at " +
                     "FROM dbo.Services WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tạo mới service
    public int addService(Service s) {
        String sql = "INSERT INTO dbo.Services (service_name, description, is_included, price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setNString(1, s.getServiceName());
            if (s.getDescription() != null) ps.setNString(2, s.getDescription()); else ps.setNull(2, Types.NVARCHAR);
            ps.setBoolean(3, s.isIncluded());
            if (s.getPrice() != null) ps.setBigDecimal(4, s.getPrice()); else ps.setNull(4, Types.DECIMAL);

            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Cập nhật service
    public boolean updateService(Service s) {
        String sql = "UPDATE dbo.Services SET service_name = ?, description = ?, is_included = ?, price = ?, updated_at = GETDATE() " +
                     "WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setNString(1, s.getServiceName());
            if (s.getDescription() != null) ps.setNString(2, s.getDescription()); else ps.setNull(2, Types.NVARCHAR);
            ps.setBoolean(3, s.isIncluded());
            if (s.getPrice() != null) ps.setBigDecimal(4, s.getPrice()); else ps.setNull(4, Types.DECIMAL);
            ps.setInt(5, s.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xoá service
    public boolean deleteService(int serviceId) {
        String sql = "DELETE FROM dbo.Services WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Nếu vướng FK từ Room_Services → cân nhắc soft-delete (is_included = 0)
            e.printStackTrace();
            return false;
        }
    }

    // Bật/tắt included nhanh (soft toggle)
    public boolean toggleIncluded(int serviceId) {
        String sql = "UPDATE dbo.Services SET is_included = 1 - CAST(is_included AS INT), updated_at = GETDATE() WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra trùng tên (nếu bạn cần rule duy nhất theo tên)
    public boolean isServiceNameTaken(String serviceName, Integer exceptId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM dbo.Services WHERE service_name = ?");
        if (exceptId != null) sql.append(" AND service_id <> ?");
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setNString(1, serviceName);
            if (exceptId != null) ps.setInt(2, exceptId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ====== Helper map ResultSet -> Model ======
    private Service map(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setServiceId(rs.getInt("service_id"));
        s.setServiceName(rs.getNString("service_name"));
        s.setDescription(rs.getNString("description"));
        s.setIncluded(rs.getBoolean("is_included"));
        s.setPrice(rs.getBigDecimal("price"));
        Timestamp c = rs.getTimestamp("created_at");
        Timestamp u = rs.getTimestamp("updated_at");
        if (c != null) s.setCreatedAt(c.toLocalDateTime());
        if (u != null) s.setUpdatedAt(u.toLocalDateTime());
        return s;
    }
}
