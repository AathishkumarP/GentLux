<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Product" %>

<%
    List<Product> products =
            (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Manage Products | GentLux Admin</title>


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
            font-weight: 600;
            letter-spacing: 3px;
        }

        .header-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .header-links a {
            color: white;
            text-decoration: none;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .container {
            width: min(1250px, 94%);
            margin: 40px auto;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;

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

        .add-button {
            display: inline-block;

            background: #2e2723;
            color: white;

            padding: 12px 18px;

            text-decoration: none;

            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.3px;
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

        .product-name {
            font-weight: 600;
        }

        .price {
            font-weight: 600;
        }

        .discount {
            color: #7a5f50;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .action-button {
            display: inline-block;

            padding: 9px 13px;

            text-decoration: none;

            border: 1px solid #2e2723;

            color: #2e2723;

            font-size: 9px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .action-button:hover {
            background: #2e2723;
            color: white;
        }

        .empty {
            padding: 40px;
            text-align: center;
            color: #82766f;
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

        <a href="${pageContext.request.contextPath}/admin/orders">
            Orders
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</header>


<main class="container">


    <section class="page-header">

        <div>

            <h1>
                Manage Products
            </h1>

            <p>
                View and manage GentLux products.
            </p>

        </div>


        <a
            href="${pageContext.request.contextPath}/admin/add-product"
            class="add-button">

            + ADD PRODUCT

        </a>

    </section>


    <%
        if (products != null && !products.isEmpty()) {
    %>


    <div class="table-wrapper">

        <table>


            <thead>

                <tr>

                    <th>ID</th>

                    <th>Product</th>

                    <th>Brand</th>

                    <th>Color</th>

                    <th>Price</th>

                    <th>MRP</th>

                    <th>Discount</th>

                    <th>Category ID</th>

                    <th>Actions</th>

                </tr>

            </thead>


            <tbody>


            <%
                for (Product product : products) {
            %>


                <tr>


                    <td>
                        #<%= product.getProductId() %>
                    </td>


                    <td class="product-name">

                        <%= product.getProductName() != null
                                ? product.getProductName()
                                : "-" %>

                    </td>


                    <td>

                        <%= product.getBrand() != null
                                ? product.getBrand()
                                : "-" %>

                    </td>


                    <td>

                        <%= product.getColor() != null
                                ? product.getColor()
                                : "-" %>

                    </td>


                    <td class="price">

                        ₹<%= String.format(
                                "%.2f",
                                product.getPrice()
                        ) %>

                    </td>


                    <td>

                        ₹<%= String.format(
                                "%.2f",
                                product.getMrp()
                        ) %>

                    </td>


                    <td class="discount">

                        <%= String.format(
                                "%.2f",
                                product.getDiscount()
                        ) %>%

                    </td>


                    <td>

                        <%= product.getCategoryId() %>

                    </td>


                    <td>

                        <div class="actions">


                            <a
                                href="${pageContext.request.contextPath}/admin/edit-product?productId=<%= product.getProductId() %>"
                                class="action-button">

                                EDIT

                            </a>


                            <a
                                href="${pageContext.request.contextPath}/admin/product-stock?productId=<%= product.getProductId() %>"
                                class="action-button">

                                STOCK

                            </a>


                        </div>

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

            No products found.

        </div>


    <%
        }
    %>


</main>


</body>

</html>