package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.impl.CategoryDAOImpl;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.model.Category;
import com.gentlux.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/add-product")
public class AdminAddProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;


    @Override
    public void init() {

        productDAO =
                new ProductDAOImpl();

        categoryDAO =
                new CategoryDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Category> categories =
                    categoryDAO.getAllCategories();

            request.setAttribute(
                    "categories",
                    categories
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-product.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load add product page."
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

            String productName =
                    request.getParameter("productName");

            String description =
                    request.getParameter("description");

            String brand =
                    request.getParameter("brand");

            String color =
                    request.getParameter("color");

            String priceParameter =
                    request.getParameter("price");

            String mrpParameter =
                    request.getParameter("mrp");

            String discountParameter =
                    request.getParameter("discount");

            String imageUrl =
                    request.getParameter("imageUrl");


            // =====================================================
            // BASIC VALIDATION
            // =====================================================

            if (categoryIdParameter == null
                    || categoryIdParameter.isBlank()
                    || productName == null
                    || productName.isBlank()
                    || priceParameter == null
                    || priceParameter.isBlank()
                    || mrpParameter == null
                    || mrpParameter.isBlank()) {

                request.setAttribute(
                        "error",
                        "Please fill all required fields."
                );

                List<Category> categories =
                        categoryDAO.getAllCategories();

                request.setAttribute(
                        "categories",
                        categories
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-product.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            int categoryId =
                    Integer.parseInt(
                            categoryIdParameter
                    );


            double price =
                    Double.parseDouble(
                            priceParameter
                    );


            double mrp =
                    Double.parseDouble(
                            mrpParameter
                    );


            double discount =
                    0.0;


            if (discountParameter != null
                    && !discountParameter.isBlank()) {

                discount =
                        Double.parseDouble(
                                discountParameter
                        );
            }


            // =====================================================
            // CREATE PRODUCT OBJECT
            // =====================================================

            Product product =
                    new Product();


            product.setCategoryId(
                    categoryId
            );

            product.setProductName(
                    productName.trim()
            );

            product.setDescription(
                    description != null
                            ? description.trim()
                            : null
            );

            product.setBrand(
                    brand != null
                            ? brand.trim()
                            : null
            );

            product.setColor(
                    color != null
                            ? color.trim()
                            : null
            );

            product.setPrice(
                    price
            );

            product.setMrp(
                    mrp
            );

            product.setDiscount(
                    discount
            );

            product.setImageUrl(
                    imageUrl != null
                            ? imageUrl.trim()
                            : null
            );


            // =====================================================
            // SAVE PRODUCT
            // =====================================================

            boolean added =
                    productDAO.addProduct(
                            product
                    );


            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products?addStatus=success"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to add product."
                );

                List<Category> categories =
                        categoryDAO.getAllCategories();

                request.setAttribute(
                        "categories",
                        categories
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-product.jsp"
                ).forward(
                        request,
                        response
                );
            }


        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Please enter valid numeric values."
            );

            try {

                List<Category> categories =
                        categoryDAO.getAllCategories();

                request.setAttribute(
                        "categories",
                        categories
                );

            } catch (Exception ex) {

                ex.printStackTrace();
            }

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-product.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add product."
            );
        }
    }
}