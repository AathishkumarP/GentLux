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

    <title>Checkout | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

    <!-- ==========================================
         NAVBAR
    =========================================== -->

    <jsp:include page="partials/nav.jsp" />


    <%
        List<CartItemView> cartItems =
                (List<CartItemView>)
                request.getAttribute("cartItems");

        Double cartTotal =
                (Double)
                request.getAttribute("cartTotal");

        Integer totalQuantity =
                (Integer)
                request.getAttribute("totalQuantity");

        Integer cartId =
                (Integer)
                request.getAttribute("cartId");
    %>


    <main>

        <section class="checkout-section">


            <!-- ==========================================
                 PAGE HEADING
            =========================================== -->

            <div class="section-heading">

                <p class="section-subtitle">
                    SECURE CHECKOUT
                </p>

                <h2>
                    COMPLETE YOUR ORDER
                </h2>

                <p class="section-description">
                    Enter your delivery details and review
                    your order before placing it.
                </p>

            </div>


            <!-- ==========================================
                 CHECKOUT CONTAINER
            =========================================== -->

            <div class="checkout-container">


                <!-- ======================================
                     LEFT SIDE
                ======================================= -->

                <div class="checkout-left">

				
				<form action="${pageContext.request.contextPath}/place-order"
				      method="post"
				      id="checkoutForm">
				
				    <!-- CHECKOUT TYPE -->
				    <input type="hidden"
				           name="checkoutType"
				           value="<%= request.getAttribute("checkoutType") != null
				                   ? request.getAttribute("checkoutType")
				                   : "CART" %>">
				
				    <!-- BUY NOW DATA -->
				    <%
				        if ("BUY_NOW".equals(
				                request.getAttribute("checkoutType"))) {
				    %>
				
				        <input type="hidden"
				               name="buyNowVariantId"
				               value="<%= request.getAttribute("buyNowVariantId") %>">
				
				        <input type="hidden"
				               name="buyNowQuantity"
				               value="<%= request.getAttribute("buyNowQuantity") %>">
				
				    <%
				        }
				    %>
				
				
				    <!-- KEEP YOUR EXISTING CHECKOUT CONTENT BELOW -->


                        <!-- CART ID -->

                        <input
                            type="hidden"
                            name="cartId"
                            value="<%= cartId %>">


                        <!-- ==================================
                             SHIPPING INFORMATION
                        =================================== -->

                        <div class="checkout-block">

                            <div class="checkout-block-heading">

                                <span class="checkout-step">
                                    01
                                </span>

                                <div>

                                    <p class="checkout-label">
                                        DELIVERY
                                    </p>

                                    <h3>
                                        SHIPPING INFORMATION
                                    </h3>

                                </div>

                            </div>


                            <!-- FULL NAME -->

                            <div class="checkout-field">

                                <label for="shippingName">
                                    Full Name
                                </label>

                                <input
                                    type="text"
                                    id="shippingName"
                                    name="shippingName"
                                    placeholder="Enter your full name"
                                    maxlength="100"
                                    required>

                            </div>


                            <!-- PHONE -->

                            <div class="checkout-field">

                                <label for="shippingPhone">
                                    Phone Number
                                </label>

                                <input
                                    type="tel"
                                    id="shippingPhone"
                                    name="shippingPhone"
                                    placeholder="Enter 10-digit mobile number"
                                    pattern="[0-9]{10}"
                                    maxlength="10"
                                    required>

                            </div>


                            <!-- ADDRESS -->

                            <div class="checkout-field">

                                <label for="shippingAddress">
                                    Address
                                </label>

                                <textarea
                                    id="shippingAddress"
                                    name="shippingAddress"
                                    rows="4"
                                    maxlength="255"
                                    placeholder="House number, street, area"
                                    required></textarea>

                            </div>


                            <!-- CITY + STATE -->

                            <div class="checkout-field-row">


                                <div class="checkout-field">

                                    <label for="shippingCity">
                                        City
                                    </label>

                                    <input
                                        type="text"
                                        id="shippingCity"
                                        name="shippingCity"
                                        placeholder="City"
                                        maxlength="50"
                                        required>

                                </div>


                                <div class="checkout-field">

                                    <label for="shippingState">
                                        State
                                    </label>

                                    <input
                                        type="text"
                                        id="shippingState"
                                        name="shippingState"
                                        placeholder="State"
                                        maxlength="50"
                                        required>

                                </div>


                            </div>


                            <!-- PINCODE -->

                            <div class="checkout-field">

                                <label for="shippingPincode">
                                    Pincode
                                </label>

                                <input
                                    type="text"
                                    id="shippingPincode"
                                    name="shippingPincode"
                                    placeholder="6-digit pincode"
                                    pattern="[0-9]{6}"
                                    maxlength="6"
                                    required>

                            </div>

                        </div>


                        <!-- ==================================
                             PAYMENT
                        =================================== -->

                        <div class="checkout-block">

                            <div class="checkout-block-heading">

                                <span class="checkout-step">
                                    02
                                </span>

                                <div>

                                    <p class="checkout-label">
                                        PAYMENT
                                    </p>

                                    <h3>
                                        PAYMENT METHOD
                                    </h3>

                                </div>

                            </div>


                            <!-- CASH ON DELIVERY -->

                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="paymentMethod"
                                    value="COD"
                                    checked>

                                <span class="payment-radio"></span>

                                <span class="payment-option-content">

                                    <strong>
                                        CASH ON DELIVERY
                                    </strong>

                                    <small>
                                        Pay when your order arrives
                                    </small>

                                </span>

                            </label>


                            <!-- ONLINE PAYMENT -->

                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="paymentMethod"
                                    value="ONLINE">

                                <span class="payment-radio"></span>

                                <span class="payment-option-content">

                                    <strong>
                                        ONLINE PAYMENT
                                    </strong>

                                    <small>
                                        UPI / Card / Net Banking
                                    </small>

                                </span>

                            </label>


                        </div>

                    </form>

                </div>


                <!-- ======================================
                     RIGHT SIDE - ORDER SUMMARY
                ======================================= -->

                <aside class="checkout-summary">


                    <p class="checkout-summary-label">
                        YOUR ORDER
                    </p>

                    <h3>
                        ORDER SUMMARY
                    </h3>


                    <!-- ==================================
                         PRODUCTS
                    =================================== -->

                    <div class="checkout-products">


                        <%
                            if (cartItems != null) {

                                for (CartItemView item : cartItems) {
                        %>


                        <div class="checkout-product">


                            <!-- IMAGE -->

                            <div class="checkout-product-image">

                                <%
                                    if (item.getImageUrl() != null
                                            && !item.getImageUrl().isEmpty()) {
                                %>

								<%
								    String imagePath = item.getImageUrl();
								
								    if (imagePath != null && !imagePath.isEmpty()) {
								
								        if (!imagePath.startsWith("/")) {
								            imagePath = "/" + imagePath;
								        }
								%>
								
								<img
								    src="<%= request.getContextPath() + imagePath %>"
								    alt="<%= item.getProductName() %>">
								
								<%
								    }
								%>
                                <%
                                    }
                                %>

                            </div>


                            <!-- PRODUCT DETAILS -->

                            <div class="checkout-product-details">

                                <p>
                                    <%= item.getBrand() %>
                                </p>

                                <h4>
                                    <%= item.getProductName() %>
                                </h4>

                                <span>
                                    Size:
                                    <%= item.getSize() %>
                                </span>

                                <span>
                                    Qty:
                                    <%= item.getQuantity() %>
                                </span>

                            </div>


                            <!-- PRICE -->

                            <div class="checkout-product-price">

                                ₹<%=
                                    String.format(
                                        "%.2f",
                                        item.getSubtotal()
                                    )
                                %>

                            </div>


                        </div>


                        <%
                                }
                            }
                        %>


                    </div>


                    <!-- ==================================
                         PRICE DETAILS
                    =================================== -->

                    <div class="checkout-summary-divider"></div>


                    <div class="checkout-summary-row">

                        <span>
                            Items
                        </span>

                        <span>
                            <%= totalQuantity %>
                        </span>

                    </div>


                    <div class="checkout-summary-row">

                        <span>
                            Subtotal
                        </span>

                        <span>

                            ₹<%=
                                String.format(
                                    "%.2f",
                                    cartTotal
                                )
                            %>

                        </span>

                    </div>


                    <div class="checkout-summary-row">

                        <span>
                            Delivery
                        </span>

                        <span>
                            FREE
                        </span>

                    </div>


                    <div class="checkout-summary-divider"></div>


                    <!-- TOTAL -->

                    <div class="checkout-summary-row checkout-grand-total">

                        <strong>
                            TOTAL
                        </strong>

                        <strong>

                            ₹<%=
                                String.format(
                                    "%.2f",
                                    cartTotal
                                )
                            %>

                        </strong>

                    </div>


                    <!-- ==================================
                         PLACE ORDER
                    =================================== -->

                    <button
                        type="submit"
                        form="checkoutForm"
                        class="place-order-button">

                        PLACE ORDER

                    </button>


                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="back-to-cart-link">

                        ← RETURN TO CART

                    </a>


                    <p class="checkout-security-text">

                        🔒 Your checkout information is
                        securely processed.

                    </p>


                </aside>


            </div>

        </section>

    </main>


    <!-- ==========================================
         FOOTER
    =========================================== -->

    <jsp:include page="partials/footer.jsp" />


</body>

</html>