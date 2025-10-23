package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.HotelAdministration.RoomDAO;

@WebServlet("/admin/rooms/action")
public class RoomActionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // **Kiểm tra Session Admin** (giữ nguyên)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").toString().toLowerCase().contains("admin")) { 
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action"); 

        if ("create".equals(action)) {
            handleCreate(request, response);
        } else if ("update".equals(action)) { // 🟢 Xử lý Update
            handleUpdate(request, response);
        } else if ("delete".equals(action)) {
            handleDelete(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/rooms?error=invalid_action");
        }
    }
    
    // 🔹 Xử lý CREATE (giữ nguyên logic đã sửa)
    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        String capacityStr = request.getParameter("capacity");
        String priceStr = request.getParameter("price");
        // String description = request.getParameter("description"); // Đã bỏ qua
        
        try {
            double price = Double.parseDouble(priceStr);
            int capacity = Integer.parseInt(capacityStr);
            RoomDAO roomDAO = new RoomDAO();
            
            boolean success = roomDAO.createRoom(roomNumber, roomType, price, capacity); 
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/rooms?success=create");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/rooms?error=db_create"); 
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms?error=format");
        }
    }
    
    // 🟢 Xử lý UPDATE
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String roomIdStr = request.getParameter("roomId");
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        String capacityStr = request.getParameter("capacity");
        String priceStr = request.getParameter("price");
        String roomStatus = request.getParameter("roomStatus");

        try {
            int roomId = Integer.parseInt(roomIdStr);
            double price = Double.parseDouble(priceStr);
            int capacity = Integer.parseInt(capacityStr);
            
            RoomDAO roomDAO = new RoomDAO();
            
            boolean success = roomDAO.updateRoom(roomId, roomNumber, roomType, capacity, price, roomStatus);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/rooms?success=update");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/rooms?error=db_update"); 
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms?error=format_update");
        }
    }

    // 🔹 Xử lý DELETE (Cập nhật xử lý lỗi)
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String roomIdStr = request.getParameter("roomId");

        try {
            int roomId = Integer.parseInt(roomIdStr);
            RoomDAO roomDAO = new RoomDAO();
            
            boolean success = roomDAO.deleteRoom(roomId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/rooms?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/rooms?error=delete_not_found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms?error=invalid_id");
        } catch (RuntimeException e) {
            if ("FK_VIOLATION".equals(e.getMessage())) {
                // Lỗi Khóa ngoại do phòng đang có đặt chỗ/lịch sử
                response.sendRedirect(request.getContextPath() + "/admin/rooms?error=delete_fk"); 
            } else {
                 response.sendRedirect(request.getContextPath() + "/admin/rooms?error=db_delete");
            }
        }
    }
}