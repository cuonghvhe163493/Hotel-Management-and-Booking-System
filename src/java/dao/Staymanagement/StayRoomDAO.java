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

    public List<StayRoom> getAllRoomsForCustomer(int id) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "select r.*,\n"
                + "       br.check_in_date,\n"
                + "       br.check_out_date,\n"
                + "       br.status,\n"
                + "       r.room_type,\n"
                + "       r.room_number,\n"
                + "       r.room_id,\n"
                + "       b.booking_id\n"
                + "from bookings b\n"
                + "join booking_rooms br ON b.booking_id = br.booking_id\n"
                + "join rooms r ON br.room_id = r.room_id\n"
                + "where b.customer_id = ?";

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

    public List<StayRoom> getAllRoomsForReceptionist() {
        List<StayRoom> list = new ArrayList<>();

        String sql = "select \n"
                + "    room_id, \n"
                + "    room_number, \n"
                + "    room_status, \n"
                + "    room_type\n"
                + "   from \n"
                + "    Rooms;";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setRoomStatus(rs.getString("room_status"));
                    r.setRoomType(rs.getString("room_type"));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }

    public StayRoom getCheckInRoomForCustomer(int booking_id,int room_id) {
        StayRoom stayroom = new StayRoom();

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

            ps.setInt(1, booking_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    stayroom.setRoomId(rs.getInt("room_id"));
                    stayroom.setRoomNumber(rs.getString("room_number"));
                    stayroom.setStatus(rs.getString("status"));
                    stayroom.setCheckInDate(rs.getDate("check_in_date"));
                    stayroom.setCheckOutDate(rs.getDate("check_out_date"));
                    stayroom.setBookingId(rs.getInt("booking_id"));
                    stayroom.setRoomType(rs.getString("room_type"));

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }

    public StayRoom getCheckInRoomForReceptionist(int booking_id, int room_id) {
        StayRoom stayroom = new StayRoom();

        String sql = "SELECT  br.booking_id, br.room_id, br.guests_count, br.status, " +
                 "b.check_in_date, b.check_out_date, " +
                 "r.room_number, r.room_status, r.room_type, r.capacity, r.price_per_night, " +
                 "d.username, d.email, d.phone " +
                 "FROM Booking_Rooms br " +
                 "JOIN Rooms r ON br.room_id = r.room_id " +
                 "JOIN Bookings b ON br.booking_id = b.booking_id " +
                 "JOIN Customers c ON b.customer_id = c.customer_id " +
                 "JOIN Users d ON c.customer_id = d.user_id " +
                 "WHERE br.booking_id = ? AND br.room_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking_id);
            ps.setInt(2, room_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    stayroom.setRoomId(rs.getInt("room_id"));
                    stayroom.setRoomNumber(rs.getString("room_number"));
                    stayroom.setRoomStatus(rs.getString("room_status"));
                    stayroom.setRoomType(rs.getString("room_type"));
                    stayroom.setCapacity(rs.getInt("capacity"));
                    stayroom.setPricePerNight(rs.getDouble("price_per_night"));
                    stayroom.setBookingId(rs.getInt("booking_id"));
                    stayroom.setGuestCount(rs.getInt("guests_count"));
                    stayroom.setStatus(rs.getString("status"));
                    stayroom.setCheckInDate(rs.getDate("check_in_date"));
                    stayroom.setCheckOutDate(rs.getDate("check_out_date"));
//                    stayroom.setPrice(rs.getDouble("price"));
//                    stayroom.setDeposit(rs.getDouble("deposit"));
//                    stayroom.setCitizenID(rs.getInt("citizen_id"));
                    stayroom.setGmail(rs.getString("email"));
                    stayroom.setPhone(rs.getInt("phone"));
                    stayroom.setName(rs.getString("username"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }
    
    public boolean updateRoomStatus(int roomId, String newStatus) {
    String sql = "UPDATE Rooms SET room_status = ? WHERE room_id = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, newStatus);
        ps.setInt(2, roomId);

        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0;

    } catch (SQLException e) {
        System.out.println("Error");
    }
    return false;
}

    
    
}
