/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.UserServicesController;

import dao.UserSerives.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.HotelService;

/**
 *
 * @author Legion
 */
@WebServlet(name="ServiceDetailsServlet", urlPatterns={"/service-detail"})
public class ServiceDetailsServlet extends HttpServlet {
    
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ServiceDAO();
    }
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        HotelService service = serviceDAO.getServiceById(id);
        
        request.setAttribute("service", service);
        
        request.getRequestDispatcher("/view/UserService/service-detail.jsp").forward(request, response);

        
    } 

    

}
