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
import model.ServiceCartItems;
import model.User;
import utils.DBConnection;

/**
 * Unified Service Confirmation Servlet - handles both Extra Services and Regular Services
 */
@WebServlet(name = "ExtraServiceConfirmServlet", urlPatterns = {"/extra-service-confirm"})
public class ExtraServiceConfirmServlet extends HttpServlet {

    List<ExtraServiceCartItem> cartExtraServices;
    List<ServiceCartItems> cartServices;

    private List<ExtraServiceCartItem> getExtraCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cartExtraServices") != null) {
            return (ArrayList<ExtraServiceCartItem>) request.getSession().getAttribute("cartExtraServices");
        } else {
            return new ArrayList<>();
        }
    }
    
    private List<ServiceCartItems> getServiceCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cartServices") != null) {
            return (ArrayList<ServiceCartItems>) request.getSession().getAttribute("cartServices");
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

        if (customerId == null && user != null) {
            customerId = user.getUserId();
            session.setAttribute("customerId", customerId);
        }

        if (customerId == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("DEBUG ExtraServiceConfirmServlet: userId=" + user.getUserId() + ", customerId=" + customerId);

        this.cartExtraServices = getExtraCart(request);
        this.cartServices = getServiceCart(request);

        // Check if both carts are empty
        boolean hasExtraServices = !cartExtraServices.isEmpty();
        boolean hasServices = !cartServices.isEmpty();
        
        if (!hasExtraServices && !hasServices) {
            System.out.println("DEBUG: Both carts are empty");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        System.out.println("DEBUG: Extra Services=" + cartExtraServices.size() + ", Regular Services=" + cartServices.size());

        double total = 0;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            BookingDAO bookingDAO = new BookingDAO(conn);

            java.util.Date firstCheckIn = null;
            java.util.Date lastCheckOut = null;
            double subtotal = 0.0;

            // Process Extra Services
            for (ExtraServiceCartItem item : cartExtraServices) {
                if (firstCheckIn == null || item.getCheckInDate().before(firstCheckIn)) {
                    firstCheckIn = item.getCheckInDate();
                }
                if (lastCheckOut == null || item.getCheckOutDate().after(lastCheckOut)) {
                    lastCheckOut = item.getCheckOutDate();
                }
                subtotal += item.getService().getServicePrice() * item.getGuestsCount();
            }

            // Process Regular Services
            for (ServiceCartItems item : cartServices) {
                if (firstCheckIn == null || item.getCheckInDate().before(firstCheckIn)) {
                    firstCheckIn = item.getCheckInDate();
                }
                if (lastCheckOut == null || item.getCheckOutDate().after(lastCheckOut)) {
                    lastCheckOut = item.getCheckOutDate();
                }
                subtotal += item.getService().getPrice() * item.getGuestsCount();
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

            // Save Extra Services
            for (ExtraServiceCartItem item : cartExtraServices) {
                serviceDAO.bookingService(item, bookingId);
                total += item.getService().getServicePrice() * item.getGuestsCount();
                System.out.println("DEBUG: Saved Extra Service: " + item.getService().getServiceName());
            }

            // Save Regular Services
            for (ServiceCartItems item : cartServices) {
                serviceDAO.bookingService(item, bookingId);
                total += item.getService().getPrice() * item.getGuestsCount();
                System.out.println("DEBUG: Saved Regular Service: " + item.getService().getServiceName());
            }

            conn.commit();
            System.out.println("DEBUG: All services committed successfully for bookingId=" + bookingId);

            // Clear both carts
            session.removeAttribute("cartExtraServices");
            session.removeAttribute("cartServices");
            session.setAttribute("successMessage", "Booking successful! Booking ID: " + bookingId);

            request.setAttribute("user", user);
            request.setAttribute("bookingSuccess", true);
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("discount", discount);

            request.getRequestDispatcher("/view/Booking/booking_success.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("ERROR in ExtraServiceConfirmServlet:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
