<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.gentlux.model.ProductVariant" %>

<%
    ProductVariant variant =
            (ProductVariant) request.getAttribute("variant");

    Integer productId =
            (Integer) request.getAttribute("productId");

    String error =
            (String) request.getAttribute("error");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Edit Stock | GentLux Admin</title>


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
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .container {
            width: min(650px, 92%);
            margin: 45px auto;
        }

        .page-heading {
            margin-bottom: 30px;
        }

        .page-heading h1 {
            font-size: 30px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .page-heading p {
            color: #82766f;
            font-size: 13px;
        }

        .variant-info {
            background: white;

            border: 1px solid #e2dad5;

            padding: 20px;

            margin-bottom: 20px;
        }

        .variant-info p {
            font-size: 12px;

            color: #746861;

            line-height: 1.8;
        }

        .variant-info strong {
            color: #2e2723;
        }

        .error-message {
            padding: 13px 16px;

            margin-bottom: 20px;

            background: #f4e6e6;

            border: 1px solid #e4caca;

            color: #8a3030;

            font-size: 12px;
        }

        .stock-form {
            padding: 30px;

            background: white;

            border: 1px solid #e2dad5;
        }

        .form-group {
            display: flex;
            flex-direction: column;

            gap: 8px;

            margin-bottom: 20px;
        }

        label {
            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1.2px;

            text-transform: uppercase;

            color: #665a54;
        }

        input {
            width: 100%;

            padding: 13px 14px;

            border: 1px solid #d9d0ca;

            background: white;

            color: #2e2723;

            font-size: 13px;

            outline: none;
        }

        input:focus {
            border-color: #2e2723;
        }

        .form-actions {
            margin-top: 25px;

            display: flex;
            gap: 12px;
        }

        .submit-button {
            padding: 13px 22px;

            border: none;

            background: #2e2723;

            color: white;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1.2px;

            cursor: pointer;
        }

        .submit-button:hover {
            opacity: 0.85;
        }

        .cancel-button {
            padding: 12px 22px;

            border: 1px solid #2e2723;

            text-decoration: none;

            color: #2e2723;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1.2px;
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

        <a href="${pageContext.request.contextPath}/admin/products">
            Products
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</header>


<main class="container">


    <section class="page-heading">

        <h1>
            Edit Stock
        </h1>

        <p>
            Update the available quantity for this product size.
        </p>

    </section>


    <% if (error != null) { %>

        <div class="error-message">
            <%= error %>
        </div>

    <% } %>


    <div class="variant-info">

        <p>

            Variant ID:
            <strong>
                #<%= variant.getVariantId() %>
            </strong>

        </p>


        <p>

            Product ID:
            <strong>
                #<%= variant.getProductId() %>
            </strong>

        </p>


        <p>

            Size:
            <strong>
                <%= variant.getSize() %>
            </strong>

        </p>


        <p>

            Current Stock:
            <strong>
                <%= variant.getStockQuantity() %>
            </strong>

        </p>

    </div>


    <form
        action="${pageContext.request.contextPath}/admin/edit-stock"
        method="post"
        class="stock-form">


        <input
            type="hidden"
            name="variantId"
            value="<%= variant.getVariantId() %>">


        <input
            type="hidden"
            name="productId"
            value="<%= productId %>">


        <div class="form-group">

            <label for="stockQuantity">
                New Stock Quantity
            </label>


            <input
                type="number"
                id="stockQuantity"
                name="stockQuantity"
                value="<%= variant.getStockQuantity() %>"
                min="0"
                required>

        </div>


        <div class="form-actions">


            <button
                type="submit"
                class="submit-button">

                UPDATE STOCK

            </button>


            <a
                href="${pageContext.request.contextPath}/admin/product-stock?productId=<%= productId %>"
                class="cancel-button">

                CANCEL

            </a>


        </div>


    </form>


</main>


</body>

</html>