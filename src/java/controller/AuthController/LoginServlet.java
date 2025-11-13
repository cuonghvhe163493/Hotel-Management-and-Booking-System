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
            session.setAttribute("user", user);
            session.setAttribute("customerId", user.getUserId());
            session.setAttribute("role", user.getRole());
            // Lấy role và chuyển về chữ thường để so sánh
            String userRole = user.getRole().toLowerCase();

            if ("admin".equals(userRole)) {
                request.getRequestDispatcher("/admin-home").forward(request, response);
                return;

            } else if ("hotel_manager".equals(userRole)) {
                // Chuyển hướng Manager đến trang Manager Homepage
                response.sendRedirect(ctx + "/index.jsp");

            } else if ("customer".equals(userRole)) {
                response.sendRedirect(ctx + "/rooms");

            } else {
                // Trường hợp vai trò không xác định 
                response.sendRedirect(ctx + "/login?error=invalid_role");
            }
        } else {
            // Username/Password sai
            response.sendRedirect(ctx + "/login?error=true");
        }
    }
}
