package controller.ProfileController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || email == null || password == null ||
            !password.equals(confirmPassword)) {
            resp.sendRedirect(req.getContextPath() + "/view/Profile/update_profile.jsp?msg=error");
            return;
        }

        boolean updated = UserDAO.updateUserProfile(username, email, phone, address, password);

        if (updated) {
            HttpSession session = req.getSession();
            session.setAttribute("user", username);
            resp.sendRedirect(req.getContextPath() + "/view/Profile/update_profile.jsp?msg=success");
        } else {
            resp.sendRedirect(req.getContextPath() + "/view/Profile/update_profile.jsp?msg=error");
        }
    }
}
