<%@ page language="java"

    contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Set" %>

<%@ page import="java.util.HashSet" %>

<%@ page import="com.gentlux.model.Product" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"

          content="width=device-width, initial-scale=1.0">

    <title>GENTLUX | Men's Fashion</title>


    

    <link rel="stylesheet"

          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"

          href="${pageContext.request.contextPath}/assets/css/wishlist.css">


    

    <style>
        /* =========================================================
           HOME FEATURED PRODUCTS - SAME DESIGN AS PRODUCTS PAGE
        ========================================================= */

        .featured-products {
            padding: 80px 2%;
            background-color: #f8f6f2;
        }

        .featured-products .section-heading {
            margin-bottom: 45px;
        }

        .featured-products .product-grid {
            width: 100%;
            max-width: 1700px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 20px;
        }

        .featured-products .modern-product-card {
            position: relative;
        }

        .featured-products .modern-product-image-wrapper {
            position: relative;
            width: 100%;
            height: auto;
            aspect-ratio: 3 / 4;
            overflow: hidden;
            background-color: #ffffff;
        }

        .featured-products .modern-product-image {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #ffffff;
        }

        .featured-products .modern-product-image img {
            width: 100%;
            height: 100%;
            display: block;
            object-fit: contain;
            object-position: center;
            transition: transform 0.35s ease;
        }

        .featured-products .modern-product-card:hover .modern-product-image img {
            transform: scale(1.02);
        }

        .featured-products .product-image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1ece8;
            color: #38251e;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 4px;
        }

        /* Wishlist heart */
        .home-wishlist-button {
            position: absolute;
            top: 14px;
            right: 14px;
            z-index: 10;
            width: 40px;
            height: 40px;
            padding: 0;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            outline: none;
            background: transparent;
            box-shadow: none;
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            transition: transform 0.2s ease, opacity 0.2s ease;
        }

        .home-wishlist-button .gentlux-heart {
            width: 28px;
            height: 28px;
            display: block;
            fill: transparent;
            stroke: #38251e;
            stroke-width: 1.8;
            stroke-linecap: round;
            stroke-linejoin: round;
            pointer-events: none;
            transition: fill 0.25s ease, stroke 0.25s ease, transform 0.25s ease;
        }

        .home-wishlist-button:hover {
            transform: scale(1.08);
        }

        .home-wishlist-button.wishlist-selected .gentlux-heart {
            fill: #38251e;
            stroke: #38251e;
        }

        .home-wishlist-button:disabled {
            opacity: 0.55;
            cursor: wait;
        }

        @media (max-width: 1000px) {
            .featured-products .product-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

@media (max-width: 600px) {

    .featured-products {
        padding: 45px 12px;
    }

    .featured-products .section-heading {
        margin-bottom: 28px;
    }

    .featured-products .product-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
        gap: 12px 8px;
    }

    .featured-products .modern-product-card {
        width: 100%;
        min-width: 0;
    }

    .featured-products .modern-product-image-wrapper {
        width: 100%;
        height: auto;
        aspect-ratio: 3 / 4;
    }

    .featured-products .modern-product-image img {
        width: 100%;
        height: 100%;
        object-fit: contain;
        object-position: center;
    }

    .featured-products .home-wishlist-button {
        top: 7px;
        right: 7px;
        width: 30px;
        height: 30px;
    }

    .featured-products .home-wishlist-button .gentlux-heart {
        width: 21px;
        height: 21px;
    }

    .featured-products .modern-product-content {
        padding: 12px 8px 14px;
    }

    .featured-products .modern-product-brand {
        font-size: 7px;
        letter-spacing: 1px;
    }

    .featured-products .modern-product-content h3 {
        font-size: 12px;
        line-height: 1.4;
    }

    .featured-products .modern-product-price {
        gap: 5px;
    }

    .featured-products .modern-current-price {
        font-size: 13px;
    }

    .featured-products .modern-original-price {
        font-size: 9px;
    }

    .featured-products .modern-view-product {
        font-size: 7px;
        letter-spacing: 0.7px;
    }
}


@media (max-width: 400px) {

    .featured-products {
        padding: 40px 10px;
    }

    .featured-products .product-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
        gap: 10px 7px;
    }

    .featured-products .modern-product-content {
        padding: 10px 7px 12px;
    }

    .featured-products .modern-product-content h3 {
        font-size: 11px;
    }

    .featured-products .modern-current-price {
        font-size: 12px;
    }

    .featured-products .modern-original-price {
        font-size: 8px;
    }
}
    </style>


</head>


<body>


<%

    

    List<Product> featuredProducts =

            (List<Product>)

            request.getAttribute(

                    "featuredProducts"

            );


    

    Set<Integer> wishlistProductIds =

            (Set<Integer>)

            request.getAttribute(

                    "wishlistProductIds"

            );


    if (wishlistProductIds == null) {

        wishlistProductIds =

                new HashSet<Integer>();

    }

%>


<jsp:include page="partials/nav.jsp" />


<main>


    

    <section class="hero-section">


        <div class="hero-content">


            <p class="hero-subtitle"

               id="heroSubtitle">

                MEN'S FASHION

            </p>


            <h1 id="heroTitle">

                ELEVATE<br>

                YOUR STYLE

            </h1>


            <p class="hero-description"

               id="heroDescription">

                Discover timeless fashion crafted for the modern gentleman.

            </p>


            <a

                href="${pageContext.request.contextPath}/products"

                class="hero-button"

                id="heroButton">

                SHOP COLLECTION

            </a>


        </div>


        <div

            class="hero-image"

            id="heroImage">

        </div>


    </section>


    

    <section class="featured-categories">


        <div class="section-heading">


            <p class="section-subtitle">

                EXPLORE

            </p>


            <h2>

                SHOP BY CATEGORY

            </h2>


            <p class="section-description">

                Discover styles designed for every occasion.

            </p>


        </div>


        <div class="category-grid">


            

            <div class="category-card">


                <a

                    href="${pageContext.request.contextPath}/products?categoryId=2"

                    class="home-category-image-link">


                    <div class="category-image">


                        <img

                            src="${pageContext.request.contextPath}/assets/images/categories/Shirt.jpg"

                            alt="Men's Shirts"

                            loading="lazy">


                    </div>


                </a>


                <div class="category-info">


                    <h3>

                        SHIRTS

                    </h3>


                    <a

                        href="${pageContext.request.contextPath}/products?categoryId=2">

                        SHOP NOW →

                    </a>


                </div>


            </div>


            

            <div class="category-card">


                <a

                    href="${pageContext.request.contextPath}/products?categoryId=4"

                    class="home-category-image-link">


                    <div class="category-image">


                        <img

                            src="${pageContext.request.contextPath}/assets/images/categories/Trousers.jpg"

                            alt="Men's Trousers"

                            loading="lazy">


                    </div>


                </a>


                <div class="category-info">


                    <h3>

                        TROUSERS

                    </h3>


                    <a

                        href="${pageContext.request.contextPath}/products?categoryId=4">

                        SHOP NOW →

                    </a>


                </div>


            </div>


            

            <div class="category-card">


                <a

                    href="${pageContext.request.contextPath}/products?categoryId=10"

                    class="home-category-image-link">


                    <div class="category-image">


                        <img

                            src="${pageContext.request.contextPath}/assets/images/categories/Footwear.jpg"

                            alt="Men's Footwear"

                            loading="lazy">


                    </div>


                </a>


                <div class="category-info">


                    <h3>

                        FOOTWEAR

                    </h3>


                    <a

                        href="${pageContext.request.contextPath}/products?categoryId=10">

                        SHOP NOW →

                    </a>


                </div>


            </div>


            

            <div class="category-card">


                <a

                    href="${pageContext.request.contextPath}/products?categoryId=5"

                    class="home-category-image-link">


                    <div class="category-image">


                        <img

                            src="${pageContext.request.contextPath}/assets/images/categories/Jackets.jpg"

                            alt="Men's Jackets"

                            loading="lazy">


                    </div>


                </a>


                <div class="category-info">


                    <h3>

                        JACKETS

                    </h3>


                    <a

                        href="${pageContext.request.contextPath}/products?categoryId=5">

                        SHOP NOW →

                    </a>


                </div>


            </div>


        </div>


    </section>


    

    <section class="featured-products">


        <div class="section-heading">


            <p class="section-subtitle">

                OUR COLLECTION

            </p>


            <h2>

                FEATURED PRODUCTS

            </h2>


            <p class="section-description">

                Discover our latest styles, carefully selected for you.

            </p>


        </div>


        <div class="product-grid">

            <%
                if (featuredProducts != null
                        && !featuredProducts.isEmpty()) {

                    for (Product product : featuredProducts) {

                        int productId = product.getProductId();

                        boolean inWishlist =
                                wishlistProductIds.contains(productId);

                        String homeImageUrl = product.getImageUrl();
                        String finalHomeImageUrl = null;

                        if (homeImageUrl != null
                                && !homeImageUrl.trim().isEmpty()) {

                            homeImageUrl = homeImageUrl.trim();

                            if (homeImageUrl.startsWith("http://")
                                    || homeImageUrl.startsWith("https://")) {

                                finalHomeImageUrl = homeImageUrl;

                            } else {

                                if (homeImageUrl.startsWith("/")) {
                                    homeImageUrl = homeImageUrl.substring(1);
                                }

                                finalHomeImageUrl =
                                        request.getContextPath()
                                        + "/"
                                        + homeImageUrl;
                            }
                        }
            %>

            <article class="modern-product-card">

                <div class="modern-product-image-wrapper">

                    <a href="<%= request.getContextPath() %>/product-details?id=<%= productId %>"
                       class="modern-product-image"
                       aria-label="<%= product.getProductName() %>">

                        <% if (finalHomeImageUrl != null) { %>

                            <img src="<%= finalHomeImageUrl %>"
                                 alt="<%= product.getProductName() %>"
                                 loading="lazy"
                                 onerror="
                                     this.style.display='none';
                                     this.nextElementSibling.style.display='flex';
                                 ">

                            <div class="product-image-placeholder"
                                 style="display:none;">
                                <span>GENTLUX</span>
                            </div>

                        <% } else { %>

                            <div class="product-image-placeholder">
                                <span>GENTLUX</span>
                            </div>

                        <% } %>

                    </a>

                    <button type="button"
                            class="home-wishlist-button <%= inWishlist ? "wishlist-selected" : "" %>"
                            data-product-id="<%= productId %>"
                            data-in-wishlist="<%= inWishlist %>"
                            onclick="toggleHomeWishlist(this)"
                            aria-label="<%= inWishlist
                                    ? "Remove from wishlist"
                                    : "Add to wishlist" %>"
                            title="<%= inWishlist
                                    ? "Remove from wishlist"
                                    : "Add to wishlist" %>">

                        <svg class="gentlux-heart"
                             viewBox="0 0 24 24"
                             aria-hidden="true"
                             focusable="false">
                            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5
                                     2 5.42 4.42 3 7.5 3
                                     9.24 3 10.91 3.81 12 5.09
                                     13.09 3.81 14.76 3 16.5 3
                                     19.58 3 22 5.42 22 8.5
                                     22 12.28 18.6 15.36 13.45 20.03
                                     L12 21.35z"/>
                        </svg>

                    </button>

                </div>

                <div class="modern-product-content">

                    <p class="modern-product-brand">
                        <%= product.getBrand() != null
                                && !product.getBrand().trim().isEmpty()
                                ? product.getBrand()
                                : "GENTLUX" %>
                    </p>

                    <h3>
                        <a href="<%= request.getContextPath() %>/product-details?id=<%= productId %>">
                            <%= product.getProductName() %>
                        </a>
                    </h3>

                    <div class="modern-product-price">

                        <span class="modern-current-price">
                            ₹<%= String.format("%.0f", product.getPrice()) %>
                        </span>

                        <% if (product.getMrp() > product.getPrice()) { %>
                            <span class="modern-original-price">
                                ₹<%= String.format("%.0f", product.getMrp()) %>
                            </span>
                        <% } %>

                    </div>

                    <a href="<%= request.getContextPath() %>/product-details?id=<%= productId %>"
                       class="modern-view-product">
                        VIEW PRODUCT
                        <span>→</span>
                    </a>

                </div>

            </article>

            <%
                    }

                } else {
            %>

            <div style="
                grid-column: 1 / -1;
                text-align: center;
                padding: 50px 20px;
            ">
                <h3>No featured products available</h3>
                <p>Products will appear here once they are available.</p>
            </div>

            <%
                }
            %>

        </div>


        

        <div class="featured-products-button">


            <a

                href="${pageContext.request.contextPath}/products"

                class="hero-button">

                VIEW ALL PRODUCTS

            </a>


        </div>


    </section>


</main>


<jsp:include page="partials/footer.jsp" />


<script>

    async function toggleHomeWishlist(button) {


        const productId =

                button.dataset.productId;


        if (!productId) {

            return;

        }


        

        button.disabled = true;


        try {


            const response =

                    await fetch(

                        "${pageContext.request.contextPath}/toggle-wishlist",

                        {

                            method: "POST",

                            headers: {

                                "Content-Type":

                                    "application/x-www-form-urlencoded"

                            },

                            body:

                                "productId="

                                + encodeURIComponent(

                                    productId

                                )

                        }

                    );


            

            if (response.status === 401) {


                window.location.href =

                        "${pageContext.request.contextPath}/login";


                return;

            }


            const data =

                    await response.json();


            

            if (!response.ok

                    || !data.success) {


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


                button.dataset.inWishlist =

                        "true";


                button.title =

                        "Remove from wishlist";


                button.setAttribute(

                    "aria-label",

                    "Remove from wishlist"

                );


            }


            

            else {


                button.classList.remove(

                    "wishlist-selected"

                );


                button.dataset.inWishlist =

                        "false";


                button.title =

                        "Add to wishlist";


                button.setAttribute(

                    "aria-label",

                    "Add to wishlist"

                );


            }


        } catch (error) {


            console.error(

                "Wishlist request error:",

                error

            );


        } finally {


            button.disabled = false;


        }

    }

</script>


</body>

</html>
