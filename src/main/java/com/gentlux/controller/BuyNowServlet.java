package com.gentlux.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.ProductVariantDAO;
import com.gentlux.dao.UserDAO;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.ProductVariantDAOImpl;
import com.gentlux.dao.impl.UserDAOImpl;
import com.gentlux.model.CartItemView;
import com.gentlux.model.Product;
import com.gentlux.model.ProductVariant;
import com.gentlux.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductVariantDAO productVariantDAO;
    private ProductDAO productDAO;
    private UserDAO userDAO;

    @Override
    public void init() {

        productVariantDAO =
                new ProductVariantDAOImpl();

        productDAO =
                new ProductDAOImpl();

        userDAO =
                new UserDAOImpl();

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

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );

            User user =
                    userDAO.getUserById(
                            userId
                    );

            if (user == null) {

                session.invalidate();

                response.sendRedirect(
                        request.getContextPath()
                        + "/login"
                );

                return;
            }

            int variantId =
                    Integer.parseInt(
                            request.getParameter("variantId")
                    );

            int quantity =
                    Integer.parseInt(
                            request.getParameter("quantity")
                    );

            if (quantity < 1) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid quantity."
                );

                return;
            }

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

            if (variant.getStockQuantity() < quantity) {

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

            List<CartItemView> cartItems =
                    new ArrayList<>();

            cartItems.add(
                    buyNowItem
            );

            double cartTotal =
                    buyNowItem.getSubtotal();

            int totalQuantity =
                    quantity;

            request.setAttribute(
                    "user",
                    user
            );

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
