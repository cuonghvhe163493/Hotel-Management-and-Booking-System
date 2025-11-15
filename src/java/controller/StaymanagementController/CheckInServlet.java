/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.StaymanagementController;

import static com.microsoft.sqlserver.jdbc.StringUtils.isEmpty;
import dao.Staymanagement.CheckInOut;
import dao.Staymanagement.StayRoomDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;
import model.StayRoom;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CheckInServlet", urlPatterns = {"/CheckInServlet"})
public class CheckInServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String phoneNumber = request.getParameter("phoneNumber");
        String md = request.getParameter("mode");
        int mode = Integer.parseInt(md);
        if (mode == 0) {
            long phoneNumb = Long.parseLong(phoneNumber);
            CheckInOut cio = new CheckInOut();

            List<StayRoom> list = cio.getCheckInRoomForReceptionist(phoneNumb);

            StayRoom info = cio.getInfoCustomer(phoneNumb);
            request.setAttribute("list", list);

            request.setAttribute("info", info);
            RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
            rd.forward(request, response);
        } 
//        else if (mode == 1) {
//
//            String idroom = request.getParameter("idroom");
//            String name = request.getParameter("name");
//            String numPeopleStr = request.getParameter("numPeople");
//            String checkInDate = request.getParameter("checkInDate");
//            String checkOutDate = request.getParameter("checkOutDate");
//            String gmail = request.getParameter("gmail");
//            String phone = request.getParameter("phone");
//            if (isEmpty(idroom) || isEmpty(name) || isEmpty(numPeopleStr)
//                    || isEmpty(checkInDate) || isEmpty(checkOutDate)) {
//                request.setAttribute("mess", "Please fill in all required information.");
//                RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
//                rd.forward(request, response);
//                return;
//            }
//
//            int roomid = Integer.parseInt(idroom);
//            int numberPeople = Integer.parseInt(numPeopleStr);
//            long phoneNumb = Long.parseLong(phone);
//            CheckInOut cio = new CheckInOut();
//            List<StayRoom> list = cio.checkInRoom(roomid,1);
//            
//            request.setAttribute("list", list);
//            RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
//            rd.forward(request, response);
//
//            //check phòng có avaiable không, check in date check out có dính không
//            //check phone có dính không
//            //check 
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String[] selectedRoomIds = request.getParameterValues("selectedRooms");

        StayRoomDAO dao = new StayRoomDAO();

        if (selectedRoomIds == null || selectedRoomIds.length == 0) {

            request.setAttribute("errorMessage", "Please select at least one room to check-in.");
            RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
            rd.forward(request, response);
            return;
        }
        for (String roomIdStr : selectedRoomIds) {

            int roomId = Integer.parseInt(roomIdStr.trim());
            dao.updateRoomStatus(roomId, "occupied");
            dao.updateBookingRoomStatus(roomId, "checked_in");
        }

        request.setAttribute("successMessage", "Check-in successful");

        RequestDispatcher rd = request.getRequestDispatcher("view/Staymanagement/CheckInForReceptionist.jsp");
        rd.forward(request, response);
    }

}
