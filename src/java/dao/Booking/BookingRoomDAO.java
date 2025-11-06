package dao.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.BookingRoom;
import utils.DBConnection;

public class BookingRoomDAO {

    public BookingRoomDAO() {
    }

    // Lấy danh sách phòng theo booking_id
    public List<BookingRoom> getRoomsByBookingId(int bookingId) {
    List<BookingRoom> list = new ArrayList<>();
    String sql = "SELECT br.*, r.room_number " +
                 "FROM Booking_Rooms br " +
                 "JOIN Rooms r ON br.room_id = r.room_id " +
                 "WHERE br.booking_id = ?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, bookingId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            BookingRoom r = new BookingRoom();
            r.setBookingRoomId(rs.getInt("booking_room_id"));
            r.setBookingId(rs.getInt("booking_id"));
            r.setRoomId(rs.getInt("room_id"));
            r.setRoomNumber(rs.getString("room_number"));
            r.setCheckInDate(rs.getDate("check_in_date"));
            r.setCheckOutDate(rs.getDate("check_out_date"));

            long diff = r.getCheckOutDate().getTime() - r.getCheckInDate().getTime();
            int nights = (int) (diff / (1000 * 60 * 60 * 24));
            r.setNights(nights);
            
            r.setGuestsCount(rs.getInt("guests_count"));
            r.setRatePerNight(rs.getDouble("rate_per_night"));
            r.setLineTotal(rs.getDouble("line_total"));
            r.setStatus(rs.getString("status"));

            list.add(r);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}


    // Xóa tất cả phòng thuộc 1 booking
    public void deleteByBookingId(int bookingId) {
        String sql = "DELETE FROM Booking_Rooms WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // (Tuỳ chọn) Thêm một booking room mới — dùng khi insert chi tiết phòng
    public void insertBookingRoom(BookingRoom room) {
        String sql = "INSERT INTO Booking_Rooms "
                + "(booking_id, room_id, check_in_date, check_out_date, guests_count, rate_per_night, line_total, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, room.getBookingId());
            ps.setInt(2, room.getRoomId());
            ps.setDate(3, new java.sql.Date(room.getCheckInDate().getTime()));
            ps.setDate(4, new java.sql.Date(room.getCheckOutDate().getTime()));
            ps.setInt(5, room.getGuestsCount());
            ps.setDouble(6, room.getRatePerNight());
            ps.setDouble(7, room.getLineTotal());
            ps.setString(8, room.getStatus());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
