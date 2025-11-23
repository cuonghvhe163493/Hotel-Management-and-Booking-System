/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.StaymanagementController;

import dao.Staymanagement.StayRoomDAO;
import model.StayRoom;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name="details", urlPatterns={"/details"})
public class Details extends HttpServlet { 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String roomId = request.getParameter("roomId");
        String bookingId = request.getParameter("bookingId");
        String role = request.getParameter("role");
        int roomid = Integer.parseInt(roomId);
        int bookingid = Integer.parseInt(bookingId);
        int rl = Integer.parseInt(role);
        StayRoomDAO d = new StayRoomDAO();
        
        StayRoom room = d.getDetails(bookingid, roomid);
        request.setAttribute("room", room);
        if(rl==1){
            request.setAttribute("role", "hotel_manager");
        }
        else{
            request.setAttribute("role", "customer");
        }
        
        
        

        

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/DetailRoom.jsp");
        rd.forward(request, response);
 
    } 
    

}
