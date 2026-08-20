<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.gentlux.model.Order" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Order Confirmed | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

    <jsp:include page="partials/nav.jsp" />


    <%
        Order order =
                (Order)
                request.getAttribute("order");
    %>


    <main>

        <section class="order-success-section">


            <div class="order-success-card">


                <div class="order-success-icon">
                    ✓
                </div>


                <p class="order-success-subtitle">
                    ORDER CONFIRMED
                </p>


                <h1>
                    THANK YOU FOR YOUR ORDER
                </h1>


                <p class="order-success-message">
                    Your order has been placed successfully.
                    We’ll begin preparing it shortly.
                </p>


                <div class="order-success-divider"></div>


                <div class="order-success-details">


                    <div class="order-success-row">

                        <span>
                            Order ID
                        </span>

                        <strong>
                            #<%= order.getOrderId() %>
                        </strong>

                    </div>


                    <div class="order-success-row">

                        <span>
                            Order Total
                        </span>

                        <strong>
                            ₹<%= String.format(
                                    "%.2f",
                                    order.getTotalAmount()
                            ) %>
                        </strong>

                    </div>


                    <div class="order-success-row">

                        <span>
                            Payment Method
                        </span>

                        <strong>
                            <%= order.getPaymentMethod() %>
                        </strong>

                    </div>


                    <div class="order-success-row">

                        <span>
                            Payment Status
                        </span>

                        <strong>
                            <%= order.getPaymentStatus() %>
                        </strong>

                    </div>


                    <div class="order-success-row">

                        <span>
                            Order Status
                        </span>

                        <strong>
                            <%= order.getOrderStatus() %>
                        </strong>

                    </div>


                </div>


                <div class="order-success-address">

                    <p class="order-success-address-label">
                        SHIPPING TO
                    </p>

                    <strong>
                        <%= order.getShippingName() %>
                    </strong>

                    <p>
                        <%= order.getShippingAddress() %>,
                        <%= order.getShippingCity() %>,
                        <%= order.getShippingState() %>
                        - <%= order.getShippingPincode() %>
                    </p>

                    <p>
                        <%= order.getShippingPhone() %>
                    </p>

                </div>


                <div class="order-success-actions">

                    <a href="${pageContext.request.contextPath}/products"
                       class="order-success-primary-button">

                        CONTINUE SHOPPING

                    </a>


                    <a href="${pageContext.request.contextPath}/home"
                       class="order-success-secondary-button">

                        BACK TO HOME

                    </a>

                </div>


            </div>

        </section>

    </main>


    <jsp:include page="partials/footer.jsp" />


</body>

</html>