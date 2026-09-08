package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.dao.impl.CategoryDAOImpl;
import com.gentlux.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/add-category")
public class AdminAddCategoryServlet extends HttpServlet {

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

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/add-category.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setCharacterEncoding("UTF-8");

            String categoryName =
                    request.getParameter("categoryName");


            // ================================
            // VALIDATION
            // ================================

            if (categoryName == null
                    || categoryName.isBlank()) {

                request.setAttribute(
                        "error",
                        "Category name is required."
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-category.jsp"
                ).forward(request, response);

                return;
            }


            categoryName = categoryName.trim();


            // ================================
            // DUPLICATE CHECK
            // ================================

            if (categoryDAO.categoryNameExists(categoryName)) {

                request.setAttribute(
                        "error",
                        "This category already exists."
                );

                request.setAttribute(
                        "categoryName",
                        categoryName
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-category.jsp"
                ).forward(request, response);

                return;
            }


            // ================================
            // CREATE CATEGORY
            // ================================

            Category category =
                    new Category();

            category.setCategoryName(
                    categoryName
            );


            boolean added =
                    categoryDAO.addCategory(
                            category
                    );


            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?addStatus=success"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to add category."
                );

                request.setAttribute(
                        "categoryName",
                        categoryName
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-category.jsp"
                ).forward(request, response);
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add category."
            );
        }
    }
}