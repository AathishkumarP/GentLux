package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.dao.impl.CategoryDAOImpl;
import com.gentlux.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/categories")
public class CategoriesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;


    @Override
    public void init() {

        categoryDAO =
                new CategoryDAOImpl();

        System.out.println(
                "CategoriesServlet initialized"
        );
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =================================================
            // GET ALL CATEGORIES
            // =================================================

            List<Category> categories =
                    categoryDAO.getAllCategories();


            // =================================================
            // SEND TO JSP
            // =================================================

            request.setAttribute(
                    "categories",
                    categories
            );


            // =================================================
            // OPEN CATEGORY PAGE
            // =================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/categories.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to load categories."
            );
        }
    }
}