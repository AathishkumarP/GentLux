<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Product" %>
<%@ page import="com.gentlux.model.ProductVariant" %>

<%
    Product product =
            (Product) request.getAttribute("product");

    List<ProductVariant> variants =
            (List<ProductVariant>) request.getAttribute("variants");


    /*
     * =========================================
     * PRODUCT IMAGE
     * =========================================
     */

    String stockImageUrl =
            product != null
            ? product.getImageUrl()
            : null;


    boolean hasStockImage =
            stockImageUrl != null
            && !stockImageUrl.trim().isEmpty();


    String finalStockImageUrl =
            null;


    if (hasStockImage) {

        stockImageUrl =
                stockImageUrl.trim();


        if (stockImageUrl.startsWith("http://")
                || stockImageUrl.startsWith("https://")) {

            finalStockImageUrl =
                    stockImageUrl;

        } else {

            if (stockImageUrl.startsWith("/")) {

                stockImageUrl =
                        stockImageUrl.substring(1);
            }


            finalStockImageUrl =
                    request.getContextPath()
                    + "/"
                    + stockImageUrl;
        }
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Product Stock | GentLux Admin</title>


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
           ADMIN HEADER
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

            opacity: 0.7;
        }


        /* =========================================
           MAIN CONTAINER
        ========================================= */

        .container {

            width: min(1000px, 92%);

            margin: 45px auto;
        }


        /* =========================================
           PAGE HEADER
        ========================================= */

        .page-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

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


        /* =========================================
           ADD SIZE BUTTON
        ========================================= */

        .add-button {

            display: inline-block;

            padding: 12px 18px;

            background: #2e2723;

            color: white;

            text-decoration: none;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1.2px;

            white-space: nowrap;
        }


        .add-button:hover {

            opacity: 0.85;
        }


        /* =========================================
           PRODUCT INFORMATION
        ========================================= */

        .product-info {

            background: white;

            border: 1px solid #e2dad5;

            padding: 22px;

            margin-bottom: 25px;

            display: flex;

            align-items: center;

            gap: 22px;
        }


        .product-info-image {

            width: 120px;

            height: 150px;

            flex-shrink: 0;

            overflow: hidden;

            background: #f1ece8;

            border: 1px solid #e2dad5;

            display: flex;

            align-items: center;

            justify-content: center;
        }


        .product-info-image img {

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

            font-size: 9px;

            font-weight: 600;

            letter-spacing: 2px;

            text-align: center;
        }


        .product-info-content {

            flex: 1;
        }


        .product-info h2 {

            font-size: 18px;

            font-weight: 600;

            margin-bottom: 10px;
        }


        .product-info p {

            font-size: 12px;

            color: #7c7069;

            line-height: 1.7;
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


        th {

            padding: 15px 14px;

            background: #f1ece8;

            text-align: left;

            font-size: 10px;

            font-weight: 600;

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


        /* =========================================
           STOCK COLORS
        ========================================= */

        .stock {

            font-weight: 600;
        }


        .low-stock {

            color: #a15c31;
        }


        .out-stock {

            color: #a53333;
        }


        /* =========================================
           EDIT STOCK BUTTON
        ========================================= */

        .action-link {

            display: inline-block;

            padding: 8px 12px;

            border: 1px solid #2e2723;

            text-decoration: none;

            color: #2e2723;

            font-size: 9px;

            font-weight: 600;

            letter-spacing: 1px;
        }


        .action-link:hover {

            background: #2e2723;

            color: white;
        }


        /* =========================================
           EMPTY STATE
        ========================================= */

        .empty {

            padding: 40px;

            background: white;

            border: 1px solid #e2dad5;

            text-align: center;

            color: #81746d;

            font-size: 13px;
        }


        /* =========================================
           RESPONSIVE
        ========================================= */

        @media (max-width: 650px) {

            .admin-header {

                padding: 0 20px;
            }


            .header-links {

                gap: 12px;
            }


            .page-header {

                flex-direction: column;

                align-items: flex-start;
            }


            .product-info {

                align-items: flex-start;

                flex-direction: column;
            }


            .product-info-image {

                width: 100%;

                height: 300px;
            }

        }

    </style>

</head>


<body>


<!-- =========================================
     ADMIN HEADER
========================================= -->

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


<!-- =========================================
     MAIN CONTENT
========================================= -->

<main class="container">


    <!-- PAGE HEADER -->

    <section class="page-header">


        <div>


            <h1>

                Product Stock

            </h1>


            <p>

                Manage product sizes and available quantity.

            </p>


        </div>


        <a
            href="${pageContext.request.contextPath}/admin/add-variant?productId=<%= product.getProductId() %>"
            class="add-button">

            + ADD SIZE

        </a>


    </section>


    <!-- =========================================
         PRODUCT INFORMATION
    ========================================= -->

    <div class="product-info">


        <!-- PRODUCT IMAGE -->

        <div class="product-info-image">


            <%

                if (hasStockImage
                        && finalStockImageUrl != null) {

            %>


                <img
                    src="<%= finalStockImageUrl %>"
                    alt="<%= product.getProductName() %>"
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


        <!-- PRODUCT DETAILS -->

        <div class="product-info-content">


            <h2>

                <%= product.getProductName() %>

            </h2>


            <p>

                Product ID:

                #<%= product.getProductId() %>


                &nbsp; | &nbsp;


                Brand:

                <%= product.getBrand() != null
                        ? product.getBrand()
                        : "-" %>


                &nbsp; | &nbsp;


                Color:

                <%= product.getColor() != null
                        ? product.getColor()
                        : "-" %>


            </p>


        </div>


    </div>


    <!-- =========================================
         PRODUCT VARIANTS
    ========================================= -->

    <%

        if (variants != null
                && !variants.isEmpty()) {

    %>


    <div class="table-wrapper">


        <table>


            <thead>


                <tr>

                    <th>
                        Variant ID
                    </th>

                    <th>
                        Size
                    </th>

                    <th>
                        Stock
                    </th>

                    <th>
                        Action
                    </th>

                </tr>


            </thead>


            <tbody>


            <%

                for (ProductVariant variant : variants) {


                    String stockClass =
                            "stock";


                    if (variant.getStockQuantity() == 0) {


                        stockClass +=
                                " out-stock";


                    } else if (
                            variant.getStockQuantity() <= 5
                    ) {


                        stockClass +=
                                " low-stock";

                    }

            %>


                <tr>


                    <!-- VARIANT ID -->

                    <td>

                        #<%= variant.getVariantId() %>

                    </td>


                    <!-- SIZE -->

                    <td>

                        <%= variant.getSize() != null
                                ? variant.getSize()
                                : "-" %>

                    </td>


                    <!-- STOCK -->

                    <td class="<%= stockClass %>">

                        <%= variant.getStockQuantity() %>

                    </td>


                    <!-- ACTION -->

                    <td>


                        <a
                            href="${pageContext.request.contextPath}/admin/edit-stock?variantId=<%= variant.getVariantId() %>&productId=<%= product.getProductId() %>"
                            class="action-link">

                            EDIT STOCK

                        </a>


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


        <!-- =========================================
             NO VARIANTS
        ========================================= -->

        <div class="empty">

            No sizes added for this product yet.

        </div>


    <%

        }

    %>


</main>


</body>

</html>