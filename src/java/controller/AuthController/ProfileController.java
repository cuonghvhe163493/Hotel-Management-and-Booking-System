package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.Authentication.UserDAO;
import model.User;

// Map Servlet tới URL "/edit_profile" hoặc "/profile"
@WebServlet("/edit_profile") 
public class ProfileController extends HttpServlet {

    // Helper: Lấy User ID từ Session
    // GIẢ ĐỊNH: Khi đăng nhập, bạn lưu user_id (kiểu Integer) vào Session.
    private int getUserIdFromSession(HttpSession session) {
        // Cần lấy đối tượng User từ session, vì bạn lưu username trong LoginServlet
        Object userObj = session.getAttribute("currentUser"); 
        if (userObj instanceof User) {
            return ((User) userObj).getUserId();
        }
        
        // Hoặc nếu bạn lưu riêng userId
        Object id = session.getAttribute("userId");
        if (id instanceof Integer) {
            return (int) id;
        }
        
        // Nếu không tìm thấy, trả về 0 (hoặc throw Exception)
        return 0; 
    }
    
    // *LƯU Ý QUAN TRỌNG: Bạn cần cập nhật LoginServlet để lưu đủ thông tin User, 
    // bao gồm cả User ID (userId) vào Session khi người dùng đăng nhập thành công.*
    // Ví dụ trong LoginServlet: session.setAttribute("currentUser", user);

    // 🔹 Xử lý GET: Tải thông tin hiện tại của User
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        // 1. Kiểm tra trạng thái đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy User ID
        // **QUAN TRỌNG:** Giả định bạn đã sửa LoginServlet để lưu userId vào session
        int userId = 0;
        try {
            // Thử lấy userId trực tiếp nếu đã lưu
            userId = (int) session.getAttribute("userId");
        } catch (NullPointerException | ClassCastException e) {
            // Nếu không có userId trong session, chuyển hướng về trang chủ
             response.sendRedirect(request.getContextPath() + "/login?error=no_user_id");
             return;
        }
        
        if (userId == 0) {
             response.sendRedirect(request.getContextPath() + "/login?error=no_user_id");
             return;
        }


        // 3. Gọi DAO để lấy toàn bộ thông tin User
        User user = UserDAO.getUserById(userId); 

        if (user != null) {
            // 4. Đặt đối tượng User vào Request để JSP hiển thị
            request.setAttribute("userProfile", user);
            // 5. Chuyển hướng tới trang JSP
            request.getRequestDispatcher("/view/Authentication/update_profile.jsp").forward(request, response);
        } else {
            // Lỗi: Không tìm thấy User trong DB
            response.sendRedirect(request.getContextPath() + "/home?error=profile_not_found");
        }
    }

    // 🔹 Xử lý POST: Cập nhật thông tin
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        // 1. Kiểm tra trạng thái đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // 2. Lấy User ID từ Session (Cần để biết User nào đang cập nhật)
        int userId = 0;
        try {
            userId = (int) session.getAttribute("userId");
        } catch (NullPointerException | ClassCastException e) {
             response.sendRedirect(request.getContextPath() + "/login?error=no_user_id");
             return;
        }
        
        if (userId == 0) {
             response.sendRedirect(request.getContextPath() + "/login?error=no_user_id");
             return;
        }

        // 3. Lấy dữ liệu từ Form (6 trường)
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        // Giả định: password cũ được truyền vào (có thể là mã hóa, hoặc "••••••")
        
        // 4. Kiểm tra mật khẩu (Xử lý trường "••••••" từ JSP)
        // Nếu người dùng không nhập mật khẩu mới, chúng ta phải giữ lại mật khẩu cũ.
        String finalPassword = password;
        if (password.equals("••••••") || password.isEmpty()) {
            // Lấy User hiện tại để có mật khẩu cũ
            User oldUser = UserDAO.getUserById(userId);
            if (oldUser != null) {
                finalPassword = oldUser.getPassword();
            } else {
                // Lỗi nghiêm trọng: Không tìm thấy user dù đã có ID
                response.sendRedirect(request.getContextPath() + "/edit_profile?error=user_not_found");
                return;
            }
        } else {
             // TODO: Thêm bước mã hóa mật khẩu mới (hash the new password)
             // finalPassword = hash(password);
        }
        
        // 5. Gọi DAO cập nhật
        // Chú ý: thứ tự các tham số phải khớp với UserDAO.updateUserProfile
        boolean success = UserDAO.updateUserProfile(userId, name, email, phone, finalPassword);

        if (success) {
            // 6. Cập nhật lại Session (Chỉ username/email/phone nếu cần)
            session.setAttribute("user", name); // Cập nhật tên hiển thị nếu có
            
            // 7. Chuyển hướng thành công
            response.sendRedirect(request.getContextPath() + "/edit_profile?success=update");
        } else {
            // 8. Chuyển hướng thất bại
            response.sendRedirect(request.getContextPath() + "/edit_profile?error=db_fail");
        }
    }
}