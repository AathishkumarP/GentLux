package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.ProductVariantDAO;
import com.gentlux.dao.impl.ProductVariantDAOImpl;
import com.gentlux.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/edit-stock")
public class AdminEditStockServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductVariantDAO productVariantDAO;


    @Override
    public void init() {

        productVariantDAO =
                new ProductVariantDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String variantIdParameter =
                    request.getParameter("variantId");

            String productIdParameter =
                    request.getParameter("productId");


            if (variantIdParameter == null
                    || variantIdParameter.isBlank()
                    || productIdParameter == null
                    || productIdParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

                return;
            }


            int variantId =
                    Integer.parseInt(
                            variantIdParameter
                    );

            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


            ProductVariant variant =
                    productVariantDAO.getVariantById(
                            variantId
                    );


            if (variant == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/product-stock?productId="
                        + productId
                );

                return;
            }


            request.setAttribute(
                    "variant",
                    variant
            );

            request.setAttribute(
                    "productId",
                    productId
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/edit-stock.jsp"
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
                    "Unable to load stock edit page."
            );
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setCharacterEncoding("UTF-8");


            String variantIdParameter =
                    request.getParameter("variantId");

            String productIdParameter =
                    request.getParameter("productId");

            String stockParameter =
                    request.getParameter("stockQuantity");


            if (variantIdParameter == null
                    || variantIdParameter.isBlank()
                    || productIdParameter == null
                    || productIdParameter.isBlank()
                    || stockParameter == null
                    || stockParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products"
                );

                return;
            }


            int variantId =
                    Integer.parseInt(
                            variantIdParameter
                    );

            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );

            int stockQuantity =
                    Integer.parseInt(
                            stockParameter
                    );


            if (stockQuantity < 0) {

                ProductVariant variant =
                        productVariantDAO.getVariantById(
                                variantId
                        );


                request.setAttribute(
                        "variant",
                        variant
                );

                request.setAttribute(
                        "productId",
                        productId
                );

                request.setAttribute(
                        "error",
                        "Stock quantity cannot be negative."
                );


                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/edit-stock.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            boolean updated =
                    productVariantDAO.updateStock(
                            variantId,
                            stockQuantity
                    );


            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/product-stock?productId="
                        + productId
                        + "&updateStatus=success"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/product-stock?productId="
                        + productId
                        + "&updateStatus=failed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update stock."
            );
        }
    }
}