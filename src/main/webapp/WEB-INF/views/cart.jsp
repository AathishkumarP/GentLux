<%@ page language="java"

    contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%@ page import="com.gentlux.model.CartItemView" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"

          content="width=device-width, initial-scale=1.0">

    <title>Shopping Cart | GENTLUX</title>

    <link rel="stylesheet"

          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* =========================================================
           CART - IMAGE
        ========================================================= */

        .cart-item-image {
            overflow: hidden;
        }

        .cart-item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .cart-image-placeholder {
            width: 100%;
            height: 100%;
            min-height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1ece8;
            color: #38251e;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 2px;
        }

        /* =========================================================
           CART - REMOVE ITEM
        ========================================================= */

        .remove-cart-form {
            margin: 16px 0 0;
        }

        .remove-cart-button {
            padding: 0;
            border: none;
            outline: none;
            background: transparent;
            color: #8a6b59;
            font-family: inherit;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1.5px;
            cursor: pointer;
            transition: color 0.2s ease, transform 0.2s ease;
        }

        .remove-cart-button:hover {
            color: #3b261d;
            transform: translateX(2px);
        }

        .remove-cart-button:focus,
        .remove-cart-button:focus-visible {
            outline: none;
            box-shadow: none;
        }

        /* =========================================================
           CART - QUANTITY CONTROL
        ========================================================= */

        .cart-quantity-control {
            width: 118px;
            height: 40px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 38px 1fr 38px;
            align-items: stretch;
            border: 1px solid #d8cbc1;
            border-radius: 7px;
            overflow: hidden;
            background: #ffffff;
        }

        .cart-quantity-control form {
            margin: 0;
            display: block;
            height: 100%;
        }

        .cart-quantity-button {
            width: 100%;
            height: 100%;
            padding: 0;
            border: none;
            outline: none;
            background: #ffffff;
            color: #3b261d;
            font-family: inherit;
            font-size: 19px;
            line-height: 1;
            cursor: pointer;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

        .cart-quantity-button:hover:not(:disabled) {
            background: #43281c;
            color: #ffffff;
        }

        .cart-quantity-button:disabled {
            background: #f5f1ee;
            color: #b9aca4;
            cursor: not-allowed;
        }

        .cart-quantity-number {
            min-width: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            border-left: 1px solid #e5dbd3;
            border-right: 1px solid #e5dbd3;
            color: #3b261d;
            font-size: 13px;
            font-weight: 600;
        }

        /* =========================================================
           CART - CLEAR CART
        ========================================================= */

        .clear-cart-form {
            margin: 12px 0 0;
        }

        .clear-cart-button {
            width: 100%;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(245, 240, 232, 0.38);
            border-radius: 6px;
            background: transparent;
            color: #f2e8df;
            font-family: inherit;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.4px;
            cursor: pointer;
            transition:
                background-color 0.2s ease,
                border-color 0.2s ease,
                color 0.2s ease;
        }

        .clear-cart-button:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(245, 240, 232, 0.72);
            color: #ffffff;
        }

        .clear-cart-button:focus,
        .clear-cart-button:focus-visible {
            outline: none;
            box-shadow: none;
        }

        /* Keep quantity aligned naturally on small screens */
        @media (max-width: 700px) {
            .cart-quantity-control {
                margin: 0;
            }
        }
    </style>

</head>

<body>

    <!-- =========================================================

         NAVBAR

    ========================================================== -->

    <jsp:include page="partials/nav.jsp" />


    <main>


        <section class="cart-section">


            <!-- =================================================

                 PAGE HEADING

            ================================================== -->

            <div class="section-heading">

                <p class="section-subtitle">

                    YOUR BAG

                </p>

                <h2>

                    SHOPPING CART

                </h2>

                <p class="section-description">

                    Review your selected items before checkout.

                </p>

            </div>


            <div class="cart-container">


                <%

                    List<CartItemView> cartItems =

                            (List<CartItemView>)

                            request.getAttribute("cartItems");

                    Double cartTotal =

                            (Double)

                            request.getAttribute("cartTotal");


                    if (cartItems != null

                            && !cartItems.isEmpty()) {

                %>


                <!-- =================================================

                     CART ITEMS

                ================================================== -->

                <div class="cart-items">


                    <%

                        for (CartItemView item : cartItems) {

                    %>


                    <div class="cart-item">


                        <!-- =========================================

                             PRODUCT IMAGE

                        ========================================== -->

                        <div class="cart-item-image">

                            <%

                                String cartImageUrl =

                                        item.getImageUrl();

                                boolean hasCartImage =

                                        cartImageUrl != null

                                        && !cartImageUrl.trim().isEmpty();


                                if (hasCartImage) {

                                    cartImageUrl =

                                            cartImageUrl.trim();


                                    String finalCartImageUrl;


                                    /* External image support */
                                    if (cartImageUrl.startsWith("http://")

                                            || cartImageUrl.startsWith("https://")) {

                                        finalCartImageUrl =

                                                cartImageUrl;

                                    } else {
                                        /*
                                         * Local uploaded product image.
                                         * Example: assets/images/products/product.jpg
                                         */
                                        if (cartImageUrl.startsWith("/")) {

                                            cartImageUrl =

                                                    cartImageUrl.substring(1);

                                        }

                                        finalCartImageUrl =

                                                request.getContextPath()

                                                + "/"

                                                + cartImageUrl;

                                    }

                            %>


                                <img

                                    src="<%= finalCartImageUrl %>"

                                    alt="<%= item.getProductName() %>"

                                    loading="lazy"

                                    onerror="

                                        this.style.display='none';

                                        this.nextElementSibling.style.display='flex';

                                    ">


                                <div

                                    class="cart-image-placeholder"

                                    style="display:none;">

                                    <span>

                                        GENTLUX

                                    </span>

                                </div>


                            <%

                                } else {

                            %>


                                <div class="cart-image-placeholder">

                                    <span>

                                        GENTLUX

                                    </span>

                                </div>


                            <%

                                }

                            %>


                        </div>


                        <!-- =========================================

                             PRODUCT DETAILS

                        ========================================== -->

                        <div class="cart-item-details">


                            <p class="cart-item-brand">

                                <%= item.getBrand() %>

                            </p>


                            <h3>

                                <%= item.getProductName() %>

                            </h3>


                            <p class="cart-item-size">

                                Size:

                                <strong>

                                    <%= item.getSize() %>

                                </strong>

                            </p>


                            <p class="cart-item-price">

                                ₹<%= String.format("%.2f", item.getPrice()) %>

                            </p>


                            <!-- =====================================

                                 REMOVE ITEM

                            ====================================== -->

                            <form

                                action="${pageContext.request.contextPath}/remove-cart-item"

                                method="post"

                                class="remove-cart-form">


                                <input

                                    type="hidden"

                                    name="cartItemId"

                                    value="<%= item.getCartItemId() %>">


                                <button

                                    type="submit"

                                    class="remove-cart-button">

                                    REMOVE

                                </button>


                            </form>


                        </div>


                        <!-- =========================================

                             QUANTITY

                        ========================================== -->

                        <div class="cart-item-quantity">


                            <p>

                                Quantity

                            </p>


                            <div class="cart-quantity-control">


                                <!-- MINUS -->

                                <form

                                    action="${pageContext.request.contextPath}/update-cart-quantity"

                                    method="post">


                                    <input

                                        type="hidden"

                                        name="cartItemId"

                                        value="<%= item.getCartItemId() %>">


                                    <input

                                        type="hidden"

                                        name="quantity"

                                        value="<%= item.getQuantity() - 1 %>">


                                    <button

                                        type="submit"

                                        class="cart-quantity-button"

                                        <%= item.getQuantity() <= 1

                                                ? "disabled"

                                                : "" %>>

                                        −

                                    </button>


                                </form>


                                <!-- CURRENT QUANTITY -->

                                <span class="cart-quantity-number">

                                    <%= item.getQuantity() %>

                                </span>


                                <!-- PLUS -->

                                <form

                                    action="${pageContext.request.contextPath}/update-cart-quantity"

                                    method="post">


                                    <input

                                        type="hidden"

                                        name="cartItemId"

                                        value="<%= item.getCartItemId() %>">


                                    <input

                                        type="hidden"

                                        name="quantity"

                                        value="<%= item.getQuantity() + 1 %>">


                                    <button

                                        type="submit"

                                        class="cart-quantity-button"

                                        <%= item.getQuantity() >= item.getStock()

                                                ? "disabled"

                                                : "" %>>

                                        +

                                    </button>


                                </form>


                            </div>


                        </div>


                        <!-- =========================================

                             SUBTOTAL

                        ========================================== -->

                        <div class="cart-item-subtotal">


                            <p>

                                Subtotal

                            </p>


                            <strong>

                                ₹<%= String.format(

                                        "%.2f",

                                        item.getSubtotal()

                                ) %>

                            </strong>


                        </div>


                    </div>


                    <%

                        }

                    %>


                </div>


                <!-- =================================================

                     CART SUMMARY

                ================================================== -->

                <div class="cart-summary">


                    <h3>

                        ORDER SUMMARY

                    </h3>


                    <!-- ITEMS -->

                    <div class="summary-row">

                        <span>

                            Items

                        </span>

                        <span>

                            <%= cartItems.size() %>

                        </span>

                    </div>


                    <!-- SUBTOTAL -->

                    <div class="summary-row">

                        <span>

                            Subtotal

                        </span>

                        <span>

                            ₹<%= String.format(

                                    "%.2f",

                                    cartTotal

                            ) %>

                        </span>

                    </div>


                    <!-- DELIVERY -->

                    <div class="summary-row">

                        <span>

                            Delivery

                        </span>

                        <span>

                            FREE

                        </span>

                    </div>


                    <div class="cart-summary-divider">

                    </div>


                    <!-- TOTAL -->

                    <div class="summary-row cart-total-row">

                        <strong>

                            TOTAL

                        </strong>

                        <strong>

                            ₹<%= String.format(

                                    "%.2f",

                                    cartTotal

                            ) %>

                        </strong>

                    </div>


                    <!-- =========================================

                         PROCEED TO CHECKOUT

                    ========================================== -->

                    <a

                        href="${pageContext.request.contextPath}/checkout"

                        class="checkout-button">

                        PROCEED TO CHECKOUT

                    </a>


                    <!-- =========================================

                         CLEAR CART

                    ========================================== -->

                    <form

                        action="${pageContext.request.contextPath}/clear-cart"

                        method="post"

                        class="clear-cart-form">


                        <button

                            type="submit"

                            class="clear-cart-button"

                            onclick="return confirm('Are you sure you want to remove all items from your cart?');">

                            CLEAR CART

                        </button>


                    </form>


                    <!-- =========================================

                         CONTINUE SHOPPING

                    ========================================== -->

                    <a

                        href="${pageContext.request.contextPath}/products"

                        class="continue-shopping-link">

                        ← CONTINUE SHOPPING

                    </a>


                </div>


                <%

                    } else {

                %>


                <!-- =================================================

                     EMPTY CART

                ================================================== -->

                <div class="empty-cart">


                    <h2>

                        Your cart is empty

                    </h2>


                    <p>

                        You haven't added any products yet.

                    </p>


                    <a

                        href="${pageContext.request.contextPath}/products"

                        class="hero-button">

                        START SHOPPING

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