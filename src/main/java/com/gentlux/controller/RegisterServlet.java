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


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO = new UserDAOImpl();

        System.out.println(
                "RegisterServlet initialized"
        );
    }


    // =========================================================
    // SHOW REGISTER PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/register.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // REGISTER USER
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

            String fullName =
                    request.getParameter(
                            "fullName"
                    );

            String email =
                    request.getParameter(
                            "email"
                    );

            String phone =
                    request.getParameter(
                            "phone"
                    );

            String password =
                    request.getParameter(
                            "password"
                    );

            String address =
                    request.getParameter(
                            "address"
                    );

            String city =
                    request.getParameter(
                            "city"
                    );

            String state =
                    request.getParameter(
                            "state"
                    );

            String pincode =
                    request.getParameter(
                            "pincode"
                    );


            // =====================================================
            // REMOVE EXTRA SPACES
            // =====================================================

            if (fullName != null) {

                fullName =
                        fullName.trim();
            }


            if (email != null) {

                email =
                        email.trim()
                                .toLowerCase();
            }


            if (phone != null) {

                phone =
                        phone.trim();
            }


            if (address != null) {

                address =
                        address.trim();
            }


            if (city != null) {

                city =
                        city.trim();
            }


            if (state != null) {

                state =
                        state.trim();
            }


            if (pincode != null) {

                pincode =
                        pincode.trim();
            }


            // =====================================================
            // BASIC EMPTY VALIDATION
            // =====================================================

            if (fullName == null
                    || fullName.isEmpty()
                    || email == null
                    || email.isEmpty()
                    || phone == null
                    || phone.isEmpty()
                    || password == null
                    || password.isEmpty()
                    || address == null
                    || address.isEmpty()
                    || city == null
                    || city.isEmpty()
                    || state == null
                    || state.isEmpty()
                    || pincode == null
                    || pincode.isEmpty()) {

                showRegisterError(
                        request,
                        response,
                        "Please fill in all fields.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // EMAIL VALIDATION
            // =====================================================

            if (!email.matches(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

                showRegisterError(
                        request,
                        response,
                        "Please enter a valid email address.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // PHONE VALIDATION
            // =====================================================

            if (!phone.matches(
                    "[0-9]{10}")) {

                showRegisterError(
                        request,
                        response,
                        "Phone number must contain exactly 10 digits.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // PINCODE VALIDATION
            // =====================================================

            if (!pincode.matches(
                    "[0-9]{6}")) {

                showRegisterError(
                        request,
                        response,
                        "Pincode must contain exactly 6 digits.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // PASSWORD VALIDATION
            // =====================================================

            if (password.length() < 6) {

                showRegisterError(
                        request,
                        response,
                        "Password must contain at least 6 characters.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // CHECK EMAIL ALREADY EXISTS
            // =====================================================

            if (userDAO.isEmailExists(
                    email)) {

                showRegisterError(
                        request,
                        response,
                        "An account already exists with this email.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // CHECK PHONE ALREADY EXISTS
            // =====================================================

            if (userDAO.isPhoneExists(
                    phone)) {

                showRegisterError(
                        request,
                        response,
                        "An account already exists with this phone number.",
                        fullName,
                        email,
                        phone,
                        address,
                        city,
                        state,
                        pincode
                );

                return;
            }


            // =====================================================
            // CREATE USER OBJECT
            // =====================================================

            User user =
                    new User();


            user.setFullName(
                    fullName
            );

            user.setEmail(
                    email
            );

            user.setPhone(
                    phone
            );

            user.setPassword(
                    password
            );

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
            // SAVE USER
            // =====================================================

            boolean registered =
                    userDAO.registerUser(
                            user
                    );


            // =====================================================
            // SUCCESS
            // =====================================================

            if (registered) {

                System.out.println(
                        "User registered successfully: "
                        + email
                );


                response.sendRedirect(
                        request.getContextPath()
                        + "/login?registered=true"
                );

                return;
            }


            // =====================================================
            // DATABASE FAILURE
            // =====================================================

            showRegisterError(
                    request,
                    response,
                    "Registration failed. Please try again.",
                    fullName,
                    email,
                    phone,
                    address,
                    city,
                    state,
                    pincode
            );


        } catch (Exception e) {

            e.printStackTrace();


            request.setAttribute(
                    "error",
                    "Something went wrong while creating your account."
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/register.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }


    // =========================================================
    // SHOW REGISTER PAGE WITH ERROR
    // =========================================================

    private void showRegisterError(
            HttpServletRequest request,
            HttpServletResponse response,
            String errorMessage,
            String fullName,
            String email,
            String phone,
            String address,
            String city,
            String state,
            String pincode)
            throws ServletException, IOException {


        // ERROR MESSAGE

        request.setAttribute(
                "error",
                errorMessage
        );


        // KEEP FULL NAME

        request.setAttribute(
                "fullName",
                fullName
        );


        // KEEP EMAIL

        request.setAttribute(
                "email",
                email
        );


        // KEEP PHONE

        request.setAttribute(
                "phone",
                phone
        );


        // KEEP ADDRESS

        request.setAttribute(
                "address",
                address
        );


        // KEEP CITY

        request.setAttribute(
                "city",
                city
        );


        // KEEP STATE

        request.setAttribute(
                "state",
                state
        );


        // KEEP PINCODE

        request.setAttribute(
                "pincode",
                pincode
        );


        // PASSWORD IS NOT PRESERVED
        // USER MUST ENTER PASSWORD AGAIN


        request.getRequestDispatcher(
                "/WEB-INF/views/register.jsp"
        ).forward(
                request,
                response
        );
    }
}