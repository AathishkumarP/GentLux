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


                // =================================================
                // GET USER CART
                // =================================================

                Cart cart =
                        cartDAO.getCartByUserId(
                                userId
                        );


                // =================================================
                // GET CART ITEM COUNT
                // =================================================

                if (cart != null) {

                    cartCount =
                            cartItemDAO
                                    .getCartItemCount(
                                            cart.getCartId()
                                    );
                }


            } catch (Exception e) {

                e.printStackTrace();

                cartCount = 0;
            }
        }


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