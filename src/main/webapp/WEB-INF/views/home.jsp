<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>GENTLUX | Men's Fashion</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

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

        <p class="hero-subtitle" id="heroSubtitle">
            MEN'S FASHION
        </p>

        <h1 id="heroTitle">
            ELEVATE<br>
            YOUR STYLE
        </h1>

        <p class="hero-description" id="heroDescription">
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


</body>

</html>