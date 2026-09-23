package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.CartDAO;
import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.UserDAO;
import com.gentlux.dao.impl.CartDAOImpl;
import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.dao.impl.UserDAOImpl;
import com.gentlux.model.Cart;
import com.gentlux.model.CartItemView;
import com.gentlux.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;
    private UserDAO userDAO;

    @Override
    public void init() {

        cartDAO =
                new CartDAOImpl();

        cartItemDAO =
                new CartItemDAOImpl();

        userDAO =
                new UserDAOImpl();

        System.out.println(
                "CheckoutServlet initialized"
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

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
                    (Integer) session.getAttribute(
                            "userId"
                    );

            User user =
                    userDAO.getUserById(
                            userId
                    );

            if (user == null) {

                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }

            Cart cart =
                    cartDAO.getOrCreateCart(
                            userId
                    );

            if (cart == null) {

                response.sendError(
                        HttpServletResponse
                                .SC_INTERNAL_SERVER_ERROR,
                        "Unable to load cart."
                );

                return;
            }

            int cartId =
                    cart.getCartId();

            List<CartItemView> cartItems =
                    cartItemDAO
                            .getCartItemViewsByCartId(
                                    cartId
                            );

            if (cartItems == null
                    || cartItems.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/cart"
                );

                return;
            }

            double cartTotal = 0.0;
            int totalQuantity = 0;

            for (CartItemView item : cartItems) {

                cartTotal +=
                        item.getSubtotal();

                totalQuantity +=
                        item.getQuantity();
            }

            request.setAttribute(
                    "user",
                    user
            );

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

            request.setAttribute(
                    "checkoutType",
                    "CART"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/checkout.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load checkout page."
            );
        }
    }
}
