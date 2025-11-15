package controller.BookingController;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Room;
import model.User;
import dao.Booking.RoomDAO;
import utils.DBConnection;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/Booking/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            Object obj = session.getAttribute("user");
            if (obj instanceof User) {
                user = (User) obj;
            }
        }

        // Nếu chưa login → redirect sang login với redirect URL
        if (user == null) {
            String currentUrl = request.getHeader("Referer"); // quay về trang trước
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + URLEncoder.encode(currentUrl, "UTF-8"));
            return;
        }

        String action = request.getParameter("action");

        try {
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            Date today = sdf.parse(sdf.format(new Date()));

            if ("add".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                Date checkIn = sdf.parse(request.getParameter("checkInDate"));
                Date checkOut = sdf.parse(request.getParameter("checkOutDate"));
                int guestsCount = Integer.parseInt(request.getParameter("guestsCount"));

                try (Connection conn = DBConnection.getConnection()) {
                    RoomDAO roomDAO = new RoomDAO(conn);
                    Room room = roomDAO.getRoomById(roomId);

                    // Kiểm tra lỗi
                    String error = null;
                    if (room == null) {
                        error = "Room not found.";
                    } else if (!"Available".equalsIgnoreCase(room.getRoomStatus())) {
                        error = "This room is not available.";
                    } else if (checkIn.before(today)) {
                        error = "Check-in date cannot be in the past.";
                    } else if (!checkOut.after(checkIn)) {
                        error = "Check-out date must be after check-in date.";
                    } else if (guestsCount <= 0 || guestsCount > room.getCapacity()) {
                        error = "Number of guests must be between 1 and " + room.getCapacity() + ".";
                    } else if (roomDAO.isRoomBooked(roomId, checkIn, checkOut)) {
                        error = "This room is already booked for the selected dates.";
                    }

                    if (error != null) {
                        List<Room> similarRooms = roomDAO.getSimilarRooms(roomId);
                        boolean isBooked = roomDAO.isRoomBooked(roomId, checkIn, checkOut);

                        request.setAttribute("error", error);
                        request.setAttribute("room", room);
                        request.setAttribute("similarRooms", similarRooms);
                        request.setAttribute("isBooked", isBooked);
                        request.setAttribute("checkInDate", request.getParameter("checkInDate"));
                        request.setAttribute("checkOutDate", request.getParameter("checkOutDate"));

                        request.getRequestDispatcher("/view/Booking/room_detail.jsp")
                               .forward(request, response);
                        return;
                    }

                    // Loại bỏ trùng roomId/roomNumber trong cart
                    cart.removeIf(item -> {
                        Room r = (Room) item.get("room");
                        return r.getRoomId() == roomId || r.getRoomNumber().equals(room.getRoomNumber());
                    });

                    // Thêm mới vào cart
                    Map<String, Object> item = new HashMap<>();
                    item.put("room", room);
                    item.put("checkIn", checkIn);
                    item.put("checkOut", checkOut);
                    item.put("guests", guestsCount);
                    cart.add(item);

                    session.setAttribute("cart", cart);
                    response.sendRedirect(request.getContextPath() + "/cart");
                }

            } else if ("remove".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                String checkInStr = request.getParameter("checkIn");
                String checkOutStr = request.getParameter("checkOut");

                cart.removeIf(item -> {
                    Room r = (Room) item.get("room");
                    String in = sdf.format((Date) item.get("checkIn"));
                    String out = sdf.format((Date) item.get("checkOut"));
                    return r.getRoomId() == roomId && in.equals(checkInStr) && out.equals(checkOutStr);
                });

                session.setAttribute("cart", cart);
                response.sendRedirect(request.getContextPath() + "/cart");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
