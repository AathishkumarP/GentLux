package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.ProductVariantDAO;

import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;

import com.gentlux.model.CartItem;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;
    private ProductVariantDAO productVariantDAO;


    @Override
    public void init() {

        cartItemDAO =
                new CartItemDAOImpl();

        productVariantDAO =
                new ProductVariantDAOImpl();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // DEBUG REQUEST VALUES
        // =====================================================

        String cartIdParam =
                request.getParameter("cartId");

        String variantIdParam =
                request.getParameter("variantId");

        String quantityParam =
                request.getParameter("quantity");


        System.out.println(
                "========== ADD TO CART =========="
        );

        System.out.println(
                "cartId = " + cartIdParam
        );

        System.out.println(
                "variantId = " + variantIdParam
        );

        System.out.println(
                "quantity = " + quantityParam
        );

        System.out.println(
                "================================="
        );


        try {

            // =================================================
            // READ REQUEST DATA
            // =================================================

            int cartId =
                    Integer.parseInt(
                            cartIdParam
                    );

            int variantId =
                    Integer.parseInt(
                            variantIdParam
                    );

            int quantity =
                    Integer.parseInt(
                            quantityParam
                    );


            // =================================================
            // VALIDATE QUANTITY
            // =================================================

            if (quantity < 1) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Quantity must be at least 1"
                );

                return;
            }


            // =================================================
            // GET SELECTED VARIANT
            // =================================================

            ProductVariant variant =
                    productVariantDAO.getVariantById(
                            variantId
                    );


            if (variant == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product variant not found"
                );

                return;
            }


            int availableStock =
                    variant.getStockQuantity();


            // =================================================
            // CHECK STOCK
            // =================================================

            if (availableStock <= 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/product-details?id="
                        + variant.getProductId()
                        + "&cartStatus=outOfStock"
                );

                return;
            }


            // =================================================
            // CHECK IF VARIANT ALREADY EXISTS IN CART
            // =================================================

            CartItem existingItem =
                    cartItemDAO
                    .getCartItemByCartAndVariant(
                            cartId,
                            variantId
                    );


            // =================================================
            // EXISTING CART ITEM
            // =================================================

            if (existingItem != null) {

                System.out.println(
                        "Variant already exists in cart."
                );

                System.out.println(
                        "Current quantity = "
                        + existingItem.getQuantity()
                );


                int newQuantity =
                        existingItem.getQuantity()
                        + quantity;


                // Don't exceed available stock
                if (newQuantity > availableStock) {

                    newQuantity =
                            availableStock;
                }


                boolean updated =
                        cartItemDAO.updateQuantity(
                                existingItem.getCartItemId(),
                                newQuantity
                        );


                System.out.println(
                        "Cart quantity updated = "
                        + updated
                );

                System.out.println(
                        "New quantity = "
                        + newQuantity
                );


                if (!updated) {

                    response.sendError(
                            HttpServletResponse
                                    .SC_INTERNAL_SERVER_ERROR,
                            "Unable to update cart"
                    );

                    return;
                }

            }


            // =================================================
            // NEW CART ITEM
            // =================================================

            else {

                System.out.println(
                        "Variant does not exist in cart."
                );


                // Don't add more than available stock
                if (quantity > availableStock) {

                    quantity =
                            availableStock;
                }


                CartItem cartItem =
                        new CartItem();

                cartItem.setCartId(
                        cartId
                );

                cartItem.setVariantId(
                        variantId
                );

                cartItem.setQuantity(
                        quantity
                );


                boolean added =
                        cartItemDAO.addCartItem(
                                cartItem
                        );


                System.out.println(
                        "New cart item added = "
                        + added
                );

                System.out.println(
                        "Quantity added = "
                        + quantity
                );


                if (!added) {

                    response.sendError(
                            HttpServletResponse
                                    .SC_INTERNAL_SERVER_ERROR,
                            "Unable to add item to cart"
                    );

                    return;
                }
            }


            // =================================================
            // RETURN TO PRODUCT DETAILS
            // =================================================

            response.sendRedirect(
                    request.getContextPath()
                    + "/product-details?id="
                    + variant.getProductId()
                    + "&cartStatus=added"
            );


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart data"
            );
        }
    }
}