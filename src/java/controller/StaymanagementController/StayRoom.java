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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name="stayRoom", urlPatterns={"/stayRoom"})
public class StayRoom extends HttpServlet {
   

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String userid = request.getParameter("id");
        int id = Integer.parseInt(userid);
        
        
        
        StayRoomDAO d = new StayRoomDAO();
        List<model.StayRoom> stayroom = d.getAllRoomsForCustomer(id,"checked_in");
        
        
        request.setAttribute("stayroom", stayroom);

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/StayRoom.jsp");
        rd.forward(request, response);
 
    } 

}
