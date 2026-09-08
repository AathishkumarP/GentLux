package com.gentlux.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.dao.impl.CategoryDAOImpl;
import com.gentlux.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/categories")
public class AdminCategoriesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;


    @Override
    public void init() {

        categoryDAO = new CategoryDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Category> categories =
                    categoryDAO.getAllCategories();


            Map<Integer, Integer> productCounts =
                    new HashMap<>();


            for (Category category : categories) {

                int count =
                        categoryDAO.getProductCountByCategory(
                                category.getCategoryId()
                        );

                productCounts.put(
                        category.getCategoryId(),
                        count
                );
            }


            request.setAttribute(
                    "categories",
                    categories
            );


            request.setAttribute(
                    "productCounts",
                    productCounts
            );


            request.setAttribute(
                    "totalCategories",
                    categories.size()
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/categories.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load categories."
            );
        }
    }
}