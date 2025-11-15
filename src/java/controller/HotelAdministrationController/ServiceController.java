package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.HotelAdministration.ServiceDAO;
import model.Service;

@WebServlet("/admin/services")
public class ServiceController extends HttpServlet {
    
    private boolean isAdmin(HttpSession session) {
        return session != null && session.getAttribute("role") != null && 
               "admin".equalsIgnoreCase(session.getAttribute("role").toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> services = serviceDAO.getAllServices();
        
        request.setAttribute("serviceList", services);
        request.getRequestDispatcher("/view/HotelAdministration/service_list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                handleCreate(request, response);
            } else if ("update".equals(action)) {
                handleUpdate(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/services?error=invalid_action");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/services?error=format");
        } catch (Exception e) {
            System.err.println("❌ Critical Error in Service Action: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/services?error=system_error");
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        // BỎ: boolean isIncluded = "1".equals(request.getParameter("isIncluded")); 

        double price = Double.parseDouble(priceStr);
        ServiceDAO dao = new ServiceDAO();
        
        // 🟢 GỌI DAO KHÔNG CÓ isIncluded
        if (dao.createService(name, description, price)) {
            response.sendRedirect(request.getContextPath() + "/admin/services?success=create");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/services?error=db_create");
        }
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String serviceIdStr = request.getParameter("serviceId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        // BỎ: boolean isIncluded = "1".equals(request.getParameter("isIncluded")); 

        int serviceId = Integer.parseInt(serviceIdStr);
        double price = Double.parseDouble(priceStr);
        ServiceDAO dao = new ServiceDAO();
        
        // 🟢 GỌI DAO KHÔNG CÓ isIncluded
        if (dao.updateService(serviceId, name, description, price)) {
            response.sendRedirect(request.getContextPath() + "/admin/services?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/services?error=db_update");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String serviceIdStr = request.getParameter("serviceId");
        
        try {
            int serviceId = Integer.parseInt(serviceIdStr);
            ServiceDAO dao = new ServiceDAO();
            
            if (dao.deleteService(serviceId)) {
                response.sendRedirect(request.getContextPath() + "/admin/services?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/services?error=not_found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/services?error=invalid_id");
        } catch (RuntimeException e) {
             if ("FK_VIOLATION".equals(e.getMessage())) {
                 response.sendRedirect(request.getContextPath() + "/admin/services?error=delete_fk"); 
             } else {
                 response.sendRedirect(request.getContextPath() + "/admin/services?error=db_delete");
             }
        }
    }
}