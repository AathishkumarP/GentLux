<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.gentlux.model.Product" %>

<%
    Product product =
            (Product) request.getAttribute("product");

    String error =
            (String) request.getAttribute("error");


    /*
     * =========================================
     * PRODUCT IMAGE
     * =========================================
     */

    String variantImageUrl =
            product != null
            ? product.getImageUrl()
            : null;

    boolean hasVariantImage =
            variantImageUrl != null
            && !variantImageUrl.trim().isEmpty();

    String finalVariantImageUrl = null;

    if (hasVariantImage) {

        variantImageUrl =
                variantImageUrl.trim();

        if (variantImageUrl.startsWith("http://")
                || variantImageUrl.startsWith("https://")) {

            finalVariantImageUrl =
                    variantImageUrl;

        } else {

            if (variantImageUrl.startsWith("/")) {

                variantImageUrl =
                        variantImageUrl.substring(1);
            }

            finalVariantImageUrl =
                    request.getContextPath()
                    + "/"
                    + variantImageUrl;
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

    <title>Add Size | GentLux Admin</title>


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

            width: min(650px, 92%);

            margin: 45px auto;
        }


        /* =========================================
           PAGE HEADING
        ========================================= */

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


        /* =========================================
           PRODUCT INFORMATION
        ========================================= */

        .product-info {

            padding: 20px;

            background: white;

            border: 1px solid #e2dad5;

            margin-bottom: 20px;

            display: flex;

            align-items: center;

            gap: 18px;
        }


        .product-image {

            width: 90px;

            height: 110px;

            flex-shrink: 0;

            overflow: hidden;

            background: #f1ece8;

            border: 1px solid #e2dad5;

            display: flex;

            align-items: center;

            justify-content: center;
        }


        .product-image img {

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

            letter-spacing: 1.5px;

            text-align: center;
        }


        .product-info-content {

            flex: 1;
        }


        .product-info h2 {

            font-size: 17px;

            margin-bottom: 8px;
        }


        .product-info p {

            font-size: 12px;

            color: #81756e;

            line-height: 1.7;
        }


        /* =========================================
           ERROR MESSAGE
        ========================================= */

        .error-message {

            padding: 13px 16px;

            margin-bottom: 20px;

            background: #f4e6e6;

            border: 1px solid #e4caca;

            color: #8a3030;

            font-size: 12px;
        }


        /* =========================================
           FORM
        ========================================= */

        .variant-form {

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


        input,
        select {

            width: 100%;

            padding: 13px 14px;

            border: 1px solid #d9d0ca;

            background: white;

            color: #2e2723;

            font-size: 13px;

            outline: none;
        }


        input:focus,
        select:focus {

            border-color: #2e2723;
        }


        /* =========================================
           FORM ACTIONS
        ========================================= */

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


        .cancel-button:hover {

            background: #2e2723;

            color: white;
        }


        /* =========================================
           RESPONSIVE
        ========================================= */

        @media (max-width: 550px) {

            .admin-header {

                padding: 0 20px;
            }


            .header-links {

                gap: 12px;
            }


            .product-info {

                align-items: flex-start;
            }


            .product-image {

                width: 80px;

                height: 100px;
            }


            .form-actions {

                flex-direction: column;
            }


            .submit-button,
            .cancel-button {

                text-align: center;
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


    <!-- =========================================
         PAGE HEADING
    ========================================= -->

    <section class="page-heading">


        <h1>

            Add Size

        </h1>


        <p>

            Add a new size and stock quantity.

        </p>


    </section>


    <!-- =========================================
         PRODUCT INFORMATION
    ========================================= -->

    <div class="product-info">


        <!-- PRODUCT IMAGE -->

        <div class="product-image">


            <%

                if (hasVariantImage
                        && finalVariantImageUrl != null) {

            %>


                <img
                    src="<%= finalVariantImageUrl %>"
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

            </p>


            <p>

                Brand:

                <%= product.getBrand() != null
                        && !product.getBrand().trim().isEmpty()
                        ? product.getBrand()
                        : "-" %>

            </p>


            <p>

                Color:

                <%= product.getColor() != null
                        && !product.getColor().trim().isEmpty()
                        ? product.getColor()
                        : "-" %>

            </p>


        </div>


    </div>


    <!-- =========================================
         ERROR MESSAGE
    ========================================= -->

    <%

        if (error != null) {

    %>


        <div class="error-message">

            <%= error %>

        </div>


    <%

        }

    %>


    <!-- =========================================
         ADD VARIANT FORM
    ========================================= -->

    <form

        action="${pageContext.request.contextPath}/admin/add-variant"

        method="post"

        class="variant-form">


        <input

            type="hidden"

            name="productId"

            value="<%= product.getProductId() %>">


        <!-- =====================================
             SIZE
        ====================================== -->

        <div class="form-group">


            <label for="size">

                Size

            </label>


            <select

                id="size"

                name="size"

                required>


                <option value="">

                    Select Size

                </option>


                <option value="XS">

                    XS

                </option>


                <option value="S">

                    S

                </option>


                <option value="M">

                    M

                </option>


                <option value="L">

                    L

                </option>


                <option value="XL">

                    XL

                </option>


                <option value="XXL">

                    XXL

                </option>


            </select>


        </div>


        <!-- =====================================
             STOCK QUANTITY
        ====================================== -->

        <div class="form-group">


            <label for="stockQuantity">

                Stock Quantity

            </label>


            <input

                type="number"

                id="stockQuantity"

                name="stockQuantity"

                min="0"

                value="0"

                required>


        </div>


        <!-- =====================================
             ACTION BUTTONS
        ====================================== -->

        <div class="form-actions">


            <button

                type="submit"

                class="submit-button">

                ADD SIZE

            </button>


            <a

                href="${pageContext.request.contextPath}/admin/product-stock?productId=<%= product.getProductId() %>"

                class="cancel-button">

                CANCEL

            </a>


        </div>


    </form>


</main>


</body>

</html>