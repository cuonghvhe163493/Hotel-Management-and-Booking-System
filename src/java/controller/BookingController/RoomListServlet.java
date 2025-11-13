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
        } catch (Exception e) {
            throw new ServletException("Cannot connect to DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

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

        Date checkInDate = null;
        Date checkOutDate = null;

        String errorMessage = null;
        String errorMessage2 = null;

        try {
            if (capacityStr != null && !capacityStr.isEmpty()) {
                capacity = Integer.parseInt(capacityStr);
                if (capacity <= 0) {
                    errorMessage2 = "Capacity must be greater than 0.";
                    capacity = -1;
                }
            }

            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
                if (maxPrice <= 0) {
                    errorMessage2 = "Max price must be greater than 0.";
                    maxPrice = Double.MAX_VALUE;
                }
            }

            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            }

            if (checkInStr != null && !checkInStr.isEmpty()) {
                checkInDate = java.sql.Date.valueOf(checkInStr);
            }
            if (checkOutStr != null && !checkOutStr.isEmpty()) {
                checkOutDate = java.sql.Date.valueOf(checkOutStr);
            }

            Date today = new Date();
            if (checkInDate != null && checkInDate.before(today)) {
                errorMessage = "Check-in date cannot be in the past.";
                checkInDate = null;
            }
            if (checkInDate != null && checkOutDate != null && !checkOutDate.after(checkInDate)) {
                errorMessage = "Check-out date must be after check-in date.";
                checkOutDate = null;
            }

        } catch (NumberFormatException e) {
            errorMessage2 = "Capacity and max price must be valid numbers.";
            capacity = -1;
            maxPrice = Double.MAX_VALUE;
            page = 1;
        }

        // --- Lấy danh sách tất cả phòng ---
        List<Room> rooms = roomDAO.getAllRooms();

        final int filterCapacity = capacity;
        final double filterMaxPrice = maxPrice;
        final String filterType = type;
        final boolean onlyAvailable = "on".equalsIgnoreCase(availableOnly);

// --- tạo bản sao final cho lambda ---
        final Date finalCheckInDate = checkInDate;
        final Date finalCheckOutDate = checkOutDate;

        List<Room> filtered = rooms.stream()
                .filter(r -> filterType == null || filterType.isEmpty() || r.getRoomType().equalsIgnoreCase(filterType))
                .filter(r -> filterCapacity <= 0 || r.getCapacity() == filterCapacity)
                .filter(r -> filterMaxPrice == Double.MAX_VALUE || r.getPricePerNight() <= filterMaxPrice)
                .filter(r -> !onlyAvailable || "available".equalsIgnoreCase(r.getRoomStatus()))
                .filter(r -> {
                    if (finalCheckInDate == null || finalCheckOutDate == null) {
                        return true;
                    }
                    try {
                        return !roomDAO.isRoomBooked(r.getRoomId(), finalCheckInDate, finalCheckOutDate);
                    } catch (Exception e) {
                        e.printStackTrace();
                        return false;
                    }
                })
                .collect(Collectors.toList());

        // --- Sort ---
        Comparator<Room> comparator = Comparator.comparing(Room::getRoomNumber);
        if ("priceAsc".equals(sort)) {
            comparator = Comparator.comparing(Room::getPricePerNight);
        } else if ("priceDesc".equals(sort)) {
            comparator = Comparator.comparing(Room::getPricePerNight).reversed();
        } else if ("capacityAsc".equals(sort)) {
            comparator = Comparator.comparing(Room::getCapacity);
        } else if ("capacityDesc".equals(sort)) {
            comparator = Comparator.comparing(Room::getCapacity).reversed();
        }
        filtered.sort(comparator);

        // --- Pagination ---
        int pageSize = 6;
        int totalRooms = filtered.size();
        int totalPages = (int) Math.ceil((double) totalRooms / pageSize);
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalRooms);
        List<Room> pageRooms = (totalRooms == 0 || start >= end) ? Collections.emptyList() : filtered.subList(start, end);

        // --- Set attributes ---
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
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("errorMessage2", errorMessage2);

        request.getRequestDispatcher("/view/Booking/rooms.jsp").forward(request, response);
    }
}
