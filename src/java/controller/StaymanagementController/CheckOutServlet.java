/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.StaymanagementController;

import dao.Staymanagement.CheckInOut;
import dao.Staymanagement.StayRoomDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;
import model.StayRoom;

/**
 *
 * @author Admin
 */
@WebServlet(name="CheckOutServlet", urlPatterns={"/CheckOutServlet"})
public class CheckOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String phoneNumber = request.getParameter("phoneNumber");
        int phoneNumb = Integer.parseInt(phoneNumber);

        CheckInOut cio = new CheckInOut();
        List<StayRoom> list = cio.getCheckOutRoomForReceptionist(phoneNumb);
        
        
        StayRoom info = cio.getInfoCustomer(phoneNumb);
        request.setAttribute("list", list);
        
        request.setAttribute("info", info);
        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckOutForReceptionist.jsp");
        rd.forward(request, response);
    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    String[] selectedRoomIds = request.getParameterValues("selectedRooms");
    
    StayRoomDAO dao = new StayRoomDAO();

    
    if (selectedRoomIds == null || selectedRoomIds.length == 0) {
        
        request.setAttribute("errorMessage", "Please select at least one room to check-out.");
        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckOutForReceptionist.jsp");
        rd.forward(request, response);
        return; 
    }
    for (String roomIdStr : selectedRoomIds) {
        
            int roomId = Integer.parseInt(roomIdStr.trim());
            dao.updateRoomStatus(roomId, "maintenance");
            dao.updateBookingRoomStatus(roomId, "checked_out");    
    }

    request.setAttribute("successMessage", "Check-out successful");

    RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
    rd.forward(request, response);
}

}
