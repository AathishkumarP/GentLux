package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CartDAO;
import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.impl.CartDAOImpl;
import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.model.Cart;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@WebFilter("/*")
public class CartCountFilter implements Filter {

    private CartDAO cartDAO;

    private CartItemDAO cartItemDAO;


    // =========================================================
    // INITIALIZE DAO
    // =========================================================

    @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {

        cartDAO = new CartDAOImpl();

        cartItemDAO = new CartItemDAOImpl();

        System.out.println(
                "CartCountFilter initialized successfully"
        );
    }


    // =========================================================
    // FILTER EVERY REQUEST
    // =========================================================

    @Override
    public void doFilter(
            ServletRequest servletRequest,
            ServletResponse servletResponse,
            FilterChain chain)
            throws IOException, ServletException {


        HttpServletRequest request =
                (HttpServletRequest) servletRequest;


        // Default cart count
        int cartCount = 0;


        // =====================================================
        // GET EXISTING SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // CHECK WHETHER USER IS LOGGED IN
        // =====================================================

        if (session != null
                && session.getAttribute("userId") != null) {

            try {

                int userId =
                        (Integer) session.getAttribute(
                                "userId"
                        );


                System.out.println(
                        "CartCountFilter USER ID = "
                        + userId
                );


                // =================================================
                // GET USER CART
                // =================================================

                Cart cart =
                        cartDAO.getCartByUserId(
                                userId
                        );


                // =================================================
                // CART EXISTS
                // =================================================

                if (cart != null) {

                    System.out.println(
                            "CartCountFilter CART ID = "
                            + cart.getCartId()
                    );


                    // Get number of cart items
                    cartCount =
                            cartItemDAO
                                    .getCartItemCount(
                                            cart.getCartId()
                                    );

                } else {

                    System.out.println(
                            "CartCountFilter: No cart found for user"
                    );
                }


            } catch (Exception e) {

                System.out.println(
                        "CartCountFilter ERROR:"
                );

                e.printStackTrace();

                cartCount = 0;
            }


        } else {

            System.out.println(
                    "CartCountFilter: User not logged in"
            );
        }


        // =====================================================
        // DEBUG CART COUNT
        // =====================================================

        System.out.println(
                "NAV CART COUNT = "
                + cartCount
        );


        // =====================================================
        // SEND COUNT TO JSP
        // =====================================================

        request.setAttribute(
                "cartCount",
                cartCount
        );


        // =====================================================
        // CONTINUE REQUEST
        // =====================================================

        chain.doFilter(
                servletRequest,
                servletResponse
        );
    }


    // =========================================================
    // DESTROY
    // =========================================================

    @Override
    public void destroy() {

        // Nothing to close
    }
}