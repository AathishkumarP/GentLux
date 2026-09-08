<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Product" %>

<%
    List<Product> products =
            (List<Product>) request.getAttribute("products");

    String keyword =
            (String) request.getAttribute("keyword");

    if (keyword == null) {
        keyword = "";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Search | GENTLUX</title>

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">


    <style>

        /* =========================================
           SEARCH PRODUCT IMAGE
        ========================================= */

        .search-product-image {

            width: 100%;
            height: 330px;

            background: #f4f0ed;

            overflow: hidden;

            position: relative;
        }


        .search-product-image img {

            width: 100%;
            height: 100%;

            object-fit: cover;

            display: block;

            transition:
                transform 0.35s ease;
        }


        .search-product-card:hover
        .search-product-image img {

            transform: scale(1.03);
        }


        /* =========================================
           IMAGE PLACEHOLDER
        ========================================= */

        .search-image-placeholder {

            width: 100%;
            height: 100%;

            display: flex;

            align-items: center;
            justify-content: center;

            background: #f1ece8;

            color: #38251e;

            font-size: 11px;
            font-weight: 600;

            letter-spacing: 3px;
        }


        /* =========================================
           RESPONSIVE SEARCH GRID
        ========================================= */

        .search-product-grid {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 30px 20px;
        }


        @media (max-width: 1000px) {

            .search-product-grid {

                grid-template-columns:
                    repeat(3, 1fr);
            }
        }


        @media (max-width: 760px) {

            .search-product-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


        @media (max-width: 500px) {

            .search-product-grid {

                grid-template-columns:
                    1fr;
            }


            .search-product-image {

                height: 400px;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<jsp:include page="partials/nav.jsp" />


<main>


    <!-- =========================================================
         SEARCH HEADER
    ========================================================= -->

    <section style="
        padding: 70px 20px 45px;
        background: #f7f3ee;
        text-align: center;
    ">


        <p style="
            margin: 0 0 10px;
            color: #9b7a68;
            font-size: 10px;
            letter-spacing: 4px;
        ">

            FIND YOUR STYLE

        </p>


        <h1 style="
            margin: 0 0 30px;
            color: #38251e;
            font-family: Georgia, serif;
            font-size: 42px;
            font-weight: 400;
        ">

            Search GENTLUX

        </h1>


        <!-- SEARCH FORM -->

        <form
            action="<%= request.getContextPath() %>/search"
            method="get"
            style="
                max-width: 650px;
                margin: 0 auto;
                display: flex;
            ">


            <input
                type="text"
                name="q"
                value="<%= keyword %>"
                placeholder="Search by product name or brand..."
                autocomplete="off"
                style="
                    flex: 1;
                    padding: 16px 18px;
                    border: 1px solid #cfc3bb;
                    border-right: none;
                    outline: none;
                    font-size: 14px;
                    background: #ffffff;
                    color: #38251e;
                ">


            <button
                type="submit"
                style="
                    padding: 0 30px;
                    border: none;
                    background: #38251e;
                    color: #ffffff;
                    font-size: 11px;
                    font-weight: 600;
                    letter-spacing: 2px;
                    cursor: pointer;
                ">

                SEARCH

            </button>


        </form>


    </section>


    <!-- =========================================================
         SEARCH RESULTS
    ========================================================= -->

    <section style="
        padding: 55px 20px 80px;
        background: #ffffff;
    ">


        <div style="
            max-width: 1200px;
            margin: 0 auto;
        ">


            <!-- =================================================
                 RESULT HEADING
            ================================================== -->

            <div style="
                margin-bottom: 35px;
            ">


                <% if (!keyword.isEmpty()) { %>


                    <h2 style="
                        margin: 0 0 8px;
                        color: #38251e;
                        font-family: Georgia, serif;
                        font-size: 28px;
                        font-weight: 400;
                    ">

                        Search results for
                        "<%= keyword %>"

                    </h2>


                    <p style="
                        margin: 0;
                        color: #8a7d76;
                        font-size: 13px;
                    ">

                        <%= products != null
                                ? products.size()
                                : 0 %>

                        product(s) found

                    </p>


                <% } else { %>


                    <h2 style="
                        margin: 0;
                        color: #38251e;
                        font-family: Georgia, serif;
                        font-size: 28px;
                        font-weight: 400;
                    ">

                        Explore Our Collection

                    </h2>


                <% } %>


            </div>


            <!-- =================================================
                 NO PRODUCTS FOUND
            ================================================== -->

            <%

                if (products == null
                        || products.isEmpty()) {

            %>


                <div style="
                    padding: 80px 20px;
                    background: #f8f5f2;
                    text-align: center;
                ">


                    <div style="
                        margin-bottom: 20px;
                        font-size: 42px;
                    ">

                        🔍

                    </div>


                    <h3 style="
                        margin: 0 0 12px;
                        color: #38251e;
                        font-family: Georgia, serif;
                        font-size: 25px;
                        font-weight: 400;
                    ">

                        No Products Found

                    </h3>


                    <p style="
                        margin: 0 0 25px;
                        color: #81746d;
                        font-size: 13px;
                        line-height: 1.7;
                    ">

                        We couldn't find any products matching
                        "<%= keyword %>".

                        <br>

                        Try searching with another product name
                        or brand.

                    </p>


                    <a
                        href="<%= request.getContextPath() %>/products"
                        style="
                            display: inline-block;
                            padding: 14px 28px;
                            background: #38251e;
                            color: #ffffff;
                            text-decoration: none;
                            font-size: 10px;
                            font-weight: 600;
                            letter-spacing: 2px;
                        ">

                        VIEW ALL PRODUCTS

                    </a>


                </div>


            <%

                } else {

            %>


                <!-- =================================================
                     PRODUCT GRID
                ================================================== -->

                <div class="search-product-grid">


                    <%

                        for (Product product : products) {


                            /*
                             * =========================================
                             * PRODUCT IMAGE
                             * =========================================
                             */

                            String searchImageUrl =
                                    product.getImageUrl();


                            boolean hasSearchImage =
                                    searchImageUrl != null
                                    && !searchImageUrl
                                            .trim()
                                            .isEmpty();


                            String finalSearchImageUrl =
                                    null;


                            if (hasSearchImage) {


                                searchImageUrl =
                                        searchImageUrl.trim();


                                /*
                                 * External image
                                 */

                                if (searchImageUrl
                                        .startsWith("http://")
                                        || searchImageUrl
                                        .startsWith("https://")) {


                                    finalSearchImageUrl =
                                            searchImageUrl;


                                } else {


                                    /*
                                     * Local uploaded image
                                     */

                                    if (searchImageUrl
                                            .startsWith("/")) {


                                        searchImageUrl =
                                                searchImageUrl
                                                        .substring(1);
                                    }


                                    finalSearchImageUrl =
                                            request.getContextPath()
                                            + "/"
                                            + searchImageUrl;

                                }
                            }

                    %>


                    <!-- =================================================
                         PRODUCT CARD
                    ================================================== -->

                    <div
                        class="search-product-card"
                        style="
                            background: #ffffff;
                            border: 1px solid #eee7e2;
                            overflow: hidden;
                        ">


                        <!-- =============================================
                             PRODUCT IMAGE
                        ============================================== -->

                        <a
                            href="<%= request.getContextPath() %>/product-details?id=<%= product.getProductId() %>"
                            style="
                                display: block;
                                text-decoration: none;
                            ">


                            <div class="search-product-image">


                                <%

                                    if (hasSearchImage
                                            && finalSearchImageUrl != null) {

                                %>


                                    <img
                                        src="<%= finalSearchImageUrl %>"
                                        alt="<%= product.getProductName() %>"
                                        loading="lazy"

                                        onerror="
                                            this.style.display='none';
                                            this.nextElementSibling.style.display='flex';
                                        ">


                                    <!-- BROKEN IMAGE FALLBACK -->

                                    <div
                                        class="search-image-placeholder"
                                        style="display:none;">

                                        GENTLUX

                                    </div>


                                <%

                                    } else {

                                %>


                                    <!-- NO IMAGE FALLBACK -->

                                    <div
                                        class="search-image-placeholder">

                                        GENTLUX

                                    </div>


                                <%

                                    }

                                %>


                            </div>


                        </a>


                        <!-- =============================================
                             PRODUCT INFORMATION
                        ============================================== -->

                        <div style="
                            padding: 18px 15px 20px;
                        ">


                            <!-- BRAND -->

                            <p style="
                                margin: 0 0 7px;
                                color: #9b7a68;
                                font-size: 10px;
                                font-weight: 600;
                                letter-spacing: 1.5px;
                                text-transform: uppercase;
                            ">

                                <%= product.getBrand() != null
                                        && !product.getBrand()
                                                .trim()
                                                .isEmpty()

                                        ? product.getBrand()
                                        : "GENTLUX" %>

                            </p>


                            <!-- PRODUCT NAME -->

                            <a
                                href="<%= request.getContextPath() %>/product-details?id=<%= product.getProductId() %>"
                                style="
                                    color: #38251e;
                                    text-decoration: none;
                                ">


                                <h3 style="
                                    margin: 0 0 10px;
                                    font-size: 14px;
                                    font-weight: 500;
                                    line-height: 1.5;
                                ">

                                    <%= product.getProductName() %>

                                </h3>


                            </a>


                            <!-- =========================================
                                 PRICE
                            ========================================== -->

                            <div style="
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                flex-wrap: wrap;
                            ">


                                <span style="
                                    color: #38251e;
                                    font-size: 15px;
                                    font-weight: 600;
                                ">

                                    ₹<%= String.format(
                                            "%.2f",
                                            product.getPrice()
                                    ) %>

                                </span>


                                <%

                                    if (product.getMrp()
                                            > product.getPrice()) {

                                %>


                                    <span style="
                                        color: #a79c96;
                                        font-size: 12px;
                                        text-decoration: line-through;
                                    ">

                                        ₹<%= String.format(
                                                "%.2f",
                                                product.getMrp()
                                        ) %>

                                    </span>


                                <%

                                    }

                                %>


                                <%

                                    if (product.getDiscount() > 0) {

                                %>


                                    <span style="
                                        color: #9b7a68;
                                        font-size: 11px;
                                        font-weight: 600;
                                    ">

                                        <%= String.format(
                                                "%.0f",
                                                product.getDiscount()
                                        ) %>% OFF

                                    </span>


                                <%

                                    }

                                %>


                            </div>


                        </div>


                    </div>


                    <%

                        }

                    %>


                </div>


            <%

                }

            %>


        </div>


    </section>


</main>


<!-- =========================================================
     FOOTER
========================================================= -->

<jsp:include page="partials/footer.jsp" />


</body>

</html>