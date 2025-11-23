package controller.UserServicesController;

import dao.UserSerives.ServiceDAO;
import dao.Booking.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.ExtraServiceCartItem;
import model.User;
import utils.DBConnection;

@WebServlet(name = "ServiceConfirmBookingV2Servlet", urlPatterns = {"/service-confirm-booking-v2"})
public class ServiceConfirmBookingV2Servlet extends HttpServlet {

    List<ExtraServiceCartItem> cartExtraServices;

    private List<ExtraServiceCartItem> getCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cartExtraServices") != null) {
            return (ArrayList<ExtraServiceCartItem>) request.getSession().getAttribute("cartExtraServices");
        } else {
            return new ArrayList<>();
        }
    }

    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer customerId = (Integer) session.getAttribute("customerId");

        // Nếu customerId null, lấy từ user
        if (customerId == null && user != null) {
            customerId = user.getUserId();
            session.setAttribute("customerId", customerId);
        }

        if (customerId == null || user == null) {
            response.sendRedirect("/HotelManagementandBookingSystem/view/Authentication/login.jsp");
            return;
        }

        System.out.println("DEBUG ServiceConfirmBookingV2: userId=" + user.getUserId() + ", customerId=" + customerId);

        this.cartExtraServices = getCart(request);

        if (cartExtraServices.size() <= 0) {
            response.sendRedirect(request.getContextPath() + "/extra-service-cart");
            return;
        }

        double total = 0;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            BookingDAO bookingDAO = new BookingDAO(conn);

            java.util.Date firstCheckIn = null;
            java.util.Date lastCheckOut = null;
            double subtotal = 0.0;

            for (ExtraServiceCartItem item : cartExtraServices) {
                if (firstCheckIn == null || item.getCheckInDate().before(firstCheckIn)) {
                    firstCheckIn = item.getCheckInDate();
                }
                if (lastCheckOut == null || item.getCheckOutDate().after(lastCheckOut)) {
                    lastCheckOut = item.getCheckOutDate();
                }
                subtotal += item.getService().getServicePrice() * item.getGuestsCount();
            }

            double discount = 0.0;
            double grandTotal = subtotal - discount;

            int bookingId = bookingDAO.createBooking(
                    customerId,
                    "pending",
                    new java.text.SimpleDateFormat("yyyy-MM-dd").format(firstCheckIn),
                    new java.text.SimpleDateFormat("yyyy-MM-dd").format(lastCheckOut),
                    subtotal,
                    discount,
                    grandTotal,
                    0.0
            );
            System.out.println("DEBUG: Created bookingId=" + bookingId + " for customerId=" + customerId);

            for (ExtraServiceCartItem item : cartExtraServices) {
                serviceDAO.bookingService(item, bookingId);
                total += item.getService().getServicePrice() * item.getGuestsCount();
            }

            conn.commit();
            System.out.println("DEBUG: Booking committed successfully for bookingId=" + bookingId);

            session.removeAttribute("cartExtraServices");
            session.setAttribute("successMessage", "Booking successful! Booking ID: " + bookingId);

            request.setAttribute("user", user);
            request.setAttribute("bookingSuccess", true);
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("discount", discount);

            request.getRequestDispatcher("/view/Booking/booking_success.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("ERROR in ServiceConfirmBookingV2:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
