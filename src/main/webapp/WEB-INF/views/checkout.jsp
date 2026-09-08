<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.CartItemView" %>
<%@ page import="com.gentlux.model.User" %>

<%
    List<CartItemView> cartItems =
            (List<CartItemView>) request.getAttribute("cartItems");

    Double cartTotalObj =
            (Double) request.getAttribute("cartTotal");

    Integer totalQuantityObj =
            (Integer) request.getAttribute("totalQuantity");

    Integer cartIdObj =
            (Integer) request.getAttribute("cartId");

    User user =
            (User) request.getAttribute("user");

    double cartTotal =
            cartTotalObj != null ? cartTotalObj : 0.0;

    int totalQuantity =
            totalQuantityObj != null ? totalQuantityObj : 0;

    int cartId =
            cartIdObj != null ? cartIdObj : 0;
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Checkout | GENTLUX</title>


    <!-- GLOBAL CSS -->

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">


    <!-- CHECKOUT ONLY CSS -->

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/checkout.css">


    <!-- IMAGE SUPPORT -->

    <style>

        .gl-checkout-product-image {
            overflow: hidden;
        }

        .gl-checkout-product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .gl-checkout-image-placeholder {
            width: 100%;
            height: 100%;
            min-height: 90px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f1ece8;
            color: #38251e;

            font-size: 9px;
            font-weight: 600;
            letter-spacing: 2px;
        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVBAR
===================================================== -->

<jsp:include page="partials/nav.jsp" />


<!-- =====================================================
     CHECKOUT PAGE
===================================================== -->

<main class="gl-checkout-page">

    <div class="gl-checkout-container">


        <!-- =============================================
             PAGE HEADING
        ============================================== -->

        <div class="gl-checkout-heading">

            <p>
                COMPLETE YOUR PURCHASE
            </p>

            <h1>
                Checkout
            </h1>

        </div>


        <!-- =============================================
             CHECKOUT FORM
        ============================================== -->

        <form
            action="<%= request.getContextPath() %>/place-order"
            method="post"
            class="gl-checkout-grid">


            <!-- CART ID -->

            <input
                type="hidden"
                name="cartId"
                value="<%= cartId %>">


            <!-- =================================================
                 LEFT SIDE
            ================================================== -->

            <div class="gl-checkout-form-side">


                <!-- =============================================
                     SHIPPING INFORMATION
                ============================================== -->

                <section class="gl-checkout-panel">


                    <div class="gl-checkout-panel-heading">

                        <span class="gl-checkout-step">
                            01
                        </span>

                        <div>

                            <p>
                                DELIVERY DETAILS
                            </p>

                            <h2>
                                Shipping Information
                            </h2>

                        </div>

                    </div>


                    <!-- FULL NAME -->

                    <div class="gl-checkout-field">

                        <label for="shippingName">
                            Full Name
                        </label>

                        <input
                            type="text"
                            id="shippingName"
                            name="shippingName"
                            value="<%= user != null
                                    && user.getFullName() != null
                                    ? user.getFullName()
                                    : "" %>"
                            placeholder="Enter your full name"
                            autocomplete="name"
                            required>

                    </div>


                    <!-- PHONE -->

                    <div class="gl-checkout-field">

                        <label for="shippingPhone">
                            Phone Number
                        </label>

                        <input
                            type="tel"
                            id="shippingPhone"
                            name="shippingPhone"
                            value="<%= user != null
                                    && user.getPhone() != null
                                    ? user.getPhone()
                                    : "" %>"
                            placeholder="Enter your phone number"
                            autocomplete="tel"
                            required>

                    </div>


                    <!-- ADDRESS -->

                    <div class="gl-checkout-field">

                        <label for="shippingAddress">
                            Address
                        </label>

                        <textarea
                            id="shippingAddress"
                            name="shippingAddress"
                            rows="4"
                            placeholder="House number, street, area"
                            autocomplete="street-address"
                            required><%= user != null
                                    && user.getAddress() != null
                                    ? user.getAddress()
                                    : "" %></textarea>

                    </div>


                    <!-- CITY + STATE -->

                    <div class="gl-checkout-two-column">


                        <!-- CITY -->

                        <div class="gl-checkout-field">

                            <label for="shippingCity">
                                City
                            </label>

                            <input
                                type="text"
                                id="shippingCity"
                                name="shippingCity"
                                value="<%= user != null
                                        && user.getCity() != null
                                        ? user.getCity()
                                        : "" %>"
                                placeholder="City"
                                autocomplete="address-level2"
                                required>

                        </div>


                        <!-- STATE -->

                        <div class="gl-checkout-field">

                            <label for="shippingState">
                                State
                            </label>

                            <input
                                type="text"
                                id="shippingState"
                                name="shippingState"
                                value="<%= user != null
                                        && user.getState() != null
                                        ? user.getState()
                                        : "" %>"
                                placeholder="State"
                                autocomplete="address-level1"
                                required>

                        </div>


                    </div>


                    <!-- PINCODE -->

                    <div class="gl-checkout-field">

                        <label for="shippingPincode">
                            Pincode
                        </label>

                        <input
                            type="text"
                            id="shippingPincode"
                            name="shippingPincode"
                            value="<%= user != null
                                    && user.getPincode() != null
                                    ? user.getPincode()
                                    : "" %>"
                            placeholder="Enter pincode"
                            autocomplete="postal-code"
                            required>

                    </div>


                    <!-- SAVED ADDRESS INFORMATION -->

                    <div class="gl-checkout-address-note">

                        <p>
                            Your saved profile address has been filled
                            automatically. You can change these details
                            for this order if needed.
                        </p>

                    </div>


                </section>


                <!-- =============================================
                     PAYMENT METHOD
                ============================================== -->

                <section class="gl-checkout-panel">


                    <div class="gl-checkout-panel-heading">

                        <span class="gl-checkout-step">
                            02
                        </span>

                        <div>

                            <p>
                                PAYMENT
                            </p>

                            <h2>
                                Payment Method
                            </h2>

                        </div>

                    </div>


                    <label class="gl-checkout-payment-option">

                        <input
                            type="radio"
                            name="paymentMethod"
                            value="COD"
                            checked
                            required>


                        <div class="gl-checkout-payment-text">

                            <strong>
                                Cash on Delivery
                            </strong>

                            <span>
                                Pay when your order is delivered
                            </span>

                        </div>

                    </label>


                    <p class="gl-checkout-payment-coming">
                        Online payment options coming soon
                    </p>


                </section>


            </div>


            <!-- =================================================
                 RIGHT SIDE
            ================================================== -->

            <aside class="gl-checkout-summary-side">


                <div class="gl-checkout-summary-card">


                    <!-- =========================================
                         SUMMARY HEADING
                    ========================================== -->

                    <div class="gl-checkout-summary-heading">

                        <p>
                            YOUR PURCHASE
                        </p>

                        <h2>
                            Order Summary
                        </h2>

                    </div>


                    <!-- =========================================
                         PRODUCTS
                    ========================================== -->

                    <div class="gl-checkout-products">


                        <%

                            if (cartItems != null
                                    && !cartItems.isEmpty()) {

                                for (CartItemView item : cartItems) {

                        %>


                        <div class="gl-checkout-product">


                            <!-- =================================
                                 PRODUCT IMAGE
                            ================================== -->

                            <div class="gl-checkout-product-image">


                                <%

                                    String checkoutImageUrl =
                                            item.getImageUrl();

                                    boolean hasCheckoutImage =
                                            checkoutImageUrl != null
                                            && !checkoutImageUrl
                                                    .trim()
                                                    .isEmpty();


                                    if (hasCheckoutImage) {


                                        checkoutImageUrl =
                                                checkoutImageUrl.trim();


                                        String finalCheckoutImageUrl;


                                        /*
                                         * External image URL
                                         */
                                        if (checkoutImageUrl
                                                .startsWith("http://")
                                                || checkoutImageUrl
                                                .startsWith("https://")) {


                                            finalCheckoutImageUrl =
                                                    checkoutImageUrl;


                                        } else {


                                            /*
                                             * Local uploaded image
                                             *
                                             * Example:
                                             * assets/images/products/product.jpg
                                             */

                                            if (checkoutImageUrl
                                                    .startsWith("/")) {

                                                checkoutImageUrl =
                                                        checkoutImageUrl
                                                                .substring(1);
                                            }


                                            finalCheckoutImageUrl =
                                                    request.getContextPath()
                                                    + "/"
                                                    + checkoutImageUrl;

                                        }

                                %>


                                    <img
                                        src="<%= finalCheckoutImageUrl %>"
                                        alt="<%= item.getProductName() %>"
                                        loading="lazy"
                                        onerror="
                                            this.style.display='none';
                                            this.nextElementSibling.style.display='flex';
                                        ">


                                    <!-- BROKEN IMAGE FALLBACK -->

                                    <div
                                        class="gl-checkout-image-placeholder"
                                        style="display:none;">

                                        GENTLUX

                                    </div>


                                <%

                                    } else {

                                %>


                                    <!-- NO IMAGE FALLBACK -->

                                    <div class="gl-checkout-image-placeholder">

                                        GENTLUX

                                    </div>


                                <%

                                    }

                                %>


                            </div>


                            <!-- =================================
                                 PRODUCT INFORMATION
                            ================================== -->

                            <div class="gl-checkout-product-info">


                                <p class="gl-checkout-product-brand">

                                    <%= item.getBrand() != null
                                            ? item.getBrand()
                                            : "" %>

                                </p>


                                <h3>

                                    <%= item.getProductName() %>

                                </h3>


                                <div class="gl-checkout-product-meta">


                                    <span>

                                        Size:

                                        <strong>

                                            <%= item.getSize() %>

                                        </strong>

                                    </span>


                                    <span>

                                        Qty:

                                        <strong>

                                            <%= item.getQuantity() %>

                                        </strong>

                                    </span>


                                </div>


                            </div>


                            <!-- =================================
                                 PRICE
                            ================================== -->

                            <div class="gl-checkout-product-price">

                                ₹<%= String.format(
                                        "%.2f",
                                        item.getSubtotal()
                                ) %>

                            </div>


                        </div>


                        <%

                                }

                            } else {

                        %>


                        <div class="gl-checkout-empty">

                            <p>
                                No products found.
                            </p>

                        </div>


                        <%

                            }

                        %>


                    </div>


                    <!-- =========================================
                         PRICE DETAILS
                    ========================================== -->

                    <div class="gl-checkout-price-details">


                        <!-- ITEMS -->

                        <div class="gl-checkout-price-row">

                            <span>

                                Items (<%= totalQuantity %>)

                            </span>

                            <span>

                                ₹<%= String.format(
                                        "%.2f",
                                        cartTotal
                                ) %>

                            </span>

                        </div>


                        <!-- DELIVERY -->

                        <div class="gl-checkout-price-row">

                            <span>
                                Delivery
                            </span>

                            <span class="gl-checkout-free">
                                FREE
                            </span>

                        </div>


                        <div class="gl-checkout-divider">
                        </div>


                        <!-- TOTAL -->

                        <div class="gl-checkout-total-row">


                            <div>

                                <span>
                                    Total
                                </span>

                                <small>
                                    Inclusive of all taxes
                                </small>

                            </div>


                            <strong>

                                ₹<%= String.format(
                                        "%.2f",
                                        cartTotal
                                ) %>

                            </strong>


                        </div>


                    </div>


                    <!-- =========================================
                         PLACE ORDER
                    ========================================== -->

                    <button
                        type="submit"
                        class="gl-checkout-place-order">

                        PLACE ORDER

                    </button>


                    <!-- =========================================
                         SECURITY
                    ========================================== -->

                    <div class="gl-checkout-security">

                        <span>
                            ✓
                        </span>

                        <p>
                            Secure checkout. Your information is protected.
                        </p>

                    </div>


                </div>


            </aside>


        </form>


    </div>


</main>


<!-- =====================================================
     FOOTER
===================================================== -->

<jsp:include page="partials/footer.jsp" />


</body>

</html>