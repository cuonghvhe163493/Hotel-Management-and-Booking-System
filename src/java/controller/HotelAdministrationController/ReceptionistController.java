package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.HotelAdministration.ReceptionistDAO;
import model.User;

@WebServlet("/admin/receptionists")
public class ReceptionistController extends HttpServlet {
    
    private boolean isAdmin(HttpSession session) {
        if (session == null || session.getAttribute("role") == null) return false;
        return "admin".equalsIgnoreCase(session.getAttribute("role").toString());
    }

    // 🔹 Xử lý GET: Hiển thị danh sách Lễ tân
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        ReceptionistDAO dao = new ReceptionistDAO();
        List<User> receptionists = dao.getAllReceptionists();
        
        request.setAttribute("receptionistList", receptionists);
        request.getRequestDispatcher("/view/HotelAdministration/receptionist_list.jsp").forward(request, response);
    }
    
    // 🔹 Xử lý POST: Tạo Lễ tân mới
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                handleCreate(request, response);
            } else if ("update".equals(action)) {
                handleUpdate(request, response);
            } else if ("update_status".equals(action)) { // 🟢 HÀNH ĐỘNG MỚI: Đổi trạng thái
                handleUpdateStatus(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=invalid_action");
            }
        } catch (RuntimeException e) {
            // Xử lý lỗi Khóa ngoại (ví dụ: Admin không thể xóa nếu Lễ tân có Reservation)
            if ("FK_VIOLATION".equals(e.getMessage())) {
                response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=delete_fk"); 
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=system_error");
            }
        } catch (Exception e) {
            System.err.println("❌ Critical Error in Receptionist Action: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=system_error");
        }
    }
    
    // 🔹 handleCreate (Giữ nguyên)
    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // ... (Logic đã có)
        // ...
    }
    
    // 🟢 Xử lý UPDATE (Sửa thông tin cá nhân)
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userIdStr = request.getParameter("userId");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password"); // Password cũ/mới
        
        int userId = Integer.parseInt(userIdStr);
        ReceptionistDAO dao = new ReceptionistDAO();
        
        // LƯU Ý: Phải đảm bảo password không bị mất. Giả sử form gửi password cũ nếu không đổi.
        boolean success = dao.updateReceptionist(userId, username, email, phone, address, password);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=db_update");
        }
    }
    
    // 🟢 Xử lý UPDATE STATUS (Đặt lại Status)
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userIdStr = request.getParameter("userId");
        String newStatus = request.getParameter("newStatus"); // active, suspended, banned
        
        int userId = Integer.parseInt(userIdStr);
        ReceptionistDAO dao = new ReceptionistDAO();
        
        boolean success = dao.updateReceptionistStatus(userId, newStatus);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?success=status_change");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=db_status_fail");
        }
    }

    // 🔹 handleDelete (Cập nhật logic)
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userIdStr = request.getParameter("userId");
        int userId = Integer.parseInt(userIdStr);
        ReceptionistDAO dao = new ReceptionistDAO();
        
        if (dao.deleteReceptionist(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/receptionists?error=delete_fail");
        }
    }
}