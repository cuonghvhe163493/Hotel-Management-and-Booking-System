package dao.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import model.BookingService;
import utils.DBConnection;

public class BookingServiceDAO {

    public List<BookingService> getServicesByBookingId(int bookingId) {
        List<BookingService> list = new ArrayList<>();
        String sql = "SELECT id, service_id, service_name, check_in_date, check_out_date, guests_count, price, total, status, booking_id "
                + "FROM booking_service WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingService s = new BookingService();
                    s.setId(rs.getInt("id"));
                    s.setServiceId(rs.getInt("service_id"));
                    s.setServiceName(rs.getString("service_name"));
                    s.setCheckInDate(rs.getDate("check_in_date"));
                    s.setCheckOutDate(rs.getDate("check_out_date"));
                    s.setGuestsCount(rs.getInt("guests_count"));
                    s.setPrice(rs.getDouble("price"));
                    s.setTotal(rs.getDouble("total"));
                    s.setStatus(rs.getString("status"));
                    s.setBookingId(rs.getInt("booking_id"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch booking services for multiple booking IDs in a single query.
     * Returns a map bookingId -> list of BookingService.
     */
    public Map<Integer, List<BookingService>> getServicesByBookingIds(List<Integer> bookingIds) {
        Map<Integer, List<BookingService>> map = new HashMap<>();
        if (bookingIds == null || bookingIds.isEmpty()) {
            return map;
        }

        // Build IN clause placeholders
        String inClause = bookingIds.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = "SELECT id, service_id, service_name, check_in_date, check_out_date, guests_count, price, total, status, booking_id "
                + "FROM booking_service WHERE booking_id IN (" + inClause + ")";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            int idx = 1;
            for (Integer id : bookingIds) {
                ps.setInt(idx++, id);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingService s = new BookingService();
                    s.setId(rs.getInt("id"));
                    s.setServiceId(rs.getInt("service_id"));
                    s.setServiceName(rs.getString("service_name"));
                    s.setCheckInDate(rs.getDate("check_in_date"));
                    s.setCheckOutDate(rs.getDate("check_out_date"));
                    s.setGuestsCount(rs.getInt("guests_count"));
                    s.setPrice(rs.getDouble("price"));
                    s.setTotal(rs.getDouble("total"));
                    s.setStatus(rs.getString("status"));
                    int bookingId = rs.getInt("booking_id");
                    s.setBookingId(bookingId);

                    map.computeIfAbsent(bookingId, k -> new ArrayList<>()).add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
}
