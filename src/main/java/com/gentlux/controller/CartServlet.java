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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;

    @Override
    public void init() {

        cartItemDAO = new CartItemDAOImpl();

        System.out.println("CartServlet initialized");
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Temporary cart ID for testing
        int cartId = 1;


        // Get complete cart item details
        List<CartItemView> cartItems =
                cartItemDAO.getCartItemViewsByCartId(cartId);


        // Calculate cart total
        double cartTotal = 0.0;

        for (CartItemView item : cartItems) {

            cartTotal += item.getSubtotal();
        }


        // Send data to JSP
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


        // Open cart page
        request.getRequestDispatcher(
                "/WEB-INF/views/cart.jsp"
        ).forward(request, response);
    }
}