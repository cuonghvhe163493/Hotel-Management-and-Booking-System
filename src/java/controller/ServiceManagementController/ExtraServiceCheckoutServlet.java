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

import dao.ServiceManagement.ReservationDAO;

/**
 *
 * @author admin
 */
@WebServlet("/extraService/checkout")
public class ExtraServiceCheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object userObj = (session != null) ? session.getAttribute("userId") : null; // đổi thành key bạn đang dùng
        if (userObj == null) {
            String back = request.getRequestURI()
                    + (request.getQueryString() == null ? "" : "?" + request.getQueryString());
            String returnUrl = URLEncoder.encode(back, StandardCharsets.UTF_8.name());
            response.sendRedirect(request.getContextPath() + "/login?returnUrl=" + returnUrl);
            return;
        }
        int userId = (userObj instanceof Integer) ? (Integer) userObj : Integer.parseInt(userObj.toString());

        // check đang có reservation/room active
        ReservationDAO rdao = new ReservationDAO();
        if (!rdao.hasActiveReservation(userId)) {
            response.sendRedirect(request.getContextPath() + "/reservation?msg=NoActiveRoom");
            return;
        }

        // load list nếu cần: request.setAttribute("extraServiceList", new ExtraServiceDAO().getAllActive());
        request.getRequestDispatcher("/view/ServiceManagement/extraService.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
