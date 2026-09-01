<%@ page language="java"

    contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%@ page import="com.gentlux.model.Product" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"

          content="width=device-width, initial-scale=1.0">

    <title>Shop | GENTLUX</title>

    <link rel="stylesheet"

          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

    <!-- =========================================================

         NAVBAR

    ========================================================== -->

    <jsp:include page="partials/nav.jsp" />

    <%

        List<Product> products =

                (List<Product>) request.getAttribute("products");

        Integer selectedCategoryId =

                (Integer) request.getAttribute("selectedCategoryId");

        String selectedBrand =

                (String) request.getAttribute("selectedBrand");

        Double selectedMinPrice =

                (Double) request.getAttribute("selectedMinPrice");

        Double selectedMaxPrice =

                (Double) request.getAttribute("selectedMaxPrice");

        String selectedSize =

                (String) request.getAttribute("selectedSize");

        String selectedSort =

                (String) request.getAttribute("selectedSort");

        String searchKeyword =

                (String) request.getAttribute("searchKeyword");

    %>

    <main class="shop-page">

        <!-- =====================================================

             SHOP HERO

        ====================================================== -->

        <section class="shop-hero">

            <div class="shop-hero-content">

                <div class="shop-eyebrow">

                    <span></span>

                    <p>

                        COLLECTION

                    </p>

                    <span></span>

                </div>

                <h1>

                    SHOP GENTLUX

                </h1>

                <p class="shop-hero-description">

                    Discover refined essentials designed

                    for the modern gentleman.

                </p>

            </div>

        </section>

        <!-- =====================================================
             CATEGORY NAVIGATION
        ====================================================== -->

        <section class="shop-category-section">

            <div class="shop-category-scroll">

                <!-- ALL -->
                <a href="${pageContext.request.contextPath}/products"
                   class="shop-category-card <%= selectedCategoryId == null ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/hero-men.jpg"
                             alt="All Products">
                    </div>

                    <span class="shop-category-name">ALL</span>
                </a>

                <!-- T-SHIRTS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=1"
                   class="shop-category-card <%= Integer.valueOf(1).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-1.jpg"
                             alt="T-Shirts">
                    </div>

                    <span class="shop-category-name">T-SHIRTS</span>
                </a>

                <!-- SHIRTS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=2"
                   class="shop-category-card <%= Integer.valueOf(2).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-2.jpg"
                             alt="Shirts">
                    </div>

                    <span class="shop-category-name">SHIRTS</span>
                </a>

                <!-- JEANS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=3"
                   class="shop-category-card <%= Integer.valueOf(3).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-3.jpg"
                             alt="Jeans">
                    </div>

                    <span class="shop-category-name">JEANS</span>
                </a>

                <!-- TROUSERS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=4"
                   class="shop-category-card <%= Integer.valueOf(4).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-4.jpg"
                             alt="Trousers">
                    </div>

                    <span class="shop-category-name">TROUSERS</span>
                </a>

                <!-- JACKETS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=5"
                   class="shop-category-card <%= Integer.valueOf(5).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-1.jpg"
                             alt="Jackets">
                    </div>

                    <span class="shop-category-name">JACKETS</span>
                </a>

                <!-- HOODIES -->
                <a href="${pageContext.request.contextPath}/products?categoryId=6"
                   class="shop-category-card <%= Integer.valueOf(6).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-2.jpg"
                             alt="Hoodies">
                    </div>

                    <span class="shop-category-name">HOODIES</span>
                </a>

                <!-- SWEATSHIRTS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=7"
                   class="shop-category-card <%= Integer.valueOf(7).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-3.jpg"
                             alt="Sweatshirts">
                    </div>

                    <span class="shop-category-name">SWEATSHIRTS</span>
                </a>

                <!-- SHORTS -->
                <a href="${pageContext.request.contextPath}/products?categoryId=8"
                   class="shop-category-card <%= Integer.valueOf(8).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-4.jpg"
                             alt="Shorts">
                    </div>

                    <span class="shop-category-name">SHORTS</span>
                </a>

                <!-- ETHNIC WEAR -->
                <a href="${pageContext.request.contextPath}/products?categoryId=9"
                   class="shop-category-card <%= Integer.valueOf(9).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-1.jpg"
                             alt="Ethnic Wear">
                    </div>

                    <span class="shop-category-name">ETHNIC WEAR</span>
                </a>

                <!-- FOOTWEAR -->
                <a href="${pageContext.request.contextPath}/products?categoryId=10"
                   class="shop-category-card <%= Integer.valueOf(10).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">
                        <img src="${pageContext.request.contextPath}/assets/images/product-2.jpg"
                             alt="Footwear">
                    </div>

                    <span class="shop-category-name">FOOTWEAR</span>
                </a>

            </div>

        </section>



        <!-- =====================================================

             SEARCH + FILTER PANEL

        ====================================================== -->

        <section class="shop-filter-wrapper">

            <!-- Search -->

            <form action="${pageContext.request.contextPath}/products"

                  method="get"

                  class="shop-search-form">

                <span class="shop-search-icon">

                    ⌕

                </span>

                <input type="text"

                       name="search"

                       value="<%= searchKeyword != null

                               ? searchKeyword

                               : "" %>"

                       placeholder="Search products or brands...">

                <button type="submit"

                        class="shop-search-button">

                    SEARCH

                </button>

                <a href="${pageContext.request.contextPath}/products"

                   class="shop-clear-all">

                    CLEAR ALL

                </a>

            </form>

            <!-- Filter Heading -->

            <div class="shop-filter-heading">

                <div>

                    <span class="filter-heading-icon">

                        ☷

                    </span>

                    <span>

                        REFINE YOUR SEARCH

                    </span>

                </div>

                <span class="filter-heading-note">

                    Find your perfect style

                </span>

            </div>

            <!-- Filters -->

            <form action="${pageContext.request.contextPath}/products"

                  method="get"

                  class="modern-filter-form">

                <!-- CATEGORY -->

                <div class="modern-filter-group">

                    <label for="categoryId">

                        CATEGORY

                    </label>

                    <select name="categoryId"

                            id="categoryId">

                        <option value="">

                            All Categories

                        </option>

                        <option value="1"

                            <%= Integer.valueOf(1).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            T-Shirts

                        </option>

                        <option value="2"

                            <%= Integer.valueOf(2).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Shirts

                        </option>

                        <option value="3"

                            <%= Integer.valueOf(3).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Jeans

                        </option>

                        <option value="4"

                            <%= Integer.valueOf(4).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Trousers

                        </option>

                        <option value="5"

                            <%= Integer.valueOf(5).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Jackets

                        </option>

                        <option value="6"

                            <%= Integer.valueOf(6).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Hoodies

                        </option>

                        <option value="7"

                            <%= Integer.valueOf(7).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Sweatshirts

                        </option>

                        <option value="8"

                            <%= Integer.valueOf(8).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Shorts

                        </option>

                        <option value="9"

                            <%= Integer.valueOf(9).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Ethnic Wear

                        </option>

                        <option value="10"

                            <%= Integer.valueOf(10).equals(selectedCategoryId)

                                    ? "selected"

                                    : "" %>>

                            Footwear

                        </option>

                    </select>

                </div>

                <!-- BRAND -->

                <div class="modern-filter-group">

                    <label for="brand">

                        BRAND

                    </label>

                    <select name="brand"

                            id="brand">

                        <option value="">

                            All Brands

                        </option>

                        <option value="Roadster"

                            <%= "Roadster".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Roadster

                        </option>

                        <option value="U.S. Polo Assn."

                            <%= "U.S. Polo Assn.".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            U.S. Polo Assn.

                        </option>

                        <option value="H&M"

                            <%= "H&M".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            H&M

                        </option>

                        <option value="Allen Solly"

                            <%= "Allen Solly".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Allen Solly

                        </option>

                        <option value="Louis Philippe"

                            <%= "Louis Philippe".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Louis Philippe

                        </option>

                        <option value="Van Heusen"

                            <%= "Van Heusen".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Van Heusen

                        </option>

                        <option value="Levis"

                            <%= "Levis".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Levis

                        </option>

                        <option value="Wrangler"

                            <%= "Wrangler".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Wrangler

                        </option>

                        <option value="Pepe Jeans"

                            <%= "Pepe Jeans".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Pepe Jeans

                        </option>

                        <option value="Peter England"

                            <%= "Peter England".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Peter England

                        </option>

                        <option value="Puma"

                            <%= "Puma".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Puma

                        </option>

                        <option value="Manyavar"

                            <%= "Manyavar".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Manyavar

                        </option>

                        <option value="Nike"

                            <%= "Nike".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Nike

                        </option>

                        <option value="Adidas"

                            <%= "Adidas".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Adidas

                        </option>

                        <option value="Bata"

                            <%= "Bata".equals(selectedBrand)

                                    ? "selected"

                                    : "" %>>

                            Bata

                        </option>

                    </select>

                </div>

                <!-- MIN PRICE -->

                <div class="modern-filter-group">

                    <label for="minPrice">

                        MIN PRICE

                    </label>

                    <div class="price-input-wrapper">

                        <span>

                            ₹

                        </span>

                        <input type="number"

                               name="minPrice"

                               id="minPrice"

                               min="0"

                               placeholder="0"

                               value="<%= selectedMinPrice != null

                                       ? selectedMinPrice.intValue()

                                       : "" %>">

                    </div>

                </div>

                <!-- MAX PRICE -->

                <div class="modern-filter-group">

                    <label for="maxPrice">

                        MAX PRICE

                    </label>

                    <div class="price-input-wrapper">

                        <span>

                            ₹

                        </span>

                        <input type="number"

                               name="maxPrice"

                               id="maxPrice"

                               min="0"

                               placeholder="5000"

                               value="<%= selectedMaxPrice != null

                                       ? selectedMaxPrice.intValue()

                                       : "" %>">

                    </div>

                </div>

                <!-- SIZE -->

                <div class="modern-filter-group">

                    <label for="size">

                        SIZE

                    </label>

                    <select name="size"

                            id="size">

                        <option value="">

                            All Sizes

                        </option>

                        <option value="S"

                            <%= "S".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            S

                        </option>

                        <option value="M"

                            <%= "M".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            M

                        </option>

                        <option value="L"

                            <%= "L".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            L

                        </option>

                        <option value="XL"

                            <%= "XL".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            XL

                        </option>

                        <option value="XXL"

                            <%= "XXL".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            XXL

                        </option>

                        <option value="28"

                            <%= "28".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            28

                        </option>

                        <option value="30"

                            <%= "30".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            30

                        </option>

                        <option value="32"

                            <%= "32".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            32

                        </option>

                        <option value="34"

                            <%= "34".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            34

                        </option>

                        <option value="36"

                            <%= "36".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            36

                        </option>

                        <option value="7"

                            <%= "7".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            7

                        </option>

                        <option value="8"

                            <%= "8".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            8

                        </option>

                        <option value="9"

                            <%= "9".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            9

                        </option>

                        <option value="10"

                            <%= "10".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            10

                        </option>

                        <option value="11"

                            <%= "11".equals(selectedSize)

                                    ? "selected"

                                    : "" %>>

                            11

                        </option>

                    </select>

                </div>

                <!-- SORT -->

                <div class="modern-filter-group">

                    <label for="sort">

                        SORT BY

                    </label>

                    <select name="sort"

                            id="sort">

                        <option value="">

                            Recommended

                        </option>

                        <option value="price_low"

                            <%= "price_low".equals(selectedSort)

                                    ? "selected"

                                    : "" %>>

                            Price: Low to High

                        </option>

                        <option value="price_high"

                            <%= "price_high".equals(selectedSort)

                                    ? "selected"

                                    : "" %>>

                            Price: High to Low

                        </option>

                        <option value="discount"

                            <%= "discount".equals(selectedSort)

                                    ? "selected"

                                    : "" %>>

                            Highest Discount

                        </option>

                        <option value="newest"

                            <%= "newest".equals(selectedSort)

                                    ? "selected"

                                    : "" %>>

                            Newest

                        </option>

                        <option value="oldest"

                            <%= "oldest".equals(selectedSort)

                                    ? "selected"

                                    : "" %>>

                            Oldest

                        </option>

                    </select>

                </div>

                <!-- APPLY -->

                <button type="submit"

                        class="modern-apply-filter">

                    <span>

                        ☷

                    </span>

                    APPLY FILTERS

                    <span>

                        →

                    </span>

                </button>

            </form>

            <!-- Quick Prices -->

            <div class="quick-filter-row">

                <span class="quick-filter-title">

                    Quick Price:

                </span>

                <a href="${pageContext.request.contextPath}/products?maxPrice=500">

                    Under ₹500

                </a>

                <a href="${pageContext.request.contextPath}/products?minPrice=500&maxPrice=1000">

                    ₹500 - ₹1000

                </a>

                <a href="${pageContext.request.contextPath}/products?minPrice=1000&maxPrice=2000">

                    ₹1000 - ₹2000

                </a>

                <a href="${pageContext.request.contextPath}/products?minPrice=2000&maxPrice=3000">

                    ₹2000 - ₹3000

                </a>

                <a href="${pageContext.request.contextPath}/products?minPrice=3000">

                    Above ₹3000

                </a>

            </div>

        </section>

        <!-- =====================================================

             PRODUCT RESULT HEADER

        ====================================================== -->

        <section class="shop-results-section">

            <div class="shop-results-toolbar">

                <div class="shop-result-count">

                    <span class="result-count-icon">

                        ◇

                    </span>

                    <strong>

                        <%= products != null

                                ? products.size()

                                : 0 %>

                    </strong>

                    <span>

                        Products found

                    </span>

                </div>

                <div class="shop-result-status">

                    Curated for you

                </div>

            </div>

            <!-- =================================================

                 PRODUCTS GRID

            ================================================== -->

            <div class="modern-products-grid">

                <%

                    if (products != null && !products.isEmpty()) {

                        for (Product product : products) {

                %>

                <article class="modern-product-card">

                    <div class="modern-product-image-wrapper">

                        <!-- Discount badge -->

                        <%

                            if (product.getDiscount() > 0) {

                        %>

                            <span class="modern-product-badge">

                                <%= product.getDiscount() %>% OFF

                            </span>

                        <%

                            }

                        %>

                        <!-- Product Image -->

                        <a href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>"

                           class="modern-product-image">

                            <%

                                if (product.getImageUrl() != null

                                        && !product.getImageUrl().trim().isEmpty()) {

                            %>

                                <img src="<%= product.getImageUrl() %>"

                                     alt="<%= product.getProductName() %>">

                            <%

                                } else {

                            %>

                                <div class="product-image-placeholder">

                                    <span>

                                        GENTLUX

                                    </span>

                                </div>

                            <%

                                }

                            %>

                        </a>

                        <!-- Decorative wishlist -->

                        <span class="modern-wishlist">

                            ♡

                        </span>

                    </div>

                    <!-- Product Content -->

                    <div class="modern-product-content">

                        <p class="modern-product-brand">

                            <%= product.getBrand() %>

                        </p>

                        <h3>

                            <a href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>">

                                <%= product.getProductName() %>

                            </a>

                        </h3>

                        <div class="modern-product-price">

                            <span class="modern-current-price">

                                ₹<%= String.format(

                                        "%.0f",

                                        product.getPrice()

                                ) %>

                            </span>

                            <%

                                if (product.getMrp()

                                        > product.getPrice()) {

                            %>

                                <span class="modern-original-price">

                                    ₹<%= String.format(

                                            "%.0f",

                                            product.getMrp()

                                    ) %>

                                </span>

                            <%

                                }

                            %>

                        </div>

                        <a href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>"

                           class="modern-view-product">

                            VIEW PRODUCT

                            <span>

                                →

                            </span>

                        </a>

                    </div>

                </article>

                <%

                        }

                    } else {

                %>

                <div class="modern-no-products">

                    <div class="modern-no-products-icon">

                        ◇

                    </div>

                    <h2>

                        No products found

                    </h2>

                    <p>

                        Try changing your search or filters.

                    </p>

                    <a href="${pageContext.request.contextPath}/products">

                        CLEAR ALL FILTERS

                    </a>

                </div>

                <%

                    }

                %>

            </div>

        </section>

    </main>

    <!-- =========================================================

         FOOTER

    ========================================================== -->

    <jsp:include page="partials/footer.jsp" />

</body>

</html>
