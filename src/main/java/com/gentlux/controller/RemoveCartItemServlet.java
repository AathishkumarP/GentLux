package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.impl.CartItemDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/remove-cart-item")
public class RemoveCartItemServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAOImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int cartItemId =
                    Integer.parseInt(
                            request.getParameter("cartItemId")
                    );

            cartItemDAO.removeCartItem(cartItemId);

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart item ID"
            );
        }
    }
}