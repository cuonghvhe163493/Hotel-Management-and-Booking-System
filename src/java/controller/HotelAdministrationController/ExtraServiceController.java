package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import dao.HotelAdministration.ExtraServiceDAO;
import model.ExtraService;

@WebServlet("/admin/extra-services")
public class ExtraServiceController extends HttpServlet {
    
    private final SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

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

        ExtraServiceDAO serviceDAO = new ExtraServiceDAO();
        List<ExtraService> services = serviceDAO.getAllExtraServices();
        
        request.setAttribute("extraServiceList", services);
        request.getRequestDispatcher("/view/HotelAdministration/extra_service_list.jsp").forward(request, response);
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
                response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=invalid_action");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=format");
        } catch (Exception e) {
            System.err.println("❌ Critical Error in ExtraService Action: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=system_error");
        }
    }
    
    // Helper để Parse DateTime
    private Date parseDateTime(String dateTimeStr) throws Exception {
        return dateTimeFormat.parse(dateTimeStr);
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resIdStr = request.getParameter("reservationId"); // Cần ID của đơn đặt chỗ
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");

        int reservationId = Integer.parseInt(resIdStr);
        double price = Double.parseDouble(priceStr);
        Date startTime = parseDateTime(startTimeStr);
        Date endTime = parseDateTime(endTimeStr);
        
        ExtraServiceDAO dao = new ExtraServiceDAO();
        if (dao.createExtraService(reservationId, name, description, price, startTime, endTime)) {
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?success=create");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=db_create");
        }
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String serviceIdStr = request.getParameter("serviceId");
        String resIdStr = request.getParameter("reservationId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String status = request.getParameter("status");

        int serviceId = Integer.parseInt(serviceIdStr);
        int reservationId = Integer.parseInt(resIdStr);
        double price = Double.parseDouble(priceStr);
        Date startTime = parseDateTime(startTimeStr);
        Date endTime = parseDateTime(endTimeStr);
        
        ExtraServiceDAO dao = new ExtraServiceDAO();
        if (dao.updateExtraService(serviceId, reservationId, name, description, price, startTime, endTime, status)) {
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=db_update");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String serviceIdStr = request.getParameter("serviceId");
        
        try {
            int serviceId = Integer.parseInt(serviceIdStr);
            ExtraServiceDAO dao = new ExtraServiceDAO();
            
            if (dao.deleteExtraService(serviceId)) {
                response.sendRedirect(request.getContextPath() + "/admin/extra-services?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=not_found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=invalid_id");
        } catch (RuntimeException e) {
             if ("FK_VIOLATION".equals(e.getMessage())) {
                 response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=delete_fk"); 
             } else {
                 response.sendRedirect(request.getContextPath() + "/admin/extra-services?error=db_delete");
             }
        }
    }
}