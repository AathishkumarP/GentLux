<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.ProductVariant" %>
<%@ page import="com.gentlux.model.Product" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>${product.productName} | GENTLUX</title>


    <!-- MAIN CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">


    <!-- WISHLIST CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/wishlist.css">


    <!-- =========================================================
         PRODUCT DETAILS PAGE STYLES
         ========================================================= -->

    <style>

        /* =========================================================
           PRODUCT WISHLIST SECTION
           ========================================================= */

        .product-wishlist-section {
            margin-top: 16px;

            /*
             * Important:
             * Keep the container transparent so hovering over the
             * wishlist area does not change the whole row.
             */
            background: transparent !important;
        }


        /*
         * This selector is intentionally more specific than the
         * general button styles in style.css / wishlist.css.
         */
        button.add-to-wishlist-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;

            width: auto !important;
            min-height: 46px;

            padding: 0 22px;

            background: transparent !important;
            background-color: transparent !important;

            border: none !important;
            box-shadow: none !important;

            color: #38251e !important;

            cursor: pointer;
            font-family: inherit;

            transition:
                opacity 0.25s ease,
                transform 0.25s ease;

            appearance: none;
            -webkit-appearance: none;
        }


        /* =========================================================
           SVG HEART
           ========================================================= */

        button.add-to-wishlist-button
        .product-wishlist-heart {

            width: 24px;
            height: 24px;

            flex-shrink: 0;

            fill: transparent;
            stroke: #38251e;

            stroke-width: 1.8;
            stroke-linecap: round;
            stroke-linejoin: round;

            pointer-events: none;

            transition:
                fill 0.25s ease,
                stroke 0.25s ease,
                transform 0.25s ease;
        }


        /* =========================================================
           WISHLIST TEXT
           ========================================================= */

        button.add-to-wishlist-button
        .wishlist-text {

            font-size: 11px;
            font-weight: 600;

            letter-spacing: 1.2px;

            color: #38251e !important;

            pointer-events: none;
        }


        /* =========================================================
           WISHLIST HOVER FIX

           Prevent general/global button:hover styles from changing
           the entire wishlist button background.
           ========================================================= */

        button.add-to-wishlist-button:hover,
        button.add-to-wishlist-button:active,
        button.add-to-wishlist-button:focus,
        button.add-to-wishlist-button:focus-visible {

            background: transparent !important;
            background-color: transparent !important;

            color: #38251e !important;

            border: none !important;

            box-shadow: none !important;

            outline: none !important;
        }


        /*
         * Only animate the heart on hover.
         */
        button.add-to-wishlist-button:hover
        .product-wishlist-heart {

            transform: scale(1.12);

            stroke: #38251e;
        }


        /*
         * Keep the text color stable during hover.
         */
        button.add-to-wishlist-button:hover
        .wishlist-text {

            color: #38251e !important;
        }


        /* =========================================================
           ACTIVE / SAVED WISHLIST
           ========================================================= */

        button.add-to-wishlist-button.wishlist-active
        .product-wishlist-heart {

            fill: #38251e;
            stroke: #38251e;
        }


        button.add-to-wishlist-button.wishlist-active:hover {

            background: transparent !important;
            background-color: transparent !important;
        }


        /* =========================================================
           FOCUS
           ========================================================= */

        button.add-to-wishlist-button:focus,
        button.add-to-wishlist-button:focus-visible {

            outline: none !important;
            box-shadow: none !important;
        }


        /* =========================================================
           AJAX PROCESSING
           ========================================================= */

        button.add-to-wishlist-button:disabled {

            opacity: 0.55;

            cursor: wait;

            background: transparent !important;
            background-color: transparent !important;
        }


        /* =========================================================
           PRODUCT IMAGE
           ========================================================= */

        .product-details-main-image {

            width: 100%;

            overflow: hidden;
        }


        .product-details-real-image {

            display: block;

            width: 100%;
            height: 100%;

            object-fit: cover;
        }


        .product-details-image-placeholder {

            width: 100%;
            min-height: 550px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f1ece8;

            color: #38251e;

            font-size: 22px;
            font-weight: 600;

            letter-spacing: 5px;
        }

    </style>

</head>


<body>


<%

    String cartStatus =
            request.getParameter("cartStatus");


    Boolean inWishlist =
            (Boolean)
            request.getAttribute("inWishlist");


    boolean productInWishlist =
            inWishlist != null
            && inWishlist;

%>


<!-- =========================================================
     CART SUCCESS MESSAGE
     ========================================================= -->

<% if ("added".equals(cartStatus)) { %>

    <div class="cart-toast cart-toast-success"
         id="cartToast">

        <div class="cart-toast-icon">
            ✓
        </div>

        <div class="cart-toast-content">

            <strong>
                ADDED TO CART
            </strong>

            <span>
                Your item has been added successfully.
            </span>

        </div>

        <button type="button"
                class="cart-toast-close"
                onclick="closeCartToast()">

            ×

        </button>

    </div>

<% } %>


<!-- =========================================================
     OUT OF STOCK MESSAGE
     ========================================================= -->

<% if ("outOfStock".equals(cartStatus)) { %>

    <div class="cart-toast cart-toast-error"
         id="cartToast">

        <div class="cart-toast-icon">
            !
        </div>

        <div class="cart-toast-content">

            <strong>
                OUT OF STOCK
            </strong>

            <span>
                This product is currently unavailable.
            </span>

        </div>

        <button type="button"
                class="cart-toast-close"
                onclick="closeCartToast()">

            ×

        </button>

    </div>

<% } %>


<!-- =========================================================
     NAVBAR
     ========================================================= -->

<jsp:include page="partials/nav.jsp" />


<!-- =========================================================
     MAIN
     ========================================================= -->

<main>


    <!-- =====================================================
         PRODUCT DETAILS
         ===================================================== -->

    <section class="product-details-section">


        <!-- =================================================
             PRODUCT IMAGE
             ================================================= -->

        <div class="product-details-image">

            <div class="product-details-main-image">

                <%

                    Product currentProduct =
                            (Product)
                            request.getAttribute("product");


                    String productImageUrl =
                            currentProduct != null
                                    ? currentProduct.getImageUrl()
                                    : null;


                    boolean hasProductImage =
                            productImageUrl != null
                            && !productImageUrl.trim().isEmpty();


                    if (hasProductImage) {

                        productImageUrl =
                                productImageUrl.trim();


                        String finalProductImageUrl;


                        if (productImageUrl.startsWith("http://")
                                || productImageUrl.startsWith("https://")) {

                            finalProductImageUrl =
                                    productImageUrl;

                        } else {

                            if (productImageUrl.startsWith("/")) {

                                productImageUrl =
                                        productImageUrl.substring(1);
                            }


                            finalProductImageUrl =
                                    request.getContextPath()
                                    + "/"
                                    + productImageUrl;
                        }

                %>

                    <img
                        src="<%= finalProductImageUrl %>"
                        alt="<%= currentProduct.getProductName() %>"
                        class="product-details-real-image"
                        loading="lazy"
                        onerror="
                            this.style.display='none';
                            this.nextElementSibling.style.display='flex';
                        ">


                    <div
                        class="product-details-image-placeholder"
                        style="display:none;">

                        <span>
                            GENTLUX
                        </span>

                    </div>


                <%

                    } else {

                %>

                    <div class="product-details-image-placeholder">

                        <span>
                            GENTLUX
                        </span>

                    </div>

                <%

                    }

                %>

            </div>

        </div>


        <!-- =================================================
             PRODUCT INFORMATION
             ================================================= -->

        <div class="product-details-info">


            <!-- BRAND -->

            <p class="product-details-brand">

                ${product.brand}

            </p>


            <!-- PRODUCT NAME -->

            <h1 class="product-details-title">

                ${product.productName}

            </h1>


            <!-- RATING -->

            <div class="product-details-rating">

                ★★★★★

                <span>
                    4.8 (124 Reviews)
                </span>

            </div>


            <!-- =================================================
                 PRICE
                 ================================================= -->

            <div class="product-details-price">

                <span class="current-price">

                    ₹${product.price}

                </span>


                <span class="original-price">

                    ₹${product.mrp}

                </span>


                <span class="discount">

                    ${product.discount}% OFF

                </span>

            </div>


            <!-- DESCRIPTION -->

            <p class="product-details-description">

                ${product.description}

            </p>


            <div class="product-details-divider">
            </div>


            <!-- =================================================
                 SIZE SELECTION
                 ================================================= -->

            <div class="product-size-section">


                <div class="size-heading">

                    <h3>
                        SELECT SIZE
                    </h3>


                    <a href="#">
                        Size Guide
                    </a>

                </div>


                <div class="size-options">


<%

    List<ProductVariant> variants =
            (List<ProductVariant>)
            request.getAttribute("variants");


    if (variants != null
            && !variants.isEmpty()) {


        for (ProductVariant variant : variants) {

%>


                    <button
                        type="button"
                        class="size-button"
                        data-variant-id="<%= variant.getVariantId() %>"
                        data-stock="<%= variant.getStockQuantity() %>"
                        onclick="selectProductVariant(this)"
                        <%= variant.getStockQuantity() == 0
                                ? "disabled"
                                : "" %>>

                        <%= variant.getSize() %>

                    </button>


<%

        }

    } else {

%>


                    <p class="no-variants-message">

                        No sizes available for this product.

                    </p>


<%

    }

%>


                </div>

            </div>


            <!-- =================================================
                 QUANTITY
                 ================================================= -->

            <div class="quantity-section">


                <h3>
                    QUANTITY
                </h3>


                <div class="quantity-control">


                    <button
                        type="button"
                        class="quantity-minus">

                        −

                    </button>


                    <span id="productQuantity">

                        1

                    </span>


                    <button
                        type="button"
                        class="quantity-plus">

                        +

                    </button>


                </div>

            </div>


            <!-- =================================================
                 ACTION BUTTONS
                 ================================================= -->

            <div class="product-details-actions">


                <!-- ADD TO CART -->

                <form
                    id="addToCartForm"
                    action="${pageContext.request.contextPath}/add-to-cart"
                    method="post">


                    <input
                        type="hidden"
                        name="variantId"
                        id="selectedVariantId">


                    <input
                        type="hidden"
                        name="quantity"
                        id="selectedQuantity"
                        value="1">


                    <button
                        type="submit"
                        class="add-to-cart-button">

                        ADD TO CART

                    </button>


                </form>


                <!-- BUY NOW -->

                <form
                    id="buyNowForm"
                    action="${pageContext.request.contextPath}/buy-now"
                    method="post">


                    <input
                        type="hidden"
                        name="variantId"
                        id="buyNowVariantId">


                    <input
                        type="hidden"
                        name="quantity"
                        id="buyNowQuantity"
                        value="1">


                    <button
                        type="submit"
                        class="buy-now-button">

                        BUY NOW

                    </button>


                </form>


            </div>


            <!-- =================================================
                 AJAX WISHLIST
                 ================================================= -->

            <div class="product-wishlist-section">


                <button
                    type="button"
                    id="productWishlistButton"
                    class="add-to-wishlist-button <%= productInWishlist
                            ? "wishlist-active"
                            : "" %>"
                    data-product-id="${product.productId}"
                    data-in-wishlist="<%= productInWishlist %>"
                    onclick="toggleProductWishlist(this)"
                    title="<%= productInWishlist
                            ? "Remove from wishlist"
                            : "Add to wishlist" %>"
                    aria-label="<%= productInWishlist
                            ? "Remove from wishlist"
                            : "Add to wishlist" %>">


                    <svg
                        class="product-wishlist-heart"
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


                    <span class="wishlist-text">

                        <%= productInWishlist
                                ? "IN WISHLIST — REMOVE"
                                : "ADD TO WISHLIST" %>

                    </span>


                </button>


            </div>


            <!-- =================================================
                 PRODUCT FEATURES
                 ================================================= -->

            <div class="product-features">


                <div class="product-feature">


                    <span class="feature-icon">
                        ✓
                    </span>


                    <div>

                        <strong>
                            Premium Quality
                        </strong>

                        <p>
                            Carefully selected materials
                        </p>

                    </div>


                </div>


                <div class="product-feature">


                    <span class="feature-icon">
                        ✓
                    </span>


                    <div>

                        <strong>
                            Easy Returns
                        </strong>

                        <p>
                            Hassle-free returns
                        </p>

                    </div>


                </div>


                <div class="product-feature">


                    <span class="feature-icon">
                        ✓
                    </span>


                    <div>

                        <strong>
                            Secure Payment
                        </strong>

                        <p>
                            100% secure checkout
                        </p>

                    </div>


                </div>


            </div>


        </div>


    </section>


    <!-- =====================================================
         PRODUCT DESCRIPTION
         ===================================================== -->

    <section class="product-description-section">


        <div class="section-heading">


            <p class="section-subtitle">
                DETAILS
            </p>


            <h2>
                PRODUCT DESCRIPTION
            </h2>


        </div>


        <div class="product-description-content">


            <p>
                ${product.description}
            </p>


            <p>

                <strong>
                    Brand:
                </strong>

                ${product.brand}

            </p>


            <p>

                <strong>
                    Color:
                </strong>

                ${product.color}

            </p>


        </div>


    </section>


</main>


<!-- =========================================================
     FOOTER
     ========================================================= -->

<jsp:include page="partials/footer.jsp" />


<!-- =========================================================
     PRODUCT VARIANT SELECTION
     ========================================================= -->

<script>

function selectProductVariant(button) {


    const variantId =
        button.getAttribute(
            "data-variant-id"
        );


    /* ADD TO CART */

    const cartVariantInput =
        document.getElementById(
            "selectedVariantId"
        );


    if (cartVariantInput) {

        cartVariantInput.value =
            variantId;
    }


    /* BUY NOW */

    const buyNowVariantInput =
        document.getElementById(
            "buyNowVariantId"
        );


    if (buyNowVariantInput) {

        buyNowVariantInput.value =
            variantId;
    }


    /* REMOVE OLD SELECTION */

    document
        .querySelectorAll(".size-button")
        .forEach(function(sizeButton) {

            sizeButton.classList.remove(
                "selected"
            );

        });


    /* SELECT CURRENT SIZE */

    button.classList.add(
        "selected"
    );

}

</script>


<!-- =========================================================
     EXISTING PRODUCT DETAILS JAVASCRIPT
     ========================================================= -->

<script
    src="${pageContext.request.contextPath}/assets/js/product-details.js">
</script>


<!-- =========================================================
     CART TOAST
     ========================================================= -->

<script>


const cartToast =
    document.getElementById(
        "cartToast"
    );


function closeCartToast() {


    if (cartToast) {


        cartToast.classList.add(
            "cart-toast-hide"
        );


        setTimeout(function() {

            cartToast.remove();

        }, 350);


    }

}


if (cartToast) {


    setTimeout(function() {

        closeCartToast();

    }, 3500);


}


</script>


<!-- =========================================================
     AJAX WISHLIST
     ========================================================= -->

<script>


async function toggleProductWishlist(button) {


    /*
     * Prevent double click
     */

    if (button.disabled) {

        return;
    }


    button.disabled = true;


    const productId =
        button.getAttribute(
            "data-product-id"
        );


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


        /* =========================================
           LOGIN REQUIRED
           ========================================= */

        if (response.status === 401) {


            window.location.href =
                "${pageContext.request.contextPath}/login";


            return;
        }


        const data =
            await response.json();


        /* =========================================
           ERROR
           ========================================= */

        if (!response.ok
                || !data.success) {


            console.error(

                "Wishlist update failed:",

                data

            );


            return;
        }


        const text =
            button.querySelector(
                ".wishlist-text"
            );


        /* =========================================
           ADDED TO WISHLIST
           ========================================= */

        if (data.inWishlist) {


            button.classList.add(
                "wishlist-active"
            );


            button.setAttribute(
                "data-in-wishlist",
                "true"
            );


            button.setAttribute(
                "title",
                "Remove from wishlist"
            );


            button.setAttribute(
                "aria-label",
                "Remove from wishlist"
            );


            if (text) {


                text.textContent =
                    "IN WISHLIST — REMOVE";


            }


        }


        /* =========================================
           REMOVED FROM WISHLIST
           ========================================= */

        else {


            button.classList.remove(
                "wishlist-active"
            );


            button.setAttribute(
                "data-in-wishlist",
                "false"
            );


            button.setAttribute(
                "title",
                "Add to wishlist"
            );


            button.setAttribute(
                "aria-label",
                "Add to wishlist"
            );


            if (text) {


                text.textContent =
                    "ADD TO WISHLIST";


            }


        }


    } catch (error) {


        console.error(

            "Wishlist error:",

            error

        );


    } finally {


        button.disabled =
            false;


    }


}


</script>


</body>

</html>