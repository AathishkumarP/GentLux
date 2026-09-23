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


@WebServlet("/edit-address")
public class EditAddressServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO =
                new UserDAOImpl();

        System.out.println(
                "EditAddressServlet initialized"
        );
    }


    // =========================================================
    // SHOW EDIT ADDRESS PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // GET SESSION
            // =====================================================

            HttpSession session =
                    request.getSession(false);


            // =====================================================
            // CHECK LOGIN
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
            // GET USER
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
            // SEND USER TO JSP
            // =====================================================

            request.setAttribute(
                    "user",
                    user
            );


            // =====================================================
            // OPEN EDIT ADDRESS PAGE
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/edit-address.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load edit address page."
            );
        }
    }


    // =========================================================
    // UPDATE ADDRESS
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
            // GET SESSION
            // =====================================================

            HttpSession session =
                    request.getSession(false);


            // =====================================================
            // CHECK LOGIN
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
            // GET FORM VALUES
            // =====================================================

            String address =
                    getCleanParameter(
                            request,
                            "address"
                    );


            String city =
                    getCleanParameter(
                            request,
                            "city"
                    );


            String state =
                    getCleanParameter(
                            request,
                            "state"
                    );


            String pincode =
                    getCleanParameter(
                            request,
                            "pincode"
                    );


            // =====================================================
            // EMPTY FIELD VALIDATION
            // =====================================================

            if (address.isEmpty()
                    || city.isEmpty()
                    || state.isEmpty()
                    || pincode.isEmpty()) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Please fill in all address fields."
                );

                return;
            }


            // =====================================================
            // PINCODE VALIDATION
            // =====================================================

            if (!pincode.matches("\\d{6}")) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Pincode must contain exactly 6 digits."
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
            // SET NEW ADDRESS DETAILS
            // =====================================================

            user.setAddress(
                    address
            );


            user.setCity(
                    city
            );


            user.setState(
                    state
            );


            user.setPincode(
                    pincode
            );


            // =====================================================
            // UPDATE ADDRESS IN DATABASE
            // =====================================================

            boolean updated =
                    userDAO.updateAddress(
                            user
                    );


            if (!updated) {

                loadPageWithError(
                        request,
                        response,
                        userId,
                        "Unable to update address."
                );

                return;
            }


            // =====================================================
            // UPDATE SESSION USER
            // =====================================================

            session.setAttribute(
                    "loggedInUser",
                    user
            );


            // =====================================================
            // RETURN TO PROFILE
            // =====================================================

            response.sendRedirect(
                    request.getContextPath()
                    + "/profile?addressUpdated=true"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to update address."
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
                "/WEB-INF/views/edit-address.jsp"
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