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
@WebServlet(name = "searchBooking", urlPatterns = {"/searchBooking"})
public class SearchBooking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("search");
        List<StayRoom> list;
        StayRoomDAO dao = new StayRoomDAO();
        
        if (keyword == null || keyword.trim().isEmpty()) {
            list = dao.getAllBooking();
            request.setAttribute("stayroom", list);
        } else {
            int key = Integer.parseInt(keyword);
            if ("phone".equals(searchType)) {
                list = dao.getBooking(key);
                request.setAttribute("stayroom", list);
            } else if ("bookingId".equals(searchType)) {
                list = dao.getBookingByBookingId(key);
                request.setAttribute("stayroom", list);
            } else {
                list = dao.getRoomByRoomId(key);
                request.setAttribute("stayroom", list);
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/StayRoomReceptionist.jsp");
        rd.forward(request, response);
    }

}
