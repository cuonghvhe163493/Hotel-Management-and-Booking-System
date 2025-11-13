/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.Authentication.UserDAO;
import dao.UserSerives.ExtraServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ExtraService;

/**
 *
 * @author Legion
 */
@WebServlet(name = "ExtraServiceDetailsServlet", urlPatterns = {"/extra-service-detail"})
public class ExtraServiceDetailsServlet extends HttpServlet {

    private ExtraServiceDAO serviceDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.serviceDAO = new ExtraServiceDAO();
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ExtraService service = serviceDAO.getExtraServiceById(id);

        request.setAttribute("service", service);

        request.getRequestDispatcher("/view/UserService/service-extra-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
