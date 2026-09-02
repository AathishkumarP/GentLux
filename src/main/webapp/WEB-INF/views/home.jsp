<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>GENTLUX | Men's Fashion</title>


    <!-- =========================
         MAIN CSS
    ========================== -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/wishlist.css">


    <!-- =========================
         HOME WISHLIST HEART
    ========================== -->

    <style>


        .featured-products .product-card {

            position: relative;

        }


        /* =========================================
           HEART ONLY WISHLIST BUTTON
        ========================================= */

        .home-wishlist-button {

            position: absolute;

            top: 18px;
            right: 18px;

            width: 34px;
            height: 34px;

            padding: 0;

            display: flex;
            align-items: center;
            justify-content: center;

            background: transparent;

            border: none;

            outline: none;

            box-shadow: none;

            cursor: pointer;

            color: #38251e;

            z-index: 10;

            appearance: none;
            -webkit-appearance: none;

            transition:
                transform 0.25s ease,
                opacity 0.25s ease;

        }



        /* =========================================
           HEART SVG
        ========================================= */

        .home-wishlist-button .gentlux-heart {

            width: 27px;
            height: 27px;

            fill: transparent;

            stroke: #38251e;

            stroke-width: 1.8;

            stroke-linecap: round;
            stroke-linejoin: round;

            pointer-events: none;

            /*
             * Small light shadow helps the heart
             * remain visible on dark product images
             */

            filter:
                drop-shadow(
                    0 1px 1px
                    rgba(255, 255, 255, 0.95)
                );

            transition:
                fill 0.25s ease,
                stroke 0.25s ease,
                transform 0.25s ease;

        }



        /* =========================================
           HOVER
        ========================================= */

        .home-wishlist-button:hover {

            transform: scale(1.12);

        }


        .home-wishlist-button:hover
        .gentlux-heart {

            transform: scale(1.05);

        }



        /* =========================================
           SAVED / ACTIVE
        ========================================= */

        .home-wishlist-button.wishlist-selected
        .gentlux-heart {

            fill: #38251e;

            stroke: #38251e;

        }



        /* =========================================
           CLICK EFFECT
        ========================================= */

        .home-wishlist-button:active {

            transform: scale(0.92);

        }



        /* =========================================
           REMOVE DEFAULT BUTTON EFFECTS
        ========================================= */

        .home-wishlist-button:focus,
        .home-wishlist-button:focus-visible {

            outline: none;

            border: none;

            box-shadow: none;

        }



        /* =========================================
           AJAX PROCESSING
        ========================================= */

        .home-wishlist-button:disabled {

            opacity: 0.55;

            cursor: wait;

        }


    </style>


</head>



<body>


<%

    /*
     * =========================================
     * USER WISHLIST PRODUCTS
     * =========================================
     */

    Set<Integer> wishlistProductIds =
            (Set<Integer>)
            request.getAttribute(
                    "wishlistProductIds"
            );


    if (wishlistProductIds == null) {

        wishlistProductIds =
                new HashSet<Integer>();

    }



    boolean product1Wishlist =
            wishlistProductIds.contains(1);


    boolean product2Wishlist =
            wishlistProductIds.contains(2);


    boolean product3Wishlist =
            wishlistProductIds.contains(3);


    boolean product4Wishlist =
            wishlistProductIds.contains(4);

%>



    <!-- =========================
         NAVBAR
    ========================== -->

    <jsp:include page="partials/nav.jsp" />



    <!-- =========================
         HOME PAGE
    ========================== -->

    <main>



        <!-- =========================
             HERO SECTION
        ========================== -->

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



                <a href="${pageContext.request.contextPath}/products"
                   class="hero-button"
                   id="heroButton">

                    SHOP COLLECTION

                </a>


            </div>



            <div class="hero-image"
                 id="heroImage">

            </div>


        </section>





        <!-- =========================
             FEATURED CATEGORIES
        ========================== -->

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



                <!-- =========================
                     SHIRTS
                ========================== -->

                <div class="category-card">


                    <a href="${pageContext.request.contextPath}/products?categoryId=2"
                       class="home-category-image-link">


                        <div class="category-image">


                            <img
                                src="${pageContext.request.contextPath}/assets/images/categories/Shirt.jpg"
                                alt="Men's Shirts">


                        </div>


                    </a>



                    <div class="category-info">


                        <h3>

                            SHIRTS

                        </h3>


                        <a href="${pageContext.request.contextPath}/products?categoryId=2">

                            SHOP NOW →

                        </a>


                    </div>


                </div>





                <!-- =========================
                     TROUSERS
                ========================== -->

                <div class="category-card">


                    <a href="${pageContext.request.contextPath}/products?categoryId=4"
                       class="home-category-image-link">


                        <div class="category-image">


                            <img
                                src="${pageContext.request.contextPath}/assets/images/categories/Trousers.jpg"
                                alt="Men's Trousers">


                        </div>


                    </a>



                    <div class="category-info">


                        <h3>

                            TROUSERS

                        </h3>


                        <a href="${pageContext.request.contextPath}/products?categoryId=4">

                            SHOP NOW →

                        </a>


                    </div>


                </div>





                <!-- =========================
                     FOOTWEAR
                ========================== -->

                <div class="category-card">


                    <a href="${pageContext.request.contextPath}/products?categoryId=10"
                       class="home-category-image-link">


                        <div class="category-image">


                            <img
                                src="${pageContext.request.contextPath}/assets/images/categories/Footwear.jpg"
                                alt="Men's Footwear">


                        </div>


                    </a>



                    <div class="category-info">


                        <h3>

                            FOOTWEAR

                        </h3>


                        <a href="${pageContext.request.contextPath}/products?categoryId=10">

                            SHOP NOW →

                        </a>


                    </div>


                </div>





                <!-- =========================
                     JACKETS
                ========================== -->

                <div class="category-card">


                    <a href="${pageContext.request.contextPath}/products?categoryId=5"
                       class="home-category-image-link">


                        <div class="category-image">


                            <img
                                src="${pageContext.request.contextPath}/assets/images/categories/Jackets.jpg"
                                alt="Men's Jackets">


                        </div>


                    </a>



                    <div class="category-info">


                        <h3>

                            JACKETS

                        </h3>


                        <a href="${pageContext.request.contextPath}/products?categoryId=5">

                            SHOP NOW →

                        </a>


                    </div>


                </div>


            </div>


        </section>





        <!-- =========================
             FEATURED PRODUCTS
        ========================== -->

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



                <!-- =========================
                     PRODUCT 1
                ========================== -->

                <div class="product-card">


                    <!-- Wishlist Heart -->

                    <button
                        type="button"

                        class="home-wishlist-button
                               <%= product1Wishlist
                                       ? "wishlist-selected"
                                       : "" %>"

                        data-product-id="1"

                        data-in-wishlist="<%= product1Wishlist %>"

                        onclick="toggleHomeWishlist(this)"

                        aria-label="<%= product1Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>"

                        title="<%= product1Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>">


                        <svg
                            class="gentlux-heart"
                            viewBox="0 0 24 24"
                            aria-hidden="true">


                            <path
                                d="M20.84 4.61
                                   a5.5 5.5 0 0 0-7.78 0
                                   L12 5.67
                                   l-1.06-1.06
                                   a5.5 5.5 0 0 0-7.78 7.78
                                   L12 21.23
                                   l8.84-8.84
                                   a5.5 5.5 0 0 0 0-7.78z">
                            </path>


                        </svg>


                    </button>



                    <!-- Product Image -->

                    <a href="${pageContext.request.contextPath}/product-details?id=1"
                       class="product-image product-image-1"
                       aria-label="Classic Oxford Shirt">

                    </a>



                    <!-- Product Information -->

                    <div class="product-info">


                        <p class="product-brand">

                            GENTLUX

                        </p>


                        <h3>

                            Classic Oxford Shirt

                        </h3>


                        <p class="product-price">

                            ₹1,499

                        </p>


                    </div>


                </div>





                <!-- =========================
                     PRODUCT 2
                ========================== -->

                <div class="product-card">


                    <!-- Wishlist Heart -->

                    <button
                        type="button"

                        class="home-wishlist-button
                               <%= product2Wishlist
                                       ? "wishlist-selected"
                                       : "" %>"

                        data-product-id="2"

                        data-in-wishlist="<%= product2Wishlist %>"

                        onclick="toggleHomeWishlist(this)"

                        aria-label="<%= product2Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>"

                        title="<%= product2Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>">


                        <svg
                            class="gentlux-heart"
                            viewBox="0 0 24 24"
                            aria-hidden="true">


                            <path
                                d="M20.84 4.61
                                   a5.5 5.5 0 0 0-7.78 0
                                   L12 5.67
                                   l-1.06-1.06
                                   a5.5 5.5 0 0 0-7.78 7.78
                                   L12 21.23
                                   l8.84-8.84
                                   a5.5 5.5 0 0 0 0-7.78z">
                            </path>


                        </svg>


                    </button>



                    <!-- Product Image -->

                    <a href="${pageContext.request.contextPath}/product-details?id=2"
                       class="product-image product-image-2"
                       aria-label="Premium Casual Shirt">

                    </a>



                    <!-- Product Information -->

                    <div class="product-info">


                        <p class="product-brand">

                            GENTLUX

                        </p>


                        <h3>

                            Premium Casual Shirt

                        </h3>


                        <p class="product-price">

                            ₹1,699

                        </p>


                    </div>


                </div>





                <!-- =========================
                     PRODUCT 3
                ========================== -->

                <div class="product-card">


                    <!-- Wishlist Heart -->

                    <button
                        type="button"

                        class="home-wishlist-button
                               <%= product3Wishlist
                                       ? "wishlist-selected"
                                       : "" %>"

                        data-product-id="3"

                        data-in-wishlist="<%= product3Wishlist %>"

                        onclick="toggleHomeWishlist(this)"

                        aria-label="<%= product3Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>"

                        title="<%= product3Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>">


                        <svg
                            class="gentlux-heart"
                            viewBox="0 0 24 24"
                            aria-hidden="true">


                            <path
                                d="M20.84 4.61
                                   a5.5 5.5 0 0 0-7.78 0
                                   L12 5.67
                                   l-1.06-1.06
                                   a5.5 5.5 0 0 0-7.78 7.78
                                   L12 21.23
                                   l8.84-8.84
                                   a5.5 5.5 0 0 0 0-7.78z">
                            </path>


                        </svg>


                    </button>



                    <!-- Product Image -->

                    <a href="${pageContext.request.contextPath}/product-details?id=3"
                       class="product-image product-image-3"
                       aria-label="Slim Fit Trousers">

                    </a>



                    <!-- Product Information -->

                    <div class="product-info">


                        <p class="product-brand">

                            GENTLUX

                        </p>


                        <h3>

                            Slim Fit Trousers

                        </h3>


                        <p class="product-price">

                            ₹1,899

                        </p>


                    </div>


                </div>





                <!-- =========================
                     PRODUCT 4
                ========================== -->

                <div class="product-card">


                    <!-- Wishlist Heart -->

                    <button
                        type="button"

                        class="home-wishlist-button
                               <%= product4Wishlist
                                       ? "wishlist-selected"
                                       : "" %>"

                        data-product-id="4"

                        data-in-wishlist="<%= product4Wishlist %>"

                        onclick="toggleHomeWishlist(this)"

                        aria-label="<%= product4Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>"

                        title="<%= product4Wishlist
                                ? "Remove from wishlist"
                                : "Add to wishlist" %>">


                        <svg
                            class="gentlux-heart"
                            viewBox="0 0 24 24"
                            aria-hidden="true">


                            <path
                                d="M20.84 4.61
                                   a5.5 5.5 0 0 0-7.78 0
                                   L12 5.67
                                   l-1.06-1.06
                                   a5.5 5.5 0 0 0-7.78 7.78
                                   L12 21.23
                                   l8.84-8.84
                                   a5.5 5.5 0 0 0 0-7.78z">
                            </path>


                        </svg>


                    </button>



                    <!-- Product Image -->

                    <a href="${pageContext.request.contextPath}/product-details?id=4"
                       class="product-image product-image-4"
                       aria-label="Classic Leather Shoes">

                    </a>



                    <!-- Product Information -->

                    <div class="product-info">


                        <p class="product-brand">

                            GENTLUX

                        </p>


                        <h3>

                            Classic Leather Shoes

                        </h3>


                        <p class="product-price">

                            ₹2,499

                        </p>


                    </div>


                </div>


            </div>





            <!-- =========================
                 VIEW ALL PRODUCTS
            ========================== -->

            <div class="featured-products-button">


                <a href="${pageContext.request.contextPath}/products"
                   class="hero-button">

                    VIEW ALL PRODUCTS

                </a>


            </div>


        </section>


    </main>





    <!-- =========================
         FOOTER
    ========================== -->

    <jsp:include page="partials/footer.jsp" />





    <!-- =========================================
         HOME WISHLIST AJAX
    ========================================== -->

    <script>


        async function toggleHomeWishlist(button) {


            const productId =
                    button.dataset.productId;


            if (!productId) {

                return;

            }



            /*
             * Stop double click while AJAX
             * request is running
             */

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



                /*
                 * =========================================
                 * LOGIN REQUIRED
                 * =========================================
                 */

                if (response.status === 401) {


                    window.location.href =
                            "${pageContext.request.contextPath}/login";


                    return;

                }



                const data =
                        await response.json();



                /*
                 * =========================================
                 * ERROR
                 * =========================================
                 */

                if (!response.ok
                        || !data.success) {


                    console.error(
                        "Wishlist update failed:",
                        data
                    );


                    return;

                }



                /*
                 * =========================================
                 * ADDED TO WISHLIST
                 * =========================================
                 */

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



                /*
                 * =========================================
                 * REMOVED FROM WISHLIST
                 * =========================================
                 */

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