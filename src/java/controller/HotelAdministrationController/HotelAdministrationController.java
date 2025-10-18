package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-home")  // URL ánh xạ đến servlet này
public class HotelAdministrationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role != null && role.equals("admin")) {
            // Chuyển hướng tới trang admin homepage nếu người dùng là admin
            request.getRequestDispatcher("/view/HotelAdministration/admin_homepage.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp?error=true");  // Nếu không phải admin, chuyển lại trang login
        }
    }
}
