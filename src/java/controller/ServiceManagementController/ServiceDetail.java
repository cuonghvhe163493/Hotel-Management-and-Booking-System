/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ServiceManagementController;

import dao.ServiceManagement.SerivceDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

/**
 *
 * @author admin
 */
@WebServlet(name = "ServiceDetail", urlPatterns = {"/ServiceDetail"})
public class ServiceDetail extends HttpServlet {

    private final SerivceDetailDAO dao = new SerivceDetailDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        Integer id = null;
        try {
            id = Integer.valueOf(idStr);
        } catch (Exception ignore) {
        }

        if (id == null) {
            // id không hợp lệ → 400
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid service id");
            return;
        }

        Service s = dao.findById(id);
        if (s == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Service not found");
            return;
        }

// lấy giá nhỏ nhất
        Long minPriceCents = dao.getMinPriceCents(s.getServiceId());
        if (minPriceCents != null) {
            request.setAttribute("minPriceCents", minPriceCents);
            request.setAttribute("priceLabel", "From: $" + String.format("%.2f", minPriceCents / 100.0));
        }

        request.setAttribute("service", s);
        request.setAttribute("related", dao.findRelated(id, 4));

        request.getRequestDispatcher("/view/ServiceManagement/service_detail.jsp")
                .forward(request, response);
    }

}
