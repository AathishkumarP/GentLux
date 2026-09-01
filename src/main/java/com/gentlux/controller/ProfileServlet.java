package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.UserDAO;
import com.gentlux.dao.impl.UserDAOImpl;
import com.gentlux.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO =
                new UserDAOImpl();

        System.out.println(
                "ProfileServlet initialized"
        );
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // GET EXISTING SESSION
            // =====================================================

            HttpSession session =
                    request.getSession(false);


            // =====================================================
            // CHECK USER LOGIN
            // =====================================================

            if (session == null
                    || session.getAttribute("userId") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            // =====================================================
            // GET LOGGED-IN USER ID
            // =====================================================

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            // =====================================================
            // GET USER FROM DATABASE
            // =====================================================

            User user =
                    userDAO.getUserById(
                            userId
                    );


            if (user == null) {

                // Session has an invalid/deleted user.
                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            // =====================================================
            // SEND USER TO JSP
            // =====================================================

            request.setAttribute(
                    "user",
                    user
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/profile.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load profile."
            );
        }
    }
}