package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;

// Servlet này xử lý BƯỚC 1: Xác thực 3 trường (Username, Email, Phone)
@WebServlet("/forgot-password-auth")
public class ForgotPasswordAuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // 🧩 Gọi DAO để kiểm tra 3 trường
        boolean credentialsMatch = UserDAO.checkUserCredentials(username, email, phone);

        if (credentialsMatch) {
            // ✅ Thành công: Chuyển username qua URL (Query Parameter) để dùng ở bước tiếp theo
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/reset_password_form.jsp?username=" + username);
        } else {
            // ❌ Thất bại: Trả về trang xác thực với thông báo lỗi
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/forgot_password.jsp?error=auth_fail");
        }
    }
}

