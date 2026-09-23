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

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO = new UserDAOImpl();

        System.out.println(
                "ChangePasswordServlet initialized"
        );
    }


    // =========================================================
    // SHOW CHANGE PASSWORD PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

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


        request.getRequestDispatcher(
                "/WEB-INF/views/change-password.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // CHANGE PASSWORD
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
            // SESSION CHECK
            // =====================================================

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
            // GET FORM DATA
            // =====================================================

            String currentPassword =
                    getCleanParameter(
                            request,
                            "currentPassword"
                    );


            String newPassword =
                    getCleanParameter(
                            request,
                            "newPassword"
                    );


            String confirmPassword =
                    getCleanParameter(
                            request,
                            "confirmPassword"
                    );


            // =====================================================
            // EMPTY VALIDATION
            // =====================================================

            if (currentPassword.isEmpty()
                    || newPassword.isEmpty()
                    || confirmPassword.isEmpty()) {

                loadPageWithError(
                        request,
                        response,
                        "Please fill in all password fields."
                );

                return;
            }


            // =====================================================
            // GET CURRENT USER
            // =====================================================

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


            // =====================================================
            // CURRENT PASSWORD CHECK
            // =====================================================

            if (!currentPassword.equals(
                    user.getPassword())) {

                loadPageWithError(
                        request,
                        response,
                        "Current password is incorrect."
                );

                return;
            }


            // =====================================================
            // NEW PASSWORD LENGTH
            // =====================================================

            if (newPassword.length() < 6) {

                loadPageWithError(
                        request,
                        response,
                        "New password must contain at least 6 characters."
                );

                return;
            }


            // =====================================================
            // CONFIRM PASSWORD CHECK
            // =====================================================

            if (!newPassword.equals(
                    confirmPassword)) {

                loadPageWithError(
                        request,
                        response,
                        "New password and confirm password do not match."
                );

                return;
            }


            // =====================================================
            // OLD PASSWORD = NEW PASSWORD CHECK
            // =====================================================

            if (newPassword.equals(
                    currentPassword)) {

                loadPageWithError(
                        request,
                        response,
                        "New password must be different from your current password."
                );

                return;
            }


            // =====================================================
            // UPDATE PASSWORD
            // =====================================================

            boolean updated =
                    userDAO.updatePassword(
                            userId,
                            newPassword
                    );


            if (!updated) {

                loadPageWithError(
                        request,
                        response,
                        "Unable to update password. Please try again."
                );

                return;
            }


            // =====================================================
            // SUCCESS
            // =====================================================

            response.sendRedirect(
                    request.getContextPath()
                    + "/change-password?success=true"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to change password."
            );
        }
    }


    // =========================================================
    // SHOW ERROR
    // =========================================================

    private void loadPageWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            String errorMessage)
            throws ServletException, IOException {

        request.setAttribute(
                "error",
                errorMessage
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/change-password.jsp"
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