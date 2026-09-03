<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Order" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Orders | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/my-orders.css">

</head>

<body>

    <jsp:include page="partials/nav.jsp" />


    <%

        List<Order> orders =
                (List<Order>)
                request.getAttribute("orders");

    %>


    <main>

        <section class="my-orders-section">


            <!-- =====================================================
                 PAGE HEADING
            ====================================================== -->

            <div class="section-heading">

                <p class="section-subtitle">
                    YOUR PURCHASES
                </p>

                <h2>
                    MY ORDERS
                </h2>

                <p class="section-description">
                    View and track your previous GentLux orders.
                </p>

            </div>


            <div class="my-orders-container">


                <%

                    if (orders != null
                            && !orders.isEmpty()) {

                        for (Order order : orders) {


                            String orderStatus =
                                    order.getOrderStatus();


                            String statusClass =
                                    "status-default";


                            if (orderStatus != null) {

                                if (orderStatus.equalsIgnoreCase(
                                        "PLACED")) {

                                    statusClass =
                                            "status-placed";

                                } else if (
                                    orderStatus.equalsIgnoreCase(
                                            "CONFIRMED")) {

                                    statusClass =
                                            "status-confirmed";

                                } else if (
                                    orderStatus.equalsIgnoreCase(
                                            "SHIPPED")) {

                                    statusClass =
                                            "status-shipped";

                                } else if (
                                    orderStatus.equalsIgnoreCase(
                                            "DELIVERED")) {

                                    statusClass =
                                            "status-delivered";

                                } else if (
                                    orderStatus.equalsIgnoreCase(
                                            "CANCELLED")) {

                                    statusClass =
                                            "status-cancelled";
                                }
                            }

                %>


                <div class="order-card">


                    <!-- =================================================
                         ORDER HEADER
                    ================================================== -->

                    <div class="order-card-top">


                        <div>

                            <p class="order-card-label">
                                ORDER
                            </p>

                            <h3>
                                #<%= order.getOrderId() %>
                            </h3>

                        </div>


                        <div class="order-status-badge <%= statusClass %>">

                            <%= orderStatus != null
                                    ? orderStatus
                                    : "-" %>

                        </div>


                    </div>


                    <div class="order-card-divider"></div>


                    <!-- =================================================
                         ORDER INFORMATION
                    ================================================== -->

                    <div class="order-card-info">


                        <div class="order-info-item">

                            <span>
                                ORDER DATE
                            </span>

                            <strong>

                                <%= order.getOrderDate() != null
                                        ? order.getOrderDate()
                                        : "-" %>

                            </strong>

                        </div>


                        <div class="order-info-item">

                            <span>
                                PAYMENT
                            </span>

                            <strong>

                                <%= order.getPaymentMethod() != null
                                        ? order.getPaymentMethod()
                                        : "-" %>

                            </strong>

                        </div>


                        <div class="order-info-item">

                            <span>
                                PAYMENT STATUS
                            </span>

                            <strong>

                                <%= order.getPaymentStatus() != null
                                        ? order.getPaymentStatus()
                                        : "-" %>

                            </strong>

                        </div>


                        <div class="order-info-item">

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


                    </div>


                    <!-- =================================================
                         ACTION
                    ================================================== -->

                    <div class="order-card-actions">

                        <a
                            href="${pageContext.request.contextPath}/order-details?orderId=<%= order.getOrderId() %>"
                            class="view-order-button">

                            VIEW DETAILS

                        </a>

                    </div>


                </div>


                <%

                        }

                    } else {

                %>


                <!-- =====================================================
                     EMPTY ORDERS
                ====================================================== -->

                <div class="no-orders">

                    <h3>
                        No orders yet
                    </h3>

                    <p>
                        You haven't placed any orders yet.
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


    <jsp:include page="partials/footer.jsp" />


</body>

</html>