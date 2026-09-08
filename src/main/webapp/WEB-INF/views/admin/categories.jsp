<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gentlux.model.Category" %>

<%
    List<Category> categories =
            (List<Category>) request.getAttribute("categories");

    Map<Integer, Integer> productCounts =
            (Map<Integer, Integer>) request.getAttribute("productCounts");

    Integer totalCategories =
            (Integer) request.getAttribute("totalCategories");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Manage Categories | GentLux Admin</title>

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

        /* =========================================
           HEADER
           ========================================= */

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

        .header-links a:hover {
            opacity: 0.75;
        }

        /* =========================================
           MAIN
           ========================================= */

        .container {
            width: min(1150px, 92%);
            margin: 45px auto;
        }

        .page-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
            margin-bottom: 30px;
        }

        .page-heading {
            flex: 1;
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

        /* =========================================
           PAGE ACTIONS
           ========================================= */

        .page-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .total-box {
            padding: 12px 18px;
            background: #eee7e1;
            font-size: 11px;
            letter-spacing: 1px;
            white-space: nowrap;
        }

        .add-category-button {
            display: inline-block;
            padding: 13px 20px;
            background: #2e2723;
            color: white;
            text-decoration: none;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.2px;
            white-space: nowrap;
            transition: opacity 0.2s ease;
        }

        .add-category-button:hover {
            opacity: 0.85;
        }

        /* =========================================
           TABLE
           ========================================= */

        .table-wrapper {
            background: white;
            border: 1px solid #e2dad5;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #eee7e1;
        }

        th {
            padding: 16px 18px;
            text-align: left;
            font-size: 10px;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            color: #655b55;
        }

        td {
            padding: 18px;
            border-top: 1px solid #eee8e4;
            font-size: 13px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #faf8f6;
        }

        /* =========================================
           CATEGORY IMAGE
           ========================================= */

        .category-image-box {
            width: 85px;
            height: 85px;
            overflow: hidden;
            background: #f1ece8;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .category-image-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .category-image-placeholder {
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

        /* =========================================
           CATEGORY DATA
           ========================================= */

        .category-id {
            color: #8b7d74;
            font-size: 12px;
        }

        .category-name {
            font-weight: 600;
        }

        .product-count {
            display: inline-block;
            min-width: 38px;
            padding: 7px 10px;
            text-align: center;
            background: #eee7e1;
            font-size: 11px;
        }

        /* =========================================
           ACTION BUTTONS
           ========================================= */

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .edit-button {
            display: inline-block;
            padding: 8px 14px;
            background: #2e2723;
            color: white;
            text-decoration: none;
            font-size: 9px;
            font-weight: 600;
            letter-spacing: 1px;
            transition: opacity 0.2s ease;
        }

        .edit-button:hover {
            opacity: 0.85;
        }

        .delete-form {
            margin: 0;
        }

        .delete-button {
            padding: 8px 14px;
            border: 1px solid #9b4b4b;
            background: white;
            color: #9b4b4b;
            font-size: 9px;
            font-weight: 600;
            letter-spacing: 1px;
            cursor: pointer;
        }

        .delete-button:hover {
            background: #9b4b4b;
            color: white;
        }

        .delete-disabled {
            display: inline-block;
            padding: 8px 14px;
            border: 1px solid #d8d0cb;
            color: #aaa19b;
            font-size: 9px;
            font-weight: 600;
            letter-spacing: 1px;
            cursor: not-allowed;
        }

        /* =========================================
           EMPTY
           ========================================= */

        .no-data {
            text-align: center;
            padding: 50px;
            color: #897d76;
        }

        /* =========================================
           BACK
           ========================================= */

        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: #2e2723;
            text-decoration: none;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.2px;
        }

        .back-link:hover {
            opacity: 0.7;
        }

        /* =========================================
           RESPONSIVE
           ========================================= */

        @media (max-width: 750px) {

            .admin-header {
                padding: 0 20px;
            }

            .header-links {
                gap: 12px;
            }

            .page-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .page-actions {
                width: 100%;
                flex-wrap: wrap;
            }

            .category-image-box {
                width: 70px;
                height: 70px;
            }
        }

        @media (max-width: 550px) {

            .admin-header {
                flex-direction: column;
                align-items: flex-start;
                padding-top: 20px;
                padding-bottom: 20px;
                gap: 18px;
            }

            .header-links {
                flex-wrap: wrap;
            }

            .page-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .total-box,
            .add-category-button {
                text-align: center;
            }
        }

    </style>

</head>

<body>

<!-- =============================================
     ADMIN HEADER
     ============================================= -->

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

        <a href="${pageContext.request.contextPath}/admin/orders">
            Orders
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</header>


<!-- =============================================
     MAIN
     ============================================= -->

<main class="container">

    <div class="page-top">

        <div class="page-heading">

            <h1>
                Manage Categories
            </h1>

            <p>
                View and manage product categories.
            </p>

        </div>


        <div class="page-actions">

            <div class="total-box">

                TOTAL CATEGORIES:

                <strong>
                    <%= totalCategories != null
                            ? totalCategories
                            : 0 %>
                </strong>

            </div>


            <a
                href="${pageContext.request.contextPath}/admin/add-category"
                class="add-category-button">

                + ADD CATEGORY

            </a>

        </div>

    </div>


    <!-- =========================================
         CATEGORY TABLE
         ========================================= -->

    <div class="table-wrapper">

        <table>

            <thead>

                <tr>

                    <th>
                        Image
                    </th>

                    <th>
                        Category ID
                    </th>

                    <th>
                        Category Name
                    </th>

                    <th>
                        Products
                    </th>

                    <th>
                        Action
                    </th>

                </tr>

            </thead>


            <tbody>

            <%
                if (categories != null &&
                        !categories.isEmpty()) {

                    for (Category category : categories) {

                        int count = 0;

                        if (productCounts != null &&
                                productCounts.containsKey(
                                        category.getCategoryId())) {

                            count =
                                    productCounts.get(
                                            category.getCategoryId()
                                    );
                        }


                        // =========================================
                        // CATEGORY IMAGE
                        // =========================================

                        String categoryName =
                                category.getCategoryName();

                        String categoryImage = null;


                        if (categoryName != null) {

                            if (categoryName.equalsIgnoreCase("T-Shirts")) {

                                categoryImage =
                                        "T-Shirt.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Shirts")
                            ) {

                                categoryImage =
                                        "Shirt.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Jeans")
                            ) {

                                categoryImage =
                                        "Jeans.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Trousers")
                            ) {

                                categoryImage =
                                        "Trousers.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Jackets")
                            ) {

                                categoryImage =
                                        "Jackets.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Hoodies")
                            ) {

                                categoryImage =
                                        "Hoodies.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Sweatshirts")
                            ) {

                                categoryImage =
                                        "SweatShirt.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Shorts")
                            ) {

                                categoryImage =
                                        "Shorts.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Ethnic Wear")
                            ) {

                                categoryImage =
                                        "EthnicWear.jpg";

                            } else if (
                                    categoryName.equalsIgnoreCase("Footwear")
                            ) {

                                categoryImage =
                                        "Footwear.jpg";
                            }
                        }


                        String finalCategoryImage = null;

                        if (categoryImage != null) {

                            finalCategoryImage =
                                    request.getContextPath()
                                    + "/assets/images/categories/"
                                    + categoryImage;
                        }
            %>


                <tr>

                    <!-- CATEGORY IMAGE -->
                    <td>

                        <div class="category-image-box">

                            <%
                                if (finalCategoryImage != null) {
                            %>

                                <img
                                    src="<%= finalCategoryImage %>"
                                    alt="<%= categoryName %>"
                                    loading="lazy"
                                    onerror="
                                        this.style.display='none';
                                        this.nextElementSibling.style.display='flex';
                                    ">

                                <div
                                    class="category-image-placeholder"
                                    style="display:none;">
                                    GENTLUX
                                </div>

                            <%
                                } else {
                            %>

                                <div class="category-image-placeholder">
                                    GENTLUX
                                </div>

                            <%
                                }
                            %>

                        </div>

                    </td>


                    <!-- CATEGORY ID -->
                    <td class="category-id">

                        #<%= category.getCategoryId() %>

                    </td>


                    <!-- CATEGORY NAME -->
                    <td class="category-name">

                        <%= category.getCategoryName() %>

                    </td>


                    <!-- PRODUCT COUNT -->
                    <td>

                        <span class="product-count">
                            <%= count %>
                        </span>

                    </td>


                    <!-- ACTION -->
                    <td>

                        <div class="action-buttons">

                            <a
                                href="${pageContext.request.contextPath}/admin/edit-category?categoryId=<%= category.getCategoryId() %>"
                                class="edit-button">

                                EDIT

                            </a>


                            <% if (count == 0) { %>

                                <form
                                    action="${pageContext.request.contextPath}/admin/delete-category"
                                    method="post"
                                    class="delete-form"
                                    onsubmit="return confirmDelete('<%= category.getCategoryName() %>');">

                                    <input
                                        type="hidden"
                                        name="categoryId"
                                        value="<%= category.getCategoryId() %>">

                                    <button
                                        type="submit"
                                        class="delete-button">

                                        DELETE

                                    </button>

                                </form>

                            <% } else { %>

                                <span
                                    class="delete-disabled"
                                    title="Remove all products from this category before deleting it.">

                                    DELETE

                                </span>

                            <% } %>

                        </div>

                    </td>

                </tr>


            <%
                    }

                } else {
            %>


                <tr>

                    <td
                        colspan="5"
                        class="no-data">

                        No categories found.

                    </td>

                </tr>


            <%
                }
            %>

            </tbody>

        </table>

    </div>


    <a
        href="${pageContext.request.contextPath}/admin/dashboard"
        class="back-link">

        ← BACK TO DASHBOARD

    </a>

</main>


<script>

    function confirmDelete(categoryName) {

        return confirm(
            "Are you sure you want to delete the category \"" +
            categoryName +
            "\"?"
        );
    }

</script>

</body>

</html>