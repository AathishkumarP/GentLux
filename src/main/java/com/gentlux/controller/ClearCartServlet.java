package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CartDAO;
import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.impl.CartDAOImpl;
import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/clear-cart")
public class ClearCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;


    @Override
    public void init() {

        cartDAO = new CartDAOImpl();

        cartItemDAO = new CartItemDAOImpl();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // CHECK LOGIN SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }


        try {

            // =================================================
            // GET LOGGED-IN USER
            // =================================================

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            // =================================================
            // GET USER'S CART
            // =================================================

            Cart cart =
                    cartDAO.getCartByUserId(
                            userId
                    );


            // =================================================
            // CLEAR CART ITEMS
            // =================================================

            if (cart != null) {

                cartItemDAO.clearCart(
                        cart.getCartId()
                );
            }


            // =================================================
            // REDIRECT BACK TO CART
            // =================================================

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );


        } catch (Exception e) {

            e.printStackTrace();


            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to clear cart."
            );
        }
    }
}