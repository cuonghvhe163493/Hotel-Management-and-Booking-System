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
public class ServiceDAO {

    private static final String SQL
            = "SELECT s.service_id, s.code, s.name, s.description, s.unit, s.is_active, "
            + " p.unit_price, p.currency "
            + "FROM services s "
            + "OUTER APPLY ( "
            + "   SELECT TOP 1 unit_price, currency "
            + "   FROM service_prices p "
            + "   WHERE p.service_id = s.service_id "
            + "     AND (p.valid_to IS NULL OR p.valid_to >= CAST(GETDATE() AS DATE)) "
            + "     AND p.valid_from <= CAST(GETDATE() AS DATE) "
            + "   ORDER BY p.valid_from DESC "
            + ") p "
            + "WHERE s.is_active = 1 "
            + "ORDER BY s.name";

    public List<Service> getActiveServicesWithCurrentPrice() {
        List<Service> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); 
                PreparedStatement ps = con.prepareStatement(SQL); 
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Service s = new Service();
                s.setServiceId(rs.getLong("service_id"));
                s.setCode(rs.getString("code"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setUnit(rs.getString("unit"));
                s.setActive(rs.getBoolean("is_active"));
                BigDecimal price = (BigDecimal) rs.getObject("unit_price");
                list.add(s);
            }
        } catch (Exception e) {
            throw new RuntimeException("Load services failed", e);
        }
        return list;
    }
}
