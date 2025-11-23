package controller.UserServicesController;

import dao.UserSerives.ExtraServiceDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ExtraService;
import model.ExtraServiceCartItem;

/**
 * Servlet to manage cart for ExtraService (add / remove / update)
 */
@WebServlet(name = "ExtraServiceCartServlet", urlPatterns = {"/extra-service-cart"})
public class ExtraServiceCartServlet extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    List<ExtraServiceCartItem> cartExtraServices;

    private ExtraServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ExtraServiceDAO();
    }

    private List<ExtraServiceCartItem> getCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cartExtraServices") != null) {
            return (ArrayList<ExtraServiceCartItem>) request.getSession().getAttribute("cartExtraServices");
        } else {
            return new ArrayList<>();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object user = request.getSession().getAttribute("user");
        if (user == null) {
            String currentUrl = request.getHeader("Referer");
            if (currentUrl == null) {
                currentUrl = request.getRequestURL().toString();
            }
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + URLEncoder.encode(currentUrl, "UTF-8"));
            return;
        }

        this.cartExtraServices = getCart(request);

        if (request.getParameter("index") != null) {
            int index = Integer.parseInt(request.getParameter("index"));
            if (index >= 0 && index < this.cartExtraServices.size()) {
                this.cartExtraServices.remove(index);
                request.getSession().setAttribute("cartExtraServices", cartExtraServices);
                response.sendRedirect("extra-service-cart?status=remove");
                return;
            }
        }

        request.getRequestDispatcher("/view/Booking/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object user = request.getSession().getAttribute("user");
        if (user == null) {
            String currentUrl = request.getHeader("Referer");
            if (currentUrl == null) {
                currentUrl = request.getRequestURL().toString();
            }
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + URLEncoder.encode(currentUrl, "UTF-8"));
            return;
        }

        String action = request.getParameter("action");
        this.cartExtraServices = getCart(request);
        HttpSession session = request.getSession();

        if ("add".equalsIgnoreCase(action)) {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));

            Date checkIn = new Date();
            Date checkOut = new Date();
            int guestsCount = 1;
            try {
                checkIn = sdf.parse(request.getParameter("checkInDate"));
                checkOut = sdf.parse(request.getParameter("checkOutDate"));
                guestsCount = Integer.parseInt(request.getParameter("guestsCount"));
            } catch (ParseException ex) {
                ex.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }

            ExtraService service = serviceDAO.getExtraServiceById(serviceId);
            ExtraServiceCartItem item = new ExtraServiceCartItem(service, checkIn, checkOut, guestsCount);

            this.cartExtraServices.add(item);
            session.setAttribute("cartExtraServices", cartExtraServices);

            System.out.println("DEBUG: Added to cartExtraServices. Size=" + cartExtraServices.size());
            System.out.println("DEBUG: Service ID=" + serviceId + ", CheckIn=" + checkIn + ", CheckOut=" + checkOut + ", Guests=" + guestsCount);

            // Redirect to unified cart so user sees the updated cart and badge
            response.sendRedirect(request.getContextPath() + "/cart?added=extra");
            return;
        }

        // Other actions (update) can be implemented later
        response.sendRedirect(request.getContextPath());
    }

}
