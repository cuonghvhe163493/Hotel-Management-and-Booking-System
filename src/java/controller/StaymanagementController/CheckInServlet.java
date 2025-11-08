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
@WebServlet(name="CheckInServlet", urlPatterns={"/CheckInServlet"})
public class CheckInServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String phoneNumber = request.getParameter("phoneNumber");
        
        String roomId = request.getParameter("idroom");
        
        int phoneNumb = Integer.parseInt(phoneNumber);
        
        
        
        StayRoomDAO d = new StayRoomDAO();
        StayRoom stayroom = d.getCheckInRoomForReceptionist(phoneNumb);
        
        request.setAttribute("stayroom", stayroom);

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
        rd.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        
        String booked = request.getParameter("booked");
        String idRoom = request.getParameter("idroom");
        String idroom = request.getParameter("idroom");
        String numPeople = request.getParameter("numPeople");
        String citizenId = request.getParameter("citizenId");
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");
        String gmail = request.getParameter("gmail");
        String phone = request.getParameter("phone");
        String note = request.getParameter("note");

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckIn.jsp");
            rd.forward(request, response);
    }

}
