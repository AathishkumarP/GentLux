<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.WishlistItemView" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Wishlist | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/wishlist.css">


    <style>

        /* =========================================================
           WISHLIST PAGE
        ========================================================== */

        .wishlist-page {
            background: #faf9f7;
            min-height: 75vh;
            padding: 70px 0 90px;
        }


        .wishlist-container {
            width: min(1240px, calc(100% - 60px));
            margin: 0 auto;
        }


        /* =========================================================
           HEADER
        ========================================================== */

        .wishlist-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 40px;

            margin-bottom: 48px;

            padding-bottom: 30px;

            border-bottom: 1px solid #ded9d4;
        }


        .wishlist-small-title {
            margin: 0 0 10px;

            font-size: 11px;
            font-weight: 600;

            letter-spacing: 3px;

            color: #8a7569;
        }


        .wishlist-header h1 {
            margin: 0;

            font-family: Georgia, "Times New Roman", serif;

            font-size: 42px;
            font-weight: 500;

            line-height: 1.1;

            color: #211815;
        }


        .wishlist-subtitle {
            max-width: 500px;

            margin: 12px 0 0;

            font-size: 14px;
            line-height: 1.7;

            color: #756c67;
        }


        /* =========================================================
           HEADER ACTIONS
        ========================================================== */

        .wishlist-header-actions {
            display: flex;
            align-items: center;
            gap: 14px;
            flex-shrink: 0;
        }


        .wishlist-count-box {
            min-width: 72px;
            height: 64px;

            padding: 0 14px;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

            background: #ffffff;

            border: 1px solid #ded8d3;
        }


        .wishlist-count-number {
            font-family: Georgia, "Times New Roman", serif;

            font-size: 21px;
            font-weight: 600;

            color: #2f211b;

            line-height: 1;
        }


        .wishlist-count-text {
            margin-top: 6px;

            font-size: 8px;
            font-weight: 600;

            letter-spacing: 2px;

            color: #89786f;
        }


        .clear-wishlist-btn {
            height: 46px;

            padding: 0 20px;

            background: transparent !important;

            border: 1px solid #6c5144 !important;

            color: #38251e !important;

            font-size: 9px;
            font-weight: 700;

            letter-spacing: 1.5px;

            cursor: pointer;

            transition:
                background 0.25s ease,
                color 0.25s ease;
        }


        .clear-wishlist-btn:hover {
            background: #38251e !important;
            color: #ffffff !important;
        }


        .clear-wishlist-btn:disabled {
            opacity: 0.55;
            cursor: wait;
        }


        /* =========================================================
           PRODUCT GRID
        ========================================================== */

        .wishlist-grid {
            display: grid;

            grid-template-columns:
                repeat(4, minmax(0, 1fr));

            gap: 26px;
        }


        /* =========================================================
           PRODUCT CARD
        ========================================================== */

        .wishlist-card {
            min-width: 0;

            background: #ffffff;

            border: 1px solid #ebe6e2;

            overflow: hidden;

            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease;
        }


        .wishlist-card:hover {
            transform: translateY(-4px);

            box-shadow:
                0 12px 28px
                rgba(56, 37, 30, 0.08);
        }


        /* =========================================================
           PRODUCT IMAGE
        ========================================================== */

        .wishlist-image-wrapper {
            position: relative;

            width: 100%;
            height: 330px;

            overflow: hidden;

            background: #f2f0ed;
        }


        .wishlist-image-wrapper > a {
            display: block;

            width: 100%;
            height: 100%;
        }


        .wishlist-product-image {
            display: block;

            width: 100% !important;
            height: 100% !important;

            object-fit: cover;

            transition: transform 0.45s ease;
        }


        .wishlist-card:hover
        .wishlist-product-image {
            transform: scale(1.025);
        }


        .product-image-placeholder {
            width: 100%;
            height: 100%;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f0eeeb;

            color: #a5968e;

            font-size: 11px;
            font-weight: 600;

            letter-spacing: 3px;
        }


        /* =========================================================
           REMOVE HEART
        ========================================================== */

        .wishlist-remove-btn {
            position: absolute !important;

            top: 16px !important;
            right: 16px !important;

            width: 36px !important;
            height: 36px !important;

            padding: 0 !important;
            margin: 0 !important;

            display: flex !important;
            align-items: center !important;
            justify-content: center !important;

            background: transparent !important;

            border: none !important;
            border-radius: 0 !important;

            outline: none !important;

            box-shadow: none !important;

            cursor: pointer;

            z-index: 30;

            appearance: none;
            -webkit-appearance: none;

            transition:
                transform 0.2s ease,
                opacity 0.2s ease;
        }


        .wishlist-remove-btn
        .wishlist-remove-heart {
            width: 27px;
            height: 27px;

            fill: #38251e;

            stroke: #38251e;

            stroke-width: 1.8;

            stroke-linecap: round;
            stroke-linejoin: round;

            pointer-events: none;

            filter:
                drop-shadow(
                    0 1px 1px
                    rgba(255, 255, 255, 0.95)
                );

            transition:
                transform 0.2s ease,
                fill 0.2s ease;
        }


        .wishlist-remove-btn:hover {
            background: transparent !important;

            transform: scale(1.13);
        }


        .wishlist-remove-btn:hover
        .wishlist-remove-heart {
            transform: scale(1.05);
        }


        .wishlist-remove-btn:active {
            transform: scale(0.92);
        }


        .wishlist-remove-btn:focus,
        .wishlist-remove-btn:focus-visible {
            outline: none !important;
            box-shadow: none !important;
        }


        .wishlist-remove-btn:disabled {
            opacity: 0.45;
            cursor: wait;
        }


        /* =========================================================
           DISCOUNT
        ========================================================== */

        .wishlist-discount {
            position: absolute;

            left: 14px;
            bottom: 14px;

            padding: 7px 10px;

            background: #2d211c;

            color: #ffffff;

            font-size: 9px;
            font-weight: 700;

            letter-spacing: 1px;

            z-index: 5;
        }


        /* =========================================================
           PRODUCT INFO
        ========================================================== */

        .wishlist-product-info {
            padding: 20px 20px 22px;
        }


        .wishlist-brand {
            margin: 0 0 8px;

            color: #8a7569;

            font-size: 9px;
            font-weight: 700;

            letter-spacing: 2px;

            text-transform: uppercase;
        }


        .wishlist-product-name {
            display: block;

            margin-bottom: 13px;

            color: #2a1d18;

            font-family: Georgia, "Times New Roman", serif;

            font-size: 17px;
            line-height: 1.35;

            text-decoration: none;
        }


        .wishlist-product-name:hover {
            color: #795c4d;
        }


        /* =========================================================
           PRICE
        ========================================================== */

        .wishlist-price {
            display: flex;
            align-items: center;
            gap: 10px;

            margin-bottom: 18px;
        }


        .wishlist-current-price {
            color: #2a1d18;

            font-size: 16px;
            font-weight: 600;
        }


        .wishlist-mrp {
            color: #a29a95;

            font-size: 12px;

            text-decoration: line-through;
        }


        /* =========================================================
           PRODUCT BUTTON
        ========================================================== */

        .wishlist-view-btn {
            width: 100%;

            min-height: 44px;

            display: flex;
            align-items: center;
            justify-content: center;

            box-sizing: border-box;

            background: #38251e;

            border: 1px solid #38251e;

            color: #ffffff;

            text-decoration: none;

            font-size: 9px;
            font-weight: 700;

            letter-spacing: 1.4px;

            transition:
                background 0.25s ease,
                color 0.25s ease;
        }


        .wishlist-view-btn:hover {
            background: #ffffff;

            color: #38251e;
        }


        /* =========================================================
           EMPTY WISHLIST
        ========================================================== */

        .empty-wishlist {
            max-width: 520px;

            margin: 70px auto;

            padding: 50px 30px;

            text-align: center;
        }


        .empty-heart {
            margin-bottom: 20px;

            font-size: 42px;

            color: #38251e;
        }


        .empty-wishlist h2 {
            margin: 0 0 12px;

            font-family: Georgia, "Times New Roman", serif;

            font-size: 30px;
            font-weight: 500;

            color: #2a1d18;
        }


        .empty-wishlist p {
            margin: 0 auto 28px;

            color: #7e736d;

            font-size: 14px;

            line-height: 1.7;
        }


        .continue-shopping-btn {
            min-height: 46px;

            padding: 0 28px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            background: #38251e;

            color: #ffffff;

            text-decoration: none;

            font-size: 9px;
            font-weight: 700;

            letter-spacing: 1.5px;
        }


        /* =========================================================
           RESPONSIVE
        ========================================================== */

        @media (max-width: 1050px) {

            .wishlist-grid {
                grid-template-columns:
                    repeat(3, minmax(0, 1fr));
            }

        }


        @media (max-width: 780px) {

            .wishlist-page {
                padding-top: 45px;
            }


            .wishlist-container {
                width: min(
                    100% - 30px,
                    1240px
                );
            }


            .wishlist-header {
                align-items: flex-start;
                flex-direction: column;
            }


            .wishlist-header h1 {
                font-size: 35px;
            }


            .wishlist-grid {
                grid-template-columns:
                    repeat(2, minmax(0, 1fr));

                gap: 16px;
            }


            .wishlist-image-wrapper {
                height: 280px;
            }

        }


        @media (max-width: 520px) {

            .wishlist-grid {
                grid-template-columns: 1fr;
            }


            .wishlist-image-wrapper {
                height: 400px;
            }

        }

    </style>


</head>


<body>


<%

    List<WishlistItemView> wishlistItems =
            (List<WishlistItemView>)
            request.getAttribute("wishlistItems");


    Integer wishlistCountAttribute =
            (Integer)
            request.getAttribute("wishlistCount");


    int wishlistCount =
            wishlistCountAttribute != null

                    ? wishlistCountAttribute

                    : (wishlistItems != null
                        ? wishlistItems.size()
                        : 0);

%>



<!-- =========================================================
     NAVBAR
========================================================== -->

<jsp:include page="partials/nav.jsp" />



<!-- =========================================================
     WISHLIST
========================================================== -->

<main class="wishlist-page">


    <div class="wishlist-container">



        <!-- =====================================================
             HEADER
        ====================================================== -->

        <div class="wishlist-header">


            <div>


                <p class="wishlist-small-title">

                    YOUR COLLECTION

                </p>


                <h1>

                    My Wishlist

                </h1>


                <p class="wishlist-subtitle">

                    Save the pieces you love and return
                    to them whenever you are ready.

                </p>


            </div>



            <% if (wishlistCount > 0) { %>


                <div class="wishlist-header-actions">


                    <div class="wishlist-count-box"
                         id="wishlistCountBox">


                        <span class="wishlist-count-number"
                              id="wishlistCountNumber">

                            <%= wishlistCount %>

                        </span>


                        <span class="wishlist-count-text">

                            ITEMS

                        </span>


                    </div>



                    <button
                        type="button"

                        class="clear-wishlist-btn"

                        id="clearWishlistButton"

                        onclick="clearWishlist()">

                        CLEAR WISHLIST

                    </button>


                </div>


            <% } %>


        </div>



        <!-- =====================================================
             EMPTY WISHLIST
        ====================================================== -->

        <div id="emptyWishlistContainer">


<%

    if (wishlistItems == null
            || wishlistItems.isEmpty()) {

%>


            <div class="empty-wishlist">


                <div class="empty-heart">

                    ♡

                </div>


                <h2>

                    Your wishlist is empty

                </h2>


                <p>

                    Discover refined pieces and save
                    your favourites here.

                </p>


                <a
                    href="${pageContext.request.contextPath}/products"

                    class="continue-shopping-btn">

                    EXPLORE COLLECTION

                </a>


            </div>


<%

    }

%>


        </div>



        <!-- =====================================================
             WISHLIST PRODUCTS
        ====================================================== -->

<%

    if (wishlistItems != null
            && !wishlistItems.isEmpty()) {

%>


        <div class="wishlist-grid"
             id="wishlistGrid">


<%

    for (WishlistItemView item
            : wishlistItems) {


        /*
         * =============================================
         * NORMALIZE IMAGE URL
         * =============================================
         *
         * Some product image values may already contain
         * the application context or may be absolute URLs.
         */

        String imageUrl =
                item.getImageUrl();


        String finalImageUrl = "";


        if (imageUrl != null
                && !imageUrl.trim().isEmpty()) {


            imageUrl =
                    imageUrl.trim();


            if (imageUrl.startsWith("http://")
                    || imageUrl.startsWith("https://")
                    || imageUrl.startsWith("//")) {


                finalImageUrl =
                        imageUrl;


            } else if (
                    imageUrl.startsWith(
                        request.getContextPath() + "/"
                    )
            ) {


                finalImageUrl =
                        imageUrl;


            } else if (
                    imageUrl.startsWith("/")
            ) {


                finalImageUrl =
                        request.getContextPath()
                        + imageUrl;


            } else {


                finalImageUrl =
                        request.getContextPath()
                        + "/"
                        + imageUrl;


            }


        }

%>



            <article class="wishlist-card">



                <!-- =================================================
                     IMAGE
                ================================================== -->

                <div class="wishlist-image-wrapper">



                    <a
                        href="${pageContext.request.contextPath}/product-details?id=<%= item.getProductId() %>">


<%

    if (!finalImageUrl.isEmpty()) {

%>


                        <img
                            src="<%= finalImageUrl %>"

                            alt="<%= item.getProductName() %>"

                            class="wishlist-product-image">


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



                    <!-- =================================================
                         SINGLE PRODUCT REMOVE HEART
                    ================================================== -->

                    <button
                        type="button"

                        class="wishlist-remove-btn"

                        data-product-id="<%= item.getProductId() %>"

                        onclick="removeWishlistItem(this)"

                        title="Remove from wishlist"

                        aria-label="Remove <%= item.getProductName() %> from wishlist">


                        <!--
                            Filled heart because this product
                            is already inside the Wishlist.
                        -->

                        <svg
                            class="wishlist-remove-heart"

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



                    <!-- =================================================
                         DISCOUNT
                    ================================================== -->

                    <% if (item.getDiscount() > 0) { %>


                        <span class="wishlist-discount">


                            <%= String.format(
                                    "%.0f",
                                    item.getDiscount()
                            ) %>% OFF


                        </span>


                    <% } %>


                </div>



                <!-- =================================================
                     PRODUCT INFORMATION
                ================================================== -->

                <div class="wishlist-product-info">



                    <p class="wishlist-brand">

                        <%= item.getBrand() %>

                    </p>



                    <a
                        href="${pageContext.request.contextPath}/product-details?id=<%= item.getProductId() %>"

                        class="wishlist-product-name">


                        <%= item.getProductName() %>


                    </a>



                    <!-- PRICE -->

                    <div class="wishlist-price">


                        <span class="wishlist-current-price">


                            ₹<%= String.format(
                                    "%.0f",
                                    item.getPrice()
                            ) %>


                        </span>



<%

    if (item.getMrp()
            > item.getPrice()) {

%>


                        <span class="wishlist-mrp">


                            ₹<%= String.format(
                                    "%.0f",
                                    item.getMrp()
                            ) %>


                        </span>


<%

    }

%>


                    </div>



                    <!--
                        Wishlist contains Product ID only.

                        Cart requires Variant ID / Size.

                        Therefore user selects the size
                        on Product Details.
                    -->

                    <a
                        href="${pageContext.request.contextPath}/product-details?id=<%= item.getProductId() %>"

                        class="wishlist-view-btn">


                        SELECT SIZE &amp; ADD TO CART


                    </a>


                </div>


            </article>


<%

    }

%>


        </div>


<%

    }

%>


    </div>


</main>



<!-- =========================================================
     FOOTER
========================================================== -->

<jsp:include page="partials/footer.jsp" />



<!-- =========================================================
     REMOVE ONE PRODUCT
========================================================== -->

<script>


async function removeWishlistItem(button) {


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



        /* LOGIN REQUIRED */

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
                "Wishlist remove failed:",
                data
            );


            button.disabled =
                false;


            return;

        }



        /*
         * Product successfully removed.
         */

        if (!data.inWishlist) {


            const card =
                button.closest(
                    ".wishlist-card"
                );


            if (card) {


                card.style.transition =
                    "opacity 0.25s ease, "
                    + "transform 0.25s ease";


                card.style.opacity =
                    "0";


                card.style.transform =
                    "translateY(8px) scale(0.97)";


                setTimeout(
                    function() {


                        card.remove();


                        updateWishlistCount();


                    },
                    250
                );


            }


        } else {


            console.error(
                "Product was not removed."
            );


            button.disabled =
                false;


        }



    } catch (error) {


        console.error(
            "Wishlist error:",
            error
        );


        button.disabled =
            false;


    }


}



/* =========================================================
   CLEAR ENTIRE WISHLIST
========================================================= */

async function clearWishlist() {


    const button =
        document.getElementById(
            "clearWishlistButton"
        );


    if (!button) {

        return;

    }



    const confirmed =
        confirm(
            "Are you sure you want to clear your wishlist?"
        );


    if (!confirmed) {

        return;

    }



    button.disabled =
        true;


    button.textContent =
        "CLEARING...";



    try {


        const response =
            await fetch(

                "${pageContext.request.contextPath}/clear-wishlist",

                {
                    method: "POST"
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
                "Clear wishlist failed:",
                data
            );


            button.disabled =
                false;


            button.textContent =
                "CLEAR WISHLIST";


            return;

        }



        const grid =
            document.getElementById(
                "wishlistGrid"
            );


        if (grid) {


            grid.style.transition =
                "opacity 0.25s ease, "
                + "transform 0.25s ease";


            grid.style.opacity =
                "0";


            grid.style.transform =
                "scale(0.98)";


            setTimeout(
                function() {


                    grid.remove();


                    showEmptyWishlist();


                },
                250
            );


        } else {


            showEmptyWishlist();


        }



    } catch (error) {


        console.error(
            "Wishlist error:",
            error
        );


        button.disabled =
            false;


        button.textContent =
            "CLEAR WISHLIST";


    }


}



/* =========================================================
   UPDATE COUNT AFTER SINGLE REMOVE
========================================================= */

function updateWishlistCount() {


    const cards =
        document.querySelectorAll(
            ".wishlist-card"
        );


    const count =
        cards.length;



    const countNumber =
        document.getElementById(
            "wishlistCountNumber"
        );


    if (countNumber) {


        countNumber.textContent =
            count;


    }



    if (count === 0) {


        const grid =
            document.getElementById(
                "wishlistGrid"
            );


        if (grid) {

            grid.remove();

        }


        showEmptyWishlist();


    }


}



/* =========================================================
   EMPTY WISHLIST UI
========================================================= */

function showEmptyWishlist() {


    const actions =
        document.querySelector(
            ".wishlist-header-actions"
        );


    if (actions) {

        actions.remove();

    }



    const emptyContainer =
        document.getElementById(
            "emptyWishlistContainer"
        );


    if (emptyContainer) {


        emptyContainer.innerHTML = `

            <div class="empty-wishlist">

                <div class="empty-heart">
                    ♡
                </div>

                <h2>
                    Your wishlist is empty
                </h2>

                <p>
                    Discover refined pieces and save
                    your favourites here.
                </p>

                <a
                    href="${pageContext.request.contextPath}/products"
                    class="continue-shopping-btn">

                    EXPLORE COLLECTION

                </a>

            </div>

        `;


    }


}


</script>


</body>

</html>