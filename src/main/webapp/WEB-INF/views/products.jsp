<%@ page language="java"

    contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Set" %>

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

        Set<Integer> wishlistProductIds =

                (Set<Integer>) request.getAttribute("wishlistProductIds");

        if (wishlistProductIds == null) {

            wishlistProductIds = new java.util.HashSet<>();

        }

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

                        <img src="${pageContext.request.contextPath}/assets/images/categories/AllCat.jpg"

                             alt="All Products">

                    </div>

                    <span class="shop-category-name">ALL</span>

                </a>

                <!-- T-SHIRTS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=1"

                   class="shop-category-card <%= Integer.valueOf(1).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/T-Shirt.jpg"

                             alt="T-Shirts">

                    </div>

                    <span class="shop-category-name">T-SHIRTS</span>

                </a>

                <!-- SHIRTS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=2"

                   class="shop-category-card <%= Integer.valueOf(2).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Shirt.jpg"

                             alt="Shirts">

                    </div>

                    <span class="shop-category-name">SHIRTS</span>

                </a>

                <!-- JEANS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=3"

                   class="shop-category-card <%= Integer.valueOf(3).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Jeans.jpg"

                             alt="Jeans">

                    </div>

                    <span class="shop-category-name">JEANS</span>

                </a>

                <!-- TROUSERS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=4"

                   class="shop-category-card <%= Integer.valueOf(4).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Trousers.jpg"

                             alt="Trousers">

                    </div>

                    <span class="shop-category-name">TROUSERS</span>

                </a>

                <!-- JACKETS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=5"

                   class="shop-category-card <%= Integer.valueOf(5).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Jackets.jpg"

                             alt="Jackets">

                    </div>

                    <span class="shop-category-name">JACKETS</span>

                </a>

                <!-- HOODIES -->

                <a href="${pageContext.request.contextPath}/products?categoryId=6"

                   class="shop-category-card <%= Integer.valueOf(6).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Hoodies.jpg"

                             alt="Hoodies">

                    </div>

                    <span class="shop-category-name">HOODIES</span>

                </a>

                <!-- SWEATSHIRTS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=7"

                   class="shop-category-card <%= Integer.valueOf(7).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/SweatShirt.jpg"

                             alt="Sweatshirts">

                    </div>

                    <span class="shop-category-name">SWEATSHIRTS</span>

                </a>

                <!-- SHORTS -->

                <a href="${pageContext.request.contextPath}/products?categoryId=8"

                   class="shop-category-card <%= Integer.valueOf(8).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Shorts.jpg"

                             alt="Shorts">

                    </div>

                    <span class="shop-category-name">SHORTS</span>

                </a>

                <!-- ETHNIC WEAR -->

                <a href="${pageContext.request.contextPath}/products?categoryId=9"

                   class="shop-category-card <%= Integer.valueOf(9).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/EthnicWear.jpg"

                             alt="Ethnic Wear">

                    </div>

                    <span class="shop-category-name">ETHNIC WEAR</span>

                </a>

                <!-- FOOTWEAR -->

                <a href="${pageContext.request.contextPath}/products?categoryId=10"

                   class="shop-category-card <%= Integer.valueOf(10).equals(selectedCategoryId) ? "active" : "" %>">

                    <div class="shop-category-image">

                        <img src="${pageContext.request.contextPath}/assets/images/categories/Footwear.jpg"

                             alt="Footwear">

                    </div>

                    <span class="shop-category-name">FOOTWEAR</span>

                </a>

            </div>

        </section>

        <!-- =====================================================

             SEARCH + FILTER PANEL

        ====================================================== -->

        <section class="shop-layout">
    <aside class="shop-sidebar">
        <div class="shop-sidebar-header">
            <div><span class="shop-sidebar-icon">☷</span><span>FILTERS</span></div>
            <a href="${pageContext.request.contextPath}/products">CLEAR ALL</a>
        </div>

        <form action="${pageContext.request.contextPath}/products" method="get" class="sidebar-filter-form">
            <div class="sidebar-filter-group">
                <label for="categoryId">CATEGORY</label>
                <select name="categoryId" id="categoryId">
                    <option value="">All Categories</option>
                    <option value="1" <%= Integer.valueOf(1).equals(selectedCategoryId) ? "selected" : "" %>>T-Shirts</option>
                    <option value="2" <%= Integer.valueOf(2).equals(selectedCategoryId) ? "selected" : "" %>>Shirts</option>
                    <option value="3" <%= Integer.valueOf(3).equals(selectedCategoryId) ? "selected" : "" %>>Jeans</option>
                    <option value="4" <%= Integer.valueOf(4).equals(selectedCategoryId) ? "selected" : "" %>>Trousers</option>
                    <option value="5" <%= Integer.valueOf(5).equals(selectedCategoryId) ? "selected" : "" %>>Jackets</option>
                    <option value="6" <%= Integer.valueOf(6).equals(selectedCategoryId) ? "selected" : "" %>>Hoodies</option>
                    <option value="7" <%= Integer.valueOf(7).equals(selectedCategoryId) ? "selected" : "" %>>Sweatshirts</option>
                    <option value="8" <%= Integer.valueOf(8).equals(selectedCategoryId) ? "selected" : "" %>>Shorts</option>
                    <option value="9" <%= Integer.valueOf(9).equals(selectedCategoryId) ? "selected" : "" %>>Ethnic Wear</option>
                    <option value="10" <%= Integer.valueOf(10).equals(selectedCategoryId) ? "selected" : "" %>>Footwear</option>
                </select>
            </div>

            <div class="sidebar-filter-group">
                <label for="brand">BRAND</label>
                <select name="brand" id="brand">
                    <option value="">All Brands</option>
                    <option value="Roadster" <%= "Roadster".equals(selectedBrand) ? "selected" : "" %>>Roadster</option>
                    <option value="U.S. Polo Assn." <%= "U.S. Polo Assn.".equals(selectedBrand) ? "selected" : "" %>>U.S. Polo Assn.</option>
                    <option value="H&M" <%= "H&M".equals(selectedBrand) ? "selected" : "" %>>H&amp;M</option>
                    <option value="Allen Solly" <%= "Allen Solly".equals(selectedBrand) ? "selected" : "" %>>Allen Solly</option>
                    <option value="Louis Philippe" <%= "Louis Philippe".equals(selectedBrand) ? "selected" : "" %>>Louis Philippe</option>
                    <option value="Van Heusen" <%= "Van Heusen".equals(selectedBrand) ? "selected" : "" %>>Van Heusen</option>
                    <option value="Levis" <%= "Levis".equals(selectedBrand) ? "selected" : "" %>>Levis</option>
                    <option value="Wrangler" <%= "Wrangler".equals(selectedBrand) ? "selected" : "" %>>Wrangler</option>
                    <option value="Pepe Jeans" <%= "Pepe Jeans".equals(selectedBrand) ? "selected" : "" %>>Pepe Jeans</option>
                    <option value="Peter England" <%= "Peter England".equals(selectedBrand) ? "selected" : "" %>>Peter England</option>
                    <option value="Puma" <%= "Puma".equals(selectedBrand) ? "selected" : "" %>>Puma</option>
                    <option value="Manyavar" <%= "Manyavar".equals(selectedBrand) ? "selected" : "" %>>Manyavar</option>
                    <option value="Nike" <%= "Nike".equals(selectedBrand) ? "selected" : "" %>>Nike</option>
                    <option value="Adidas" <%= "Adidas".equals(selectedBrand) ? "selected" : "" %>>Adidas</option>
                    <option value="Bata" <%= "Bata".equals(selectedBrand) ? "selected" : "" %>>Bata</option>
                </select>
            </div>

            <div class="sidebar-filter-group">
                <label for="size">SIZE</label>
                <select name="size" id="size">
                    <option value="">All Sizes</option>
                    <% String[] sizes = {"S","M","L","XL","XXL","28","30","32","34","36","7","8","9","10","11"};
                       for (String sizeOption : sizes) { %>
                        <option value="<%= sizeOption %>" <%= sizeOption.equals(selectedSize) ? "selected" : "" %>><%= sizeOption %></option>
                    <% } %>
                </select>
            </div>

            <div class="sidebar-filter-group">
                <label>PRICE RANGE</label>
                <div class="sidebar-price-row">
                    <div class="price-input-wrapper">
                        <span>₹</span>
                        <input type="number" name="minPrice" min="0" placeholder="Min"
                               value="<%= selectedMinPrice != null ? selectedMinPrice.intValue() : "" %>">
                    </div>
                    <div class="price-input-wrapper">
                        <span>₹</span>
                        <input type="number" name="maxPrice" min="0" placeholder="Max"
                               value="<%= selectedMaxPrice != null ? selectedMaxPrice.intValue() : "" %>">
                    </div>
                </div>
            </div>

            <div class="sidebar-filter-group">
                <label for="sort">SORT BY</label>
                <select name="sort" id="sort">
                    <option value="">Recommended</option>
                    <option value="price_low" <%= "price_low".equals(selectedSort) ? "selected" : "" %>>Price: Low to High</option>
                    <option value="price_high" <%= "price_high".equals(selectedSort) ? "selected" : "" %>>Price: High to Low</option>
                    <option value="discount" <%= "discount".equals(selectedSort) ? "selected" : "" %>>Highest Discount</option>
                    <option value="newest" <%= "newest".equals(selectedSort) ? "selected" : "" %>>Newest</option>
                    <option value="oldest" <%= "oldest".equals(selectedSort) ? "selected" : "" %>>Oldest</option>
                </select>
            </div>

            <button type="submit" class="sidebar-apply-button">APPLY FILTERS →</button>
        </form>

    </aside>

    <section class="shop-products-area">
        <form action="${pageContext.request.contextPath}/products" method="get" class="shop-search-form shop-search-form-main">
            <span class="shop-search-icon">⌕</span>
            <input type="text" name="search"
                   value="<%= searchKeyword != null ? searchKeyword : "" %>"
                   placeholder="Search products or brands...">
            <button type="submit" class="shop-search-button">SEARCH</button>
        </form>

        <div class="shop-results-toolbar">
            <div class="shop-result-count">
                <span class="result-count-icon">◇</span>
                <strong><%= products != null ? products.size() : 0 %></strong>
                <span>Products found</span>
            </div>
            <div class="shop-result-status">Curated for you</div>
        </div>

        <div class="modern-products-grid">
            <%
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
            %>
            <article class="modern-product-card">
                <div class="modern-product-image-wrapper">
                    <% if (product.getDiscount() > 0) { %>
                        <span class="modern-product-badge"><%= product.getDiscount() %>% OFF</span>
                    <% } %>

                    <a href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>" class="modern-product-image">
                        <% if (product.getImageUrl() != null && !product.getImageUrl().trim().isEmpty()) { %>
                            <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>">
                        <% } else { %>
                            <div class="product-image-placeholder"><span>GENTLUX</span></div>
                        <% } %>
                    </a>

                    <%
                        boolean productInWishlist = wishlistProductIds.contains(product.getProductId());
                    %>
                    <button type="button"
                            class="modern-wishlist <%= productInWishlist ? "wishlist-selected" : "" %>"
                            data-product-id="<%= product.getProductId() %>"
                            data-in-wishlist="<%= productInWishlist %>"
                            onclick="toggleWishlist(this)"
                            title="<%= productInWishlist ? "Remove from wishlist" : "Add to wishlist" %>">
                        <svg class="modern-wishlist-heart" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
                            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3 9.24 3 10.91 3.81 12 5.09 13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5 22 12.28 18.6 15.36 13.45 20.03 L12 21.35z"/>
                        </svg>
                    </button>
                </div>

                <div class="modern-product-content">
                    <p class="modern-product-brand"><%= product.getBrand() %></p>
                    <h3><a href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>"><%= product.getProductName() %></a></h3>
                    <div class="modern-product-price">
                        <span class="modern-current-price">₹<%= String.format("%.0f", product.getPrice()) %></span>
                        <% if (product.getMrp() > product.getPrice()) { %>
                            <span class="modern-original-price">₹<%= String.format("%.0f", product.getMrp()) %></span>
                        <% } %>
                    </div>
                    <a href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>" class="modern-view-product">
                        VIEW PRODUCT <span>→</span>
                    </a>
                </div>
            </article>
            <%
                    }
                } else {
            %>
            <div class="modern-no-products">
                <div class="modern-no-products-icon">◇</div>
                <h2>No products found</h2>
                <p>Try changing your search or filters.</p>
                <a href="${pageContext.request.contextPath}/products">CLEAR ALL FILTERS</a>
            </div>
            <% } %>
        </div>
    </section>
</section>


    </main>

    <!-- =========================================================

         FOOTER

    ========================================================== -->

    <jsp:include page="partials/footer.jsp" />

    <!-- =========================================================

         AJAX WISHLIST SCRIPT

    ========================================================== -->

    <script>

        async function toggleWishlist(button) {

            if (button.disabled) {

                return;

            }

            button.disabled = true;

            const productId =

                    button.getAttribute("data-product-id");

            try {

                const response = await fetch(

                    "${pageContext.request.contextPath}/toggle-wishlist",

                    {

                        method: "POST",

                        headers: {

                            "Content-Type":

                                "application/x-www-form-urlencoded"

                        },

                        body:

                            "productId="

                            + encodeURIComponent(productId)

                    }

                );

                if (response.status === 401) {

                    window.location.href =

                        "${pageContext.request.contextPath}/login";

                    return;

                }

                const data = await response.json();

                if (!response.ok || !data.success) {

                    console.error(

                        "Wishlist update failed:",

                        data

                    );

                    return;

                }

                if (data.inWishlist) {

                    button.classList.add(

                        "wishlist-selected"

                    );

                    button.setAttribute(

                        "data-in-wishlist",

                        "true"

                    );

                    button.setAttribute(

                        "title",

                        "Remove from wishlist"

                    );

                } else {

                    button.classList.remove(

                        "wishlist-selected"

                    );

                    button.setAttribute(

                        "data-in-wishlist",

                        "false"

                    );

                    button.setAttribute(

                        "title",

                        "Add to wishlist"

                    );

                }

            } catch (error) {

                console.error(

                    "Wishlist error:",

                    error

                );

            } finally {

                button.disabled = false;

            }

        }

    </script>

</body>

</html>
