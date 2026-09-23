package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CartDAO;
import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.ProductVariantDAO;

import com.gentlux.dao.impl.CartDAOImpl;
import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;

import com.gentlux.model.Cart;
import com.gentlux.model.CartItem;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;
    private ProductVariantDAO productVariantDAO;


    @Override
    public void init() {

        cartDAO =
                new CartDAOImpl();

        cartItemDAO =
                new CartItemDAOImpl();

        productVariantDAO =
                new ProductVariantDAOImpl();

        System.out.println(
                "AddToCartServlet initialized"
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =====================================================
            // CHECK LOGIN SESSION
            // =====================================================

            HttpSession session =
                    request.getSession(false);


            if (session == null
                    || session.getAttribute("userId") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }


            // =====================================================
            // GET LOGGED-IN USER ID
            // =====================================================

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            // =====================================================
            // GET USER CART
            // =====================================================

            Cart cart =
                    cartDAO.getOrCreateCart(
                            userId
                    );


            if (cart == null) {

                response.sendError(
                        HttpServletResponse
                                .SC_INTERNAL_SERVER_ERROR,
                        "Unable to load cart."
                );

                return;
            }


            int cartId =
                    cart.getCartId();


            // =====================================================
            // READ PRODUCT DATA
            // =====================================================

            String variantIdParam =
                    request.getParameter(
                            "variantId"
                    );


            String quantityParam =
                    request.getParameter(
                            "quantity"
                    );


            if (variantIdParam == null
                    || quantityParam == null) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product information."
                );

                return;
            }


            int variantId =
                    Integer.parseInt(
                            variantIdParam
                    );


            int quantity =
                    Integer.parseInt(
                            quantityParam
                    );


            // =====================================================
            // DEBUG
            // =====================================================

            System.out.println(
                    "========== ADD TO CART =========="
            );

            System.out.println(
                    "User ID = "
                    + userId
            );

            System.out.println(
                    "Cart ID = "
                    + cartId
            );

            System.out.println(
                    "Variant ID = "
                    + variantId
            );

            System.out.println(
                    "Quantity = "
                    + quantity
            );

            System.out.println(
                    "================================="
            );


            // =====================================================
            // VALIDATE QUANTITY
            // =====================================================

            if (quantity < 1) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Quantity must be at least 1."
                );

                return;
            }


            // =====================================================
            // GET SELECTED VARIANT
            // =====================================================

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


            int availableStock =
                    variant.getStockQuantity();


            // =====================================================
            // CHECK STOCK
            // =====================================================

            if (availableStock <= 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/product-details?id="
                        + variant.getProductId()
                        + "&cartStatus=outOfStock"
                );

                return;
            }


            // =====================================================
            // CHECK IF ITEM ALREADY EXISTS
            // =====================================================

            CartItem existingItem =
                    cartItemDAO
                            .getCartItemByCartAndVariant(
                                    cartId,
                                    variantId
                            );


            // =====================================================
            // ITEM ALREADY EXISTS
            // =====================================================

            if (existingItem != null) {

                int newQuantity =
                        existingItem.getQuantity()
                        + quantity;


                if (newQuantity > availableStock) {

                    newQuantity =
                            availableStock;
                }


                boolean updated =
                        cartItemDAO.updateQuantity(
                                existingItem.getCartItemId(),
                                newQuantity
                        );


                if (!updated) {

                    response.sendError(
                            HttpServletResponse
                                    .SC_INTERNAL_SERVER_ERROR,
                            "Unable to update cart."
                    );

                    return;
                }
            }


            // =====================================================
            // NEW CART ITEM
            // =====================================================

            else {

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


                if (!added) {

                    response.sendError(
                            HttpServletResponse
                                    .SC_INTERNAL_SERVER_ERROR,
                            "Unable to add item to cart."
                    );

                    return;
                }
            }


            // =====================================================
            // SUCCESS
            // =====================================================

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
                    "Invalid product information."
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to add item to cart."
            );
        }
    }
}