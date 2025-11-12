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
    //Web Customer

    public List<StayRoom> getCheckInRoomForCustomer(int booking_id) {
        List<StayRoom> stayroom = new ArrayList<>();

        String sql = "SELECT\n"
                + "	b.booking_id,\n"
                + "    br.check_in_date,\n"
                + "    br.check_out_date,\n"
                + "    r.room_number,\n"
                + "    r.room_id,\n"
                + "    r.price_per_night,      \n"
                + "	(DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night * 0.1) AS deposit,\n"
                + "	SUM(DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night * 0.1) \n"
                + "    OVER (PARTITION BY b.booking_id) AS total_deposit,\n"
                + "    DATEDIFF(DAY, br.check_in_date, br.check_out_date) AS stay_days,\n"
                + "    (DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night) AS total_price\n"
                + "\n"
                + "FROM bookings b\n"
                + "JOIN booking_rooms br ON b.booking_id = br.booking_id\n"
                + "JOIN rooms r ON br.room_id = r.room_id\n"
                + "WHERE b.booking_id = ? \n"
                + "  AND br.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking_id);
            ps.setString(2, "reserved");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setCheckInDate(rs.getDate("check_in_date"));
                    r.setPricePerNight(rs.getDouble("price_per_night"));
                    r.setPrice(rs.getDouble("total_price"));
                    r.setDeposit(rs.getDouble("deposit"));
                    r.setTotalDeposit(rs.getDouble("total_deposit"));
                    stayroom.add(r);

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }

    public List<StayRoom> getCheckOutRoomForCustomer(int booking_id) {
        List<StayRoom> stayroom = new ArrayList<>();

        String sql = "SELECT\n"
                + "	b.booking_id,\n"
                + "    br.check_in_date,\n"
                + "    br.check_out_date,\n"
                + "    r.room_number,\n"
                + "    r.room_id,\n"
                + "    r.price_per_night,      \n"
                + "	(DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night * 0.1) AS deposit,\n"
                + "	SUM(DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night * 0.1) \n"
                + "    OVER (PARTITION BY b.booking_id) AS total_deposit,\n"
                + "    DATEDIFF(DAY, br.check_in_date, br.check_out_date) AS stay_days,\n"
                + "    (DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night) AS total_price,\n"
                + "    SUM(DATEDIFF(DAY, br.check_in_date, br.check_out_date) * r.price_per_night) \n"
                + "        OVER (PARTITION BY b.booking_id) AS total_all_price\n"
                + "\n"
                + "FROM bookings b\n"
                + "JOIN booking_rooms br ON b.booking_id = br.booking_id\n"
                + "JOIN rooms r ON br.room_id = r.room_id\n"
                + "WHERE b.booking_id = ? \n"
                + "  AND br.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking_id);
            ps.setString(2, "checked_in");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom r = new StayRoom();
                    r.setBookingId(rs.getInt("booking_id"));
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setCheckOutDate(rs.getDate("check_out_date"));
                    r.setPricePerNight(rs.getDouble("price_per_night"));
                    r.setPrice(rs.getDouble("total_price"));
                    r.setDeposit(rs.getDouble("deposit"));
                    r.setTotalDeposit(rs.getDouble("total_all_price"));
                    stayroom.add(r);

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }

    public List<Integer> getBooking(int id) {
        List<Integer> list = new ArrayList<>();

        String sql = "SELECT distinct br.booking_id \n"
                + "FROM Booking_Rooms br \n"
                + "JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "WHERE c.customer_id = ? and b.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ps.setString(2, "confirmed");
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

    //Web Receptionist
    public List<StayRoom> getCheckInRoomForReceptionist(int phoneNumber) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT  b.booking_id, r.room_id, br.check_in_date, r.room_number, price_per_night, r.room_type\n"
                + "FROM Booking_Rooms br \n"
                + "JOIN Rooms r ON br.room_id = r.room_id \n"
                + "JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "JOIN Users d ON c.customer_id = d.user_id\n"
                + "WHERE d.phone = ? and b.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, phoneNumber);
            ps.setString(2, "confirmed");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom stayroom = new StayRoom();
                    stayroom.setRoomId(rs.getInt("room_id"));
                    stayroom.setRoomNumber(rs.getString("room_number"));
                    stayroom.setRoomType(rs.getString("room_type"));
                    stayroom.setPricePerNight(rs.getDouble("price_per_night"));
                    stayroom.setBookingId(rs.getInt("booking_id"));
                    stayroom.setCheckInDate(rs.getDate("check_in_date"));
                    list.add(stayroom);

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
    }
    public List<StayRoom> getCheckOutRoomForReceptionist(int phoneNumber) {
        List<StayRoom> list = new ArrayList<>();

        String sql = "SELECT  b.booking_id, r.room_id, br.check_out_date, r.room_number, price_per_night, r.room_type\n"
                + "FROM Booking_Rooms br \n"
                + "JOIN Rooms r ON br.room_id = r.room_id \n"
                + "JOIN Bookings b ON br.booking_id = b.booking_id \n"
                + "JOIN Customers c ON b.customer_id = c.customer_id \n"
                + "JOIN Users d ON c.customer_id = d.user_id\n"
                + "WHERE d.phone = ? and b.status = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, phoneNumber);
            ps.setString(2, "confirmed");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StayRoom stayroom = new StayRoom();
                    stayroom.setRoomId(rs.getInt("room_id"));
                    stayroom.setRoomNumber(rs.getString("room_number"));
                    stayroom.setRoomType(rs.getString("room_type"));
                    stayroom.setPricePerNight(rs.getDouble("price_per_night"));
                    stayroom.setBookingId(rs.getInt("booking_id"));
                    stayroom.setCheckInDate(rs.getDate("check_out_date"));
                    list.add(stayroom);

                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return list;
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

    public StayRoom getInfoCustomer(int phoneNumber) {
        StayRoom stayroom = new StayRoom();

        String sql = "SELECT d.username, d.email, d.user_id \n"
                + "FROM  Customers c JOIN Users d ON c.customer_id = d.user_id \n"
                + "WHERE d.phone = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, phoneNumber);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    stayroom.setUserId(rs.getInt("user_id"));
                    stayroom.setGmail(rs.getString("email"));
                    stayroom.setName(rs.getString("username"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error when fetching room list: " + e.getMessage());
        }
        return stayroom;
    }

}
