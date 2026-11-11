package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.UserDAO;
import com.gentlux.dao.impl.UserDAOImpl;
import com.gentlux.model.User;
import com.gentlux.util.PasswordUtil;

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

        userDAO =
                new UserDAOImpl();

        System.out.println(
                "LoginServlet initialized"
        );
    }


    // =========================================================
    // SHOW LOGIN PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, do not show login page
        HttpSession session =
                request.getSession(false);

        if (session != null
                && session.getAttribute("userId") != null) {

            String role =
                    (String) session.getAttribute("role");

            if ("ADMIN".equalsIgnoreCase(role)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/dashboard"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/home"
                );
            }

            return;
        }

        request.getRequestDispatcher(
                "/WEB-INF/views/login.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // LOGIN USER
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setCharacterEncoding(
                    "UTF-8"
            );


            // =====================================================
            // GET FORM VALUES
            // =====================================================

            String email =
                    request.getParameter(
                            "email"
                    );

            String password =
                    request.getParameter(
                            "password"
                    );


            // =====================================================
            // CLEAN VALUES
            // =====================================================

            if (email != null) {

                email =
                        email.trim()
                             .toLowerCase();
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
                ).forward(
                        request,
                        response
                );

                return;
            }


            // =====================================================
            // FIND USER BY EMAIL
            // =====================================================

            User user =
                    userDAO.getUserByEmail(
                            email
                    );


            // =====================================================
            // USER NOT FOUND
            // =====================================================

            if (user == null) {

                request.setAttribute(
                        "error",
                        "Invalid email or password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/login.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            // =====================================================
            // CHECK PASSWORD (BCRYPT + LEGACY PLAINTEXT FALLBACK)
            // =====================================================

            if (!PasswordUtil.checkPassword(
                    password,
                    user.getPassword()
            )) {

                request.setAttribute(
                        "error",
                        "Invalid email or password."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/login.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            // =====================================================
            // PROGRESSIVE BCRYPT MIGRATION FOR LEGACY PASSWORDS
            // =====================================================

            if (!PasswordUtil.isBCryptHash(
                    user.getPassword()
            )) {

                try {

                    String newHash =
                            PasswordUtil.hashPassword(
                                    password
                            );

                    boolean migrated =
                            userDAO.updatePassword(
                                    user.getUserId(),
                                    newHash
                            );

                    if (!migrated) {

                        System.err.println(
                                "Warning: Unable to update migrated password in database for user ID: "
                                + user.getUserId()
                        );
                    }

                } catch (Exception migrationException) {

                    System.err.println(
                            "Warning: Error during password migration for user ID: "
                            + user.getUserId()
                    );
                }
            }


            // =====================================================
            // CREATE & ROTATE LOGIN SESSION (SESSION FIXATION DEFENSE)
            // =====================================================

            HttpSession session =
                    request.getSession();

            request.changeSessionId();


            // =====================================================
            // SANITIZE USER OBJECT BEFORE STORING IN SESSION
            // =====================================================

            user.setPassword(null);


            session.setAttribute(
                    "loggedInUser",
                    user
            );


            session.setAttribute(
                    "userId",
                    user.getUserId()
            );


            // =====================================================
            // STORE ROLE IN SESSION
            // =====================================================

            String role =
                    user.getRole();


            if (role == null
                    || role.isBlank()) {

                role =
                        "CUSTOMER";
            }


            session.setAttribute(
                    "role",
                    role
            );


            // Session expires after 30 minutes of inactivity
            session.setMaxInactiveInterval(
                    30 * 60
            );


            System.out.println(
                    "Login successful: "
                    + user.getEmail()
                    + " | Role: "
                    + role
            );


            // =====================================================
            // REDIRECT BASED ON ROLE
            // =====================================================

            if ("ADMIN".equalsIgnoreCase(
                    role
            )) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/dashboard"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/home"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();


            request.setAttribute(
                    "error",
                    "Something went wrong while logging in."
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/login.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}