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

        User user = UserDAO.getUserByUsernameAndPassword(username, password);
        String ctx = request.getContextPath();

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user.getUsername());
            session.setAttribute("role", user.getRole());

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(ctx + "/view/HotelAdministration/admin_homepage.jsp");
            } else if ("customer".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(ctx + "/view/Customer/customer_homepage.jsp");
            } else if ("hotel_manager".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(ctx + "/view/HotelManager/manager_homepage.jsp");
            } else {
                response.sendRedirect(ctx + "/login?error=true");
            }
        } else {
            response.sendRedirect(ctx + "/login?error=true");
        }
    }
}
