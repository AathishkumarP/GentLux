package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.OrderItemDAO;

import com.gentlux.dao.impl.OrderDAOImpl;
import com.gentlux.dao.impl.OrderItemDAOImpl;

import com.gentlux.model.Order;
import com.gentlux.model.OrderItemView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;


    @Override
    public void init() {

        orderDAO =
                new OrderDAOImpl();

        orderItemDAO =
                new OrderItemDAOImpl();

        System.out.println(
                "OrderDetailsServlet initialized"
        );
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =========================================================
        // CHECK LOGIN
        // =========================================================

        HttpSession session =
                request.getSession(false);


        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        int userId =
                (Integer)
                session.getAttribute("userId");


        try {


            // =====================================================
            // GET ORDER ID
            // =====================================================

            String orderIdParameter =
                    request.getParameter(
                            "orderId"
                    );


            if (orderIdParameter == null
                    || orderIdParameter.isBlank()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid order ID."
                );

                return;
            }


            int orderId =
                    Integer.parseInt(
                            orderIdParameter
                    );


            // =====================================================
            // GET ORDER
            // =====================================================

            Order order =
                    orderDAO.getOrderById(
                            orderId
                    );


            if (order == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Order not found."
                );

                return;
            }


            // =====================================================
            // VERIFY ORDER BELONGS TO LOGGED-IN USER
            // =====================================================

            if (order.getUserId() != userId) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "You are not allowed to view this order."
                );

                return;
            }


            // =====================================================
            // GET ORDER ITEMS WITH PRODUCT DETAILS
            // =====================================================

            List<OrderItemView> orderItems =
                    orderItemDAO
                    .getOrderItemViewsByOrderId(
                            orderId
                    );


            // =====================================================
            // SEND DATA TO JSP
            // =====================================================

            request.setAttribute(
                    "order",
                    order
            );


            request.setAttribute(
                    "orderItems",
                    orderItems
            );


            // =====================================================
            // OPEN ORDER DETAILS PAGE
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/order-details.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {


            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order ID."
            );


        } catch (Exception e) {


            e.printStackTrace();


            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load order details."
            );
        }
    }
}