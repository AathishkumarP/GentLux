package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.impl.OrderDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

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


        // =========================================================
        // GET ORDER ID
        // =========================================================

        String orderIdParameter =
                request.getParameter("orderId");


        if (orderIdParameter == null
                || orderIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/my-orders?cancelStatus=invalid"
            );

            return;
        }


        try {


            int orderId =
                    Integer.parseInt(
                            orderIdParameter
                    );


            // =====================================================
            // CANCEL ORDER
            // =====================================================

            boolean cancelled =
                    orderDAO.cancelOrder(
                            orderId,
                            userId
                    );


            // =====================================================
            // REDIRECT
            // =====================================================

            if (cancelled) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/order-details?orderId="
                        + orderId
                        + "&cancelStatus=success"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/order-details?orderId="
                        + orderId
                        + "&cancelStatus=failed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/my-orders?cancelStatus=invalid"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/my-orders?cancelStatus=error"
            );
        }
    }
}