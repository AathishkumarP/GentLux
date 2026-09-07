<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Order" %>

<%
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");
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

        body {
            font-family: Arial, sans-serif;
            background: #f7f5f2;
            color: #2e2723;
        }

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

        .container {
            width: min(1250px, 94%);
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

        .table-wrapper {
            overflow-x: auto;
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
        }

        td {
            padding: 16px 14px;
            border-top: 1px solid #eee8e4;
            font-size: 12px;
            vertical-align: middle;
        }

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

        .status-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-form select {
            min-width: 125px;
            padding: 9px 10px;

            border: 1px solid #d7cec8;
            background: white;
            color: #2e2723;

            font-size: 11px;
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
        }

        .status-form button:hover {
            opacity: 0.85;
        }

        .final-status {
            color: #8b7d76;
            font-size: 11px;
        }

        .empty {
            padding: 40px;
            text-align: center;
            color: #8a7d76;
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
            View and update customer order statuses.
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

    <div class="table-wrapper">

        <table>

            <thead>

                <tr>

                    <th>Order ID</th>

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
            %>


                <tr>

                    <td>
                        #<%= order.getOrderId() %>
                    </td>


                    <td>
                        <%= order.getUserId() %>
                    </td>


                    <td>

                        <%= order.getOrderDate() != null
                                ? order.getOrderDate()
                                : "-" %>

                    </td>


                    <td>
                        ₹<%= String.format(
                                "%.2f",
                                order.getTotalAmount()
                        ) %>
                    </td>


                    <td>

                        <%= order.getPaymentMethod() != null
                                ? order.getPaymentMethod()
                                : "-" %>

                    </td>


                    <td>

                        <span class="status <%= statusClass %>">

                            <%= status != null
                                    ? status
                                    : "-" %>

                        </span>

                    </td>


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