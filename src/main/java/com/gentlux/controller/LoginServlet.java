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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {

        userDAO = new UserDAOImpl();

        System.out.println("LoginServlet initialized");
    }


    /*
     * =========================================================
     * SHOW LOGIN PAGE
     * =========================================================
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/login.jsp"
        ).forward(request, response);
    }

    /*
     * =========================================================
     * LOGIN USER
     * =========================================================
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setCharacterEncoding("UTF-8");


            // =====================================================
            // GET FORM VALUES
            // =====================================================

            String email =
                    request.getParameter("email");

            String password =
                    request.getParameter("password");


            // =====================================================
            // CLEAN VALUES
            // =====================================================

            if (email != null) {

                email = email.trim().toLowerCase();
            }


            // =====================================================
            // BASIC VALIDATION
            // =====================================================

            if (email == null
                    || email.isEmpty()
                    || password == null
                    || password.isEmpty()) {

                request.setAttribute(
                        "error",
                        "Please enter your email and password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/login.jsp"
                ).forward(request, response);

                return;
            }


            // =====================================================
            // FIND USER BY EMAIL
            // =====================================================

            User user =
                    userDAO.getUserByEmail(email);


            // =====================================================
            // EMAIL NOT FOUND
            // =====================================================

            if (user == null) {

                request.setAttribute(
                        "error",
                        "Invalid email or password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/login.jsp"
                ).forward(request, response);

                return;
            }


            // =====================================================
            // CHECK PASSWORD
            // =====================================================

            if (!password.equals(user.getPassword())) {

                request.setAttribute(
                        "error",
                        "Invalid email or password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/login.jsp"
                ).forward(request, response);

                return;
            }


            // =====================================================
            // CREATE LOGIN SESSION
            // =====================================================

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "loggedInUser",
                    user
            );

            session.setAttribute(
                    "userId",
                    user.getUserId()
            );


            // Session expires after 30 minutes of inactivity
            session.setMaxInactiveInterval(30 * 60);


            System.out.println(
                    "Login successful: "
                    + user.getEmail()
            );


            // =====================================================
            // REDIRECT AFTER LOGIN
            // =====================================================

            response.sendRedirect(
                    request.getContextPath() + "/home"
            );


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Something went wrong while logging in."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/login.jsp"
            ).forward(request, response);
        }
    }
}