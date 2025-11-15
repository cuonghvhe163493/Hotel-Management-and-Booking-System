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
        // Luôn forward đến trang login.jsp
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

        // 1. Xác thực tên đăng nhập và mật khẩu
        User user = UserDAO.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            String status = user.getAccountStatus().toLowerCase();
            HttpSession session = request.getSession();

            // 2. Kiểm tra trạng thái tài khoản
            if ("banned".equals(status)) {
                // Trường hợp 1: Tài khoản bị BAN -> Không cho đăng nhập
                System.out.println("🚫 Login Denied: User " + username + " is BANNED.");
                // Redirect về trang login kèm thông báo lỗi cụ thể
                response.sendRedirect(ctx + "/login?error=banned");
                return;
            }

            // 3. Đăng nhập thành công -> Thiết lập Session
            session.setAttribute("user", user);
            session.setAttribute("customerId", user.getUserId());
            session.setAttribute("role", user.getRole());

            // 4. Xử lý thông báo Suspended
            if ("suspended".equals(status)) {
                // Trường hợp 2: Tài khoản bị SUSPENDED -> Vẫn cho login, và lưu thông báo vào Session 
                // Sử dụng một cờ để trang đích biết cần hiển thị thông báo
                session.setAttribute("isSuspended", true);
                System.out.println("⚠️ Login Success: User " + username + " is SUSPENDED.");
            } else {
                // Đảm bảo không còn cờ suspended/alert cũ từ lần đăng nhập trước
                session.removeAttribute("isSuspended");
            }

            // 5. Logic Redirect (Giữ nguyên, chuyển hướng đến trang đích)
            String redirectUrl = request.getParameter("redirect");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
                return;
            }

            String role = user.getRole().toLowerCase();
            if ("admin".equals(role)) {
                response.sendRedirect(ctx + "/admin-home");
            } else {
                // Mọi role khác (bao gồm customer) về trang chủ
                response.sendRedirect(ctx + "/index.jsp");
            }

        } else {
            // Trường hợp 3: Sai username/password
            System.out.println("❌ Login Failed: Invalid credentials for " + username);
            response.sendRedirect(ctx + "/login?error=invalid");
        }
    }
}