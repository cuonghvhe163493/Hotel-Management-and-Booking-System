package dao.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Booking;
import utils.DBConnection;

public class BookingDAO {

    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    public int createBooking(int customerId, String status, String checkIn, String checkOut,
            double subtotal, double discount, double grandTotal, double paidTotal)
            throws SQLException {

        String sql = "INSERT INTO Bookings (customer_id, status, check_in_date, check_out_date, "
                + "subtotal, discount_total, grand_total, paid_total, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setString(2, status);
            ps.setString(3, checkIn);
            ps.setString(4, checkOut);
            ps.setDouble(5, subtotal);
            ps.setDouble(6, discount);
            ps.setDouble(7, grandTotal);
            ps.setDouble(8, paidTotal);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return -1;
    }

    public void addRoomToBooking(int bookingId, int roomId, String checkIn, String checkOut,
            int guestsCount, double rate, String status) throws SQLException {

        String sql = "INSERT INTO Booking_Rooms (booking_id, room_id, check_in_date, check_out_date, "
                + "guests_count, rate_per_night, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, roomId);
            ps.setString(3, checkIn);
            ps.setString(4, checkOut);
            ps.setInt(5, guestsCount);
            ps.setDouble(6, rate);
            ps.setString(7, status);
            ps.executeUpdate();
        }
    }

    // Cập nhật trạng thái booking
    public void updateBookingStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE Bookings SET status=? WHERE booking_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        }
    }

    // Lấy danh sách roomId theo booking
    public List<Integer> getRoomIdsByBooking(int bookingId) throws SQLException {
        String sql = "SELECT room_id FROM Booking_Rooms WHERE booking_id=?";
        List<Integer> roomIds = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    roomIds.add(rs.getInt("room_id"));
                }
            }
        }
        return roomIds;
    }

    // Cập nhật trạng thái tất cả room trong booking
    public void updateBookingRoomsStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE Booking_Rooms SET status=? WHERE booking_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        }
    }

    public Booking getBookingById(int bookingId) throws Exception {
        String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking b = new Booking();
                    b.setBookingId(rs.getInt("booking_id"));
                    b.setCustomerId(rs.getInt("customer_id"));
                    b.setStatus(rs.getString("status"));
                    b.setCheckInDate(rs.getDate("check_in_date"));
                    b.setCheckOutDate(rs.getDate("check_out_date"));
                    b.setHoldUntil(rs.getDate("hold_until"));
                    b.setNote(rs.getString("note"));
                    b.setSubtotal(rs.getDouble("subtotal"));
                    b.setDiscountTotal(rs.getDouble("discount_total"));
                    b.setGrandTotal(rs.getDouble("grand_total"));
                    b.setPaidTotal(rs.getDouble("paid_total"));
                    b.setCreatedAt(rs.getTimestamp("created_at"));
                    b.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return b;
                } else {
                    throw new Exception("Booking not found: " + bookingId);
                }
            }
        }
    }

    public List<Booking> getBookingsByCustomerId(int customerId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE customer_id = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setStatus(rs.getString("status"));
                b.setCheckInDate(rs.getDate("check_in_date"));
                b.setCheckOutDate(rs.getDate("check_out_date"));
                b.setHoldUntil(rs.getDate("hold_until"));
                b.setNote(rs.getString("note"));
                b.setSubtotal(rs.getDouble("subtotal"));
                b.setDiscountTotal(rs.getDouble("discount_total"));
                b.setGrandTotal(rs.getDouble("grand_total"));
                b.setPaidTotal(rs.getDouble("paid_total"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteBooking(int bookingId) {
        String sql = "DELETE FROM Bookings WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
