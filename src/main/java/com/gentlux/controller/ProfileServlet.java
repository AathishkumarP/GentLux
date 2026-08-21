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

            // Temporary user ID.
            // Later we will replace this with session user ID.

            int userId = 1;


            User user =
                    userDAO.getUserById(
                            userId
                    );


            if (user == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "User not found."
                );

                return;
            }


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