package controller.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment"})
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Lấy param từ form
        String bookingIdStr   = request.getParameter("bookingId");
        String grandTotalStr  = request.getParameter("grandTotal");
        String orderInfo      = request.getParameter("orderInfo");

        if (bookingIdStr == null || bookingIdStr.isEmpty()
                || grandTotalStr == null || grandTotalStr.isEmpty()) {
            response.getWriter().println("Missing bookingId or grandTotal!");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            double grandTotal = Double.parseDouble(grandTotalStr);

            if (orderInfo == null || orderInfo.isEmpty()) {
                orderInfo = "Payment for booking #" + bookingId;
            }

            // ------------ VNPay params ------------
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType   = "topup";
            String vnp_TxnRef  = String.valueOf(bookingId); // dùng bookingId
            String vnp_IpAddr  = request.getRemoteAddr();
            String vnp_TmnCode = VNPayConfig.vnp_TmnCode;

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            // VNPay yêu cầu *100
            vnp_Params.put("vnp_Amount", String.valueOf((long) (grandTotal * 100)));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", orderInfo);
            vnp_Params.put("vnp_OrderType", orderType);
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            // ------------ Build query & hash ------------
            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            StringBuilder query    = new StringBuilder();

            for (String fieldName : fieldNames) {
                String fieldValue = vnp_Params.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    hashData.append(fieldName)
                            .append('=')
                            .append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()))
                            .append('&');

                    query.append(fieldName)
                         .append('=')
                         .append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()))
                         .append('&');
                }
            }

            // Bỏ dấu & cuối cùng
            String hashDataStr = hashData.substring(0, hashData.length() - 1);
            String queryUrl    = query.substring(0, query.length() - 1);

            String vnp_SecureHash = VNPayConfig.hmacSHA512(
                    VNPayConfig.vnp_HashSecret,
                    hashDataStr
            );

            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;

            String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;

            System.out.println("Redirecting to VNPay URL: " + paymentUrl);

            // Redirect sang VNPay
            response.sendRedirect(paymentUrl);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Nếu có ai GET thẳng /payment thì cho về trang chủ
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}