package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import dao.HotelAdministration.VoucherDAO;

@WebServlet("/admin/vouchers/action")
public class VoucherActionController extends HttpServlet {

 
   
    private Date parseDate(String dateStr) throws Exception {
        
        return new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").toString().toLowerCase().contains("admin")) { 
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
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=invalid_action");
            }
        } catch (NumberFormatException e) {
          
            System.err.println(" Format Error (Number): " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=format_number");
        } 
        catch (Exception e) {
            
            System.err.println(" Critical Error in VoucherAction: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=system_error");
        }
    }
    
 
    private void handleCreate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String code = request.getParameter("code");
        String discountStr = request.getParameter("discountValue");
    
        String description = request.getParameter("description");
        
       
        double discountValue = Double.parseDouble(discountStr);
        
        VoucherDAO dao = new VoucherDAO();
      
        boolean success = dao.createVoucher(code, discountValue, description);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?success=create");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=db_create");
        }
    }
    
   
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String voucherIdStr = request.getParameter("voucherId");
        String code = request.getParameter("code");
        String discountStr = request.getParameter("discountValue");
     
        String description = request.getParameter("description");
        
        int voucherId = Integer.parseInt(voucherIdStr);
       
        double discountValue = Double.parseDouble(discountStr);
        
        VoucherDAO dao = new VoucherDAO();
    
        boolean success = dao.updateVoucher(voucherId, code, discountValue, description);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?success=update");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=db_update");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String voucherIdStr = request.getParameter("voucherId");
        int voucherId = Integer.parseInt(voucherIdStr);
        
        VoucherDAO dao = new VoucherDAO();
        boolean success = dao.deleteVoucher(voucherId);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=delete_fail");
        }
    }
}