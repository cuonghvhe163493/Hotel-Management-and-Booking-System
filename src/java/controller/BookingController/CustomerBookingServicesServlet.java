package controller.BookingController;


import dao.Booking.BookingDAO;
import dao.Booking.BookingServiceDAO;
import model.Booking;
import model.BookingService;
import model.User;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.net.URLEncoder;

/**
 * Servlet to display all booking services for the current customer
 */
@WebServlet("/customer-booking-services")
public class CustomerBookingServicesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            Object obj = session.getAttribute("user");
            if (obj instanceof User) {
                user = (User) obj;
            }
        }

        // Check if user is logged in
        if (user == null) {
            System.out.println("DEBUG CustomerBookingServicesServlet: User not logged in, redirecting to login");
            String currentUrl = request.getRequestURI();
            if (request.getQueryString() != null) {
                currentUrl += "?" + request.getQueryString();
            }
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + URLEncoder.encode(currentUrl, "UTF-8"));
            return;
        }

        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            customerId = user.getUserId();
            session.setAttribute("customerId", customerId);
        }

        System.out.println("DEBUG CustomerBookingServicesServlet: Fetching booking services for customerId=" + customerId);

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();

            // Get all bookings for this customer
            List<Booking> bookings = bookingDAO.getBookingsByCustomerId(customerId);
            System.out.println("DEBUG: Found " + (bookings != null ? bookings.size() : "0") + " bookings");

            // Batch load services for all bookings
            Map<Integer, List<BookingService>> bookingServicesMap = new HashMap<>();
            if (bookings != null && !bookings.isEmpty()) {
                List<Integer> bookingIds = bookings.stream().map(b -> b.getBookingId()).collect(Collectors.toList());
                bookingServicesMap = bookingServiceDAO.getServicesByBookingIds(bookingIds);
                for (Booking booking : bookings) {
                    bookingServicesMap.putIfAbsent(booking.getBookingId(), new ArrayList<>());
                    System.out.println("DEBUG: Booking " + booking.getBookingId() + " has " + bookingServicesMap.get(booking.getBookingId()).size() + " services");
                }
            }

            // Calculate statistics
            Map<String, Object> statistics = new HashMap<>();
            int totalBookings = bookings != null ? bookings.size() : 0;
            int totalServices = 0;
            double totalSpent = 0;
            
            for (Booking booking : bookings) {
                totalSpent += booking.getGrandTotal();
                if (bookingServicesMap.containsKey(booking.getBookingId())) {
                    totalServices += bookingServicesMap.get(booking.getBookingId()).size();
                }
            }

            statistics.put("totalBookings", totalBookings);
            statistics.put("totalServices", totalServices);
            statistics.put("totalSpent", totalSpent);

            // Set request attributes
            request.setAttribute("user", user);
            request.setAttribute("bookings", bookings);
            request.setAttribute("bookingServicesMap", bookingServicesMap);
            request.setAttribute("statistics", statistics);

            System.out.println("DEBUG: Statistics - Bookings: " + totalBookings + 
                             ", Services: " + totalServices + 
                             ", Total Spent: " + totalSpent);

            request.getRequestDispatcher("/view/Booking/customer_booking_services.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("ERROR in CustomerBookingServicesServlet:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading booking services");
        }
    }
}
