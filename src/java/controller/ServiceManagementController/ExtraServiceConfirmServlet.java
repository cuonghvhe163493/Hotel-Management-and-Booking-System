/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ServiceManagementController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

import dao.ServiceManagement.ReservationDAO;
import dao.ServiceManagement.ExtraServiceBookingDAO;
import dao.ServiceManagement.ExtraServiceDAO;
import model.ExtraService;;

/**
 *
 * @author admin
 */
@WebServlet("/extraService/confirm")
public class ExtraServiceConfirmServlet extends HttpServlet {
   
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        Object userIdObj = (session != null) ? session.getAttribute("userId") : null;
        if (userIdObj == null) {
            resp.sendRedirect(req.getContextPath()+"/login");
            return;
        }
        int userId = Integer.parseInt(userIdObj.toString());

        // Lấy & validate input
        String sid = req.getParameter("serviceId");
        String qtyStr = req.getParameter("qty");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        // note: có thể lưu vào bảng khác nếu cần

        int serviceId; int qty;
        try { serviceId = Integer.parseInt(sid); qty = Math.max(1, Integer.parseInt(qtyStr)); }
        catch (Exception e) { resp.sendRedirect(req.getContextPath()+"/extraService"); return; }

        // Lấy service & reservation active
        ExtraServiceDAO sdao = new ExtraServiceDAO();
        ExtraService svc = sdao.getById(serviceId);
        if (svc == null) { resp.sendRedirect(req.getContextPath()+"/extraService?msg=ServiceNotFound"); return; }

        ReservationDAO rdao = new ReservationDAO();
        Integer reservationId = rdao.getActiveReservationId(userId);
        if (reservationId == null) {
            resp.sendRedirect(req.getContextPath()+"/reservation?msg=NoActiveReservation");
            return;
        }

        // Ghi DB
        ExtraServiceBookingDAO bdao = new ExtraServiceBookingDAO();
        boolean ok = bdao.addExtraServiceToReservation(
                reservationId, serviceId, qty, BigDecimal.valueOf(svc.getServicePrice())
        );

        // (Optional) lưu tạm thông tin khách vào session để lần sau prefill
        session.setAttribute("customerName", fullName);
        session.setAttribute("customerPhone", phone);
        session.setAttribute("customerEmail", email);

        String back = req.getContextPath()+"/extraServiceDetail?id="+serviceId;
        resp.sendRedirect(ok ? back+"&msg=Booked" : back+"&msg=BookFailed");
    }}