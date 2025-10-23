package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.HotelAdministration.HotelAdministrationDAO;
import model.User;

@WebServlet("/admin-home")
public class HotelAdministrationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // **Session Check:** Đảm bảo chỉ Admin/Manager mới truy cập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !(session.getAttribute("role").toString().toLowerCase().equals("admin") || 
              session.getAttribute("role").toString().toLowerCase().equals("hotel_manager"))) { 
            response.sendRedirect(request.getContextPath() + "/login?error=auth_fail"); 
            return;
        }

        try {
            HotelAdministrationDAO dao = new HotelAdministrationDAO();

            int availableRooms = dao.getAvailableRoomsCount();
            int bookedRooms = dao.getOccupiedRoomsCount();
            int receptionistCount = dao.getReceptionistCount();
            int customerCount = dao.getCustomerCount();
            double averageRating = dao.getAverageRating();


            // Gán các giá trị vào request
            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("bookedRooms", bookedRooms);
            request.setAttribute("receptionistCount", receptionistCount);
            request.setAttribute("customerCount", customerCount);
            request.setAttribute("avgRating", averageRating);

        } catch (Exception e) {
            System.err.println("🚨 CRITICAL ERROR in AdminDashboardController:");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu. Vui lòng kiểm tra Console Server.");
        }

        // Forward đến JSP
        request.getRequestDispatcher("/view/HotelAdministration/admin_homepage.jsp").forward(request, response);
    }
}