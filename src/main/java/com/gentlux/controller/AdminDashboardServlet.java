package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.UserDAO;
import com.gentlux.dao.impl.OrderDAOImpl;
import com.gentlux.dao.impl.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private UserDAO userDAO;


    @Override
    public void init() {

        orderDAO = new OrderDAOImpl();
        userDAO = new UserDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // DASHBOARD COUNTS
            // =====================================================

            int totalOrders =
                    orderDAO.getAllOrders().size();


            int placedOrders =
                    orderDAO.getOrderCountByStatus(
                            "PLACED"
                    );


            int confirmedOrders =
                    orderDAO.getOrderCountByStatus(
                            "CONFIRMED"
                    );


            int shippedOrders =
                    orderDAO.getOrderCountByStatus(
                            "SHIPPED"
                    );


            int deliveredOrders =
                    orderDAO.getOrderCountByStatus(
                            "DELIVERED"
                    );


            int cancelledOrders =
                    orderDAO.getOrderCountByStatus(
                            "CANCELLED"
                    );


            int totalUsers =
                    userDAO.getAllUsers().size();


            // =====================================================
            // SEND DATA TO JSP
            // =====================================================

            request.setAttribute(
                    "totalOrders",
                    totalOrders
            );

            request.setAttribute(
                    "totalUsers",
                    totalUsers
            );

            request.setAttribute(
                    "placedOrders",
                    placedOrders
            );

            request.setAttribute(
                    "confirmedOrders",
                    confirmedOrders
            );

            request.setAttribute(
                    "shippedOrders",
                    shippedOrders
            );

            request.setAttribute(
                    "deliveredOrders",
                    deliveredOrders
            );

            request.setAttribute(
                    "cancelledOrders",
                    cancelledOrders
            );


            // =====================================================
            // OPEN ADMIN DASHBOARD
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/dashboard.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load admin dashboard."
            );
        }
    }
}