/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ServiceManagementController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import dao.ServiceManagement.ExtraServiceDAO;
import dao.ServiceManagement.ReservationDAO;
import model.ExtraService;

/**
 *
 * @author Hoang Viet Cuong
 */
@WebServlet(name = "NewServlet", urlPatterns = {"/NewServlet"})
public class extraService extends HttpServlet {


        @Override protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) YÊU CẦU LOGIN
        HttpSession session = request.getSession(false);
        Object userObj = (session != null) ? session.getAttribute("userId") : null; // key session của bạn
        if (userObj == null) {
            String back = request.getRequestURI() + (request.getQueryString()==null? "" : "?"+request.getQueryString());
            String returnUrl = URLEncoder.encode(back, StandardCharsets.UTF_8.name());
            response.sendRedirect(request.getContextPath()+"/login?returnUrl="+returnUrl);
            return;
        }
        int userId = Integer.parseInt(userObj.toString());

        // 2) PHẢI CÓ BOOKING PHÒNG (active)
        if (!new ReservationDAO().hasActiveReservation(userId)) {
            response.sendRedirect(request.getContextPath()+"/reservation?msg=NoActiveRoom");
            return;
        }

        // 3) LOAD LIST DỊCH VỤ (active) + phân trang đơn giản
        int page = 1, size = 12;
//        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); } catch (Exception ignored) {}
//        List<ExtraService> services = new ExtraServiceDAO().getAllActive(page, size);
//        int total = new ExtraServiceDAO().countActive();
//        int totalPages = (int)Math.ceil(total/(double)size);
//
//        request.setAttribute("services", services);
//        request.setAttribute("page", page);
//        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/view/ServiceManagement/extraService.jsp").forward(request, response);
    }
}

