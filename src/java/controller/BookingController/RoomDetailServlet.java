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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/room-detail")
public class RoomDetailServlet extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/rooms");
            return;
        }

        int roomId;
        try {
            roomId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/rooms");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            RoomDAO roomDAO = new RoomDAO(conn);

            // Lấy thông tin phòng
            Room room = roomDAO.getRoomById(roomId);
            if (room == null) {
                response.sendRedirect(request.getContextPath() + "/rooms");
                return;
            }
            request.setAttribute("room", room);

            // Lấy phòng tương tự
            List<Room> similarRooms = roomDAO.getSimilarRooms(roomId);
            request.setAttribute("similarRooms", similarRooms);

            // Kiểm tra booking nếu user chọn ngày
            String checkInStr = request.getParameter("checkInDate");
            String checkOutStr = request.getParameter("checkOutDate");
            boolean isBooked = false;
            if (checkInStr != null && checkOutStr != null) {
                try {
                    Date checkIn = sdf.parse(checkInStr);
                    Date checkOut = sdf.parse(checkOutStr);
                    isBooked = roomDAO.isRoomBooked(roomId, checkIn, checkOut);
                    request.setAttribute("checkInDate", checkInStr);
                    request.setAttribute("checkOutDate", checkOutStr);
                } catch (ParseException e) {
                    isBooked = false;
                }
            }
            request.setAttribute("isBooked", isBooked);

            // Nếu có lỗi từ CartServlet (forward từ POST), giữ nguyên
            Object error = request.getAttribute("error");
            if (error != null) {
                request.setAttribute("error", error);
            }

            // --- Forward tới JSP trực tiếp, không dùng query string ---
            request.getRequestDispatcher("/view/Booking/room_detail.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
