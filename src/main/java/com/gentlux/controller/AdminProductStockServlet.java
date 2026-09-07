package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.ProductVariantDAO;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;
import com.gentlux.model.Product;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/product-stock")
public class AdminProductStockServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private ProductVariantDAO productVariantDAO;


    @Override
    public void init() {

        productDAO =
                new ProductDAOImpl();

        productVariantDAO =
                new ProductVariantDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String productIdParameter =
                    request.getParameter("productId");


            if (productIdParameter == null
                    || productIdParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

                return;
            }


            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


            Product product =
                    productDAO.getProductById(
                            productId
                    );


            if (product == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

                return;
            }


            List<ProductVariant> variants =
                    productVariantDAO.getVariantsByProductId(
                            productId
                    );


            request.setAttribute(
                    "product",
                    product
            );

            request.setAttribute(
                    "variants",
                    variants
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/product-stock.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load product stock."
            );
        }
    }
}