package com.gentlux.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // =========================================================
    // LOGOUT USER
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // GET EXISTING SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // DESTROY SESSION
        // =====================================================

        if (session != null) {

            session.invalidate();

        }


        // =====================================================
        // REDIRECT TO LOGIN PAGE
        // =====================================================

        response.sendRedirect(
                request.getContextPath()
                + "/login?logout=true"
        );

    }
}