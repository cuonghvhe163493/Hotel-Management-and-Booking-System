package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.HotelAdministration.ChangeUserStatusDAO;
import model.User;

@WebServlet("/admin/customer-status")
public class CustomerStatusController extends HttpServlet {

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
        
        ChangeUserStatusDAO dao = new ChangeUserStatusDAO();
        List<User> customers = dao.getAllCustomers();
        request.setAttribute("customerList", customers);

        request.getRequestDispatcher("/view/HotelAdministration/customer_status.jsp").forward(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userIdStr = request.getParameter("customerID");
        String newStatus = request.getParameter("status"); 
        
      
        if ("pending".equalsIgnoreCase(newStatus)) {
            newStatus = "suspended"; 
        }
        
        try {
            int userId = Integer.parseInt(userIdStr);
            ChangeUserStatusDAO dao = new ChangeUserStatusDAO();
            boolean success = dao.updateAccountStatus(userId, newStatus); 

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/customer-status?success=update");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/customer-status?error=db_fail");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/customer-status?error=invalid_id");
        }
    }
}