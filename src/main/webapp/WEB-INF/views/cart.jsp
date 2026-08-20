<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.CartItemView" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Shopping Cart | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

    <jsp:include page="partials/nav.jsp" />

    <main>

        <section class="cart-section">

            <div class="section-heading">

                <p class="section-subtitle">
                    YOUR BAG
                </p>

                <h2>
                    SHOPPING CART
                </h2>

                <p class="section-description">
                    Review your selected items before checkout.
                </p>

            </div>

            <div class="cart-container">

                <%
                    List<CartItemView> cartItems =
                            (List<CartItemView>)
                            request.getAttribute("cartItems");

                    Double cartTotal =
                            (Double)
                            request.getAttribute("cartTotal");

                    if (cartItems != null && !cartItems.isEmpty()) {
                %>

                <div class="cart-items">

                    <%
                        for (CartItemView item : cartItems) {
                    %>

                    <div class="cart-item">

                        <!-- Product Image -->
                        
						<div class="cart-item-image">
						
						    <%
						        if (item.getImageUrl() != null
						                && !item.getImageUrl().isEmpty()) {
						
						            String imagePath = item.getImageUrl();
						
						            if (!imagePath.startsWith("/")) {
						                imagePath = "/" + imagePath;
						            }
						    %>
						
						        <img
						            src="<%= request.getContextPath() + imagePath %>"
						            alt="<%= item.getProductName() %>">
						
						    <%
						        }
						    %>
						
						</div>


                        <!-- Product Details -->
                        <div class="cart-item-details">

                            <p class="cart-item-brand">
                                <%= item.getBrand() %>
                            </p>

                            <h3>
                                <%= item.getProductName() %>
                            </h3>

                            <p class="cart-item-size">
                                Size:
                                <strong>
                                    <%= item.getSize() %>
                                </strong>
                            </p>

                            <p class="cart-item-price">
                                ₹<%= String.format("%.2f", item.getPrice()) %>
                            </p>

                            <!-- Remove Item -->
                            <form action="${pageContext.request.contextPath}/remove-cart-item"
                                  method="post"
                                  class="remove-cart-form">

                                <input type="hidden"
                                       name="cartItemId"
                                       value="<%= item.getCartItemId() %>">

                                <button type="submit"
                                        class="remove-cart-button">
                                    REMOVE
                                </button>

                            </form>

                        </div>


                        <!-- Quantity -->
                        <div class="cart-item-quantity">

                            <p>
                                Quantity
                            </p>

                            <div class="cart-quantity-control">

                                <!-- MINUS -->
                                <form action="${pageContext.request.contextPath}/update-cart-quantity"
                                      method="post">

                                    <input type="hidden"
                                           name="cartItemId"
                                           value="<%= item.getCartItemId() %>">

                                    <input type="hidden"
                                           name="quantity"
                                           value="<%= item.getQuantity() - 1 %>">

                                    <button type="submit"
                                            class="cart-quantity-button"
                                            <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                        −
                                    </button>

                                </form>


                                <!-- CURRENT QUANTITY -->
                                <span class="cart-quantity-number">

                                    <%= item.getQuantity() %>

                                </span>


                                <!-- PLUS -->
                                <form action="${pageContext.request.contextPath}/update-cart-quantity"
                                      method="post">

                                    <input type="hidden"
                                           name="cartItemId"
                                           value="<%= item.getCartItemId() %>">

                                    <input type="hidden"
                                           name="quantity"
                                           value="<%= item.getQuantity() + 1 %>">

									<button type="submit"
									        class="cart-quantity-button"
									        <%= item.getQuantity() >= item.getStock()
									                ? "disabled"
									                : "" %>>
									    +
									</button>

                                </form>

                            </div>

                        </div>


                        <!-- Subtotal -->
                        <div class="cart-item-subtotal">

                            <p>
                                Subtotal
                            </p>

                            <strong>
                                ₹<%= String.format("%.2f", item.getSubtotal()) %>
                            </strong>

                        </div>

                    </div>

                    <%
                        }
                    %>

                </div>


                <!-- CART SUMMARY -->
                <div class="cart-summary">

                    <h3>
                        ORDER SUMMARY
                    </h3>

                    <div class="summary-row">

                        <span>
                            Items
                        </span>

                        <span>
                            <%= cartItems.size() %>
                        </span>

                    </div>

                    <div class="summary-row">

                        <span>
                            Subtotal
                        </span>

                        <span>
                            ₹<%= String.format("%.2f", cartTotal) %>
                        </span>

                    </div>

                    <div class="summary-row">

                        <span>
                            Delivery
                        </span>

                        <span>
                            FREE
                        </span>

                    </div>

                    <div class="cart-summary-divider">
                    </div>

                    <div class="summary-row cart-total-row">

                        <strong>
                            TOTAL
                        </strong>

                        <strong>
                            ₹<%= String.format("%.2f", cartTotal) %>
                        </strong>

                    </div>

					<!-- PROCEED TO CHECKOUT -->
					<a href="${pageContext.request.contextPath}/checkout"
					   class="checkout-button">
					    PROCEED TO CHECKOUT
					</a>
					
					
					<!-- CLEAR CART -->
					<form action="${pageContext.request.contextPath}/clear-cart"
					      method="post"
					      class="clear-cart-form">
					
					    <button type="submit"
					            class="clear-cart-button"
					            onclick="return confirm('Are you sure you want to remove all items from your cart?');">
					        CLEAR CART
					    </button>
					
					</form>
					
					
					<!-- CONTINUE SHOPPING -->
					<a href="${pageContext.request.contextPath}/products"
					   class="continue-shopping-link">
					    ← CONTINUE SHOPPING
					</a>

                </div>

                <%
                    } else {
                %>

                <div class="empty-cart">

                    <h2>
                        Your cart is empty
                    </h2>

                    <p>
                        You haven't added any products yet.
                    </p>

                    <a href="${pageContext.request.contextPath}/products"
                       class="hero-button">
                        START SHOPPING
                    </a>

                </div>

                <%
                    }
                %>

            </div>

        </section>

    </main>

    <jsp:include page="partials/footer.jsp" />

</body>

</html>