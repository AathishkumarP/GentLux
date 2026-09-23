package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.WishlistDAOImpl;
import com.gentlux.model.WishlistItemView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private WishlistDAO wishlistDAO;


    @Override
    public void init() {

        wishlistDAO = new WishlistDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);


        // Check whether user is logged in
        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }


        try {

            int userId =
                    (Integer) session.getAttribute("userId");


            // Get wishlist products for logged-in user
            List<WishlistItemView> wishlistItems =
                    wishlistDAO
                            .getWishlistItemViewsByUserId(
                                    userId
                            );


            // Send wishlist items to JSP
            request.setAttribute(
                    "wishlistItems",
                    wishlistItems
            );


            // Send wishlist count
            request.setAttribute(
                    "wishlistCount",
                    wishlistItems.size()
            );


            // Open wishlist page
            request.getRequestDispatcher(
                    "/WEB-INF/views/wishlist.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load wishlist."
            );
        }
    }
}