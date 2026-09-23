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


@WebServlet("/admin/products")
public class AdminProductsServlet extends HttpServlet {

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

        try {

            List<Product> products =
                    productDAO.getAllProducts();

            request.setAttribute(
                    "products",
                    products
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/products.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load products."
            );
        }
    }
}