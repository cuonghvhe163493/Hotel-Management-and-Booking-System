/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.Staymanagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.StayRoom;
import utils.DBConnection;

public class CheckInOut {
    public List<StayRoom> getCheckInRoomForCustomer(int booking_id) {
        List<StayRoom> stayroom = new ArrayList<>();

        String sql = "SELECT "
                + "       br.check_in_date,\n"               
                + "       r.room_number,\n"
                + "       r.room_id,\n"
                + "FROM bookings b\n"
                + "JOIN booking_rooms br ON b.booking_id = br.booking_id\n"
                + "JOIN rooms r ON br.room_id = r.room_id\n"
                + "WHERE b.booking_id = ? and br.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking_id);
            ps.setString(2, "checked_in");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    stayroom.add(r);
                    

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }

    public StayRoom getCheckInRoomForReceptionist(int phoneNumber) {
        StayRoom stayroom = new StayRoom();

        String sql = "SELECT  br.booking_id, br.room_id, br.guests_count, br.status, "
                + "b.check_in_date, b.check_out_date, "
                + "r.room_number, r.room_status, r.room_type, r.capacity, r.price_per_night, "
                + "d.username, d.email"
                + "FROM Booking_Rooms br "
                + "JOIN Rooms r ON br.room_id = r.room_id "
                + "JOIN Bookings b ON br.booking_id = b.booking_id "
                + "JOIN Customers c ON b.customer_id = c.customer_id "
                + "JOIN Users d ON c.customer_id = d.user_id "
                + "WHERE d.phone = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, phoneNumber);

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

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, roomId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error");
        }
        return false;
    }
    
    
    public List<Integer> getBooking(int id) {
        List<Integer> list = new ArrayList<>();

        String sql = "SELECT distinct br.booking_id \n" +
                        "FROM Booking_Rooms br \n" +
                        "JOIN Bookings b ON br.booking_id = b.booking_id \n" +
                        "JOIN Customers c ON b.customer_id = c.customer_id \n" +
                        "WHERE c.customer_id = ? and b.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, "completed"); 
//            confirmed
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("booking_id"));
                    
                    

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }
}
