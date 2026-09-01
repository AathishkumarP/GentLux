<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.ProductVariant" %>

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

</head>


<body>


<%
    String cartStatus =
            request.getParameter("cartStatus");

    String wishlistStatus =
            request.getParameter("wishlistStatus");
%>



<!-- =========================================================
     CART - ADDED SUCCESS
========================================================== -->

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
     CART - OUT OF STOCK
========================================================== -->

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
     WISHLIST - ADDED
========================================================== -->

<% if ("added".equals(wishlistStatus)) { %>

    <div class="cart-toast cart-toast-success"
         id="wishlistToast">

        <div class="cart-toast-icon">
            ♡
        </div>

        <div class="cart-toast-content">

            <strong>
                ADDED TO WISHLIST
            </strong>

            <span>
                This product has been saved to your wishlist.
            </span>

        </div>

        <button type="button"
                class="cart-toast-close"
                onclick="closeWishlistToast()">

            ×

        </button>

    </div>

<% } %>



<!-- =========================================================
     WISHLIST - ALREADY EXISTS
========================================================== -->

<% if ("exists".equals(wishlistStatus)) { %>

    <div class="cart-toast cart-toast-success"
         id="wishlistToast">

        <div class="cart-toast-icon">
            ♥
        </div>

        <div class="cart-toast-content">

            <strong>
                ALREADY IN WISHLIST
            </strong>

            <span>
                This product is already saved in your wishlist.
            </span>

        </div>

        <button type="button"
                class="cart-toast-close"
                onclick="closeWishlistToast()">

            ×

        </button>

    </div>

<% } %>



<!-- =========================================================
     WISHLIST - REMOVED
========================================================== -->

<% if ("removed".equals(wishlistStatus)) { %>

    <div class="cart-toast cart-toast-success"
         id="wishlistToast">

        <div class="cart-toast-icon">
            ✓
        </div>

        <div class="cart-toast-content">

            <strong>
                REMOVED FROM WISHLIST
            </strong>

            <span>
                This product has been removed from your wishlist.
            </span>

        </div>

        <button type="button"
                class="cart-toast-close"
                onclick="closeWishlistToast()">

            ×

        </button>

    </div>

<% } %>



<!-- =========================================================
     WISHLIST - ERROR
========================================================== -->

<% if ("error".equals(wishlistStatus)) { %>

    <div class="cart-toast cart-toast-error"
         id="wishlistToast">

        <div class="cart-toast-icon">
            !
        </div>

        <div class="cart-toast-content">

            <strong>
                UNABLE TO ADD
            </strong>

            <span>
                Something went wrong while adding this product.
            </span>

        </div>

        <button type="button"
                class="cart-toast-close"
                onclick="closeWishlistToast()">

            ×

        </button>

    </div>

<% } %>



<!-- =========================================================
     NAVBAR
========================================================== -->

<jsp:include page="partials/nav.jsp" />



<!-- =========================================================
     MAIN
========================================================== -->

<main>



    <!-- =====================================================
         PRODUCT DETAILS
    ====================================================== -->

    <section class="product-details-section">



        <!-- PRODUCT IMAGE -->

        <div class="product-details-image">

            <div class="product-details-main-image product-image-1">
            </div>

        </div>



        <!-- PRODUCT INFORMATION -->

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



            <!-- PRICE -->

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
            ================================================== -->

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


                        <button type="button"
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
            ================================================== -->

            <div class="quantity-section">

                <h3>
                    QUANTITY
                </h3>


                <div class="quantity-control">

                    <button type="button"
                            class="quantity-minus">

                        −

                    </button>


                    <span id="productQuantity">

                        1

                    </span>


                    <button type="button"
                            class="quantity-plus">

                        +

                    </button>

                </div>

            </div>



            <!-- =================================================
                 ACTION BUTTONS
            ================================================== -->

            <div class="product-details-actions">



                <!-- ADD TO CART -->

                <form id="addToCartForm"
                      action="${pageContext.request.contextPath}/add-to-cart"
                      method="post">


                    <input type="hidden"
                           name="variantId"
                           id="selectedVariantId">


                    <input type="hidden"
                           name="quantity"
                           id="selectedQuantity"
                           value="1">


                    <button type="submit"
                            class="add-to-cart-button">

                        ADD TO CART

                    </button>

                </form>



                <!-- BUY NOW -->

                <form id="buyNowForm"
                      action="${pageContext.request.contextPath}/buy-now"
                      method="post">


                    <input type="hidden"
                           name="variantId"
                           id="buyNowVariantId">


                    <input type="hidden"
                           name="quantity"
                           id="buyNowQuantity"
                           value="1">


                    <button type="submit"
                            class="buy-now-button">

                        BUY NOW

                    </button>

                </form>


            </div>



            <!-- =================================================
                 WISHLIST
            ================================================== -->

            <div class="product-wishlist-section">

                <%

                    Boolean inWishlist =
                            (Boolean)
                            request.getAttribute(
                                    "inWishlist"
                            );


                    boolean productInWishlist =
                            inWishlist != null
                            && inWishlist;

                %>


                <% if (productInWishlist) { %>


                    <!-- ALREADY IN WISHLIST -->

                    <form action="${pageContext.request.contextPath}/remove-from-wishlist"
                          method="post">


                        <input type="hidden"
                               name="productId"
                               value="${product.productId}">


                        <input type="hidden"
                               name="redirect"
                               value="product">


                        <button type="submit"
                                class="add-to-wishlist-button wishlist-active">

                            <span class="wishlist-heart">
                                ♥
                            </span>

                            IN WISHLIST — REMOVE

                        </button>


                    </form>


                <% } else { %>


                    <!-- NOT IN WISHLIST -->

                    <form action="${pageContext.request.contextPath}/add-to-wishlist"
                          method="post">


                        <input type="hidden"
                               name="productId"
                               value="${product.productId}">


                        <button type="submit"
                                class="add-to-wishlist-button">

                            <span class="wishlist-heart">
                                ♡
                            </span>

                            ADD TO WISHLIST

                        </button>


                    </form>


                <% } %>


            </div>



            <!-- =================================================
                 PRODUCT FEATURES
            ================================================== -->

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
    ====================================================== -->

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
========================================================== -->

<jsp:include page="partials/footer.jsp" />



<!-- =========================================================
     PRODUCT VARIANT SCRIPT
========================================================== -->

<script>

function selectProductVariant(button) {

    const variantId =
        button.getAttribute("data-variant-id");


    /* ADD TO CART VARIANT */

    const cartVariantInput =
        document.getElementById(
            "selectedVariantId"
        );


    if (cartVariantInput) {

        cartVariantInput.value =
            variantId;
    }



    /* BUY NOW VARIANT */

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


    console.log(
        "Selected variant ID:",
        variantId
    );
}

</script>



<!-- EXISTING PRODUCT DETAILS JS -->

<script src="${pageContext.request.contextPath}/assets/js/product-details.js">
</script>



<!-- =========================================================
     CART TOAST SCRIPT
========================================================== -->

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


            setTimeout(function () {

                cartToast.remove();

            }, 350);
        }
    }


    if (cartToast) {

        setTimeout(function () {

            closeCartToast();

        }, 3500);
    }

</script>



<!-- =========================================================
     WISHLIST TOAST SCRIPT
========================================================== -->

<script>

    const wishlistToast =
        document.getElementById(
            "wishlistToast"
        );


    function closeWishlistToast() {

        if (wishlistToast) {

            wishlistToast.classList.add(
                "cart-toast-hide"
            );


            setTimeout(function () {

                wishlistToast.remove();

            }, 350);
        }
    }


    if (wishlistToast) {

        setTimeout(function () {

            closeWishlistToast();

        }, 3500);
    }

</script>


</body>

</html>