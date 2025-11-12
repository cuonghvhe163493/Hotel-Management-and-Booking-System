/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserServicesController;

import dao.UserSerives.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.ServiceCartItems;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name = "ServiceConfirmBookingServlet", urlPatterns = {"/service-confirm-booking"})
public class ServiceConfirmBookingServlet extends HttpServlet {

    List<ServiceCartItems> cartServices;

    private List<ServiceCartItems> getCart(HttpServletRequest request) {
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
        if (user == null) {
            // fake login Alice
            user = new User();
            user.setUserId(5);
            user.setUsername("alice");
            user.setEmail("alice@mail.com");
            user.setRole("customer");
            session.setAttribute("user", user);
            System.out.println("Alice đang login");
        }

        /*if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }*/
        this.cartServices = getCart(request);

        if (cartServices.size() <= 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        double total = 0;
        
        for (ServiceCartItems item : cartServices) {
            serviceDAO.bookingService(item);
            total += item.getService().getPrice();
        }
        
        
        
        session.setAttribute("successMessage", "Booking successful! Booking ID: " + 1);

        request.setAttribute("user", user);
        request.setAttribute("bookingSuccess", true);
        request.setAttribute("bookingId", 1);
        request.setAttribute("grandTotal", total);
        request.getRequestDispatcher("/view/UserService/booking_success.jsp").forward(request, response);
    }

}
