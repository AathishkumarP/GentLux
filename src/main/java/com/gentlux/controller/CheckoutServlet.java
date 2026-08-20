package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.model.CartItemView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        cartItemDAO =
                new CartItemDAOImpl();

        System.out.println(
                "CheckoutServlet initialized"
        );
    }


    // =========================================================
    // GET CHECKOUT PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =================================================
            // TEMPORARY CART ID
            // =================================================
            // Later we will get this from logged-in user's session.

            int cartId = 1;


            // =================================================
            // GET CART ITEMS
            // =================================================

            List<CartItemView> cartItems =
                    cartItemDAO
                    .getCartItemViewsByCartId(
                            cartId
                    );


            // =================================================
            // CHECK EMPTY CART
            // =================================================

            if (cartItems == null
                    || cartItems.isEmpty()) {

                System.out.println(
                        "Checkout blocked: cart is empty"
                );

                response.sendRedirect(
                        request.getContextPath()
                        + "/cart"
                );

                return;
            }


            // =================================================
            // CALCULATE CART TOTAL
            // =================================================

            double cartTotal = 0.0;

            int totalQuantity = 0;


            for (CartItemView item : cartItems) {

                cartTotal +=
                        item.getSubtotal();

                totalQuantity +=
                        item.getQuantity();
            }


            // =================================================
            // DEBUG
            // =================================================

            System.out.println(
                    "========== CHECKOUT =========="
            );

            System.out.println(
                    "Cart ID = "
                    + cartId
            );

            System.out.println(
                    "Cart Items = "
                    + cartItems.size()
            );

            System.out.println(
                    "Total Quantity = "
                    + totalQuantity
            );

            System.out.println(
                    "Cart Total = "
                    + cartTotal
            );

            System.out.println(
                    "=============================="
            );


            // =================================================
            // SEND VALUES TO JSP
            // =================================================

            request.setAttribute(
                    "cartItems",
                    cartItems
            );

            request.setAttribute(
                    "cartTotal",
                    cartTotal
            );

            request.setAttribute(
                    "totalQuantity",
                    totalQuantity
            );

            request.setAttribute(
                    "cartId",
                    cartId
            );


            // =================================================
            // OPEN CHECKOUT PAGE
            // =================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/checkout.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            System.out.println(
                    "Error while loading checkout page"
            );

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load checkout page"
            );
        }
    }
}