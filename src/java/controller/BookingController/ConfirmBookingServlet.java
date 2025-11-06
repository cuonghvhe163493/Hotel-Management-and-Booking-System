package controller.BookingController;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.Booking.BookingDAO;
import dao.Booking.RoomDAO;
import model.Room;
import model.User;
import utils.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.*;
import java.text.SimpleDateFormat;
import java.sql.SQLException;

@WebServlet("/confirm-booking")
public class ConfirmBookingServlet extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // fake login Alice
            user = new User();
            user.setUserId(5);
            user.setUsername("alice");
            user.setEmail("alice@mail.com");
            user.setRole("customer");
            session.setAttribute("user", user);
            System.out.println("Alice đang login");
        }
        
        /*if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }*/

        int roomCount = Integer.parseInt(request.getParameter("roomCount"));
        if (roomCount <= 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<Map<String, Object>> cartFromForm = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            RoomDAO roomDAO = new RoomDAO(conn);
            BookingDAO bookingDAO = new BookingDAO(conn);

            double subtotal = 0.0;
            Date firstCheckIn = null;
            Date lastCheckOut = null;

            for (int i = 0; i < roomCount; i++) {
                int roomId = Integer.parseInt(request.getParameter("roomId_" + i));
                Date checkIn = sdf.parse(request.getParameter("checkInDate_" + i));
                Date checkOut = sdf.parse(request.getParameter("checkOutDate_" + i));
                int guests = Integer.parseInt(request.getParameter("guestsCount_" + i));

                Room room = new RoomDAO(conn).getRoomById(roomId);
                if (room == null) {
                    throw new SQLException("Room not found: " + roomId);
                }

                Map<String, Object> item = new HashMap<>();
                item.put("room", room);
                item.put("checkIn", checkIn);
                item.put("checkOut", checkOut);
                item.put("guests", guests);
                cartFromForm.add(item);

                long nights = Math.max(1, (checkOut.getTime() - checkIn.getTime()) / (1000L * 60 * 60 * 24));
                subtotal += room.getPricePerNight().doubleValue() * nights;

                if (firstCheckIn == null || checkIn.before(firstCheckIn)) {
                    firstCheckIn = checkIn;
                }
                if (lastCheckOut == null || checkOut.after(lastCheckOut)) {
                    lastCheckOut = checkOut;
                }
            }

            double discount = 0.0;
            double grandTotal = subtotal - discount;

            int bookingId = bookingDAO.createBooking(
                    user.getUserId(),
                    "pending",
                    sdf.format(firstCheckIn),
                    sdf.format(lastCheckOut),
                    subtotal,
                    discount,
                    grandTotal,
                    0.0
            );

            for (Map<String, Object> item : cartFromForm) {
                Room room = (Room) item.get("room");
                Date checkIn = (Date) item.get("checkIn");
                Date checkOut = (Date) item.get("checkOut");
                int guests = (int) item.get("guests");

                bookingDAO.addRoomToBooking(
                        bookingId,
                        room.getRoomId(),
                        sdf.format(checkIn),
                        sdf.format(checkOut),
                        guests,
                        room.getPricePerNight().doubleValue(),
                        "reserved" // hợp lệ với Booking_Rooms
                );

                //roomDAO.updateRoomStatus(room.getRoomId(), "occupied"); // hợp lệ với Rooms
            }

            conn.commit();
            session.removeAttribute("cart");
            session.setAttribute("successMessage", "Booking successful! Booking ID: " + bookingId);

            request.setAttribute("user", user);
            request.setAttribute("bookingSuccess", true);
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("discount", discount);
            request.getRequestDispatcher("/view/Booking/booking_success.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
