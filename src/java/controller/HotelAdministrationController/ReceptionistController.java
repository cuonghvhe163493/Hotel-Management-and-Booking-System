package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.HotelAdministration.ReceptionistDAO;
import model.User;

@WebServlet("/admin/receptionists")
public class ReceptionistController extends HttpServlet {
    
    private boolean isAdmin(HttpSession session) {
        if (session == null || session.getAttribute("role") == null) return false;
        return "admin".equalsIgnoreCase(session.getAttribute("role").toString());
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        ReceptionistDAO dao = new ReceptionistDAO();
        List<User> receptionists = dao.getAllReceptionists();
        
        request.setAttribute("receptionistList", receptionists);
        request.getRequestDispatcher("/view/HotelAdministration/receptionist_list.jsp").forward(request, response);
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
            } else if ("update_status".equals(action)) { 
                handleUpdateStatus(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=invalid_action");
            }
        } catch (RuntimeException e) {
           
            if ("FK_VIOLATION".equals(e.getMessage())) {
                response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=delete_fk"); 
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=system_error");
            }
        } catch (Exception e) {
            System.err.println("❌ Critical Error in Receptionist Action: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=system_error");
        }
    }
    
   
    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    }
    
  
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userIdStr = request.getParameter("userId");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password"); 
        
        int userId = Integer.parseInt(userIdStr);
        ReceptionistDAO dao = new ReceptionistDAO();
        
        
        boolean success = dao.updateReceptionist(userId, username, email, phone, address, password);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=db_update");
        }
    }
    
   
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userIdStr = request.getParameter("userId");
        String newStatus = request.getParameter("newStatus"); 
        
        int userId = Integer.parseInt(userIdStr);
        ReceptionistDAO dao = new ReceptionistDAO();
        
        boolean success = dao.updateReceptionistStatus(userId, newStatus);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?success=status_change");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=db_status_fail");
        }
    }

    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userIdStr = request.getParameter("userId");
        int userId = Integer.parseInt(userIdStr);
        ReceptionistDAO dao = new ReceptionistDAO();
        
        if (dao.deleteReceptionist(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=delete_fail");
        }
    }
}