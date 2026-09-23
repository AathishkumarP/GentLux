package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.WishlistDAOImpl;
import com.gentlux.model.Wishlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-to-wishlist")
public class AddToWishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private WishlistDAO wishlistDAO;


    @Override
    public void init() {

        wishlistDAO = new WishlistDAOImpl();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // LOGIN CHECK
        // =====================================================

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }


        try {

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            String productIdParameter =
                    request.getParameter(
                            "productId"
                    );


            String redirect =
                    request.getParameter(
                            "redirect"
                    );


            // =================================================
            // VALIDATE PRODUCT ID
            // =================================================

            if (productIdParameter == null
                    || productIdParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/products"
                );

                return;
            }


            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


            // =================================================
            // CHECK IF ALREADY IN WISHLIST
            // =================================================

            boolean alreadyExists =
                    wishlistDAO.isProductInWishlist(
                            userId,
                            productId
                    );


            if (alreadyExists) {

                // From Products page
                if ("products".equals(redirect)) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/products"
                    );

                    return;
                }


                // From Product Details page
                response.sendRedirect(
                        request.getContextPath()
                        + "/product-details?id="
                        + productId
                        + "&wishlistStatus=exists"
                );

                return;
            }


            // =================================================
            // CREATE WISHLIST OBJECT
            // =================================================

            Wishlist wishlist =
                    new Wishlist();


            wishlist.setUserId(
                    userId
            );


            wishlist.setProductId(
                    productId
            );


            // =================================================
            // ADD TO DATABASE
            // =================================================

            boolean added =
                    wishlistDAO.addToWishlist(
                            wishlist
                    );


            // =================================================
            // REDIRECT FROM PRODUCTS PAGE
            // =================================================

            if ("products".equals(redirect)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/products"
                );

                return;
            }


            // =================================================
            // REDIRECT FROM PRODUCT DETAILS PAGE
            // =================================================

            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/product-details?id="
                        + productId
                        + "&wishlistStatus=added"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/product-details?id="
                        + productId
                        + "&wishlistStatus=error"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/products"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to add product to wishlist."
            );
        }
    }
}