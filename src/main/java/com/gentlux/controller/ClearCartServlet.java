package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.impl.CartItemDAOImpl;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/clear-cart")
public class ClearCartServlet extends HttpServlet {

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
            throws IOException {

        // Temporary until login/user-specific carts are connected
        int cartId = 1;

        cartItemDAO.clearCart(cartId);

        response.sendRedirect(
                request.getContextPath() + "/cart"
        );
    }
}