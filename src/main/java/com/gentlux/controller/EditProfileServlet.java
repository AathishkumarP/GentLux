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

@WebServlet("/edit-profile")
public class EditProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO =
                new UserDAOImpl();

        System.out.println(
                "EditProfileServlet initialized"
        );
    }


    // =========================================================
    // SHOW EDIT PROFILE PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession(false);


            if (session == null
                    || session.getAttribute("userId") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            User user =
                    userDAO.getUserById(
                            userId
                    );


            if (user == null) {

                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            request.setAttribute(
                    "user",
                    user
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/edit-profile.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load edit profile page."
            );
        }
    }


    // =========================================================
    // UPDATE PERSONAL INFORMATION
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


            HttpSession session =
                    request.getSession(false);


            if (session == null
                    || session.getAttribute("userId") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            // =====================================================
            // GET FORM VALUES
            // =====================================================

            String fullName =
                    getCleanParameter(
                            request,
                            "fullName"
                    );


            String email =
                    getCleanParameter(
                            request,
                            "email"
                    ).toLowerCase();


            String phone =
                    getCleanParameter(
                            request,
                            "phone"
                    );


            // =====================================================
            // EMPTY VALIDATION
            // =====================================================

            if (fullName.isEmpty()
                    || email.isEmpty()
                    || phone.isEmpty()) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Please fill in all fields."
                );

                return;
            }


            // =====================================================
            // EMAIL VALIDATION
            // =====================================================

            if (!email.matches(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Please enter a valid email address."
                );

                return;
            }


            // =====================================================
            // PHONE VALIDATION
            // =====================================================

            if (!phone.matches("\\d{10}")) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Phone number must contain exactly 10 digits."
                );

                return;
            }


            // =====================================================
            // GET CURRENT USER
            // =====================================================

            User currentUser =
                    userDAO.getUserById(
                            userId
                    );


            if (currentUser == null) {

                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            // =====================================================
            // CHECK EMAIL DUPLICATE
            // =====================================================

            User emailUser =
                    userDAO.getUserByEmail(
                            email
                    );


            if (emailUser != null
                    && emailUser.getUserId() != userId) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "This email is already used by another account."
                );

                return;
            }


            // =====================================================
            // UPDATE ONLY PERSONAL INFORMATION
            // =====================================================

            currentUser.setFullName(
                    fullName
            );

            currentUser.setEmail(
                    email
            );

            currentUser.setPhone(
                    phone
            );


            // =====================================================
            // UPDATE DATABASE
            // =====================================================

            boolean updated =
                    userDAO.updateUser(
                            currentUser
                    );


            if (!updated) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Unable to update personal information."
                );

                return;
            }


            // =====================================================
            // UPDATE SESSION USER
            // =====================================================

            session.setAttribute(
                    "loggedInUser",
                    currentUser
            );


            // =====================================================
            // SUCCESS
            // =====================================================

            response.sendRedirect(
                    request.getContextPath()
                    + "/profile?updated=true"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to update personal information."
            );
        }
    }


    // =========================================================
    // LOAD PAGE WITH ERROR
    // =========================================================

    private void loadPageWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            int userId,
            String errorMessage)
            throws ServletException, IOException {

        User user =
                userDAO.getUserById(
                        userId
                );


        request.setAttribute(
                "user",
                user
        );


        request.setAttribute(
                "error",
                errorMessage
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/edit-profile.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // CLEAN PARAMETER
    // =========================================================

    private String getCleanParameter(
            HttpServletRequest request,
            String parameterName) {

        String value =
                request.getParameter(
                        parameterName
                );


        if (value == null) {

            return "";
        }


        return value.trim();
    }
}