package com.gentlux.controller;

import java.io.IOException;

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


@WebServlet("/admin/add-variant")
public class AdminAddVariantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private ProductVariantDAO productVariantDAO;


    @Override
    public void init() {

        productDAO = new ProductDAOImpl();

        productVariantDAO = new ProductVariantDAOImpl();
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


            request.setAttribute(
                    "product",
                    product
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-variant.jsp"
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
                    "Unable to load add size page."
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


            String productIdParameter =
                    request.getParameter("productId");

            String size =
                    request.getParameter("size");

            String stockParameter =
                    request.getParameter("stockQuantity");


            // =====================================================
            // VALIDATION
            // =====================================================

            if (productIdParameter == null
                    || productIdParameter.isBlank()
                    || size == null
                    || size.isBlank()
                    || stockParameter == null
                    || stockParameter.isBlank()) {

                request.setAttribute(
                        "error",
                        "Please fill all required fields."
                );

                loadProductAndForward(
                        request,
                        response,
                        productIdParameter
                );

                return;
            }


            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


            int stockQuantity =
                    Integer.parseInt(
                            stockParameter
                    );


            size =
                    size.trim()
                        .toUpperCase();


            if (stockQuantity < 0) {

                request.setAttribute(
                        "error",
                        "Stock quantity cannot be negative."
                );

                loadProductAndForward(
                        request,
                        response,
                        productIdParameter
                );

                return;
            }


            // =====================================================
            // CHECK PRODUCT
            // =====================================================

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


            // =====================================================
            // CHECK DUPLICATE SIZE
            // =====================================================

            boolean sizeAlreadyExists =
                    productVariantDAO
                            .variantExistsForProductAndSize(
                                    productId,
                                    size
                            );


            if (sizeAlreadyExists) {

                request.setAttribute(
                        "error",
                        "This size already exists for the product."
                );

                request.setAttribute(
                        "product",
                        product
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-variant.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            // =====================================================
            // CREATE VARIANT
            // =====================================================

            ProductVariant variant =
                    new ProductVariant();


            variant.setProductId(
                    productId
            );

            variant.setSize(
                    size
            );

            variant.setStockQuantity(
                    stockQuantity
            );


            // =====================================================
            // SAVE VARIANT
            // =====================================================

            boolean added =
                    productVariantDAO.addVariant(
                            variant
                    );


            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/product-stock?productId="
                        + productId
                        + "&addStatus=success"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to add size."
                );

                request.setAttribute(
                        "product",
                        product
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/add-variant.jsp"
                ).forward(
                        request,
                        response
                );
            }


        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Please enter a valid stock quantity."
            );

            loadProductAndForward(
                    request,
                    response,
                    request.getParameter("productId")
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add product size."
            );
        }
    }


    private void loadProductAndForward(
            HttpServletRequest request,
            HttpServletResponse response,
            String productIdParameter)
            throws ServletException, IOException {

        try {

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


            request.setAttribute(
                    "product",
                    product
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-variant.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products"
            );
        }
    }
}