/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.StaymanagementController;

import dao.Staymanagement.ExtendChangeRoom;
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
@WebServlet(name = "ChangeRoom", urlPatterns = {"/ChangeRoom"})
public class ChangeRoom extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");


        ExtendChangeRoom ex = new ExtendChangeRoom();
        
        List<Integer> list_1= ex.getRoom("occupied");
        List<Integer> list_2= ex.getRoom("available");
        
        
        request.setAttribute("list_1", list_1);
        request.setAttribute("list_2", list_2);
        
        
        
        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/ChangeRoom.jsp");
        rd.forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String roomId = request.getParameter("roomId");
        String roomIdToChange = request.getParameter("roomIdToChange");

        int id = Integer.parseInt(roomId);
        int idToChange = Integer.parseInt(roomIdToChange);
        
        
        ExtendChangeRoom ex = new ExtendChangeRoom();
        
        boolean change = ex.changeRoom(id, idToChange);
        
        if (change==true){
            String mess = "Successful";
            request.setAttribute("mess", mess);
        }
        else{
            String mess = "Failed";
            request.setAttribute("mess", mess);
        }
        
        
        
        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/ChangeRoom.jsp");
        rd.forward(request, response);
    }

}
