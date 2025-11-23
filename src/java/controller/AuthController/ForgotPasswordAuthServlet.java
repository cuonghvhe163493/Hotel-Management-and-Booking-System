package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;

@WebServlet("/forgot-password-auth")
public class ForgotPasswordAuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        
        boolean credentialsMatch = UserDAO.checkUserCredentials(username, email, phone);

        if (credentialsMatch) {
           
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/reset_password_form.jsp?username=" + username);
        } else {
            
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/forgot_password.jsp?error=auth_fail");
        }
    }
}