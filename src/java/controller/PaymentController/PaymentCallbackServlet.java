package controller.PaymentController;

import dao.Booking.BookingDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/payment-vnpay-callback")
public class PaymentCallbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        Map<String, String> fields = new HashMap<>();
        for (String key : request.getParameterMap().keySet()) {
            String value = request.getParameter(key);
            if (value != null && !value.isEmpty()) {
                fields.put(key, value);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");

        String signValue = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, VNPayConfig.hashAllFields(fields));

        System.out.println("VNPay Callback debug:");
        System.out.println("BookingId: " + request.getParameter("vnp_TxnRef"));
        System.out.println("TransactionStatus: " + request.getParameter("vnp_TransactionStatus"));
        System.out.println("SecureHash match: " + signValue.equals(vnp_SecureHash));

        if (signValue.equals(vnp_SecureHash)) {
            String status = request.getParameter("vnp_TransactionStatus");
            int bookingId = -1;
            try {
                bookingId = Integer.parseInt(request.getParameter("vnp_TxnRef"));
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (bookingId > 0 && "00".equals(status)) {
                try (Connection conn = DBConnection.getConnection()) {
                    BookingDAO bookingDAO = new BookingDAO(conn);
                    bookingDAO.updateBookingStatus(bookingId, "completed");
                    bookingDAO.updateBookingRoomsStatus(bookingId, "reserved");
                    System.out.println("Booking and rooms updated successfully!");
                } catch (Exception e) {
                    e.printStackTrace();
                }

                response.sendRedirect(request.getContextPath() + "/view/Payment/payment_success.jsp?" + request.getQueryString());
            } else {
                response.sendRedirect(request.getContextPath() + "/view/Payment/payment_failure.jsp?" + request.getQueryString());
            }
        } else {
            response.getWriter().println("<html><body><h3>Lỗi: Chữ ký không hợp lệ!</h3></body></html>");
        }
    }
}
