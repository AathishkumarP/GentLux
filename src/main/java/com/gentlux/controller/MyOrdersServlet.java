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


@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;


    @Override
    public void init() {

        orderDAO =
                new OrderDAOImpl();

        System.out.println(
                "MyOrdersServlet initialized"
        );
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Temporary until authentication is connected
            int userId = 1;


            List<Order> orders =
                    orderDAO.getOrdersByUserId(
                            userId
                    );


            request.setAttribute(
                    "orders",
                    orders
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/my-orders.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load orders."
            );
        }
    }
}