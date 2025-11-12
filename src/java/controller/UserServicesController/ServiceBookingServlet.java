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
        
        // --- Fake login tạm thời (xóa/comment khi test xong) ---
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User();
            user.setUserId(5);
            user.setUsername("alice");
            user.setPassword("alicepwd");
            user.setEmail("alice@mail.com");
            user.setRole("customer");
            user.setProfileData("{\"fullname\":\"Alice\"}");
            user.setAccountStatus("active");

            session.setAttribute("user", user);
            System.out.println("Alice đang login"); // log console
        }
        
        /*if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }*/
        
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
