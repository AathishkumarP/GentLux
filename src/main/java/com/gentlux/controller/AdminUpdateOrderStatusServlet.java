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


@WebServlet("/admin/update-order-status")
public class AdminUpdateOrderStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;


    @Override
    public void init() {

        orderDAO =
                new OrderDAOImpl();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // GET PARAMETERS
            // =====================================================

            String orderIdParameter =
                    request.getParameter("orderId");

            String requestedStatus =
                    request.getParameter("status");


            // =====================================================
            // BASIC VALIDATION
            // =====================================================

            if (orderIdParameter == null
                    || orderIdParameter.isBlank()
                    || requestedStatus == null
                    || requestedStatus.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders?updateStatus=failed"
                );

                return;
            }


            int orderId =
                    Integer.parseInt(
                            orderIdParameter
                    );


            requestedStatus =
                    requestedStatus.trim()
                                   .toUpperCase();


            // =====================================================
            // GET CURRENT ORDER
            // =====================================================

            Order order =
                    orderDAO.getOrderById(
                            orderId
                    );


            if (order == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders?updateStatus=failed"
                );

                return;
            }


            String currentStatus =
                    order.getOrderStatus();


            if (currentStatus == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders?updateStatus=failed"
                );

                return;
            }


            // =====================================================
            // CHECK ALLOWED STATUS TRANSITION
            // =====================================================

            boolean allowed =
                    false;


            if ("PLACED".equalsIgnoreCase(
                    currentStatus
            )
                    && "CONFIRMED".equalsIgnoreCase(
                            requestedStatus
                    )) {

                allowed =
                        true;

            } else if (
                    "CONFIRMED".equalsIgnoreCase(
                            currentStatus
                    )
                    && "SHIPPED".equalsIgnoreCase(
                            requestedStatus
                    )
            ) {

                allowed =
                        true;

            } else if (
                    "SHIPPED".equalsIgnoreCase(
                            currentStatus
                    )
                    && "DELIVERED".equalsIgnoreCase(
                            requestedStatus
                    )
            ) {

                allowed =
                        true;
            }


            // =====================================================
            // INVALID TRANSITION
            // =====================================================

            if (!allowed) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders?updateStatus=failed"
                );

                return;
            }


            // =====================================================
            // UPDATE ORDER STATUS
            // =====================================================

            boolean updated =
                    orderDAO.updateOrderStatus(
                            orderId,
                            requestedStatus
                    );


            // =====================================================
            // REDIRECT
            // =====================================================

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders?updateStatus=success"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/orders?updateStatus=failed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/orders?updateStatus=failed"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/orders?updateStatus=failed"
            );
        }
    }
}