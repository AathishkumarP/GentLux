package com.gentlux.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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


@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;


    @Override
    public void init() {

        orderDAO =
                new OrderDAOImpl();

        orderItemDAO =
                new OrderItemDAOImpl();
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
            // GET ITEMS FOR EACH ORDER
            // =====================================================

            Map<Integer, List<OrderItemView>> orderItemsMap =
                    new HashMap<>();


            if (orders != null) {

                for (Order order : orders) {

                    List<OrderItemView> orderItems =
                            orderItemDAO
                                    .getOrderItemViewsByOrderId(
                                            order.getOrderId()
                                    );

                    orderItemsMap.put(
                            order.getOrderId(),
                            orderItems
                    );
                }
            }


            // =====================================================
            // SEND TO JSP
            // =====================================================

            request.setAttribute(
                    "orders",
                    orders
            );

            request.setAttribute(
                    "orderItemsMap",
                    orderItemsMap
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