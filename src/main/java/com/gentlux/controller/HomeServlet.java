package com.gentlux.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.WishlistDAOImpl;
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

    @Override
    public void init() {

        wishlistDAO =
                new WishlistDAOImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Set<Integer> wishlistProductIds =
                new HashSet<>();


        HttpSession session =
                request.getSession(false);


        if (session != null
                && session.getAttribute("userId") != null) {

            int userId =
                    (Integer)
                    session.getAttribute("userId");


            List<Wishlist> wishlistItems =
                    wishlistDAO.getWishlistByUserId(
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


        request.setAttribute(
                "wishlistProductIds",
                wishlistProductIds
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/home.jsp"
        ).forward(request, response);
    }
}