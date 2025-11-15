package controller.BookingController;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer customerId = (Integer) session.getAttribute("customerId");
        
        if (customerId == null) {
            response.sendRedirect("/HotelManagementandBookingSystem/view/Authentication/login.jsp");
            return;
        }

        // Lấy giỏ hàng từ session
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        // Nếu giỏ trống => quay lại trang danh sách phòng
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/rooms");
            return;
        }

        // Đặt dữ liệu để hiển thị ở JSP
        request.setAttribute("user", user);
        request.setAttribute("cart", cart);

        // Forward đến booking-form.jsp
        request.getRequestDispatcher("/view/Booking/booking_form.jsp").forward(request, response);
    }
}
