package com.gentlux.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.WishlistDAOImpl;
import com.gentlux.model.Product;
import com.gentlux.model.Wishlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private WishlistDAO wishlistDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {

        wishlistDAO =
                new WishlistDAOImpl();

        productDAO =
                new ProductDAOImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        /*
         * =========================================
         * FEATURED PRODUCTS
         * =========================================
         *
         * Currently the Home page uses
         * Product IDs 1, 2, 3 and 4.
         *
         * Instead of hardcoding their product
         * information inside JSP, we now load
         * those products directly from database.
         */

        List<Product> featuredProducts =
                new ArrayList<>();


        int[] featuredProductIds = {
                1, 2, 3, 4
        };


        for (int productId : featuredProductIds) {

            Product product =
                    productDAO.getProductById(
                            productId
                    );


            if (product != null) {

                featuredProducts.add(
                        product
                );
            }
        }


        /*
         * Send featured products to home.jsp
         */

        request.setAttribute(
                "featuredProducts",
                featuredProducts
        );


        /*
         * =========================================
         * USER WISHLIST PRODUCTS
         * =========================================
         */

        Set<Integer> wishlistProductIds =
                new HashSet<>();


        HttpSession session =
                request.getSession(false);


        if (session != null
                && session.getAttribute("userId") != null) {


            int userId =
                    (Integer)
                    session.getAttribute(
                            "userId"
                    );


            List<Wishlist> wishlistItems =
                    wishlistDAO
                            .getWishlistByUserId(
                                    userId
                            );


            if (wishlistItems != null) {

                for (Wishlist wishlist
                        : wishlistItems) {


                    wishlistProductIds.add(
                            wishlist.getProductId()
                    );

                }
            }
        }


        /*
         * Send wishlist IDs to home.jsp
         */

        request.setAttribute(
                "wishlistProductIds",
                wishlistProductIds
        );


        /*
         * =========================================
         * OPEN HOME PAGE
         * =========================================
         */

        request.getRequestDispatcher(
                "/WEB-INF/views/home.jsp"
        ).forward(
                request,
                response
        );
    }
}