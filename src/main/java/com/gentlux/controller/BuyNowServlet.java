package com.gentlux.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.ProductVariantDAO;

import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;

import com.gentlux.model.CartItemView;
import com.gentlux.model.Product;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductVariantDAO productVariantDAO;
    private ProductDAO productDAO;


    @Override
    public void init() {

        productVariantDAO =
                new ProductVariantDAOImpl();

        productDAO =
                new ProductDAOImpl();

        System.out.println(
                "BuyNowServlet initialized"
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =================================================
            // GET FORM VALUES
            // =================================================

            int variantId =
                    Integer.parseInt(
                            request.getParameter("variantId")
                    );

            int quantity =
                    Integer.parseInt(
                            request.getParameter("quantity")
                    );


            // =================================================
            // QUANTITY VALIDATION
            // =================================================

            if (quantity < 1) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid quantity."
                );

                return;
            }


            // =================================================
            // GET VARIANT
            // =================================================

            ProductVariant variant =
                    productVariantDAO.getVariantById(
                            variantId
                    );


            if (variant == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product variant not found."
                );

                return;
            }


            // =================================================
            // STOCK CHECK
            // =================================================

            if (variant.getStockQuantity() < quantity) {

                response.sendError(
                        HttpServletResponse.SC_CONFLICT,
                        "Requested quantity is not available."
                );

                return;
            }


            // =================================================
            // GET PRODUCT
            // =================================================

            Product product =
                    productDAO.getProductById(
                            variant.getProductId()
                    );


            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found."
                );

                return;
            }


            // =================================================
            // BUILD TEMPORARY CHECKOUT ITEM
            // =================================================

            CartItemView buyNowItem =
                    new CartItemView();

            buyNowItem.setVariantId(
                    variant.getVariantId()
            );

            buyNowItem.setQuantity(
                    quantity
            );

            buyNowItem.setProductId(
                    product.getProductId()
            );

            buyNowItem.setProductName(
                    product.getProductName()
            );

            buyNowItem.setBrand(
                    product.getBrand()
            );

            buyNowItem.setSize(
                    variant.getSize()
            );

            buyNowItem.setPrice(
                    product.getPrice()
            );

            buyNowItem.setImageUrl(
                    product.getImageUrl()
            );


            // =================================================
            // CREATE LIST FOR EXISTING CHECKOUT JSP
            // =================================================

            List<CartItemView> cartItems =
                    new ArrayList<>();

            cartItems.add(
                    buyNowItem
            );


            // =================================================
            // TOTALS
            // =================================================

            double cartTotal =
                    buyNowItem.getSubtotal();

            int totalQuantity =
                    quantity;


            // =================================================
            // SEND DATA TO CHECKOUT JSP
            // =================================================

            request.setAttribute(
                    "cartItems",
                    cartItems
            );

            request.setAttribute(
                    "cartTotal",
                    cartTotal
            );

            request.setAttribute(
                    "totalQuantity",
                    totalQuantity
            );


            // Buy Now does not use normal cart.
            request.setAttribute(
                    "cartId",
                    0
            );

            request.setAttribute(
                    "checkoutType",
                    "BUY_NOW"
            );

            request.setAttribute(
                    "buyNowVariantId",
                    variantId
            );

            request.setAttribute(
                    "buyNowQuantity",
                    quantity
            );


            System.out.println(
                    "========== BUY NOW =========="
            );

            System.out.println(
                    "Variant ID = "
                    + variantId
            );

            System.out.println(
                    "Product ID = "
                    + product.getProductId()
            );

            System.out.println(
                    "Quantity = "
                    + quantity
            );

            System.out.println(
                    "Total = "
                    + cartTotal
            );

            System.out.println(
                    "============================="
            );


            // =================================================
            // OPEN EXISTING CHECKOUT PAGE
            // =================================================

            request.getRequestDispatcher(
                    "/WEB-INF/views/checkout.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Buy Now data."
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to process Buy Now."
            );
        }
    }
}