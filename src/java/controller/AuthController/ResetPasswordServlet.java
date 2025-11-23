package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;


@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
       
        String username = request.getParameter("username_final"); 

       
        if (!newPassword.equals(confirmPassword)) {
        
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/reset_password_form.jsp?error=mismatch&username=" + username);
            return;
        }
        
        if (username == null || username.isEmpty()) {
          
             response.sendRedirect(request.getContextPath() + "/view/Authentication/forgot_password.jsp?error=invalid_flow");
             return;
        }

    
        boolean updated = UserDAO.updatePassword(username, newPassword);

        if (updated) {
       
            response.sendRedirect(request.getContextPath() + "/login?success=reset");
        } else {
           
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/reset_password_form.jsp?error=db_fail&username=" + username);
        }
    }
}