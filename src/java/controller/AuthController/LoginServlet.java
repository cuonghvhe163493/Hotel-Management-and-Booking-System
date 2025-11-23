package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
      
        req.getRequestDispatcher("/view/Authentication/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ctx = request.getContextPath();

      
        User user = UserDAO.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            String status = user.getAccountStatus().toLowerCase();
            HttpSession session = request.getSession();

            
            if ("banned".equals(status)) {
               
                System.out.println(" Login Denied: User " + username + " is BANNED.");
               
                response.sendRedirect(ctx + "/login?error=banned");
                return;
            }

           
            session.setAttribute("user", user);
            session.setAttribute("customerId", user.getUserId());
            session.setAttribute("role", user.getRole());

          
            if ("suspended".equals(status)) {
               
                session.setAttribute("isSuspended", true);
                System.out.println("️ Login Success: User " + username + " is SUSPENDED.");
            } else {
               
                session.removeAttribute("isSuspended");
            }

            
            String redirectUrl = request.getParameter("redirect");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
                return;
            }

            String role = user.getRole().toLowerCase();
            if ("admin".equals(role)) {
                response.sendRedirect(ctx + "/admin-home");
            } else {
               
                response.sendRedirect(ctx + "/index.jsp");
            }

        } else {
           
            System.out.println("Login Failed: Invalid credentials for " + username);
            response.sendRedirect(ctx + "/login?error=invalid");
        }
    }
}