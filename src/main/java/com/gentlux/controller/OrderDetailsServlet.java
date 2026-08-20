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

        try {

            int orderId =
                    Integer.parseInt(
                            request.getParameter(
                                    "orderId"
                            )
                    );


            // =================================================
            // GET ORDER
            // =================================================

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


            // =================================================
            // GET ORDER ITEMS WITH PRODUCT DETAILS
            // =================================================

            List<OrderItemView> orderItems =
                    orderItemDAO
                    .getOrderItemViewsByOrderId(
                            orderId
                    );


            // =================================================
            // SEND DATA TO JSP
            // =================================================

            request.setAttribute(
                    "order",
                    order
            );

            request.setAttribute(
                    "orderItems",
                    orderItems
            );


            // =================================================
            // OPEN ORDER DETAILS PAGE
            // =================================================

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