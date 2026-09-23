package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.UserDAO;
import com.gentlux.dao.impl.UserDAOImpl;
import com.gentlux.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO = new UserDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<User> users =
                    userDAO.getAllUsers();


            int totalUsers =
                    users != null
                            ? users.size()
                            : 0;


            int customerCount = 0;
            int adminCount = 0;


            if (users != null) {

                for (User user : users) {

                    String role =
                            user.getRole();


                    if (role != null
                            && role.equalsIgnoreCase("ADMIN")) {

                        adminCount++;

                    } else {

                        customerCount++;
                    }
                }
            }


            request.setAttribute(
                    "users",
                    users
            );


            request.setAttribute(
                    "totalUsers",
                    totalUsers
            );


            request.setAttribute(
                    "customerCount",
                    customerCount
            );


            request.setAttribute(
                    "adminCount",
                    adminCount
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/users.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load users."
            );
        }
    }
}