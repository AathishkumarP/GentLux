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


@WebServlet("/admin/edit-product")

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

public class AdminEditProductServlet extends HttpServlet {

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


    // =========================================================
    // GET - LOAD EDIT PAGE
    // =========================================================

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


            List<Category> categories =
                    categoryDAO.getAllCategories();


            request.setAttribute(
                    "product",
                    product
            );


            request.setAttribute(
                    "categories",
                    categories
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/edit-product.jsp"
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
                    "Unable to load product edit page."
            );
        }
    }


    // =========================================================
    // POST - UPDATE PRODUCT
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Path newSavedImagePath = null;

        String oldImageUrl = null;


        try {

            request.setCharacterEncoding("UTF-8");


            // =================================================
            // GET FORM VALUES
            // =================================================

            String productIdParameter =
                    request.getParameter("productId");

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


            // =================================================
            // BASIC VALIDATION
            // =================================================

            if (productIdParameter == null
                    || productIdParameter.isBlank()
                    || categoryIdParameter == null
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
                        "Please fill all required fields.",
                        productIdParameter
                );

                return;
            }


            int productId =
                    Integer.parseInt(
                            productIdParameter
                    );


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


            // =================================================
            // NUMERIC VALIDATION
            // =================================================

            if (price < 0
                    || mrp < 0
                    || discount < 0
                    || discount > 100) {

                forwardWithError(
                        request,
                        response,
                        "Please enter valid price, MRP and discount values.",
                        productIdParameter
                );

                return;
            }


            // =================================================
            // LOAD EXISTING PRODUCT
            // =================================================

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


            oldImageUrl =
                    product.getImageUrl();


            // =================================================
            // CHECK NEW IMAGE
            // =================================================

            Part imagePart =
                    request.getPart(
                            "productImage"
                    );


            boolean newImageSelected =
                    imagePart != null
                    && imagePart.getSize() > 0;


            String finalImageUrl =
                    oldImageUrl;


            // =================================================
            // IF ADMIN SELECTED NEW IMAGE
            // =================================================

            if (newImageSelected) {


                // ---------------------------------------------
                // SIZE VALIDATION
                // ---------------------------------------------

                if (imagePart.getSize()
                        > MAX_IMAGE_SIZE) {

                    forwardWithError(
                            request,
                            response,
                            "Image size must be less than 5 MB.",
                            productIdParameter
                    );

                    return;
                }


                // ---------------------------------------------
                // TYPE VALIDATION
                // ---------------------------------------------

                String contentType =
                        imagePart.getContentType();


                if (contentType == null
                        || (!contentType.equalsIgnoreCase("image/jpeg")
                        && !contentType.equalsIgnoreCase("image/png")
                        && !contentType.equalsIgnoreCase("image/webp"))) {

                    forwardWithError(
                            request,
                            response,
                            "Only JPG, JPEG, PNG and WEBP images are allowed.",
                            productIdParameter
                    );

                    return;
                }


                // ---------------------------------------------
                // ORIGINAL FILE NAME
                // ---------------------------------------------

                String originalFileName =
                        imagePart.getSubmittedFileName();


                if (originalFileName == null
                        || originalFileName.isBlank()) {

                    forwardWithError(
                            request,
                            response,
                            "Invalid image file.",
                            productIdParameter
                    );

                    return;
                }


                originalFileName =
                        Paths.get(
                                originalFileName
                        )
                        .getFileName()
                        .toString();


                // ---------------------------------------------
                // EXTENSION
                // ---------------------------------------------

                String extension =
                        getFileExtension(
                                originalFileName
                        );


                if (extension == null) {

                    forwardWithError(
                            request,
                            response,
                            "Invalid image extension.",
                            productIdParameter
                    );

                    return;
                }


                // ---------------------------------------------
                // UNIQUE FILE NAME
                // ---------------------------------------------

                String uniqueFileName =
                        UUID.randomUUID()
                                .toString()
                                .replace("-", "")
                        + "."
                        + extension;


                // ---------------------------------------------
                // PRODUCT IMAGE DIRECTORY
                // ---------------------------------------------

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


                newSavedImagePath =
                        uploadPath.resolve(
                                uniqueFileName
                        );


                // ---------------------------------------------
                // SAVE NEW IMAGE
                // ---------------------------------------------

                try (InputStream inputStream =
                             imagePart.getInputStream()) {


                    Files.copy(
                            inputStream,
                            newSavedImagePath,
                            StandardCopyOption.REPLACE_EXISTING
                    );
                }


                // ---------------------------------------------
                // NEW DATABASE PATH
                // ---------------------------------------------

                finalImageUrl =
                        "assets/images/products/"
                        + uniqueFileName;
            }


            // =================================================
            // UPDATE PRODUCT VALUES
            // =================================================

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
                    finalImageUrl
            );


            // =================================================
            // UPDATE DATABASE
            // =================================================

            boolean updated =
                    productDAO.updateProduct(
                            product
                    );


            if (updated) {


                /*
                 * The database update succeeded.
                 *
                 * If a new image was uploaded,
                 * we can now safely remove the old uploaded image.
                 */
                if (newImageSelected) {

                    deleteOldUploadedImage(
                            oldImageUrl
                    );
                }


                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products?updateStatus=success"
                );


            } else {


                /*
                 * DB update failed.
                 *
                 * Delete the newly uploaded image because
                 * the product is still using the old image.
                 */
                if (newSavedImagePath != null) {

                    Files.deleteIfExists(
                            newSavedImagePath
                    );
                }


                forwardWithError(
                        request,
                        response,
                        "Unable to update product.",
                        productIdParameter
                );
            }


        } catch (NumberFormatException e) {


            if (newSavedImagePath != null) {

                Files.deleteIfExists(
                        newSavedImagePath
                );
            }


            forwardWithError(
                    request,
                    response,
                    "Please enter valid numeric values.",
                    request.getParameter("productId")
            );


        } catch (IllegalStateException e) {


            if (newSavedImagePath != null) {

                Files.deleteIfExists(
                        newSavedImagePath
                );
            }


            forwardWithError(
                    request,
                    response,
                    "Uploaded image is too large. Maximum size is 5 MB.",
                    request.getParameter("productId")
            );


        } catch (Exception e) {


            if (newSavedImagePath != null) {

                try {

                    Files.deleteIfExists(
                            newSavedImagePath
                    );

                } catch (IOException ignored) {

                }
            }


            e.printStackTrace();


            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update product."
            );
        }
    }


    // =========================================================
    // FORWARD WITH ERROR
    // =========================================================

    private void forwardWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            String error,
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


            List<Category> categories =
                    categoryDAO.getAllCategories();


            request.setAttribute(
                    "product",
                    product
            );


            request.setAttribute(
                    "categories",
                    categories
            );


            request.setAttribute(
                    "error",
                    error
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/edit-product.jsp"
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


    // =========================================================
    // GET FILE EXTENSION
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


    // =========================================================
    // DELETE OLD UPLOADED IMAGE
    // =========================================================

    private void deleteOldUploadedImage(
            String imageUrl) {


        try {


            if (imageUrl == null
                    || imageUrl.isBlank()) {

                return;
            }


            /*
             * Only delete files created by our upload system.
             *
             * This protects old manually configured image paths
             * or external URLs.
             */
            String prefix =
                    "assets/images/products/";


            if (!imageUrl.startsWith(prefix)) {

                return;
            }


            String fileName =
                    imageUrl.substring(
                            prefix.length()
                    );


            /*
             * Security check:
             * the database value must only contain a filename.
             */
            String safeFileName =
                    Paths.get(fileName)
                            .getFileName()
                            .toString();


            if (!safeFileName.equals(fileName)) {

                return;
            }


            String uploadDirectory =
                    getServletContext()
                            .getRealPath(
                                    "/assets/images/products"
                            );


            if (uploadDirectory == null) {

                return;
            }


            Path oldImagePath =
                    Paths.get(
                            uploadDirectory
                    )
                    .resolve(
                            safeFileName
                    );


            Files.deleteIfExists(
                    oldImagePath
            );


        } catch (Exception e) {

            /*
             * Do not fail the product update merely because
             * an old image could not be deleted.
             */
            e.printStackTrace();
        }
    }
}