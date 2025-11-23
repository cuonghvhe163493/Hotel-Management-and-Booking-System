package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/Authentication/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");

        
        if (username == null || email == null || password == null || confirm == null
                || username.isEmpty() || email.isEmpty() || password.isEmpty() || confirm.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/register?error=missing");
            return;
        }

        if (!password.equals(confirm)) {
            response.sendRedirect(request.getContextPath() + "/register?error=pass");
            return;
        }

       
        if (UserDAO.isUsernameExists(username) || UserDAO.isEmailExists(email)) {
            response.sendRedirect(request.getContextPath() + "/register?error=exists");
            return;
        }

      
        boolean success = UserDAO.registerUserFull(username, password, email, phone, address, dob);

        if (success) {
           
            response.sendRedirect(request.getContextPath() + "/view/Authentication/login.jsp?success=1");
        } else {
         
            response.sendRedirect(request.getContextPath() + "/view/Authentication/register.jsp?error=1");
        }

    }
}
