/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.UserServicesController;

import dao.Authentication.UserDAO;
import dao.UserSerives.ExtraServiceDAO;
import dao.UserSerives.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import model.ExtraService;
import model.HotelService;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name="ExtraServiceServlet", urlPatterns={"/extra-services"})
public class ExtraServiceServlet extends HttpServlet {
   
    private ExtraServiceDAO serviceDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ExtraServiceDAO();
        this.userDAO = new UserDAO();
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //check login thi bỏ comment

        // Get parameters from query string
        String nameKeyword = request.getParameter("name");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String serviceType = request.getParameter("serviceType");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        // Convert parameters safely
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int pageSize = (pageSizeStr != null) ? Integer.parseInt(pageSizeStr) : 9;

        // Call DAO
        ServiceDAO dao = new ServiceDAO();
        List<ExtraService> services = serviceDAO.getServices(nameKeyword, minPrice, maxPrice, serviceType, page, pageSize);
        
//        System.out.println("services: " + services);
        
        List<String> uniqueTypes = services.stream()
                                    .map(ExtraService::getServiceType)   // extract serviceType
                                    .filter(Objects::nonNull)            // remove null values
                                    .distinct()                          // keep only unique ones
                                    .collect(Collectors.toList());
        

        // Set attributes for JSP
        request.setAttribute("services", services);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("name", nameKeyword);
        request.setAttribute("serviceType", serviceType);
        request.setAttribute("serviceTypes", uniqueTypes);

        // Forward to JSP page
        request.getRequestDispatcher("extra_services.jsp").forward(request, response);
        
    }
}
