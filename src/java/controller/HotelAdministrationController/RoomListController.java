package controller.HotelAdministrationController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.HotelAdministration.RoomDAO;
import model.Room;

@WebServlet("/admin/rooms")
public class RoomListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
      
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").toString().toLowerCase().contains("admin")) { 
            response.sendRedirect(request.getContextPath() + "/login"); 
            return;
        }

        RoomDAO roomDAO = new RoomDAO();
        
       
        List<Room> rooms = roomDAO.getAllRooms();
        
       
        request.setAttribute("roomList", rooms);
        
      
        request.getRequestDispatcher("/view/HotelAdministration/room_list.jsp").forward(request, response);
    }
}