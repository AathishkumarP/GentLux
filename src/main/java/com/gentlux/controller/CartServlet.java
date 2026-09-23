package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.CartDAO;
import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.impl.CartDAOImpl;
import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.model.Cart;
import com.gentlux.model.CartItemView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;


    @Override
    public void init() {

        cartDAO = new CartDAOImpl();

        cartItemDAO = new CartItemDAOImpl();

        System.out.println("CartServlet initialized");
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // GET EXISTING SESSION
            // =====================================================

            HttpSession session =
                    request.getSession(false);


            // =====================================================
            // CHECK LOGIN
            // =====================================================

            if (session == null
                    || session.getAttribute("userId") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            // =====================================================
            // GET LOGGED-IN USER ID
            // =====================================================

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            // =====================================================
            // GET OR CREATE USER CART
            // =====================================================

            Cart cart =
                    cartDAO.getOrCreateCart(
                            userId
                    );


            if (cart == null) {

                response.sendError(
                        HttpServletResponse
                                .SC_INTERNAL_SERVER_ERROR,
                        "Unable to create or load cart."
                );

                return;
            }


            int cartId =
                    cart.getCartId();


            // =====================================================
            // GET CART ITEMS
            // =====================================================

            List<CartItemView> cartItems =
                    cartItemDAO
                            .getCartItemViewsByCartId(
                                    cartId
                            );


            // =====================================================
            // CALCULATE CART TOTAL
            // =====================================================

            double cartTotal = 0.0;

            for (CartItemView item : cartItems) {

                cartTotal +=
                        item.getSubtotal();
            }


            // =====================================================
            // SEND DATA TO JSP
            // =====================================================

            request.setAttribute(
                    "cartItems",
                    cartItems
            );

            request.setAttribute(
                    "cartId",
                    cartId
            );

            request.setAttribute(
                    "cartTotal",
                    cartTotal
            );


            // =====================================================
            // OPEN CART PAGE
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/cart.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load cart."
            );
        }
    }
}