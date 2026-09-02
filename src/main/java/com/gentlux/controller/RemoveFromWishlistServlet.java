package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.WishlistDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/remove-from-wishlist")
public class RemoveFromWishlistServlet extends HttpServlet {

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
                        + "/wishlist"
                );

                return;
            }


            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


            // =================================================
            // REMOVE FROM WISHLIST
            // =================================================

            wishlistDAO.removeFromWishlist(
                    userId,
                    productId
            );


            // =================================================
            // CLICK CAME FROM PRODUCTS PAGE
            // =================================================

            if ("products".equals(redirect)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/products"
                );

                return;
            }


            // =================================================
            // CLICK CAME FROM PRODUCT DETAILS PAGE
            // =================================================

            if ("product".equals(redirect)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/product-details?id="
                        + productId
                        + "&wishlistStatus=removed"
                );

                return;
            }


            // =================================================
            // CLICK CAME FROM WISHLIST PAGE
            // =================================================

            response.sendRedirect(
                    request.getContextPath()
                    + "/wishlist?status=removed"
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/wishlist"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to remove product from wishlist."
            );
        }
    }
}