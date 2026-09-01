<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.WishlistItemView" %>

<%
    List<WishlistItemView> wishlistItems =
            (List<WishlistItemView>) request.getAttribute("wishlistItems");

    int wishlistCount = 0;

    if (wishlistItems != null) {
        wishlistCount = wishlistItems.size();
    }

    String status = request.getParameter("status");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Wishlist | GentLux</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/style.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/wishlist.css">

</head>


<body>


<!-- ========================= -->
<!-- NAVBAR -->
<!-- ========================= -->

<jsp:include page="partials/nav.jsp" />


<!-- ========================= -->
<!-- WISHLIST PAGE -->
<!-- ========================= -->

<main class="wishlist-page">


    <div class="wishlist-container">


        <!-- PAGE HEADER -->

        <div class="wishlist-header">

            <div>

                <p class="wishlist-small-title">
                    YOUR COLLECTION
                </p>

                <h1>
                    My Wishlist
                </h1>

                <p class="wishlist-subtitle">
                    Save your favourite GentLux pieces
                    and come back to them anytime.
                </p>

            </div>


            <% if (wishlistCount > 0) { %>

                <div class="wishlist-count-box">

                    <span class="wishlist-count-number">
                        <%= wishlistCount %>
                    </span>

                    <span class="wishlist-count-text">

                        <%= wishlistCount == 1
                                ? "ITEM"
                                : "ITEMS" %>

                    </span>

                </div>

            <% } %>

        </div>



        <!-- SUCCESS MESSAGE -->

        <% if ("removed".equals(status)) { %>

            <div class="wishlist-message success">

                Product removed from your wishlist.

            </div>

        <% } %>



        <!-- ========================= -->
        <!-- EMPTY WISHLIST -->
        <!-- ========================= -->

        <% if (wishlistItems == null || wishlistItems.isEmpty()) { %>


            <div class="empty-wishlist">


                <div class="empty-heart">
                    ♡
                </div>


                <h2>
                    Your wishlist is empty
                </h2>


                <p>

                    Save the styles you love and
                    they'll appear here.

                </p>


                <a href="<%= request.getContextPath() %>/products"
                   class="continue-shopping-btn">

                    EXPLORE COLLECTION

                </a>


            </div>


        <% } else { %>



        <!-- ========================= -->
        <!-- PRODUCT GRID -->
        <!-- ========================= -->

        <div class="wishlist-grid">


            <% for (WishlistItemView item : wishlistItems) { %>


                <div class="wishlist-card">


                    <!-- PRODUCT IMAGE -->

                    <div class="wishlist-image-wrapper">


                        <a href="<%= request.getContextPath() %>/product-details?id=<%= item.getProductId() %>">


                            <img
                                src="<%= request.getContextPath() %>/<%= item.getImageUrl() %>"
                                alt="<%= item.getProductName() %>"
                                class="wishlist-product-image">


                        </a>



                        <!-- REMOVE BUTTON -->

                        <form
                            action="<%= request.getContextPath() %>/remove-from-wishlist"
                            method="post"
                            class="wishlist-remove-form">


                            <input
                                type="hidden"
                                name="productId"
                                value="<%= item.getProductId() %>">


                            <button
                                type="submit"
                                class="wishlist-remove-btn"
                                title="Remove from wishlist">

                                ×

                            </button>


                        </form>


                        <% if (item.getDiscount() > 0) { %>

                            <span class="wishlist-discount">

                                <%= Math.round(item.getDiscount()) %>% OFF

                            </span>

                        <% } %>


                    </div>



                    <!-- PRODUCT INFORMATION -->

                    <div class="wishlist-product-info">


                        <p class="wishlist-brand">

                            <%= item.getBrand() %>

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/product-details?id=<%= item.getProductId() %>"
                            class="wishlist-product-name">

                            <%= item.getProductName() %>

                        </a>



                        <!-- PRICE -->

                        <div class="wishlist-price">


                            <span class="wishlist-current-price">

                                ₹<%= String.format("%.0f", item.getPrice()) %>

                            </span>


                            <% if (item.getMrp() > item.getPrice()) { %>

                                <span class="wishlist-mrp">

                                    ₹<%= String.format("%.0f", item.getMrp()) %>

                                </span>

                            <% } %>


                        </div>



                        <!-- VIEW PRODUCT -->

                        <a
                            href="<%= request.getContextPath() %>/product-details?id=<%= item.getProductId() %>"
                            class="wishlist-view-btn">

                            SELECT SIZE & ADD TO CART

                        </a>


                    </div>


                </div>


            <% } %>


        </div>


        <% } %>


    </div>


</main>



<!-- ========================= -->
<!-- FOOTER -->
<!-- ========================= -->

<jsp:include page="partials/footer.jsp" />


</body>

</html>