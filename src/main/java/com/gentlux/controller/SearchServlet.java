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


@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;


    @Override
    public void init() {

        productDAO = new ProductDAOImpl();

        System.out.println(
                "SearchServlet initialized"
        );
    }


    // =========================================================
    // SEARCH PRODUCTS
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // GET SEARCH KEYWORD
            // =====================================================

            String keyword =
                    request.getParameter(
                            "q"
                    );


            // =====================================================
            // CLEAN KEYWORD
            // =====================================================

            if (keyword != null) {

                keyword =
                        keyword.trim();
            }


            // =====================================================
            // SEARCH RESULTS
            // =====================================================

            List<Product> products;


            if (keyword == null
                    || keyword.isEmpty()) {

                products =
                        productDAO.getAllProducts();

            } else {

                products =
                        productDAO.searchProducts(
                                keyword
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
                    "keyword",
                    keyword
            );


            // =====================================================
            // OPEN SEARCH PAGE
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/search.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();


            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to search products."
            );
        }
    }
}