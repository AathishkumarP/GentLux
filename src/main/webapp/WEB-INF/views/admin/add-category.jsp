<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String error =
            (String) request.getAttribute("error");

    String categoryName =
            (String) request.getAttribute("categoryName");

    if (categoryName == null) {
        categoryName = "";
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Add Category | GentLux Admin</title>


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

        .error-message {
            padding: 13px 16px;

            margin-bottom: 20px;

            background: #f4e6e6;

            border: 1px solid #e4caca;

            color: #8a3030;

            font-size: 12px;
        }

        .category-form {
            padding: 30px;

            background: white;

            border: 1px solid #e2dad5;
        }

        .form-group {
            display: flex;
            flex-direction: column;

            gap: 8px;

            margin-bottom: 25px;
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

        <a href="${pageContext.request.contextPath}/admin/categories">
            Categories
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</header>


<main class="container">


    <section class="page-heading">

        <h1>
            Add Category
        </h1>

        <p>
            Create a new product category.
        </p>

    </section>


    <% if (error != null) { %>

        <div class="error-message">

            <%= error %>

        </div>

    <% } %>


    <form
        action="${pageContext.request.contextPath}/admin/add-category"
        method="post"
        class="category-form">


        <div class="form-group">

            <label for="categoryName">
                Category Name
            </label>


            <input
                type="text"
                id="categoryName"
                name="categoryName"
                value="<%= categoryName %>"
                placeholder="Example: Accessories"
                maxlength="50"
                required>

        </div>


        <div class="form-actions">


            <button
                type="submit"
                class="submit-button">

                ADD CATEGORY

            </button>


            <a
                href="${pageContext.request.contextPath}/admin/categories"
                class="cancel-button">

                CANCEL

            </a>


        </div>


    </form>


</main>


</body>

</html>