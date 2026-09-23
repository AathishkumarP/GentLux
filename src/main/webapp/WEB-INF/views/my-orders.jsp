<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gentlux.model.Order" %>
<%@ page import="com.gentlux.model.OrderItemView" %>

<%

@SuppressWarnings("unchecked")
    List<Order> orders =
            (List<Order>)
            request.getAttribute("orders");


@SuppressWarnings("unchecked")
    Map<Integer, List<OrderItemView>> orderItemsMap =
            (Map<Integer, List<OrderItemView>>)
            request.getAttribute("orderItemsMap");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Orders | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        /* =========================================================
           MY ORDERS PAGE
        ========================================================= */

        .my-orders-page {
            min-height: 75vh;
            padding: 70px 5% 90px;
            background: #f8f4ef;
            color: #38251e;
        }

        .my-orders-container {
            max-width: 1450px;
            margin: 0 auto;
        }


        /* =========================================================
           PAGE HEADING
        ========================================================= */

        .my-orders-heading {
            text-align: center;
            margin-bottom: 55px;
        }

        .my-orders-heading .eyebrow {
            margin: 0 0 14px;
            color: #a47761;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 5px;
        }

        .my-orders-heading h1 {
            margin: 0;
            color: #38251e;
            font-size: clamp(38px, 5vw, 58px);
            font-weight: 500;
            letter-spacing: 3px;
        }

        .my-orders-heading .description {
            margin: 16px 0 0;
            color: #756862;
            font-size: 15px;
        }


        /* =========================================================
           ORDERS LIST
        ========================================================= */

        .orders-list {
            display: flex;
            flex-direction: column;
            gap: 28px;
        }

        .order-card {
            padding: 34px 38px;
            border: 1px solid #e2d7cf;
            background: #ffffff;
        }


        /* =========================================================
           ORDER HEADER
        ========================================================= */

        .order-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
            padding-bottom: 24px;
            border-bottom: 1px solid #e9dfd8;
        }

        .order-number-label {
            margin: 0 0 7px;
            color: #a47761;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 2.5px;
        }

        .order-number {
            margin: 0;
            color: #38251e;
            font-size: 25px;
            font-weight: 500;
        }


        /* =========================================================
           STATUS
        ========================================================= */

        .order-status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 100px;
            min-height: 38px;
            padding: 0 18px;
            border-radius: 24px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1.2px;
            text-transform: uppercase;
        }

        .status-placed {
            background: #f3eee7;
            color: #765344;
        }

        .status-confirmed {
            background: #eee9dc;
            color: #796529;
        }

        .status-shipped {
            background: #e7eef5;
            color: #365b7a;
        }

        .status-delivered {
            background: #e3f1e5;
            color: #35643d;
        }

        .status-cancelled {
            background: #f6e5e5;
            color: #914545;
        }


        /* =========================================================
           MAIN ORDER CONTENT
        ========================================================= */

        .order-card-content {
            display: grid;
            grid-template-columns: minmax(320px, 1.5fr) 2fr auto;
            gap: 34px;
            align-items: center;
            padding-top: 26px;
        }


        /* =========================================================
           PRODUCT PREVIEW
        ========================================================= */

        .order-products-preview {
            min-width: 0;
        }

        .order-preview-item {
            display: grid;
            grid-template-columns: 105px minmax(0, 1fr);
            gap: 18px;
            align-items: center;
        }

        .order-preview-item + .order-preview-item {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #eee5df;
        }

		.order-preview-image {
		    width: 105px;
		    height: 120px;
		    overflow: hidden;
		    background: #ffffff;
		}

		.order-preview-image img {
		    width: 100%;
		    height: 100%;
		    display: block;
		    object-fit: contain;
		    object-position: center;
		}

        .order-image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #d8c5b7;
            color: #6f5446;
            font-size: 9px;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .order-preview-brand {
            margin: 0 0 6px;
            color: #a47761;
            font-size: 9px;
            font-weight: 700;
            letter-spacing: 1.7px;
            text-transform: uppercase;
        }

        .order-preview-name {
            margin: 0 0 9px;
            color: #38251e;
            font-size: 17px;
            font-weight: 500;
            line-height: 1.35;
        }

        .order-preview-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 8px 15px;
            color: #766a63;
            font-size: 12px;
        }

        .order-extra-items {
            margin: 12px 0 0;
            color: #8d7568;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: .5px;
        }


        /* =========================================================
           ORDER INFORMATION GRID
        ========================================================= */

        .order-information {
            display: grid;
            grid-template-columns: repeat(4, minmax(110px, 1fr));
            gap: 22px;
        }

        .order-info-label {
            margin: 0 0 9px;
            color: #a47761;
            font-size: 9px;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .order-info-value {
            margin: 0;
            color: #38251e;
            font-size: 13px;
            font-weight: 600;
            line-height: 1.45;
            overflow-wrap: anywhere;
        }

        .order-info-total {
            font-size: 16px;
        }


        /* =========================================================
           VIEW DETAILS
        ========================================================= */

        .order-actions {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .view-details-button {
            min-width: 125px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0 16px;
            background: #38251e;
            color: #ffffff;
            text-decoration: none;
            font-size: 9px;
            font-weight: 700;
            letter-spacing: 1.4px;
            border: none;
            border-radius: 0;
            transition:
                background-color .2s ease,
                transform .2s ease;
        }

        .view-details-button:hover {
            background: #56382c;
            transform: translateY(-1px);
        }


        /* =========================================================
           EMPTY ORDERS
        ========================================================= */

        .empty-orders {
            padding: 80px 30px;
            border: 1px solid #e2d7cf;
            background: #ffffff;
            text-align: center;
        }

        .empty-orders-icon {
            margin-bottom: 20px;
            color: #94715f;
            font-size: 48px;
        }

        .empty-orders h2 {
            margin: 0 0 12px;
            color: #38251e;
            font-size: 26px;
            font-weight: 500;
        }

        .empty-orders p {
            margin: 0 0 28px;
            color: #756862;
            font-size: 14px;
        }

        .empty-orders a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 48px;
            padding: 0 25px;
            background: #38251e;
            color: #ffffff;
            text-decoration: none;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1.5px;
        }


        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 1200px) {

            .order-card-content {
                grid-template-columns: 1fr;
            }

            .order-actions {
                justify-content: center;
            }
        }

        @media (max-width: 800px) {

            .my-orders-page {
                padding: 50px 20px 70px;
            }

            .order-card {
                padding: 26px 22px;
            }

            .order-information {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 520px) {

            .order-card-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .order-preview-item {
                grid-template-columns: 90px minmax(0, 1fr);
            }

            .order-preview-image {
                width: 90px;
                height: 105px;
            }

            .order-information {
                grid-template-columns: 1fr;
            }

            .view-details-button {
                width: 100%;
            }
        }

    </style>

</head>


<body>

    <jsp:include page="partials/nav.jsp" />


    <main class="my-orders-page">

        <div class="my-orders-container">


            <!-- =====================================================
                 PAGE HEADING
            ====================================================== -->

            <div class="my-orders-heading">

                <p class="eyebrow">
                    YOUR PURCHASES
                </p>

                <h1>
                    MY ORDERS
                </h1>

                <p class="description">
                    View and track your previous GentLux orders.
                </p>

            </div>


            <!-- =====================================================
                 ORDERS
            ====================================================== -->

            <%
                if (orders != null
                        && !orders.isEmpty()) {
            %>

                <div class="orders-list">

                    <%
                        for (Order order : orders) {

                            String orderStatus =
                                    order.getOrderStatus() != null
                                            ? order.getOrderStatus()
                                            : "PLACED";

                            String statusClass =
                                    "status-"
                                    + orderStatus.toLowerCase();

                            List<OrderItemView> orderItems =
                                    orderItemsMap != null
                                            ? orderItemsMap.get(
                                                    order.getOrderId()
                                              )
                                            : null;
                    %>


                    <article class="order-card">


                        <!-- =========================================
                             ORDER HEADER
                        ========================================== -->

                        <div class="order-card-header">

                            <div>

                                <p class="order-number-label">
                                    ORDER
                                </p>

                                <p class="order-number">
                                    #<%= order.getOrderId() %>
                                </p>

                            </div>


                            <span class="order-status <%= statusClass %>">
                                <%= orderStatus %>
                            </span>

                        </div>


                        <!-- =========================================
                             ORDER CONTENT
                        ========================================== -->

                        <div class="order-card-content">


                            <!-- =====================================
                                 PRODUCT IMAGE + DETAILS
                            ====================================== -->

                            <div class="order-products-preview">

                                <%
                                    if (orderItems != null
                                            && !orderItems.isEmpty()) {

                                        int previewLimit =
                                                Math.min(
                                                        orderItems.size(),
                                                        2
                                                );

                                        for (int i = 0;
                                                i < previewLimit;
                                                i++) {

                                            OrderItemView item =
                                                    orderItems.get(i);

                                            String imageUrl =
                                                    item.getImageUrl();

                                            String finalImageUrl =
                                                    null;

                                            if (imageUrl != null
                                                    && !imageUrl
                                                            .trim()
                                                            .isEmpty()) {

                                                imageUrl =
                                                        imageUrl.trim();

                                                if (imageUrl.startsWith(
                                                        "http://")
                                                        || imageUrl.startsWith(
                                                                "https://")) {

                                                    finalImageUrl =
                                                            imageUrl;

                                                } else {

                                                    if (imageUrl.startsWith(
                                                            "/")) {

                                                        imageUrl =
                                                                imageUrl
                                                                .substring(1);
                                                    }

                                                    finalImageUrl =
                                                            request
                                                            .getContextPath()
                                                            + "/"
                                                            + imageUrl;
                                                }
                                            }
                                %>


                                <div class="order-preview-item">

                                    <div class="order-preview-image">

                                        <% if (finalImageUrl != null) { %>

                                            <img
                                                src="<%= finalImageUrl %>"
                                                alt="<%= item.getProductName() %>"
                                                loading="lazy"
                                                onerror="
                                                    this.style.display='none';
                                                    this.nextElementSibling.style.display='flex';
                                                ">

                                            <div
                                                class="order-image-placeholder"
                                                style="display:none;">
                                                GENTLUX
                                            </div>

                                        <% } else { %>

                                            <div class="order-image-placeholder">
                                                GENTLUX
                                            </div>

                                        <% } %>

                                    </div>


                                    <div class="order-preview-info">

                                        <p class="order-preview-brand">
                                            <%= item.getBrand() != null
                                                    ? item.getBrand()
                                                    : "GENTLUX" %>
                                        </p>

                                        <h3 class="order-preview-name">
                                            <%= item.getProductName() %>
                                        </h3>

                                        <div class="order-preview-meta">

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

                                </div>


                                <%
                                        }

                                        if (orderItems.size()
                                                > previewLimit) {
                                %>

                                    <p class="order-extra-items">
                                        + <%= orderItems.size()
                                                - previewLimit %>
                                        more item(s)
                                    </p>

                                <%
                                        }

                                    } else {
                                %>

                                    <div class="order-preview-item">

                                        <div class="order-preview-image">

                                            <div class="order-image-placeholder">
                                                GENTLUX
                                            </div>

                                        </div>

                                        <div class="order-preview-info">

                                            <p class="order-preview-brand">
                                                ORDER
                                            </p>

                                            <h3 class="order-preview-name">
                                                Product details unavailable
                                            </h3>

                                        </div>

                                    </div>

                                <%
                                    }
                                %>

                            </div>


                            <!-- =====================================
                                 ORDER INFORMATION
                            ====================================== -->

                            <div class="order-information">


                                <div class="order-info">

                                    <p class="order-info-label">
                                        ORDER DATE
                                    </p>

                                    <p class="order-info-value">
                                        <%= order.getOrderDate() != null
                                                ? order.getOrderDate()
                                                : "-" %>
                                    </p>

                                </div>


                                <div class="order-info">

                                    <p class="order-info-label">
                                        PAYMENT
                                    </p>

                                    <p class="order-info-value">
                                        <%= order.getPaymentMethod() != null
                                                ? order.getPaymentMethod()
                                                : "-" %>
                                    </p>

                                </div>


                                <div class="order-info">

                                    <p class="order-info-label">
                                        PAYMENT STATUS
                                    </p>

                                    <p class="order-info-value">
                                        <%= order.getPaymentStatus() != null
                                                ? order.getPaymentStatus()
                                                : "-" %>
                                    </p>

                                </div>


                                <div class="order-info">

                                    <p class="order-info-label">
                                        TOTAL
                                    </p>

                                    <p class="order-info-value order-info-total">
                                        ₹<%= String.format(
                                                "%.2f",
                                                order.getTotalAmount()
                                        ) %>
                                    </p>

                                </div>


                            </div>


                            <!-- =====================================
                                 VIEW DETAILS
                            ====================================== -->

                            <div class="order-actions">

                                <a
                                    href="${pageContext.request.contextPath}/order-details?orderId=<%= order.getOrderId() %>"
                                    class="view-details-button">

                                    VIEW DETAILS

                                </a>

                            </div>


                        </div>

                    </article>


                    <%
                        }
                    %>

                </div>

            <%
                } else {
            %>


                <div class="empty-orders">

                    <div class="empty-orders-icon">
                        ◇
                    </div>

                    <h2>
                        You have no orders yet
                    </h2>

                    <p>
                        Explore the GentLux collection and place your first order.
                    </p>

                    <a href="${pageContext.request.contextPath}/products">
                        SHOP COLLECTION
                    </a>

                </div>


            <%
                }
            %>


        </div>

    </main>


    <jsp:include page="partials/footer.jsp" />

</body>

</html>
