package com.gentlux.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.impl.CategoryDAOImpl;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.model.Category;
import com.gentlux.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


@WebServlet("/admin/add-product")

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

public class AdminAddProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final long MAX_IMAGE_SIZE =
            5 * 1024 * 1024;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;


    @Override
    public void init() {

        productDAO =
                new ProductDAOImpl();

        categoryDAO =
                new CategoryDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        loadCategoriesAndForward(
                request,
                response
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Path savedImagePath = null;

        try {

            request.setCharacterEncoding("UTF-8");


            // =====================================================
            // GET FORM VALUES
            // =====================================================

            String categoryIdParameter =
                    request.getParameter("categoryId");

            String productName =
                    request.getParameter("productName");

            String description =
                    request.getParameter("description");

            String brand =
                    request.getParameter("brand");

            String color =
                    request.getParameter("color");

            String priceParameter =
                    request.getParameter("price");

            String mrpParameter =
                    request.getParameter("mrp");

            String discountParameter =
                    request.getParameter("discount");


            // =====================================================
            // BASIC VALIDATION
            // =====================================================

            if (categoryIdParameter == null
                    || categoryIdParameter.isBlank()
                    || productName == null
                    || productName.isBlank()
                    || priceParameter == null
                    || priceParameter.isBlank()
                    || mrpParameter == null
                    || mrpParameter.isBlank()) {

                forwardWithError(
                        request,
                        response,
                        "Please fill all required fields."
                );

                return;
            }


            int categoryId =
                    Integer.parseInt(
                            categoryIdParameter
                    );


            double price =
                    Double.parseDouble(
                            priceParameter
                    );


            double mrp =
                    Double.parseDouble(
                            mrpParameter
                    );


            double discount = 0.0;


            if (discountParameter != null
                    && !discountParameter.isBlank()) {

                discount =
                        Double.parseDouble(
                                discountParameter
                        );
            }


            // =====================================================
            // PRICE VALIDATION
            // =====================================================

            if (price < 0
                    || mrp < 0
                    || discount < 0
                    || discount > 100) {

                forwardWithError(
                        request,
                        response,
                        "Please enter valid price, MRP and discount values."
                );

                return;
            }


            // =====================================================
            // GET IMAGE
            // =====================================================

            Part imagePart =
                    request.getPart("productImage");


            if (imagePart == null
                    || imagePart.getSize() == 0) {

                forwardWithError(
                        request,
                        response,
                        "Please select a product image."
                );

                return;
            }


            // =====================================================
            // IMAGE SIZE VALIDATION
            // =====================================================

            if (imagePart.getSize() > MAX_IMAGE_SIZE) {

                forwardWithError(
                        request,
                        response,
                        "Image size must be less than 5 MB."
                );

                return;
            }


            // =====================================================
            // IMAGE TYPE VALIDATION
            // =====================================================

            String contentType =
                    imagePart.getContentType();


            if (contentType == null
                    || (!contentType.equalsIgnoreCase("image/jpeg")
                    && !contentType.equalsIgnoreCase("image/png")
                    && !contentType.equalsIgnoreCase("image/webp"))) {

                forwardWithError(
                        request,
                        response,
                        "Only JPG, JPEG, PNG and WEBP images are allowed."
                );

                return;
            }


            // =====================================================
            // ORIGINAL FILE NAME
            // =====================================================

            String originalFileName =
                    imagePart.getSubmittedFileName();


            if (originalFileName == null
                    || originalFileName.isBlank()) {

                forwardWithError(
                        request,
                        response,
                        "Invalid image file."
                );

                return;
            }


            originalFileName =
                    Paths.get(originalFileName)
                            .getFileName()
                            .toString();


            // =====================================================
            // GET FILE EXTENSION
            // =====================================================

            String extension =
                    getFileExtension(
                            originalFileName
                    );


            if (extension == null) {

                forwardWithError(
                        request,
                        response,
                        "Invalid image extension."
                );

                return;
            }


            // =====================================================
            // CREATE UNIQUE FILE NAME
            // =====================================================

            String uniqueFileName =
                    UUID.randomUUID()
                            .toString()
                            .replace("-", "")
                            + "."
                            + extension;


            // =====================================================
            // GET IMAGE FOLDER
            // =====================================================

            String uploadDirectory =
                    getServletContext()
                            .getRealPath(
                                    "/assets/images/products"
                            );


            if (uploadDirectory == null) {

                throw new ServletException(
                        "Unable to resolve product image directory."
                );
            }


            Path uploadPath =
                    Paths.get(
                            uploadDirectory
                    );


            Files.createDirectories(
                    uploadPath
            );


            savedImagePath =
                    uploadPath.resolve(
                            uniqueFileName
                    );


            // =====================================================
            // SAVE IMAGE
            // =====================================================

            try (InputStream inputStream =
                         imagePart.getInputStream()) {

                Files.copy(
                        inputStream,
                        savedImagePath,
                        StandardCopyOption.REPLACE_EXISTING
                );
            }


            // =====================================================
            // PATH STORED IN DATABASE
            // =====================================================

            String imageUrl =
                    "assets/images/products/"
                    + uniqueFileName;


            // =====================================================
            // CREATE PRODUCT
            // =====================================================

            Product product =
                    new Product();


            product.setCategoryId(
                    categoryId
            );


            product.setProductName(
                    productName.trim()
            );


            product.setDescription(
                    description != null
                            ? description.trim()
                            : null
            );


            product.setBrand(
                    brand != null
                            ? brand.trim()
                            : null
            );


            product.setColor(
                    color != null
                            ? color.trim()
                            : null
            );


            product.setPrice(
                    price
            );


            product.setMrp(
                    mrp
            );


            product.setDiscount(
                    discount
            );


            product.setImageUrl(
                    imageUrl
            );


            // =====================================================
            // SAVE PRODUCT TO DATABASE
            // =====================================================

            boolean added =
                    productDAO.addProduct(
                            product
                    );


            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products?addStatus=success"
                );

            } else {

                /*
                 * Product DB insert failed.
                 * Remove uploaded image so an unused file
                 * is not left on the server.
                 */
                if (savedImagePath != null) {

                    Files.deleteIfExists(
                            savedImagePath
                    );
                }


                forwardWithError(
                        request,
                        response,
                        "Unable to add product."
                );
            }


        } catch (NumberFormatException e) {

            if (savedImagePath != null) {

                Files.deleteIfExists(
                        savedImagePath
                );
            }


            forwardWithError(
                    request,
                    response,
                    "Please enter valid numeric values."
            );


        } catch (IllegalStateException e) {

            if (savedImagePath != null) {

                Files.deleteIfExists(
                        savedImagePath
                );
            }


            forwardWithError(
                    request,
                    response,
                    "Uploaded image is too large. Maximum size is 5 MB."
            );


        } catch (Exception e) {

            if (savedImagePath != null) {

                try {

                    Files.deleteIfExists(
                            savedImagePath
                    );

                } catch (IOException ignored) {

                }
            }


            e.printStackTrace();


            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to add product."
            );
        }
    }


    // =========================================================
    // FORWARD WITH ERROR
    // =========================================================

    private void forwardWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            String error)
            throws ServletException, IOException {

        request.setAttribute(
                "error",
                error
        );


        loadCategoriesAndForward(
                request,
                response
        );
    }


    // =========================================================
    // LOAD CATEGORIES
    // =========================================================

    private void loadCategoriesAndForward(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Category> categories =
                    categoryDAO.getAllCategories();


            request.setAttribute(
                    "categories",
                    categories
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-product.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();


            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load add product page."
            );
        }
    }


    // =========================================================
    // GET IMAGE EXTENSION
    // =========================================================

    private String getFileExtension(
            String fileName) {

        int dotIndex =
                fileName.lastIndexOf('.');


        if (dotIndex == -1
                || dotIndex == fileName.length() - 1) {

            return null;
        }


        String extension =
                fileName
                        .substring(dotIndex + 1)
                        .toLowerCase();


        if (extension.equals("jpg")
                || extension.equals("jpeg")
                || extension.equals("png")
                || extension.equals("webp")) {

            return extension;
        }


        return null;
    }
}