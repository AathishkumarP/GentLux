package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.WishlistDAOImpl;
import com.gentlux.model.Wishlist;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/toggle-wishlist")
public class ToggleWishlistServlet extends HttpServlet {

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
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // LOGIN CHECK
        // =====================================================

        if (session == null
                || session.getAttribute("userId") == null) {

            response.setStatus(
                    HttpServletResponse.SC_UNAUTHORIZED
            );

            response.getWriter().write(
                    "{\"success\":false,\"loginRequired\":true}"
            );

            return;
        }


        // =====================================================
        // PRODUCT ID
        // =====================================================

        String productIdParameter =
                request.getParameter("productId");


        if (productIdParameter == null
                || productIdParameter.isBlank()) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid product\"}"
            );

            return;
        }


        try {

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );

            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


            // =================================================
            // CHECK CURRENT WISHLIST STATE
            // =================================================

            boolean alreadyInWishlist =
                    wishlistDAO.isProductInWishlist(
                            userId,
                            productId
                    );


            // =================================================
            // IF EXISTS -> REMOVE
            // =================================================

            if (alreadyInWishlist) {

                boolean removed =
                        wishlistDAO.removeFromWishlist(
                                userId,
                                productId
                        );


                if (removed) {

                    response.getWriter().write(
                            "{\"success\":true,\"inWishlist\":false}"
                    );

                } else {

                    response.setStatus(
                            HttpServletResponse.SC_INTERNAL_SERVER_ERROR
                    );

                    response.getWriter().write(
                            "{\"success\":false}"
                    );
                }

                return;
            }


            // =================================================
            // IF NOT EXISTS -> ADD
            // =================================================

            Wishlist wishlist =
                    new Wishlist();

            wishlist.setUserId(userId);
            wishlist.setProductId(productId);


            boolean added =
                    wishlistDAO.addToWishlist(
                            wishlist
                    );


            if (added) {

                response.getWriter().write(
                        "{\"success\":true,\"inWishlist\":true}"
                );

            } else {

                response.setStatus(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR
                );

                response.getWriter().write(
                        "{\"success\":false}"
                );
            }


        } catch (NumberFormatException e) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid product ID\"}"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }
}