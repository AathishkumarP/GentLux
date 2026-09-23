<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gentlux.model.Order" %>
<%@ page import="com.gentlux.model.OrderItemView" %>

<%
    @SuppressWarnings("unchecked")
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    @SuppressWarnings("unchecked")
    Map<Integer, List<OrderItemView>> orderItemsMap =
            (Map<Integer, List<OrderItemView>>)
                    request.getAttribute("orderItemsMap");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Manage Orders | GentLux Admin</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html,
        body {
            width: 100%;
            overflow-x: hidden;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f7f5f2;
            color: #2e2723;
        }


        /* =========================================================
           HEADER
        ========================================================= */

        .admin-header {
            min-height: 72px;
            padding: 0 40px;
            background: #2e2723;
            color: white;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-logo {
            font-size: 22px;
            letter-spacing: 3px;
            font-weight: 600;
        }

        .header-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        .header-links a {
            color: white;
            text-decoration: none;
            font-size: 10px;
            letter-spacing: 1.4px;
            text-transform: uppercase;
        }

        .header-links a:hover {
            opacity: 0.75;
        }


        /* =========================================================
           PAGE
        ========================================================= */

        .container {
            width: min(1450px, 96%);
            margin: 40px auto;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 30px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #82766f;
            font-size: 13px;
        }


        /* =========================================================
           MESSAGES
        ========================================================= */

        .message {
            padding: 13px 16px;
            margin-bottom: 20px;

            background: #e7efe8;
            color: #41624a;

            border: 1px solid #ccdccc;

            font-size: 12px;
        }

        .error-message {
            background: #f4e6e6;
            color: #8a3030;
            border-color: #e4caca;
        }


        /* =========================================================
           DESKTOP TABLE
        ========================================================= */

        .desktop-orders {
            display: block;
        }

        .table-wrapper {
            width: 100%;
            background: white;
            border: 1px solid #e2dad5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f1ece8;
            padding: 15px 14px;

            text-align: left;

            font-size: 10px;
            letter-spacing: 1px;
            text-transform: uppercase;

            color: #6d625c;

            white-space: nowrap;
        }

        td {
            padding: 16px 14px;
            border-top: 1px solid #eee8e4;

            font-size: 12px;
            vertical-align: middle;
        }


        /* =========================================================
           PRODUCTS
        ========================================================= */

        .order-products {
            min-width: 300px;

            display: flex;
            flex-direction: column;

            gap: 12px;
        }

        .order-product {
            display: flex;
            align-items: center;

            gap: 12px;
        }

        .order-product + .order-product {
            padding-top: 12px;
            border-top: 1px solid #eee8e4;
        }

        .product-image-box {
            width: 65px;
            height: 82px;

            flex-shrink: 0;

            overflow: hidden;

            background: #f1ece8;

            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-image-box img {
            width: 100%;
            height: 100%;

            object-fit: cover;

            display: block;
        }

        .product-image-placeholder {
            width: 100%;
            height: 100%;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f1ece8;
            color: #38251e;

            font-size: 8px;
            font-weight: 600;
            letter-spacing: 1px;

            text-align: center;
        }

        .product-details {
            min-width: 0;
        }

        .product-name {
            font-size: 12px;
            font-weight: 600;

            color: #2e2723;

            margin-bottom: 5px;

            line-height: 1.4;
        }

        .product-brand {
            font-size: 10px;

            color: #8a7d76;

            margin-bottom: 5px;
        }

        .product-meta {
            font-size: 10px;

            color: #746861;

            line-height: 1.6;
        }

        .product-meta strong {
            color: #2e2723;
        }

        .no-products {
            color: #8a7d76;
            font-size: 11px;
        }


        /* =========================================================
           STATUS
        ========================================================= */

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-width: 90px;

            padding: 7px 12px;

            border-radius: 20px;

            font-size: 9px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .status-placed {
            background: #f6efe9;
            color: #6f4d3d;
        }

        .status-confirmed {
            background: #eee9df;
            color: #5d5144;
        }

        .status-shipped {
            background: #e7edf0;
            color: #415d68;
        }

        .status-delivered {
            background: #e6eee8;
            color: #41624a;
        }

        .status-cancelled {
            background: #f5e7e7;
            color: #8a3030;
        }

        .status-default {
            background: #eeeeee;
            color: #666666;
        }


        /* =========================================================
           STATUS ACTION
        ========================================================= */

        .status-form {
            display: flex;
            align-items: center;

            gap: 8px;
        }

        .status-form button {
            padding: 9px 13px;

            border: none;

            background: #2e2723;
            color: white;

            font-size: 9px;
            font-weight: 600;
            letter-spacing: 1px;

            cursor: pointer;

            white-space: nowrap;
        }

        .status-form button:hover {
            opacity: 0.85;
        }

        .final-status {
            color: #8b7d76;
            font-size: 11px;
        }


        /* =========================================================
           MOBILE ORDERS
        ========================================================= */

        .mobile-orders {
            display: none;
        }

        .mobile-order-card {
            background: #ffffff;

            border: 1px solid #e2dad5;

            margin-bottom: 18px;
        }

        .mobile-order-header {
            padding: 16px;

            background: #f1ece8;

            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 12px;
        }

        .mobile-order-number {
            font-size: 13px;
            font-weight: 600;

            letter-spacing: 0.6px;

            color: #2e2723;
        }

        .mobile-products {
            padding: 16px;
        }

        .mobile-products .order-products {
            min-width: 0;
            width: 100%;
        }

        .mobile-order-information {
            padding: 0 16px 16px;
        }

        .mobile-info-grid {
            border-top: 1px solid #eee8e4;
            border-bottom: 1px solid #eee8e4;

            padding: 14px 0;

            display: grid;
            grid-template-columns: 1fr 1fr;

            gap: 14px 18px;
        }

        .mobile-info-item {
            min-width: 0;
        }

        .mobile-info-label {
            display: block;

            margin-bottom: 5px;

            color: #8a7d76;

            font-size: 8px;
            font-weight: 600;

            letter-spacing: 1px;

            text-transform: uppercase;
        }

        .mobile-info-value {
            display: block;

            color: #2e2723;

            font-size: 11px;
            line-height: 1.45;

            overflow-wrap: anywhere;
        }

        .mobile-total-value {
            font-size: 14px;
            font-weight: 600;
        }

        .mobile-order-action {
            padding: 0 16px 16px;
        }

        .mobile-order-action .status-form {
            width: 100%;
        }

        .mobile-order-action .status-form button {
            width: 100%;

            padding: 13px 15px;
        }

        .mobile-final-status {
            width: 100%;

            padding: 12px;

            background: #f7f5f2;

            text-align: center;

            color: #8b7d76;

            font-size: 10px;

            letter-spacing: 0.5px;
        }


        /* =========================================================
           EMPTY
        ========================================================= */

        .empty {
            padding: 40px;

            text-align: center;

            color: #8a7d76;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 1024px) {

            .admin-header {
                padding: 0 28px;
            }

            .container {
                width: 94%;
                margin: 32px auto;
            }

            th {
                padding: 13px 10px;
                font-size: 9px;
            }

            td {
                padding: 14px 10px;
                font-size: 11px;
            }

            .order-products {
                min-width: 250px;
            }

            .product-image-box {
                width: 55px;
                height: 70px;
            }

            .status {
                min-width: 78px;
                padding: 6px 9px;

                font-size: 8px;
            }

            .status-form button {
                padding: 8px 9px;

                font-size: 8px;
                letter-spacing: 0.5px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 768px) {

            .admin-header {
                min-height: 64px;

                padding: 0 18px;
            }

            .admin-logo {
                font-size: 19px;
                letter-spacing: 2.5px;
            }

            .header-links {
                gap: 14px;
            }

            .header-links a {
                font-size: 8px;
                letter-spacing: 1px;
            }

            .container {
                width: auto;

                margin: 27px 14px 40px;
            }

            .page-header {
                margin-bottom: 22px;
            }

            .page-header h1 {
                font-size: 25px;

                margin-bottom: 7px;
            }

            .page-header p {
                font-size: 12px;

                line-height: 1.5;
            }

            .message {
                padding: 11px 13px;

                margin-bottom: 16px;

                font-size: 11px;

                line-height: 1.5;
            }

            /*
             * Desktop table disappears.
             * Mobile cards appear.
             */
            .desktop-orders {
                display: none;
            }

            .mobile-orders {
                display: block;
            }

            .product-image-box {
                width: 58px;
                height: 74px;
            }

            .product-name {
                font-size: 11px;
            }

            .product-brand {
                font-size: 9px;
            }

            .product-meta {
                font-size: 9px;
            }

            .status {
                min-width: 76px;

                padding: 6px 9px;

                font-size: 7px;
                letter-spacing: 0.6px;
            }

            .empty {
                padding: 40px 15px;

                font-size: 12px;
            }
        }


        /* =========================================================
           SMALL MOBILE
        ========================================================= */

        @media (max-width: 480px) {

            .admin-header {
                min-height: 60px;

                padding: 0 13px;
            }

            .admin-logo {
                font-size: 17px;
                letter-spacing: 2px;
            }

            .header-links {
                gap: 10px;
            }

            .header-links a {
                font-size: 7px;
                letter-spacing: 0.7px;
            }

            .container {
                margin: 22px 10px 35px;
            }

            .page-header {
                margin-bottom: 18px;
            }

            .page-header h1 {
                font-size: 22px;
            }

            .page-header p {
                font-size: 11px;
            }

            .mobile-order-card {
                margin-bottom: 14px;
            }

            .mobile-order-header {
                padding: 13px 12px;
            }

            .mobile-order-number {
                font-size: 11px;
            }

            .mobile-products {
                padding: 13px 12px;
            }

            .mobile-order-information {
                padding: 0 12px 13px;
            }

            .mobile-order-action {
                padding: 0 12px 13px;
            }

            .mobile-info-grid {
                gap: 12px 14px;
            }

            .mobile-info-label {
                font-size: 7px;
            }

            .mobile-info-value {
                font-size: 10px;
            }

            .mobile-total-value {
                font-size: 13px;
            }

            .product-image-box {
                width: 54px;
                height: 69px;
            }

            .product-name {
                font-size: 10px;
            }

            .product-brand {
                font-size: 8px;
            }

            .product-meta {
                font-size: 8px;
            }

            .mobile-order-action .status-form button {
                padding: 12px;

                font-size: 8px;
            }
        }


        /* =========================================================
           VERY SMALL MOBILE
        ========================================================= */

        @media (max-width: 360px) {

            .admin-header {
                padding: 0 10px;
            }

            .admin-logo {
                font-size: 16px;
            }

            .header-links {
                gap: 8px;
            }

            .container {
                margin-left: 8px;
                margin-right: 8px;
            }

            .mobile-order-header {
                padding: 12px 10px;
            }

            .mobile-products {
                padding: 12px 10px;
            }

            .mobile-order-information {
                padding: 0 10px 12px;
            }

            .mobile-order-action {
                padding: 0 10px 12px;
            }

            .mobile-info-grid {
                gap: 11px 10px;
            }

            .product-image-box {
                width: 50px;
                height: 64px;
            }
        }

    </style>

</head>

<body>


<header class="admin-header">

    <div class="admin-logo">
        GENTLUX
    </div>

    <div class="header-links">

        <a href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</header>


<main class="container">

    <section class="page-header">

        <h1>
            Manage Orders
        </h1>

        <p>
            View ordered products and update customer order statuses.
        </p>

    </section>


    <%
        String updateStatus =
                request.getParameter("updateStatus");

        if ("success".equals(updateStatus)) {
    %>

        <div class="message">
            Order status updated successfully.
        </div>

    <%
        } else if ("failed".equals(updateStatus)) {
    %>

        <div class="message error-message">
            Order status could not be updated.
        </div>

    <%
        }
    %>


    <%
        if (orders != null && !orders.isEmpty()) {
    %>


    <!-- =========================================================
         DESKTOP / TABLET ORDERS TABLE
    ========================================================== -->

    <div class="desktop-orders">

        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>Order ID</th>
                        <th>Products</th>
                        <th>User ID</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Payment</th>
                        <th>Status</th>
                        <th>Update</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    for (Order order : orders) {

                        String status =
                                order.getOrderStatus();

                        String statusClass =
                                "status-default";

                        if (status != null) {

                            if (status.equalsIgnoreCase("PLACED")) {

                                statusClass =
                                        "status-placed";

                            } else if (
                                    status.equalsIgnoreCase("CONFIRMED")
                            ) {

                                statusClass =
                                        "status-confirmed";

                            } else if (
                                    status.equalsIgnoreCase("SHIPPED")
                            ) {

                                statusClass =
                                        "status-shipped";

                            } else if (
                                    status.equalsIgnoreCase("DELIVERED")
                            ) {

                                statusClass =
                                        "status-delivered";

                            } else if (
                                    status.equalsIgnoreCase("CANCELLED")
                            ) {

                                statusClass =
                                        "status-cancelled";
                            }
                        }

                        List<OrderItemView> orderItems = null;

                        if (orderItemsMap != null) {

                            orderItems =
                                    orderItemsMap.get(
                                            order.getOrderId()
                                    );
                        }
                %>

                    <tr>

                        <!-- ORDER ID -->

                        <td>
                            #<%= order.getOrderId() %>
                        </td>


                        <!-- PRODUCTS -->

                        <td>

                            <div class="order-products">

                            <%
                                if (
                                        orderItems != null &&
                                        !orderItems.isEmpty()
                                ) {

                                    for (OrderItemView item : orderItems) {

                                        String imageUrl =
                                                item.getImageUrl();

                                        boolean hasImage =
                                                imageUrl != null &&
                                                !imageUrl.trim().isEmpty();

                                        String finalImageUrl = null;

                                        if (hasImage) {

                                            imageUrl =
                                                    imageUrl.trim();

                                            if (
                                                imageUrl.startsWith("http://") ||
                                                imageUrl.startsWith("https://")
                                            ) {

                                                finalImageUrl =
                                                        imageUrl;

                                            } else {

                                                if (
                                                    imageUrl.startsWith("/")
                                                ) {

                                                    imageUrl =
                                                        imageUrl.substring(1);
                                                }

                                                finalImageUrl =
                                                        request.getContextPath()
                                                        + "/"
                                                        + imageUrl;
                                            }
                                        }
                            %>

                                <div class="order-product">

                                    <div class="product-image-box">

                                    <%
                                        if (hasImage) {
                                    %>

                                        <img
                                            src="<%= finalImageUrl %>"
                                            alt="<%= item.getProductName() %>"
                                            loading="lazy"
                                            onerror="
                                                this.style.display='none';
                                                this.nextElementSibling.style.display='flex';
                                            ">

                                        <div
                                            class="product-image-placeholder"
                                            style="display:none;">
                                            GENTLUX
                                        </div>

                                    <%
                                        } else {
                                    %>

                                        <div class="product-image-placeholder">
                                            GENTLUX
                                        </div>

                                    <%
                                        }
                                    %>

                                    </div>


                                    <div class="product-details">

                                        <div class="product-name">

                                            <%= item.getProductName() != null
                                                    ? item.getProductName()
                                                    : "Product" %>

                                        </div>

                                        <div class="product-brand">

                                            <%= item.getBrand() != null
                                                    ? item.getBrand()
                                                    : "GENTLUX" %>

                                        </div>

                                        <div class="product-meta">

                                            Size:
                                            <strong>
                                                <%= item.getSize() != null
                                                        ? item.getSize()
                                                        : "-" %>
                                            </strong>

                                            <br>

                                            Qty:
                                            <strong>
                                                <%= item.getQuantity() %>
                                            </strong>

                                            <br>

                                            ₹<%= String.format(
                                                    "%.2f",
                                                    item.getPrice()
                                            ) %>

                                        </div>

                                    </div>

                                </div>

                            <%
                                    }

                                } else {
                            %>

                                <div class="no-products">
                                    No product details
                                </div>

                            <%
                                }
                            %>

                            </div>

                        </td>


                        <!-- USER -->

                        <td>
                            <%= order.getUserId() %>
                        </td>


                        <!-- DATE -->

                        <td>

                            <%= order.getOrderDate() != null
                                    ? order.getOrderDate()
                                    : "-" %>

                        </td>


                        <!-- TOTAL -->

                        <td>

                            ₹<%= String.format(
                                    "%.2f",
                                    order.getTotalAmount()
                            ) %>

                        </td>


                        <!-- PAYMENT -->

                        <td>

                            <%= order.getPaymentMethod() != null
                                    ? order.getPaymentMethod()
                                    : "-" %>

                        </td>


                        <!-- STATUS -->

                        <td>

                            <span class="status <%= statusClass %>">

                                <%= status != null
                                        ? status
                                        : "-" %>

                            </span>

                        </td>


                        <!-- ACTION -->

                        <td>

                        <%
                            if ("PLACED".equalsIgnoreCase(status)) {
                        %>

                            <form
                                class="status-form"
                                action="${pageContext.request.contextPath}/admin/update-order-status"
                                method="post">

                                <input
                                    type="hidden"
                                    name="orderId"
                                    value="<%= order.getOrderId() %>">

                                <input
                                    type="hidden"
                                    name="status"
                                    value="CONFIRMED">

                                <button type="submit">
                                    CONFIRM
                                </button>

                            </form>

                        <%
                            } else if (
                                    "CONFIRMED".equalsIgnoreCase(status)
                            ) {
                        %>

                            <form
                                class="status-form"
                                action="${pageContext.request.contextPath}/admin/update-order-status"
                                method="post">

                                <input
                                    type="hidden"
                                    name="orderId"
                                    value="<%= order.getOrderId() %>">

                                <input
                                    type="hidden"
                                    name="status"
                                    value="SHIPPED">

                                <button type="submit">
                                    MARK SHIPPED
                                </button>

                            </form>

                        <%
                            } else if (
                                    "SHIPPED".equalsIgnoreCase(status)
                            ) {
                        %>

                            <form
                                class="status-form"
                                action="${pageContext.request.contextPath}/admin/update-order-status"
                                method="post">

                                <input
                                    type="hidden"
                                    name="orderId"
                                    value="<%= order.getOrderId() %>">

                                <input
                                    type="hidden"
                                    name="status"
                                    value="DELIVERED">

                                <button type="submit">
                                    MARK DELIVERED
                                </button>

                            </form>

                        <%
                            } else {
                        %>

                            <span class="final-status">
                                No action
                            </span>

                        <%
                            }
                        %>

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>



    <!-- =========================================================
         MOBILE ORDERS
    ========================================================== -->

    <div class="mobile-orders">

    <%
        for (Order order : orders) {

            String status =
                    order.getOrderStatus();

            String statusClass =
                    "status-default";

            if (status != null) {

                if (status.equalsIgnoreCase("PLACED")) {

                    statusClass =
                            "status-placed";

                } else if (
                        status.equalsIgnoreCase("CONFIRMED")
                ) {

                    statusClass =
                            "status-confirmed";

                } else if (
                        status.equalsIgnoreCase("SHIPPED")
                ) {

                    statusClass =
                            "status-shipped";

                } else if (
                        status.equalsIgnoreCase("DELIVERED")
                ) {

                    statusClass =
                            "status-delivered";

                } else if (
                        status.equalsIgnoreCase("CANCELLED")
                ) {

                    statusClass =
                            "status-cancelled";
                }
            }

            List<OrderItemView> orderItems = null;

            if (orderItemsMap != null) {

                orderItems =
                        orderItemsMap.get(
                                order.getOrderId()
                        );
            }
    %>

        <article class="mobile-order-card">


            <!-- MOBILE ORDER HEADER -->

            <div class="mobile-order-header">

                <div class="mobile-order-number">
                    ORDER #<%= order.getOrderId() %>
                </div>

                <span class="status <%= statusClass %>">

                    <%= status != null
                            ? status
                            : "-" %>

                </span>

            </div>


            <!-- MOBILE PRODUCTS -->

            <div class="mobile-products">

                <div class="order-products">

                <%
                    if (
                            orderItems != null &&
                            !orderItems.isEmpty()
                    ) {

                        for (OrderItemView item : orderItems) {

                            String imageUrl =
                                    item.getImageUrl();

                            boolean hasImage =
                                    imageUrl != null &&
                                    !imageUrl.trim().isEmpty();

                            String finalImageUrl = null;

                            if (hasImage) {

                                imageUrl =
                                        imageUrl.trim();

                                if (
                                    imageUrl.startsWith("http://") ||
                                    imageUrl.startsWith("https://")
                                ) {

                                    finalImageUrl =
                                            imageUrl;

                                } else {

                                    if (
                                        imageUrl.startsWith("/")
                                    ) {

                                        imageUrl =
                                                imageUrl.substring(1);
                                    }

                                    finalImageUrl =
                                            request.getContextPath()
                                            + "/"
                                            + imageUrl;
                                }
                            }
                %>

                    <div class="order-product">

                        <div class="product-image-box">

                        <%
                            if (hasImage) {
                        %>

                            <img
                                src="<%= finalImageUrl %>"
                                alt="<%= item.getProductName() %>"
                                loading="lazy"
                                onerror="
                                    this.style.display='none';
                                    this.nextElementSibling.style.display='flex';
                                ">

                            <div
                                class="product-image-placeholder"
                                style="display:none;">
                                GENTLUX
                            </div>

                        <%
                            } else {
                        %>

                            <div class="product-image-placeholder">
                                GENTLUX
                            </div>

                        <%
                            }
                        %>

                        </div>


                        <div class="product-details">

                            <div class="product-name">

                                <%= item.getProductName() != null
                                        ? item.getProductName()
                                        : "Product" %>

                            </div>

                            <div class="product-brand">

                                <%= item.getBrand() != null
                                        ? item.getBrand()
                                        : "GENTLUX" %>

                            </div>

                            <div class="product-meta">

                                Size:
                                <strong>
                                    <%= item.getSize() != null
                                            ? item.getSize()
                                            : "-" %>
                                </strong>

                                &nbsp; | &nbsp;

                                Qty:
                                <strong>
                                    <%= item.getQuantity() %>
                                </strong>

                                <br>

                                ₹<%= String.format(
                                        "%.2f",
                                        item.getPrice()
                                ) %>

                            </div>

                        </div>

                    </div>

                <%
                        }

                    } else {
                %>

                    <div class="no-products">
                        No product details
                    </div>

                <%
                    }
                %>

                </div>

            </div>


            <!-- MOBILE ORDER INFORMATION -->

            <div class="mobile-order-information">

                <div class="mobile-info-grid">


                    <div class="mobile-info-item">

                        <span class="mobile-info-label">
                            User ID
                        </span>

                        <span class="mobile-info-value">
                            <%= order.getUserId() %>
                        </span>

                    </div>


                    <div class="mobile-info-item">

                        <span class="mobile-info-label">
                            Payment
                        </span>

                        <span class="mobile-info-value">

                            <%= order.getPaymentMethod() != null
                                    ? order.getPaymentMethod()
                                    : "-" %>

                        </span>

                    </div>


                    <div class="mobile-info-item">

                        <span class="mobile-info-label">
                            Date
                        </span>

                        <span class="mobile-info-value">

                            <%= order.getOrderDate() != null
                                    ? order.getOrderDate()
                                    : "-" %>

                        </span>

                    </div>


                    <div class="mobile-info-item">

                        <span class="mobile-info-label">
                            Total
                        </span>

                        <span class="mobile-info-value mobile-total-value">

                            ₹<%= String.format(
                                    "%.2f",
                                    order.getTotalAmount()
                            ) %>

                        </span>

                    </div>


                </div>

            </div>


            <!-- MOBILE STATUS ACTION -->

            <div class="mobile-order-action">

            <%
                if ("PLACED".equalsIgnoreCase(status)) {
            %>

                <form
                    class="status-form"
                    action="${pageContext.request.contextPath}/admin/update-order-status"
                    method="post">

                    <input
                        type="hidden"
                        name="orderId"
                        value="<%= order.getOrderId() %>">

                    <input
                        type="hidden"
                        name="status"
                        value="CONFIRMED">

                    <button type="submit">
                        CONFIRM ORDER
                    </button>

                </form>

            <%
                } else if (
                        "CONFIRMED".equalsIgnoreCase(status)
                ) {
            %>

                <form
                    class="status-form"
                    action="${pageContext.request.contextPath}/admin/update-order-status"
                    method="post">

                    <input
                        type="hidden"
                        name="orderId"
                        value="<%= order.getOrderId() %>">

                    <input
                        type="hidden"
                        name="status"
                        value="SHIPPED">

                    <button type="submit">
                        MARK AS SHIPPED
                    </button>

                </form>

            <%
                } else if (
                        "SHIPPED".equalsIgnoreCase(status)
                ) {
            %>

                <form
                    class="status-form"
                    action="${pageContext.request.contextPath}/admin/update-order-status"
                    method="post">

                    <input
                        type="hidden"
                        name="orderId"
                        value="<%= order.getOrderId() %>">

                    <input
                        type="hidden"
                        name="status"
                        value="DELIVERED">

                    <button type="submit">
                        MARK AS DELIVERED
                    </button>

                </form>

            <%
                } else {
            %>

                <div class="mobile-final-status">
                    No further action required
                </div>

            <%
                }
            %>

            </div>


        </article>

    <%
        }
    %>

    </div>


    <%
        } else {
    %>

        <div class="empty">
            No orders found.
        </div>

    <%
        }
    %>


</main>

</body>
</html>