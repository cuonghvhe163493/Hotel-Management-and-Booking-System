package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.HotelAdministration.VoucherDAO;
import model.Voucher;

@WebServlet("/admin/vouchers")
public class VoucherListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // **Kiểm tra Session Admin**
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").toString().toLowerCase().contains("admin")) { 
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        VoucherDAO voucherDAO = new VoucherDAO();
        
        // 1. Lấy danh sách voucher
        List<Voucher> vouchers = voucherDAO.getAllVouchers();
        
        // 2. Gán vào request
        request.setAttribute("voucherList", vouchers);
        
        // 3. Chuyển tiếp đến JSP
        request.getRequestDispatcher("/view/HotelAdministration/voucher_list.jsp").forward(request, response);
    }
}