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
        
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").toString().toLowerCase().contains("admin")) { 
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        VoucherDAO voucherDAO = new VoucherDAO();
        
       
        List<Voucher> vouchers = voucherDAO.getAllVouchers();
        
      
        request.setAttribute("voucherList", vouchers);
        
      
        request.getRequestDispatcher("/view/HotelAdministration/voucher_list.jsp").forward(request, response);
    }
}