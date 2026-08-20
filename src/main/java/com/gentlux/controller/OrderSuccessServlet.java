package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.impl.OrderDAOImpl;
import com.gentlux.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;


    @Override
    public void init() {

        orderDAO =
                new OrderDAOImpl();

        System.out.println(
                "OrderSuccessServlet initialized"
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


            request.setAttribute(
                    "order",
                    order
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/order-success.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order ID."
            );
        }
    }
}