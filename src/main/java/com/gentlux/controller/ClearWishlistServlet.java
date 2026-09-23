package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.WishlistDAOImpl;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/clear-wishlist")
public class ClearWishlistServlet extends HttpServlet {

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

        // =========================================
        // LOGIN CHECK
        // =========================================

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

        try {

            int userId =
                    (Integer)
                    session.getAttribute("userId");

            System.out.println(
                    "Clearing wishlist for userId = "
                    + userId
            );

            boolean cleared =
                    wishlistDAO.clearWishlist(userId);

            System.out.println(
                    "Wishlist cleared = "
                    + cleared
            );

            if (cleared) {

                response.setStatus(
                        HttpServletResponse.SC_OK
                );

                response.getWriter().write(
                        "{\"success\":true}"
                );

            } else {

                response.setStatus(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR
                );

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"No wishlist items were removed\"}"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Unable to clear wishlist\"}"
            );
        }
    }
}