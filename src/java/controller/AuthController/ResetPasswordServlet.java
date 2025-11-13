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
        
        // Lấy username từ hidden field của form 
        String username = request.getParameter("username_final"); 

        //  Kiểm tra xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {
            // Trả về trang nhập mật khẩu mới với lỗi
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/reset_password_form.jsp?error=mismatch&username=" + username);
            return;
        }
        
        if (username == null || username.isEmpty()) {
            //Username không hợp lệ hoặc bị mất
             response.sendRedirect(request.getContextPath() + "/view/Authentication/forgot_password.jsp?error=invalid_flow");
             return;
        }

        //  Gọi DAO để cập nhật mật khẩu
        boolean updated = UserDAO.updatePassword(username, newPassword);

        if (updated) {
            //  Thành công: Chuyển hướng về trang login
            response.sendRedirect(request.getContextPath() + "/login?success=reset");
        } else {
            //  Thất bại
            response.sendRedirect(request.getContextPath() 
                    + "/view/Authentication/reset_password_form.jsp?error=db_fail&username=" + username);
        }
    }
}