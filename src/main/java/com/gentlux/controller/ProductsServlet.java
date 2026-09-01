package com.gentlux.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.gentlux.dao.ProductDAO;
import com.gentlux.dao.WishlistDAO;
import com.gentlux.dao.impl.ProductDAOImpl;
import com.gentlux.dao.impl.WishlistDAOImpl;
import com.gentlux.model.Product;
import com.gentlux.model.Wishlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private WishlistDAO wishlistDAO;


    @Override
    public void init() {

        productDAO = new ProductDAOImpl();
        wishlistDAO = new WishlistDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        String search =
                request.getParameter("search");

        String categoryIdParam =
                request.getParameter("categoryId");

        String brand =
                request.getParameter("brand");

        String minPriceParam =
                request.getParameter("minPrice");

        String maxPriceParam =
                request.getParameter("maxPrice");

        String size =
                request.getParameter("size");

        String sortBy =
                request.getParameter("sort");


        Integer categoryId = null;
        Double minPrice = null;
        Double maxPrice = null;


        // =====================================================
        // CONVERT FILTER VALUES
        // =====================================================

        try {

            if (categoryIdParam != null
                    && !categoryIdParam.trim().isEmpty()) {

                categoryId =
                        Integer.parseInt(categoryIdParam);
            }


            if (minPriceParam != null
                    && !minPriceParam.trim().isEmpty()) {

                minPrice =
                        Double.parseDouble(minPriceParam);
            }


            if (maxPriceParam != null
                    && !maxPriceParam.trim().isEmpty()) {

                maxPrice =
                        Double.parseDouble(maxPriceParam);
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid filter value"
            );

            return;
        }


        // =====================================================
        // CLEAN EMPTY VALUES
        // =====================================================

        if (search != null
                && search.trim().isEmpty()) {

            search = null;
        }


        if (brand != null
                && brand.trim().isEmpty()) {

            brand = null;
        }


        if (size != null
                && size.trim().isEmpty()) {

            size = null;
        }


        if (sortBy == null
                || sortBy.trim().isEmpty()) {

            sortBy = "default";
        }


        // =====================================================
        // GET PRODUCTS
        // =====================================================

        List<Product> products;


        // Search has priority
        if (search != null) {

            products =
                    productDAO.searchProducts(
                            search.trim()
                    );

        } else {

            products =
                    productDAO.getFilteredProducts(
                            categoryId,
                            brand,
                            minPrice,
                            maxPrice,
                            size,
                            sortBy,
                            1,
                            100
                    );
        }


        // =====================================================
        // GET USER WISHLIST PRODUCT IDS
        // =====================================================

        Set<Integer> wishlistProductIds =
                new HashSet<>();


        HttpSession session =
                request.getSession(false);


        if (session != null
                && session.getAttribute("userId") != null) {

            int userId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            List<Wishlist> wishlistItems =
                    wishlistDAO.getWishlistByUserId(
                            userId
                    );


            if (wishlistItems != null) {

                for (Wishlist wishlist : wishlistItems) {

                    wishlistProductIds.add(
                            wishlist.getProductId()
                    );
                }
            }
        }


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "products",
                products
        );


        /*
         * This Set contains the product IDs currently
         * saved in the logged-in user's wishlist.
         *
         * Example:
         *
         * [3, 7, 11]
         *
         * products.jsp can therefore decide:
         *
         * product 11 -> ♥
         * product 12 -> ♡
         */

        request.setAttribute(
                "wishlistProductIds",
                wishlistProductIds
        );


        request.setAttribute(
                "searchKeyword",
                search
        );


        request.setAttribute(
                "selectedCategoryId",
                categoryId
        );


        request.setAttribute(
                "selectedBrand",
                brand
        );


        request.setAttribute(
                "selectedMinPrice",
                minPrice
        );


        request.setAttribute(
                "selectedMaxPrice",
                maxPrice
        );


        request.setAttribute(
                "selectedSize",
                size
        );


        request.setAttribute(
                "selectedSort",
                "default".equals(sortBy)
                        ? null
                        : sortBy
        );


        // =====================================================
        // FORWARD TO PRODUCTS PAGE
        // =====================================================

        request.getRequestDispatcher(
                "/WEB-INF/views/products.jsp"
        ).forward(
                request,
                response
        );
    }
}