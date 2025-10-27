/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.StaymanagementController;

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
import java.util.List;
import model.StayRoom;

/**
 *
 * @author Admin
 */
@WebServlet(name="CheckInServletForCustomer", urlPatterns={"/CheckInServletForCustomer"})
public class CheckInServletForCustomer extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String bookingId = request.getParameter("bookingId");
        
        String roomId = request.getParameter("idroom");
        
        int booking_Id = Integer.parseInt(bookingId);
        int room_Id = Integer.parseInt(roomId);
        
        
        StayRoomDAO d = new StayRoomDAO();
        StayRoom stayroom = d.getCheckInRoomForCustomer(booking_Id,room_Id);
        
        request.setAttribute("stayroom", stayroom);

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForCustomer.jsp");
        rd.forward(request, response);
    }
    
    

}
