package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.HotelAdministration.HotelAdministrationDAO;

@WebServlet("/admin-home")
public class HotelAdministrationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy các thống kê từ DAO
            int availableRooms = HotelAdministrationDAO.getAvailableRoomsCount();
            int bookedRooms = HotelAdministrationDAO.getBookedRoomsCount();
            int receptionistCount = HotelAdministrationDAO.getReceptionistCount();
            int customerCount = HotelAdministrationDAO.getCustomerCount();
            double avgRating = HotelAdministrationDAO.getAverageRating();

            // Debug: In ra console để kiểm tra giá trị (Nếu chạy được đến đây, DAO đã thành công)
            System.out.println("✅ --- Dashboard Data Debug (Controller) ---");
            System.out.println("Available Rooms: " + availableRooms);
            System.out.println("Booked Rooms: " + bookedRooms);
            System.out.println("Receptionist Count: " + receptionistCount);
            System.out.println("Customer Count: " + customerCount);
            System.out.println("Average Rating: " + avgRating);
            System.out.println("----------------------------------------");


            // Gửi các giá trị vào request để hiển thị trên JSP
            // Nếu các giá trị này là 0 hoặc 0.0, JSP sẽ hiển thị 0 hoặc 0.0
            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("bookedRooms", bookedRooms);
            request.setAttribute("receptionistCount", receptionistCount);
            request.setAttribute("customerCount", customerCount);
            request.setAttribute("avgRating", avgRating);

        } catch (Exception e) {
            // Đây là nơi bắt các lỗi Runtime tiềm ẩn (ví dụ: NullPointerException nếu DBConnection.getConnection() bị lỗi)
            System.err.println("🚨 CRITICAL ERROR in HotelAdministrationController:");
            e.printStackTrace();
            
            // Đặt thuộc tính là NULL hoặc 0 để đảm bảo JSP hiển thị "Không có dữ liệu"
            // (Tuy nhiên, nếu lỗi nghiêm trọng, code này có thể không chạy)
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu. Vui lòng kiểm tra Console Server.");
            
            // Không cần gán các thuộc tính khác, vì chúng sẽ là null (như bạn thấy)
        }

        // Chuyển hướng đến trang JSP của admin
        request.getRequestDispatcher("/view/HotelAdministration/admin_homepage.jsp").forward(request, response);
    }
}