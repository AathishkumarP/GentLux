package com.gentlux.controller;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebFilter("/admin/*")
public class AdminFilter implements Filter {


    @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {

    }


    @Override
    public void doFilter(
            ServletRequest servletRequest,
            ServletResponse servletResponse,
            FilterChain chain)
            throws IOException, ServletException {


        HttpServletRequest request =
                (HttpServletRequest) servletRequest;


        HttpServletResponse response =
                (HttpServletResponse) servletResponse;


        // =====================================================
        // GET EXISTING SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // NOT LOGGED IN
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
        // GET ROLE FROM SESSION
        // =====================================================

        Object roleObject =
                session.getAttribute("role");


        String role =
                roleObject != null
                ? roleObject.toString()
                : null;


        // =====================================================
        // NOT ADMIN
        // =====================================================

        if (role == null
                || !"ADMIN".equalsIgnoreCase(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied. Admin only."
            );

            return;
        }


        // =====================================================
        // ADMIN ALLOWED
        // =====================================================

        chain.doFilter(
                servletRequest,
                servletResponse
        );
    }


    @Override
    public void destroy() {

    }
}