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

/**
 *
 * @author Admin
 */
@WebServlet(name="ExtendServlet", urlPatterns={"/ExtendServlet"})
public class ExtendServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String roomId = request.getParameter("roomId");
        String time = request.getParameter("time");

        int roomid = Integer.parseInt(roomId);
        
        
        ExtendChangeRoom ex = new ExtendChangeRoom();
        
        boolean extend = ex.extendRoom(roomid, time);
        
        if (extend==true){
            String mess = "Successful";
            request.setAttribute("mess", mess);
        }
        else{
            String mess = "Failed";
            request.setAttribute("mess", mess);
        }
        

        

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/ExtendRoomForReceptionist.jsp");
        rd.forward(request, response);
 
    } 

}
