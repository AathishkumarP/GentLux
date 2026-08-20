package com.gentlux.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.gentlux.dao.CartItemDAO;
import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.OrderItemDAO;
import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.ProductVariantDAO;

import com.gentlux.dao.impl.CartItemDAOImpl;
import com.gentlux.dao.impl.OrderDAOImpl;
import com.gentlux.dao.impl.OrderItemDAOImpl;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;

import com.gentlux.model.CartItemView;
import com.gentlux.model.Order;
import com.gentlux.model.OrderItem;
import com.gentlux.model.Product;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ProductVariantDAO productVariantDAO;
    private ProductDAO productDAO;


    @Override
    public void init() {

        cartItemDAO =
                new CartItemDAOImpl();

        orderDAO =
                new OrderDAOImpl();

        orderItemDAO =
                new OrderItemDAOImpl();

        productVariantDAO =
                new ProductVariantDAOImpl();

        productDAO =
                new ProductDAOImpl();

        System.out.println(
                "PlaceOrderServlet initialized"
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =================================================
            // TEMPORARY USER
            // =================================================

            int userId = 1;


            // =================================================
            // CHECKOUT TYPE
            // =================================================

            String checkoutType =
                    getCleanParameter(
                            request,
                            "checkoutType"
                    );

            if (checkoutType.isEmpty()) {
                checkoutType = "CART";
            }


            // =================================================
            // SHIPPING DETAILS
            // =================================================

            String shippingName =
                    getCleanParameter(
                            request,
                            "shippingName"
                    );

            String shippingPhone =
                    getCleanParameter(
                            request,
                            "shippingPhone"
                    );

            String shippingAddress =
                    getCleanParameter(
                            request,
                            "shippingAddress"
                    );

            String shippingCity =
                    getCleanParameter(
                            request,
                            "shippingCity"
                    );

            String shippingState =
                    getCleanParameter(
                            request,
                            "shippingState"
                    );

            String shippingPincode =
                    getCleanParameter(
                            request,
                            "shippingPincode"
                    );

            String paymentMethod =
                    getCleanParameter(
                            request,
                            "paymentMethod"
                    );


            // =================================================
            // VALIDATE CHECKOUT FIELDS
            // =================================================

            if (shippingName.isEmpty()
                    || shippingPhone.isEmpty()
                    || shippingAddress.isEmpty()
                    || shippingCity.isEmpty()
                    || shippingState.isEmpty()
                    || shippingPincode.isEmpty()
                    || paymentMethod.isEmpty()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Please complete all checkout fields."
                );

                return;
            }


            if (!shippingPhone.matches("\\d{10}")) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Phone number must contain exactly 10 digits."
                );

                return;
            }


            if (!shippingPincode.matches("\\d{6}")) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Pincode must contain exactly 6 digits."
                );

                return;
            }


            if (!"COD".equals(paymentMethod)
                    && !"ONLINE".equals(paymentMethod)) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid payment method."
                );

                return;
            }


            // =================================================
            // BUILD CHECKOUT ITEMS
            // =================================================

            List<CartItemView> checkoutItems =
                    new ArrayList<>();

            int cartId = 0;


            // =================================================
            // BUY NOW
            // =================================================

            if ("BUY_NOW".equals(checkoutType)) {

                int variantId =
                        Integer.parseInt(
                                request.getParameter(
                                        "buyNowVariantId"
                                )
                        );

                int quantity =
                        Integer.parseInt(
                                request.getParameter(
                                        "buyNowQuantity"
                                )
                        );


                if (quantity < 1) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid quantity."
                    );

                    return;
                }


                ProductVariant variant =
                        productVariantDAO
                        .getVariantById(
                                variantId
                        );


                if (variant == null) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Product variant not found."
                    );

                    return;
                }


                if (variant.getStockQuantity()
                        < quantity) {

                    response.sendError(
                            HttpServletResponse.SC_CONFLICT,
                            "Requested quantity is not available."
                    );

                    return;
                }


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

                checkoutItems.add(
                        buyNowItem
                );

            }


            // =================================================
            // NORMAL CART CHECKOUT
            // =================================================

            else {

                cartId =
                        Integer.parseInt(
                                request.getParameter(
                                        "cartId"
                                )
                        );


                checkoutItems =
                        cartItemDAO
                        .getCartItemViewsByCartId(
                                cartId
                        );


                if (checkoutItems == null
                        || checkoutItems.isEmpty()) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/cart"
                    );

                    return;
                }
            }


            // =================================================
            // VALIDATE STOCK AGAIN
            // =================================================

            for (CartItemView item : checkoutItems) {

                ProductVariant variant =
                        productVariantDAO
                        .getVariantById(
                                item.getVariantId()
                        );


                if (variant == null) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "One of the selected product variants no longer exists."
                    );

                    return;
                }


                if (variant.getStockQuantity()
                        < item.getQuantity()) {

                    response.sendError(
                            HttpServletResponse.SC_CONFLICT,
                            "Not enough stock for "
                            + item.getProductName()
                            + " - Size "
                            + item.getSize()
                    );

                    return;
                }
            }


            // =================================================
            // CALCULATE TOTAL
            // =================================================

            double orderTotal = 0.0;

            for (CartItemView item : checkoutItems) {

                orderTotal +=
                        item.getSubtotal();
            }


            // =================================================
            // CREATE ORDER
            // =================================================

            Order order =
                    new Order();

            order.setUserId(
                    userId
            );

            order.setTotalAmount(
                    orderTotal
            );

            order.setPaymentMethod(
                    paymentMethod
            );

            order.setPaymentStatus(
                    "PENDING"
            );

            order.setOrderStatus(
                    "PLACED"
            );

            order.setShippingName(
                    shippingName
            );

            order.setShippingPhone(
                    shippingPhone
            );

            order.setShippingAddress(
                    shippingAddress
            );

            order.setShippingCity(
                    shippingCity
            );

            order.setShippingState(
                    shippingState
            );

            order.setShippingPincode(
                    shippingPincode
            );


            int orderId =
                    orderDAO.createOrder(
                            order
                    );


            if (orderId <= 0) {

                response.sendError(
                        HttpServletResponse
                                .SC_INTERNAL_SERVER_ERROR,
                        "Unable to create order."
                );

                return;
            }


            // =================================================
            // CREATE ORDER ITEMS + REDUCE STOCK
            // =================================================

            List<CartItemView> reducedStockItems =
                    new ArrayList<>();

            boolean orderProcessingSuccess =
                    true;


            for (CartItemView item : checkoutItems) {

                OrderItem orderItem =
                        new OrderItem();

                orderItem.setOrderId(
                        orderId
                );

                orderItem.setVariantId(
                        item.getVariantId()
                );

                orderItem.setQuantity(
                        item.getQuantity()
                );

                orderItem.setPrice(
                        item.getPrice()
                );


                boolean itemAdded =
                        orderItemDAO.addOrderItem(
                                orderItem
                        );


                if (!itemAdded) {

                    orderProcessingSuccess =
                            false;

                    break;
                }


                boolean stockReduced =
                        productVariantDAO
                        .decreaseStock(
                                item.getVariantId(),
                                item.getQuantity()
                        );


                if (!stockReduced) {

                    orderProcessingSuccess =
                            false;

                    break;
                }


                reducedStockItems.add(
                        item
                );
            }


            // =================================================
            // ROLLBACK-LIKE CLEANUP
            // =================================================

            if (!orderProcessingSuccess) {

                for (CartItemView item
                        : reducedStockItems) {

                    productVariantDAO
                    .increaseStock(
                            item.getVariantId(),
                            item.getQuantity()
                    );
                }


                orderItemDAO.clearOrderItems(
                        orderId
                );


                orderDAO.deleteOrder(
                        orderId
                );


                response.sendError(
                        HttpServletResponse
                                .SC_INTERNAL_SERVER_ERROR,
                        "Unable to complete the order."
                );

                return;
            }


            // =================================================
            // CLEAR CART ONLY FOR CART CHECKOUT
            // =================================================

            if ("CART".equals(checkoutType)) {

                cartItemDAO.clearCart(
                        cartId
                );
            }


            // =================================================
            // DEBUG
            // =================================================

            System.out.println(
                    "========== ORDER PLACED =========="
            );

            System.out.println(
                    "Checkout Type = "
                    + checkoutType
            );

            System.out.println(
                    "Order ID = "
                    + orderId
            );

            System.out.println(
                    "User ID = "
                    + userId
            );

            System.out.println(
                    "Total = "
                    + orderTotal
            );

            System.out.println(
                    "Payment = "
                    + paymentMethod
            );

            System.out.println(
                    "Items = "
                    + checkoutItems.size()
            );

            System.out.println(
                    "=================================="
            );


            // =================================================
            // ORDER SUCCESS
            // =================================================

            response.sendRedirect(
                    request.getContextPath()
                    + "/order-success?orderId="
                    + orderId
            );


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid checkout information."
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse
                            .SC_INTERNAL_SERVER_ERROR,
                    "Unable to place order."
            );
        }
    }


    // =========================================================
    // CLEAN PARAMETER
    // =========================================================

    private String getCleanParameter(
            HttpServletRequest request,
            String parameterName) {

        String value =
                request.getParameter(
                        parameterName
                );

        if (value == null) {
            return "";
        }

        return value.trim();
    }
}