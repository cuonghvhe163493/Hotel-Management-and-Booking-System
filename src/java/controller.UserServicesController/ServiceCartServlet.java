/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserServicesController;

import dao.UserSerives.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.HotelService;
import model.ServiceCartItems;

/**
 *
 * @author Legion
 */
@WebServlet(name = "ServiceCartServlet", urlPatterns = {"/service-cart"})
public class ServiceCartServlet extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    List<ServiceCartItems> cartServices;

    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ServiceDAO();
    }

    private List<ServiceCartItems> getCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cartServices") != null) {
            return (ArrayList<ServiceCartItems>) request.getSession().getAttribute("cartServices");
        } else {
            return new ArrayList<>();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        this.cartServices = getCart(request);

        if (request.getParameter("index") != null) {
            int index = Integer.parseInt(request.getParameter("index"));
            if (index >= 0 && index < this.cartServices.size()) {
                this.cartServices.remove(index);
                request.getSession().setAttribute("cartServices", cartServices);
                response.sendRedirect("cart");
                return;
            } else {
                String error = "Invalid delete action";
                request.setAttribute("error", error);
                request.setAttribute("checkInDate", request.getParameter("checkIn"));
                request.setAttribute("checkOutDate", request.getParameter("checkOut"));

                request.getRequestDispatcher("/view/Booking/cart.jsp")
                        .forward(request, response);
                return;
            }
        }
        request.getRequestDispatcher("/view/Booking/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        this.cartServices = getCart(request);
        HttpSession session = request.getSession();

        if ("add".equals(action)) {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            Date checkIn = new Date();
            Date checkOut = new Date();
            int guestsCount = Integer.parseInt(request.getParameter("guestsCount"));
            try {
                checkIn = sdf.parse(request.getParameter("checkInDate"));
                checkOut = sdf.parse(request.getParameter("checkOutDate"));
            } catch (ParseException ex) {
                ex.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            HotelService service = serviceDAO.getServiceById(serviceId);
            ServiceCartItems item = new ServiceCartItems(service, checkIn, checkOut, guestsCount);

            this.cartServices.add(item);

            session.setAttribute("cartServices", cartServices);

            System.out.println("cartServices: " + cartServices.toString());

            response.sendRedirect("service-detail?id=" + serviceId);
        } else if (action.equalsIgnoreCase("update")) {
            int index = Integer.parseInt(request.getParameter("index"));
            int guestCount = Integer.parseInt(request.getParameter("guestcount"));

            Date checkIn = new Date();
            Date checkOut = new Date();
            try {
                checkIn = sdf.parse(request.getParameter("checkIn"));
                checkOut = sdf.parse(request.getParameter("checkOut"));
            } catch (ParseException ex) {
                ex.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }

            String error = this.validate(checkIn, checkOut, guestCount);

            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("checkInDate", request.getParameter("checkIn"));
                request.setAttribute("checkOutDate", request.getParameter("checkOut"));

                request.getRequestDispatcher("/view/Booking/cart.jsp")
                        .forward(request, response);
                return;
            }

            ServiceCartItems item = this.cartServices.get(index);
            item.setGuestsCount(guestCount);
            item.setCheckInDate(checkIn);
            item.setCheckOutDate(checkOut);
            session.setAttribute("cartServices", cartServices);
            response.sendRedirect("cart");
        }

    }

    private String validate(Date checkIn, Date checkOut, int guestsCount) {
        Date today = new Date();
        if (checkIn.before(today)) {
            return "Check-in date cannot be in the past.";
        } else if (!checkOut.after(checkIn)) {
            return "Check-out date must be after check-in date.";
        } else if (guestsCount <= 0) {
            return "Number of guests must be >= 1";
        }
        return null;
    }

}
