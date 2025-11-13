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
import java.util.List;
import model.StayRoom;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChangeStatus", urlPatterns = {"/ChangeStatus"})
public class SearchBooking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int phone = Integer.parseInt(request.getParameter("searchBooking"));
        
        
        StayRoomDAO dao = new StayRoomDAO();
        List<StayRoom> list = dao.getBooking(phone);
        
        
        request.setAttribute("stayroom", list);
        
        
        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/StayRoomForReceptionist.jsp");
        rd.forward(request, response);
    }

}
