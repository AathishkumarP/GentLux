<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Order" %>
<%@ page import="com.gentlux.model.OrderItemView" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Order Details | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

    <jsp:include page="partials/nav.jsp" />


    <%
        Order order =
                (Order)
                request.getAttribute("order");

        List<OrderItemView> orderItems =
                (List<OrderItemView>)
                request.getAttribute("orderItems");
    %>


    <main>

        <section class="order-details-section">


            <!-- =================================================
                 PAGE HEADING
            ================================================== -->

            <div class="section-heading">

                <p class="section-subtitle">
                    ORDER INFORMATION
                </p>

                <h2>
                    ORDER #<%= order.getOrderId() %>
                </h2>

                <p class="section-description">
                    Review your purchased products,
                    payment and delivery information.
                </p>

            </div>


            <div class="order-details-container">


                <!-- =================================================
                     LEFT SIDE
                ================================================== -->

                <div class="order-details-main">


                    <!-- =============================================
                         ORDER PRODUCTS
                    ============================================== -->

                    <div class="order-details-card">

                        <div class="order-details-card-heading">

                            <div>

                                <p>
                                    PURCHASED ITEMS
                                </p>

                                <h3>
                                    ORDER PRODUCTS
                                </h3>

                            </div>

                            <span>
                                <%= orderItems != null
                                        ? orderItems.size()
                                        : 0 %>
                                Item(s)
                            </span>

                        </div>


                        <div class="order-products-list">


                            <%
                                if (orderItems != null
                                        && !orderItems.isEmpty()) {

                                    for (OrderItemView item : orderItems) {

                                        String imagePath =
                                                item.getImageUrl();

                                        if (imagePath != null
                                                && !imagePath.isEmpty()
                                                && !imagePath.startsWith("/")) {

                                            imagePath =
                                                    "/" + imagePath;
                                        }
                            %>


                            <div class="order-product-item">


                                <!-- PRODUCT IMAGE -->

                                <div class="order-product-image">

                                    <%
                                        if (imagePath != null
                                                && !imagePath.isEmpty()) {
                                    %>

                                    <img
                                        src="<%= request.getContextPath()
                                                + imagePath %>"
                                        alt="<%= item.getProductName() %>">

                                    <%
                                        }
                                    %>

                                </div>


                                <!-- PRODUCT INFORMATION -->

                                <div class="order-product-info">

                                    <p class="order-product-brand">
                                        <%= item.getBrand() %>
                                    </p>

                                    <h4>
                                        <%= item.getProductName() %>
                                    </h4>


                                    <div class="order-product-meta">

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


                                <!-- PRICE -->

                                <div class="order-product-price">

                                    <p>
                                        Unit Price
                                    </p>

                                    <strong>
                                        ₹<%= String.format(
                                                "%.2f",
                                                item.getPrice()
                                        ) %>
                                    </strong>

                                </div>


                                <!-- SUBTOTAL -->

                                <div class="order-product-subtotal">

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

                                } else {
                            %>


                            <div class="order-products-empty">

                                No products were found for this order.

                            </div>


                            <%
                                }
                            %>


                        </div>

                    </div>


                    <!-- =============================================
                         SHIPPING ADDRESS
                    ============================================== -->

                    <div class="order-details-card">


                        <div class="order-details-card-heading">

                            <div>

                                <p>
                                    DELIVERY
                                </p>

                                <h3>
                                    SHIPPING ADDRESS
                                </h3>

                            </div>

                        </div>


                        <div class="order-shipping-details">

                            <strong class="order-shipping-name">
                                <%= order.getShippingName() %>
                            </strong>


                            <p>
                                <%= order.getShippingAddress() %>
                            </p>


                            <p>
                                <%= order.getShippingCity() %>,
                                <%= order.getShippingState() %>
                                - <%= order.getShippingPincode() %>
                            </p>


                            <p>
                                Phone:
                                <strong>
                                    <%= order.getShippingPhone() %>
                                </strong>
                            </p>

                        </div>

                    </div>


                </div>


                <!-- =================================================
                     RIGHT SIDE
                ================================================== -->

                <aside class="order-details-summary">


                    <p class="order-details-summary-label">
                        ORDER
                    </p>


                    <h3>
                        ORDER SUMMARY
                    </h3>


                    <div class="order-details-summary-row">

                        <span>
                            Order ID
                        </span>

                        <strong>
                            #<%= order.getOrderId() %>
                        </strong>

                    </div>


                    <div class="order-details-summary-row">

                        <span>
                            Order Status
                        </span>

                        <strong>
                            <%= order.getOrderStatus() %>
                        </strong>

                    </div>


                    <div class="order-details-summary-row">

                        <span>
                            Payment Method
                        </span>

                        <strong>
                            <%= order.getPaymentMethod() %>
                        </strong>

                    </div>


                    <div class="order-details-summary-row">

                        <span>
                            Payment Status
                        </span>

                        <strong>
                            <%= order.getPaymentStatus() %>
                        </strong>

                    </div>


                    <div class="order-details-summary-row">

                        <span>
                            Order Date
                        </span>

                        <strong class="order-date-value">
                            <%= order.getOrderDate() != null
                                    ? order.getOrderDate()
                                    : "-" %>
                        </strong>

                    </div>


                    <div class="order-details-summary-divider">
                    </div>


                    <div class="order-details-summary-row
                                order-details-total">

                        <span>
                            TOTAL
                        </span>

                        <strong>
                            ₹<%= String.format(
                                    "%.2f",
                                    order.getTotalAmount()
                            ) %>
                        </strong>

                    </div>


                    <a
                        href="${pageContext.request.contextPath}/my-orders"
                        class="order-details-back-button">

                        ← BACK TO MY ORDERS

                    </a>


                    <a
                        href="${pageContext.request.contextPath}/products"
                        class="order-details-shop-button">

                        CONTINUE SHOPPING

                    </a>


                </aside>


            </div>

        </section>

    </main>


    <jsp:include page="partials/footer.jsp" />


</body>

</html>