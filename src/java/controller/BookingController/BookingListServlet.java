package controller.BookingController;

import dao.Booking.BookingDAO;
import dao.Booking.BookingRoomDAO;
import model.Booking;
import model.BookingRoom;
import utils.DBConnection;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/booking-list")
public class BookingListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null && user != null) {
            customerId = user.getUserId();
            session.setAttribute("customerId", customerId);
        }

        // Lấy filter & sort từ request
        String statusFilter = request.getParameter("statusFilter");
        if (statusFilter != null) {
            statusFilter = statusFilter.trim();
            if (statusFilter.isEmpty()) {
                statusFilter = null;
            }
        }

        String sortBy = request.getParameter("sortBy");

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingRoomDAO bookingRoomDAO = new BookingRoomDAO();

            // Lấy danh sách booking theo customer
            List<Booking> bookings = bookingDAO.getBookingsByCustomerId(customerId);

            // --- Filter by status (sử dụng vòng lặp an toàn) ---
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                List<Booking> filteredBookings = new java.util.ArrayList<>();
                for (Booking b : bookings) {
                    if (b.getStatus() != null && b.getStatus().equalsIgnoreCase(statusFilter)) {
                        filteredBookings.add(b);
                    }
                }
                bookings = filteredBookings;
            }

            // --- Sort ---
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                switch (sortBy) {
                    case "priceAsc":
                        bookings.sort((b1, b2) -> Double.compare(b1.getGrandTotal(), b2.getGrandTotal()));
                        break;
                    case "priceDesc":
                        bookings.sort((b1, b2) -> Double.compare(b2.getGrandTotal(), b1.getGrandTotal()));
                        break;
                    case "dateAsc":
                        bookings.sort((b1, b2) -> b1.getCheckInDate().compareTo(b2.getCheckInDate()));
                        break;
                    case "dateDesc":
                        bookings.sort((b1, b2) -> b2.getCheckInDate().compareTo(b1.getCheckInDate()));
                        break;
                }
            }

            request.setAttribute("bookings", bookings);

            // --- Lấy roomsMap ---
            Map<Integer, List<BookingRoom>> roomsMap = new HashMap<>();
            for (Booking b : bookings) {
                List<BookingRoom> rooms = bookingRoomDAO.getRoomsByBookingId(b.getBookingId());
                if (rooms == null) {
                    rooms = new java.util.ArrayList<>();
                }
                roomsMap.put(b.getBookingId(), rooms);
            }
            request.setAttribute("roomsMap", roomsMap);

            // Forward đến JSP
            request.getRequestDispatcher("/view/Booking/booking_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading booking list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingRoomDAO bookingRoomDAO = new BookingRoomDAO();

            if ("delete".equals(action)) {
                bookingRoomDAO.deleteByBookingId(bookingId);
                bookingDAO.deleteBooking(bookingId);
            } else if ("pay".equals(action)) {
                response.sendRedirect("payment?bookingId=" + bookingId);
                return;
            }

            response.sendRedirect("booking-list");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing booking action");
        }
    }
}
