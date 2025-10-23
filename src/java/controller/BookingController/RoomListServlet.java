package controller.BookingController;

import dao.Booking.RoomDAO;
import model.Room;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/rooms")
public class RoomListServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection(); 
            roomDAO = new RoomDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Cannot connect to DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> rooms = roomDAO.getAllRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/view/Booking/rooms.jsp").forward(request, response);
    }
}
