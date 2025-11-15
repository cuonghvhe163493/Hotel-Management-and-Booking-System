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

    //Web Customer
    public List<StayRoom> getAllRoomsForCustomer(int id, String status) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "select r.*,\n"
                + "       br.check_in_date,\n"
                + "       br.check_out_date,\n"
                + "       r.room_type,\n"
                + "       r.room_number,\n"
                + "       r.room_id,\n"
                + "       b.booking_id\n"
                + "from bookings b\n"
                + "join booking_rooms br ON b.booking_id = br.booking_id\n"
                + "join rooms r ON br.room_id = r.room_id\n"
                + "where b.customer_id = ? and br.status = ? and r.room_status = ? ";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, status);
            ps.setString(3, "occupied");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
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

    //Web Receptionist
    //
    public List<StayRoom> getBooking(int phone) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT  b.booking_id, r.room_id, br.check_in_date, r.room_number, br.check_out_date, br.status\n"
                + "                FROM Booking_Rooms br \n"
                + "                JOIN Rooms r ON br.room_id = r.room_id \n"
                + "                JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "                JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "                JOIN Users d ON c.customer_id = d.user_id\n"
                + "                WHERE d.phone =  ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setStatus(rs.getString("status"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    r.setCheckOutDate(rs.getDate("check_out_date"));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }
    public List<StayRoom> getBookingByBookingId(int bookingId) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT  b.booking_id, r.room_id, br.check_in_date, r.room_number, br.check_out_date, br.status\n"
                + "                FROM Booking_Rooms br \n"
                + "                JOIN Rooms r ON br.room_id = r.room_id \n"
                + "                JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "                JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "                JOIN Users d ON c.customer_id = d.user_id\n"
                + "                WHERE b.booking_id =  ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setStatus(rs.getString("status"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    r.setCheckOutDate(rs.getDate("check_out_date"));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }
    public List<StayRoom> getRoomByRoomId(int roomId) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT  b.booking_id, r.room_id, br.check_in_date, r.room_number, br.check_out_date, br.status\n"
                + "                FROM Booking_Rooms br \n"
                + "                JOIN Rooms r ON br.room_id = r.room_id \n"
                + "                JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "                JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "                JOIN Users d ON c.customer_id = d.user_id\n"
                + "                WHERE r.room_id =  ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setStatus(rs.getString("status"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    r.setCheckOutDate(rs.getDate("check_out_date"));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }


    //get booking for stayroom
    public List<StayRoom> getAllBooking() {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT  b.booking_id, r.room_id, br.check_in_date, r.room_number, br.check_out_date, br.status\n"
                + "FROM Booking_Rooms br \n"
                + "JOIN Rooms r ON br.room_id = r.room_id \n"
                + "JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "JOIN Users d ON c.customer_id = d.user_id\n"
                + "WHERE b.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "confirmed");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setStatus(rs.getString("status"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    r.setCheckOutDate(rs.getDate("check_out_date"));

                    list.add(r);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }

//    public List<StayRoom> getAllRoomsForReceptionist() {
//        List<StayRoom> list = new ArrayList<>();
//
//        String sql = "select \n"
//                + "    room_id, \n"
//                + "    room_number, \n"
//                + "    room_status, \n"
//                + "    room_type\n"
//                + "   from \n"
//                + "    Rooms;";
//
//        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    StayRoom r = new StayRoom();
//                    r.setRoomId(rs.getInt("room_id"));
//                    r.setRoomNumber(rs.getString("room_number"));
//                    r.setRoomStatus(rs.getString("room_status"));
//                    r.setRoomType(rs.getString("room_type"));
//                    list.add(r);
//                }
//            }
//        } catch (SQLException e) {
//            System.out.println("Error when fetching room list: " + e.getMessage());
//        }
//        return list;
//    }
//Update Status
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

    public boolean updateBookingRoomStatus(int roomId, String newStatus) {
        String sql = "UPDATE Booking_Rooms SET status = ? WHERE room_id = ?";

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

    public boolean updateBookingStatus(int booking, String newStatus) {
        String sql = "";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, booking);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error");
        }
        return false;
    }

    //Details Room
    public StayRoom getDetails(int bookingId, int roomId) {
        StayRoom stayroom = new StayRoom();

        String sql = "SELECT \n"
                + "r.room_number, r.room_id, r.room_type, b.booking_id, r.capacity,\n"
                + "b.status, r.room_status, d.username,d.email,d.phone,br.guests_count,\n"
                + "r.price_per_night, b.check_in_date, b.check_out_date\n"
                + "FROM Booking_Rooms br \n"
                + "JOIN Rooms r ON br.room_id = r.room_id \n"
                + "JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "JOIN Users d ON c.customer_id = d.user_id\n"
                + "WHERE b.booking_id = ? and r.room_id = ? ";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    stayroom.setRoomId(rs.getInt("room_id"));
                    stayroom.setRoomNumber(rs.getString("room_number"));
                    stayroom.setRoomType(rs.getString("room_type"));
                    stayroom.setPricePerNight(rs.getDouble("price_per_night"));
                    stayroom.setBookingId(rs.getInt("booking_id"));
                    stayroom.setCheckInDate(rs.getDate("check_in_date"));
                    stayroom.setCheckOutDate(rs.getDate("check_out_date"));
                    stayroom.setCapacity(rs.getInt("capacity"));
                    stayroom.setStatus(rs.getString("status"));
                    stayroom.setRoomStatus(rs.getString("room_status"));
                    stayroom.setName(rs.getString("username"));
                    stayroom.setGmail(rs.getString("email"));
                    stayroom.setPhone(rs.getInt("phone"));
                    stayroom.setGuestCount(rs.getInt("guests_count"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }

}
