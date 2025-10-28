package controller.BookingController;

import dao.Booking.RoomDAO;
import model.Room;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/rooms")
public class RoomListServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            roomDAO = new RoomDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Cannot connect to DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // --- Lấy tham số từ request ---
        String type = request.getParameter("roomType");
        String capacityStr = request.getParameter("capacity");
        String maxPriceStr = request.getParameter("maxPrice");
        String availableOnly = request.getParameter("availableOnly");
        String sort = request.getParameter("sort");
        String pageStr = request.getParameter("page");
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");

        int capacity = -1;
        double maxPrice = Double.MAX_VALUE;
        int page = 1;

        Date _checkInDate = null;
        Date _checkOutDate = null;

        try {
            if (capacityStr != null && !capacityStr.isEmpty()) {
                capacity = Integer.parseInt(capacityStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
            if (checkInStr != null && !checkInStr.isEmpty()) {
                _checkInDate = java.sql.Date.valueOf(checkInStr);
            }
            if (checkOutStr != null && !checkOutStr.isEmpty()) {
                _checkOutDate = java.sql.Date.valueOf(checkOutStr);
            }
        } catch (Exception e) {
            capacity = 0;
            maxPrice = Double.MAX_VALUE;
            page = 1;
        }

        final Date checkInDate = _checkInDate;
        final Date checkOutDate = _checkOutDate;
        final int filterCapacity = capacity;
        final double filterMaxPrice = maxPrice;
        final String filterType = type;

        List<Room> rooms = new ArrayList<>();
        try {
            rooms = roomDAO.getAllRooms();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // --- FILTER ---
        List<Room> filtered = rooms.stream()
                .filter(r -> filterType == null || filterType.isEmpty() || r.getRoomType().equalsIgnoreCase(filterType))
                .filter(r -> filterCapacity <= 0 || r.getCapacity() == filterCapacity)
                .filter(r -> filterMaxPrice < 0 || (r.getPricePerNight() != null && r.getPricePerNight().doubleValue() <= filterMaxPrice))
                .filter(r -> {
                    if (checkInDate == null || checkOutDate == null) {
                        return true; // nếu chưa chọn ngày -> giữ tất cả
                    }
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT 1 FROM Booking_Rooms WHERE room_id = ? AND status IN ('reserved','checked_in') AND NOT (check_out_date <= ? OR check_in_date >= ?)";
                        try (PreparedStatement ps = conn.prepareStatement(sql)) {
                            ps.setInt(1, r.getRoomId());
                            ps.setDate(2, new java.sql.Date(checkInDate.getTime()));
                            ps.setDate(3, new java.sql.Date(checkOutDate.getTime()));
                            try (ResultSet rs = ps.executeQuery()) {
                                return !rs.next(); // nếu có booking trùng -> không available
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        return false;
                    }
                })
                .collect(Collectors.toList());

        // --- SORT ---
        Comparator<Room> comparator = Comparator.comparing(Room::getRoomNumber);
        if ("priceAsc".equals(sort)) {
            comparator = Comparator.comparing(r -> r.getPricePerNight().doubleValue());
        } else if ("priceDesc".equals(sort)) {
            comparator = Comparator.comparing((Room r) -> r.getPricePerNight().doubleValue()).reversed();
        } else if ("capacityAsc".equals(sort)) {
            comparator = Comparator.comparing(Room::getCapacity);
        } else if ("capacityDesc".equals(sort)) {
            comparator = Comparator.comparing(Room::getCapacity).reversed();
        }
        filtered.sort(comparator);

        // --- PAGINATION ---
        int pageSize = 6;
        int totalRooms = filtered.size();
        int totalPages = (int) Math.ceil((double) totalRooms / pageSize);
        if (page < 1) {
            page = 1;
        }
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalRooms);
        List<Room> pageRooms = (totalRooms == 0 || start >= end) ? Collections.emptyList() : filtered.subList(start, end);

        // --- SET ATTRIBUTE ---
        request.setAttribute("rooms", pageRooms);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("roomType", type == null ? "" : type);
        request.setAttribute("capacity", capacityStr == null ? "" : capacityStr);
        request.setAttribute("maxPrice", maxPriceStr == null ? "" : maxPriceStr);
        request.setAttribute("availableOnly", availableOnly == null ? "" : availableOnly);
        request.setAttribute("sort", sort == null ? "" : sort);
        request.setAttribute("checkInDate", checkInStr == null ? "" : checkInStr);
        request.setAttribute("checkOutDate", checkOutStr == null ? "" : checkOutStr);

        // --- Forward sang JSP ---
        request.getRequestDispatcher("/view/Booking/rooms.jsp").forward(request, response);
    }
}
