package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.impl.OrderDAOImpl;
import com.gentlux.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;


    @Override
    public void init() {

        orderDAO =
                new OrderDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // GET ALL ORDERS
            // =====================================================

            List<Order> orders =
                    orderDAO.getAllOrders();


            // =====================================================
            // SEND TO JSP
            // =====================================================

            request.setAttribute(
                    "orders",
                    orders
            );


            // =====================================================
            // OPEN ADMIN ORDERS PAGE
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/orders.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load orders."
            );
        }
    }
}