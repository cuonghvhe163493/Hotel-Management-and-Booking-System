/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ServiceManagementController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.ServiceManagement.ExtraServiceDAO;
import model.ExtraService;

/**
 *
 * @author admin
 */
@WebServlet(name = "ExtraServiceDetail", urlPatterns = {"/extraServiceDetail"})
public class ExtraServiceDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/extraService");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/extraService");
            return;
        }

        ExtraServiceDAO dao = new ExtraServiceDAO();
        ExtraService service = dao.getById(id);
        if (service == null) {
            service = new ExtraService();
            service.setExtraServiceId(id);
            service.setServiceName("Extra Service #" + id + " (preview)");
            service.setServiceDescription("No data in database yet. This is a placeholder detail page.");
            service.setServicePrice(0.0);
            // các field khác để null cũng không sao, JSP sẽ if-check
        }

        request.setAttribute("service", service);
        request.setAttribute("related", java.util.Collections.emptyList()); // tạm không liên quan khi DB trống
        request.getRequestDispatcher("/view/ServiceManagement/extraServiceDetail.jsp").forward(request, response);
    }
}
