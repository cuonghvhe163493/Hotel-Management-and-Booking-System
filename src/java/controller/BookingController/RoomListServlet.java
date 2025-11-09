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

        // --- Validation logic ---
        String errorMessage = null;
        String errorMessage2 = null;
        try {
            // --- Validate capacity ---
            if (capacityStr != null && !capacityStr.isEmpty()) {
                capacity = Integer.parseInt(capacityStr);
                if (capacity <= 0) {
                    errorMessage2 = "Capacity must be greater than 0.";
                    capacity = -1; // bỏ filter invalid
                }
            }

            // --- Validate maxPrice ---
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
                if (maxPrice <= 0) {
                    errorMessage2 = "Max price must be greater than 0.";
                    maxPrice = Double.MAX_VALUE; // bỏ giá trị invalid
                }
            }

            // --- Validate page ---
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            }

            // --- Validate check-in / check-out date ---
            if (checkInStr != null && !checkInStr.isEmpty()) {
                _checkInDate = java.sql.Date.valueOf(checkInStr);
            }
            if (checkOutStr != null && !checkOutStr.isEmpty()) {
                _checkOutDate = java.sql.Date.valueOf(checkOutStr);
            }

            Date today = new Date();
            if (_checkInDate != null && _checkInDate.before(today)) {
                errorMessage = "Check-in date cannot be in the past.";
                _checkInDate = null;
            }
            if (_checkInDate != null && _checkOutDate != null && !_checkOutDate.after(_checkInDate)) {
                errorMessage = "Check-out date must be after check-in date.";
                _checkOutDate = null;
            }

        } catch (NumberFormatException e) {
            errorMessage2 = "Capacity and max price must be valid numbers.";
            capacity = -1;
            maxPrice = Double.MAX_VALUE;
            page = 1;
        }

        // --- Set lại các giá trị checked để hiển thị lại form ---
        final Date checkInDate = _checkInDate;
        final Date checkOutDate = _checkOutDate;
        final int filterCapacity = capacity;
        final double filterMaxPrice = maxPrice;
        final String filterType = type;

        // --- Lấy danh sách phòng và filter như cũ ---
        List<Room> rooms = new ArrayList<>();
        try {
            rooms = roomDAO.getAllRooms();
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Room> filtered = rooms.stream()
                .filter(r -> filterType == null || filterType.isEmpty() || r.getRoomType().equalsIgnoreCase(filterType))
                .filter(r -> filterCapacity <= 0 || r.getCapacity() == filterCapacity)
                .filter(r -> filterMaxPrice < 0 || (r.getPricePerNight() != null && r.getPricePerNight().doubleValue() <= filterMaxPrice))
                .filter(r -> {
                    if (checkInDate == null || checkOutDate == null) {
                        return true; // nếu chưa chọn ngày hoặc date invalid -> giữ tất cả
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

        // --- SORT, PAGINATION như cũ ---
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

        // --- Set attribute ---
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
        request.setAttribute("errorMessage", errorMessage); // thông báo lỗi date
        request.setAttribute("errorMessage2", errorMessage2); // lỗi price và capacity

        // --- Forward sang JSP ---
        request.getRequestDispatcher("/view/Booking/rooms.jsp").forward(request, response);
    }
}
