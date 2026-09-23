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


@WebServlet("/update-cart-quantity")
public class UpdateCartQuantityServlet extends HttpServlet {

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

        try {

            int cartItemId =
                    Integer.parseInt(
                            request.getParameter(
                                    "cartItemId"
                            )
                    );

            int requestedQuantity =
                    Integer.parseInt(
                            request.getParameter(
                                    "quantity"
                            )
                    );


            // =====================================================
            // GET CART ITEM
            // =====================================================

            CartItem cartItem =
                    cartItemDAO.getCartItemById(
                            cartItemId
                    );


            if (cartItem == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Cart item not found"
                );

                return;
            }


            // =====================================================
            // GET PRODUCT VARIANT
            // =====================================================

            ProductVariant variant =
                    productVariantDAO.getVariantById(
                            cartItem.getVariantId()
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


            // =====================================================
            // CHECK STOCK
            // =====================================================

            if (availableStock <= 0) {

                // Product became unavailable.
                // Remove it from cart.

                cartItemDAO.removeCartItem(
                        cartItemId
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/cart"
                );

                return;
            }


            // =====================================================
            // MINIMUM QUANTITY = 1
            // =====================================================

            if (requestedQuantity < 1) {

                requestedQuantity = 1;
            }


            // =====================================================
            // MAXIMUM QUANTITY = AVAILABLE STOCK
            // =====================================================

            if (requestedQuantity > availableStock) {

                requestedQuantity =
                        availableStock;
            }


            // =====================================================
            // UPDATE CART
            // =====================================================

            boolean updated =
                    cartItemDAO.updateQuantity(
                            cartItemId,
                            requestedQuantity
                    );


            if (!updated) {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Unable to update cart quantity"
                );

                return;
            }


            // =====================================================
            // REDIRECT BACK TO CART
            // =====================================================

            response.sendRedirect(
                    request.getContextPath()
                            + "/cart"
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart quantity data"
            );
        }
    }
}