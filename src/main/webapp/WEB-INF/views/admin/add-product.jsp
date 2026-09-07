<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Category" %>

<%
    List<Category> categories =
            (List<Category>) request.getAttribute("categories");

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

    <title>Add Product | GentLux Admin</title>

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
            width: min(850px, 92%);
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

        .error-message {
            padding: 13px 16px;
            margin-bottom: 20px;

            background: #f4e6e6;
            border: 1px solid #e4caca;

            color: #8a3030;

            font-size: 12px;
        }

        .product-form {
            background: white;

            border: 1px solid #e2dad5;

            padding: 35px;
        }

        .form-grid {
            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap: 22px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.2px;
            text-transform: uppercase;

            color: #665a54;
        }

        input,
        select,
        textarea {
            width: 100%;

            padding: 13px 14px;

            border: 1px solid #d9d0ca;
            outline: none;

            background: white;

            color: #2e2723;

            font-family: Arial, sans-serif;
            font-size: 13px;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #2e2723;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .required {
            color: #9b4b4b;
        }

        .form-note {
            margin-top: 6px;

            font-size: 10px;
            color: #948780;

            line-height: 1.5;
        }

        .form-actions {
            margin-top: 30px;

            display: flex;
            align-items: center;
            gap: 12px;
        }

        .submit-button {
            padding: 13px 24px;

            border: none;

            background: #2e2723;
            color: white;

            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.3px;

            cursor: pointer;
        }

        .submit-button:hover {
            opacity: 0.88;
        }

        .cancel-button {
            padding: 12px 24px;

            border: 1px solid #2e2723;

            background: white;
            color: #2e2723;

            text-decoration: none;

            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.3px;
        }

        .cancel-button:hover {
            background: #f1ece8;
        }

        @media (max-width: 650px) {

            .admin-header {
                padding: 0 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: auto;
            }

            .product-form {
                padding: 22px;
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
            Add Product
        </h1>

        <p>
            Add a new product to the GentLux catalogue.
        </p>

    </section>


    <% if (error != null) { %>

        <div class="error-message">
            <%= error %>
        </div>

    <% } %>


    <form
        action="${pageContext.request.contextPath}/admin/add-product"
        method="post"
        class="product-form">


        <div class="form-grid">


            <!-- CATEGORY -->

            <div class="form-group">

                <label for="categoryId">

                    Category
                    <span class="required">*</span>

                </label>


                <select
                    id="categoryId"
                    name="categoryId"
                    required>

                    <option value="">
                        Select Category
                    </option>


                    <%
                        if (categories != null) {

                            for (Category category : categories) {
                    %>

                        <option
                            value="<%= category.getCategoryId() %>">

                            <%= category.getCategoryName() %>

                        </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <!-- PRODUCT NAME -->

            <div class="form-group">

                <label for="productName">

                    Product Name
                    <span class="required">*</span>

                </label>

                <input
                    type="text"
                    id="productName"
                    name="productName"
                    maxlength="150"
                    required>

            </div>


            <!-- BRAND -->

            <div class="form-group">

                <label for="brand">
                    Brand
                </label>

                <input
                    type="text"
                    id="brand"
                    name="brand"
                    maxlength="100">

            </div>


            <!-- COLOR -->

            <div class="form-group">

                <label for="color">
                    Color
                </label>

                <input
                    type="text"
                    id="color"
                    name="color"
                    maxlength="50">

            </div>


            <!-- PRICE -->

            <div class="form-group">

                <label for="price">

                    Selling Price
                    <span class="required">*</span>

                </label>

                <input
                    type="number"
                    id="price"
                    name="price"
                    min="0"
                    step="0.01"
                    required>

            </div>


            <!-- MRP -->

            <div class="form-group">

                <label for="mrp">

                    MRP
                    <span class="required">*</span>

                </label>

                <input
                    type="number"
                    id="mrp"
                    name="mrp"
                    min="0"
                    step="0.01"
                    required>

            </div>


            <!-- DISCOUNT -->

            <div class="form-group">

                <label for="discount">
                    Discount %
                </label>

                <input
                    type="number"
                    id="discount"
                    name="discount"
                    min="0"
                    max="100"
                    step="0.01"
                    value="0">

            </div>


            <!-- IMAGE URL -->

            <div class="form-group">

                <label for="imageUrl">
                    Image URL
                </label>

                <input
                    type="text"
                    id="imageUrl"
                    name="imageUrl"
                    maxlength="500">

                <div class="form-note">
                    We can configure the actual product images later.
                </div>

            </div>


            <!-- DESCRIPTION -->

            <div class="form-group full-width">

                <label for="description">
                    Description
                </label>

                <textarea
                    id="description"
                    name="description"
                    maxlength="2000"></textarea>

            </div>


        </div>


        <div class="form-actions">


            <button
                type="submit"
                class="submit-button">

                ADD PRODUCT

            </button>


            <a
                href="${pageContext.request.contextPath}/admin/products"
                class="cancel-button">

                CANCEL

            </a>


        </div>


    </form>


</main>


</body>

</html>