package com.gentlux.controller;

import java.io.IOException;
import java.util.List;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.ProductVariantDAO;
import com.gentlux.dao.WishlistDAO;

import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;
import com.gentlux.dao.impl.WishlistDAOImpl;

import com.gentlux.model.Product;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private ProductVariantDAO productVariantDAO;
    private WishlistDAO wishlistDAO;


    @Override
    public void init() {

        productDAO = new ProductDAOImpl();

        productVariantDAO =
                new ProductVariantDAOImpl();

        wishlistDAO =
                new WishlistDAOImpl();


        System.out.println(
                "ProductDetailsServlet initialized"
        );
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");


        System.out.println(
                "Received Product ID = "
                + idParameter
        );


        if (idParameter == null
                || idParameter.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is required"
            );

            return;
        }


        try {

            int productId =
                    Integer.parseInt(
                            idParameter
                    );


            System.out.println(
                    "Searching database for Product ID = "
                    + productId
            );


            // =====================================================
            // GET PRODUCT
            // =====================================================

            Product product =
                    productDAO
                            .getProductById(
                                    productId
                            );


            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }


            // =====================================================
            // GET PRODUCT VARIANTS
            // =====================================================

            List<ProductVariant> variants =
                    productVariantDAO
                            .getVariantsByProductId(
                                    productId
                            );


            // =====================================================
            // CHECK WISHLIST STATUS
            // =====================================================

            boolean inWishlist = false;


            HttpSession session =
                    request.getSession(false);


            if (session != null
                    && session.getAttribute("userId") != null) {


                int userId =
                        (Integer) session.getAttribute(
                                "userId"
                        );


                inWishlist =
                        wishlistDAO
                                .isProductInWishlist(
                                        userId,
                                        productId
                                );
            }


            // =====================================================
            // DEBUG OUTPUT
            // =====================================================

            System.out.println(
                    "PRODUCT FOUND"
            );


            System.out.println(
                    "ID    : "
                    + product.getProductId()
            );


            System.out.println(
                    "Name  : "
                    + product.getProductName()
            );


            System.out.println(
                    "Brand : "
                    + product.getBrand()
            );


            System.out.println(
                    "Price : "
                    + product.getPrice()
            );


            System.out.println(
                    "Total Variants : "
                    + variants.size()
            );


            System.out.println(
                    "In Wishlist : "
                    + inWishlist
            );


            for (ProductVariant variant : variants) {

                System.out.println(
                        "Variant ID: "
                        + variant.getVariantId()
                        + " | Size: "
                        + variant.getSize()
                        + " | Stock: "
                        + variant.getStockQuantity()
                );
            }


            // =====================================================
            // SEND DATA TO JSP
            // =====================================================

            request.setAttribute(
                    "product",
                    product
            );


            request.setAttribute(
                    "variants",
                    variants
            );


            request.setAttribute(
                    "inWishlist",
                    inWishlist
            );


            // =====================================================
            // FORWARD TO JSP
            // =====================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/product-details.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );
        }
    }
}