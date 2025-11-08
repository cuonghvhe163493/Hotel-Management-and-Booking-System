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
import model.StayRoom;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChangeStatus", urlPatterns = {"/ChangeStatus"})
public class ChangeStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        StayRoomDAO dao = new StayRoomDAO();
        boolean success = dao.updateRoomStatus(roomId, "occupied");

        if (success) {
            request.setAttribute("message", "successfully");
        } else {
            request.setAttribute("error", "Failed");
        }
        StayRoom stayroom = dao.getCheckInRoomForReceptionist(bookingId, roomId);
        request.setAttribute("stayroom", stayroom);
        
        
        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
        rd.forward(request, response);
    }

}
