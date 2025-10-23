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

@WebServlet("/room-detail")
public class RoomDetailServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection(); // dùng DBConnection hiện tại
            roomDAO = new RoomDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Cannot connect to DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("rooms");
            return;
        }

        try {
            int roomId = Integer.parseInt(idParam);
            Room room = roomDAO.getRoomById(roomId);

            if (room != null) {
                // Lấy 2 phòng tương tự
                request.setAttribute("room", room);
                request.setAttribute("similarRooms", roomDAO.getSimilarRooms(roomId));

                request.getRequestDispatcher("/view/Booking/room_detail.jsp")
                        .forward(request, response);
            } else {
                response.sendRedirect("rooms");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("rooms");
        }
    }
}
