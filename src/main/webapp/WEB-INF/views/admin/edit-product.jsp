<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Product" %>
<%@ page import="com.gentlux.model.Category" %>

<%
    Product product =
            (Product) request.getAttribute("product");

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

    <title>Edit Product | GentLux Admin</title>


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


        /* =========================================
           ERROR
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

        .product-form {

            padding: 35px;

            background: white;

            border: 1px solid #e2dad5;
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

            background: white;

            color: #2e2723;

            font-family: Arial, sans-serif;

            font-size: 13px;

            outline: none;
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

            margin-top: 5px;

            font-size: 10px;

            line-height: 1.5;

            color: #948780;
        }


        /* =========================================
           IMAGE SECTION
           ========================================= */

        .image-section {

            padding: 20px;

            border: 1px dashed #c9beb7;

            background: #faf8f6;
        }


        .current-image-title {

            margin-bottom: 10px;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1px;

            text-transform: uppercase;

            color: #665a54;
        }


        .current-image {

            display: block;

            width: 180px;

            height: 220px;

            object-fit: cover;

            background: #eee9e5;

            border: 1px solid #ddd4ce;

            margin-bottom: 18px;
        }


        .no-current-image {

            width: 180px;

            height: 120px;

            margin-bottom: 18px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eee9e5;

            border: 1px solid #ddd4ce;

            color: #968a83;

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: 1px;
        }


        .replace-image-label {

            display: block;

            margin-bottom: 8px;
        }


        .image-preview-wrapper {

            display: none;

            margin-top: 18px;
        }


        .new-image-title {

            margin-bottom: 8px;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1px;

            text-transform: uppercase;

            color: #665a54;
        }


        .new-image-preview {

            width: 180px;

            height: 220px;

            object-fit: cover;

            display: block;

            border: 1px solid #ddd4ce;

            background: #eee9e5;
        }


        /* =========================================
           ACTIONS
           ========================================= */

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

            opacity: 0.85;
        }


        .cancel-button {

            padding: 12px 24px;

            border: 1px solid #2e2723;

            color: #2e2723;

            background: white;

            text-decoration: none;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1.3px;
        }


        .cancel-button:hover {

            background: #f1ece8;
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


<!-- =============================================
     HEADER
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


        <a href="${pageContext.request.contextPath}/logout">

            Logout

        </a>


    </div>


</header>



<!-- =============================================
     MAIN
     ============================================= -->

<main class="container">


    <section class="page-heading">


        <h1>

            Edit Product

        </h1>


        <p>

            Update product information and product image.

        </p>


    </section>



    <% if (error != null) { %>


        <div class="error-message">

            <%= error %>

        </div>


    <% } %>



    <!-- IMPORTANT:
         multipart/form-data is required for image upload
    -->

    <form
        action="${pageContext.request.contextPath}/admin/edit-product"
        method="post"
        enctype="multipart/form-data"
        class="product-form">


        <input
            type="hidden"
            name="productId"
            value="<%= product.getProductId() %>">



        <div class="form-grid">



            <!-- =====================================
                 CATEGORY
                 ===================================== -->

            <div class="form-group">


                <label for="categoryId">

                    Category

                    <span class="required">
                        *
                    </span>

                </label>


                <select
                    id="categoryId"
                    name="categoryId"
                    required>


                    <%

                        if (categories != null) {

                            for (Category category : categories) {

                                boolean selected =
                                        category.getCategoryId()
                                        == product.getCategoryId();

                    %>


                        <option
                            value="<%= category.getCategoryId() %>"
                            <%= selected ? "selected" : "" %>>

                            <%= category.getCategoryName() %>

                        </option>


                    <%

                            }

                        }

                    %>


                </select>


            </div>



            <!-- =====================================
                 PRODUCT NAME
                 ===================================== -->

            <div class="form-group">


                <label for="productName">

                    Product Name

                    <span class="required">
                        *
                    </span>

                </label>


                <input
                    type="text"
                    id="productName"
                    name="productName"
                    maxlength="150"
                    value="<%= product.getProductName() != null
                            ? product.getProductName()
                            : "" %>"
                    required>


            </div>



            <!-- =====================================
                 BRAND
                 ===================================== -->

            <div class="form-group">


                <label for="brand">

                    Brand

                </label>


                <input
                    type="text"
                    id="brand"
                    name="brand"
                    maxlength="100"
                    value="<%= product.getBrand() != null
                            ? product.getBrand()
                            : "" %>">


            </div>



            <!-- =====================================
                 COLOR
                 ===================================== -->

            <div class="form-group">


                <label for="color">

                    Color

                </label>


                <input
                    type="text"
                    id="color"
                    name="color"
                    maxlength="50"
                    value="<%= product.getColor() != null
                            ? product.getColor()
                            : "" %>">


            </div>



            <!-- =====================================
                 SELLING PRICE
                 ===================================== -->

            <div class="form-group">


                <label for="price">

                    Selling Price

                    <span class="required">
                        *
                    </span>

                </label>


                <input
                    type="number"
                    id="price"
                    name="price"
                    min="0"
                    step="0.01"
                    value="<%= product.getPrice() %>"
                    required>


            </div>



            <!-- =====================================
                 MRP
                 ===================================== -->

            <div class="form-group">


                <label for="mrp">

                    MRP

                    <span class="required">
                        *
                    </span>

                </label>


                <input
                    type="number"
                    id="mrp"
                    name="mrp"
                    min="0"
                    step="0.01"
                    value="<%= product.getMrp() %>"
                    required>


            </div>



            <!-- =====================================
                 DISCOUNT
                 ===================================== -->

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
                    value="<%= product.getDiscount() %>">


            </div>



            <!-- =====================================
                 PRODUCT IMAGE
                 ===================================== -->

            <div class="form-group">


                <label>

                    Product Image

                </label>


                <div class="image-section">


                    <div class="current-image-title">

                        Current Image

                    </div>



                    <%

                        String currentImage =
                                product.getImageUrl();

                        if (currentImage != null
                                && !currentImage.isBlank()) {

                    %>


                        <img
                            src="<%= request.getContextPath() %>/<%= currentImage %>"
                            class="current-image"
                            alt="Current product image">


                    <%

                        } else {

                    %>


                        <div class="no-current-image">

                            No Image

                        </div>


                    <%

                        }

                    %>



                    <label
                        for="productImage"
                        class="replace-image-label">

                        Replace Image

                    </label>


                    <input
                        type="file"
                        id="productImage"
                        name="productImage"
                        accept=".jpg,.jpeg,.png,.webp,image/jpeg,image/png,image/webp">


                    <div class="form-note">

                        Leave this empty to keep the current image.
                        JPG, JPEG, PNG or WEBP. Maximum size: 5 MB.

                    </div>



                    <div
                        id="imagePreviewWrapper"
                        class="image-preview-wrapper">


                        <div class="new-image-title">

                            New Image Preview

                        </div>


                        <img
                            id="imagePreview"
                            class="new-image-preview"
                            alt="New product image preview">


                    </div>


                </div>


            </div>



            <!-- =====================================
                 DESCRIPTION
                 ===================================== -->

            <div class="form-group full-width">


                <label for="description">

                    Description

                </label>


                <textarea
                    id="description"
                    name="description"
                    maxlength="2000"><%= product.getDescription() != null
                            ? product.getDescription()
                            : "" %></textarea>


            </div>


        </div>



        <!-- =========================================
             ACTIONS
             ========================================= -->

        <div class="form-actions">


            <button
                type="submit"
                class="submit-button">

                UPDATE PRODUCT

            </button>


            <a
                href="${pageContext.request.contextPath}/admin/products"
                class="cancel-button">

                CANCEL

            </a>


        </div>


    </form>


</main>



<!-- =============================================
     NEW IMAGE PREVIEW
     ============================================= -->

<script>

    const productImage =
        document.getElementById("productImage");

    const imagePreview =
        document.getElementById("imagePreview");

    const imagePreviewWrapper =
        document.getElementById("imagePreviewWrapper");


    productImage.addEventListener(
        "change",
        function () {


            const file =
                this.files[0];


            if (!file) {

                imagePreviewWrapper.style.display =
                    "none";

                imagePreview.removeAttribute(
                    "src"
                );

                return;
            }


            const allowedTypes = [
                "image/jpeg",
                "image/png",
                "image/webp"
            ];


            if (!allowedTypes.includes(file.type)) {

                alert(
                    "Please select a JPG, JPEG, PNG or WEBP image."
                );


                this.value = "";


                imagePreviewWrapper.style.display =
                    "none";


                return;
            }


            const maximumSize =
                5 * 1024 * 1024;


            if (file.size > maximumSize) {

                alert(
                    "Image size must be less than 5 MB."
                );


                this.value = "";


                imagePreviewWrapper.style.display =
                    "none";


                return;
            }


            const reader =
                new FileReader();


            reader.onload =
                function (event) {


                    imagePreview.src =
                        event.target.result;


                    imagePreviewWrapper.style.display =
                        "block";

                };


            reader.readAsDataURL(
                file
            );

        }
    );

</script>


</body>

</html>