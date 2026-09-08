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


@WebServlet("/admin/edit-category")
public class AdminEditCategoryServlet extends HttpServlet {

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

            String categoryIdParameter =
                    request.getParameter("categoryId");


            if (categoryIdParameter == null
                    || categoryIdParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories"
                );

                return;
            }


            int categoryId =
                    Integer.parseInt(
                            categoryIdParameter
                    );


            Category category =
                    categoryDAO.getCategoryById(
                            categoryId
                    );


            if (category == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories"
                );

                return;
            }


            request.setAttribute(
                    "category",
                    category
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/edit-category.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/categories"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load category."
            );
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setCharacterEncoding("UTF-8");


            String categoryIdParameter =
                    request.getParameter("categoryId");

            String categoryName =
                    request.getParameter("categoryName");


            if (categoryIdParameter == null
                    || categoryIdParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories"
                );

                return;
            }


            int categoryId =
                    Integer.parseInt(
                            categoryIdParameter
                    );


            Category existingCategory =
                    categoryDAO.getCategoryById(
                            categoryId
                    );


            if (existingCategory == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories"
                );

                return;
            }


            if (categoryName == null
                    || categoryName.isBlank()) {

                forwardWithError(
                        request,
                        response,
                        existingCategory,
                        "Category name is required."
                );

                return;
            }


            categoryName =
                    categoryName.trim();


            /*
             * Check duplicate only when the admin
             * actually changed the category name.
             */
            if (!existingCategory
                    .getCategoryName()
                    .equalsIgnoreCase(categoryName)) {


                if (categoryDAO
                        .categoryNameExists(categoryName)) {

                    forwardWithError(
                            request,
                            response,
                            existingCategory,
                            "This category name already exists."
                    );

                    return;
                }
            }


            boolean updated =
                    categoryDAO.updateCategoryName(
                            categoryId,
                            categoryName
                    );


            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?updateStatus=success"
                );

            } else {

                forwardWithError(
                        request,
                        response,
                        existingCategory,
                        "Unable to update category."
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/categories"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update category."
            );
        }
    }


    private void forwardWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            Category category,
            String error)
            throws ServletException, IOException {


        request.setAttribute(
                "category",
                category
        );


        request.setAttribute(
                "error",
                error
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/admin/edit-category.jsp"
        ).forward(
                request,
                response
        );
    }
}