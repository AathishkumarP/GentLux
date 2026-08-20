package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String search =
                request.getParameter("search");

        String categoryIdParam =
                request.getParameter("categoryId");

        String brand =
                request.getParameter("brand");

        String minPriceParam =
                request.getParameter("minPrice");

        String maxPriceParam =
                request.getParameter("maxPrice");

        String size =
                request.getParameter("size");

        String sortBy =
                request.getParameter("sort");


        Integer categoryId = null;
        Double minPrice = null;
        Double maxPrice = null;


        // =====================================================
        // CONVERT FILTER VALUES
        // =====================================================

        try {

            if (categoryIdParam != null
                    && !categoryIdParam.trim().isEmpty()) {

                categoryId =
                        Integer.parseInt(categoryIdParam);
            }


            if (minPriceParam != null
                    && !minPriceParam.trim().isEmpty()) {

                minPrice =
                        Double.parseDouble(minPriceParam);
            }


            if (maxPriceParam != null
                    && !maxPriceParam.trim().isEmpty()) {

                maxPrice =
                        Double.parseDouble(maxPriceParam);
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid filter value"
            );

            return;
        }


        // =====================================================
        // CLEAN EMPTY VALUES
        // =====================================================

        if (search != null
                && search.trim().isEmpty()) {

            search = null;
        }


        if (brand != null
                && brand.trim().isEmpty()) {

            brand = null;
        }


        if (size != null
                && size.trim().isEmpty()) {

            size = null;
        }


        if (sortBy == null
                || sortBy.trim().isEmpty()) {

            sortBy = "default";
        }


        // =====================================================
        // GET PRODUCTS
        // =====================================================

        List<Product> products;


        // Search has priority for now
        if (search != null) {

            products =
                    productDAO.searchProducts(
                            search.trim()
                    );

        } else {

            products =
                    productDAO.getFilteredProducts(
                            categoryId,
                            brand,
                            minPrice,
                            maxPrice,
                            size,
                            sortBy,
                            1,
                            100
                    );
        }


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "products",
                products
        );

        request.setAttribute(
                "searchKeyword",
                search
        );

        request.setAttribute(
                "selectedCategoryId",
                categoryId
        );

        request.setAttribute(
                "selectedBrand",
                brand
        );

        request.setAttribute(
                "selectedMinPrice",
                minPrice
        );

        request.setAttribute(
                "selectedMaxPrice",
                maxPrice
        );

        request.setAttribute(
                "selectedSize",
                size
        );

        request.setAttribute(
                "selectedSort",
                "default".equals(sortBy)
                        ? null
                        : sortBy
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/products.jsp"
        ).forward(request, response);
    }
}