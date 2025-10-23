package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa có
        
        if (session != null) {
            // Hủy toàn bộ session hiện tại
            session.invalidate(); 
            System.out.println("✅ User logged out successfully.");
        }
        
        // Chuyển hướng người dùng về trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/login?logout=success");
    }
}