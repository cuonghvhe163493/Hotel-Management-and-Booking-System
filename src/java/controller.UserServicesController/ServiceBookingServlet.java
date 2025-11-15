/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.UserServicesController;

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
@WebServlet(name="ServiceBookingServlet", urlPatterns={"/service-booking"})
public class ServiceBookingServlet extends HttpServlet {
   
    List<ServiceCartItems> cartServices;
    
    private List<ServiceCartItems> getCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cartServices") != null) {
            return (ArrayList<ServiceCartItems>) request.getSession().getAttribute("cartServices");
        } else {
            return new ArrayList<>();
        }
    }
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        User user = (User) session.getAttribute("user");
      Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendRedirect("/HotelManagementandBookingSystem/view/Authentication/login.jsp");
            return;
        }
        
        this.cartServices = getCart(request);

        // Nếu giỏ trống => quay lại trang danh sách phòng
        if (cartServices == null || cartServices.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/services");
            return;
        }
        
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/view/UserService/booking_form.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }
}
