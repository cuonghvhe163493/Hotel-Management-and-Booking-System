/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.Staymanagement;

/**
 *
 * @author Admin
 */
import java.sql.*;
import java.util.*;
import model.StayRoom;
import utils.DBConnection;

public class StayRoomDAO {

    public List<StayRoom> getAllRooms(int id) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT r.*,\n"
                + "       br.check_in_date,\n"
                + "       br.check_out_date,\n"
                + "       br.status,\n"
                + "       r.room_type,\n"
                + "       r.room_number,\n"
                + "       r.room_id,\n"
                + "       b.booking_id\n"
                + "FROM bookings b\n"
                + "JOIN booking_rooms br ON b.booking_id = br.booking_id\n"
                + "JOIN rooms r ON br.room_id = r.room_id\n"
                + "WHERE b.customer_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);  

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setStatus(rs.getString("status"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    r.setCheckOutDate(rs.getDate("check_out_date"));
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setRoomType(rs.getString("room_type"));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }
}
