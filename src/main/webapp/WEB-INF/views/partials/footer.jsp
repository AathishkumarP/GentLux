<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<footer class="footer">

    <div class="footer-container">

        <!-- Brand -->
        <div class="footer-section">
            <h2>GENTLUX</h2>
            <p>
                Elevate your style with timeless fashion
                crafted for the modern gentleman.
            </p>
        </div>

        <!-- Shop -->
        <div class="footer-section">
            <h3>Shop</h3>

            <a href="${pageContext.request.contextPath}/products">
                All Products
            </a>

            <a href="${pageContext.request.contextPath}/categories">
                Categories
            </a>

            <a href="${pageContext.request.contextPath}/cart">
                Cart
            </a>
        </div>

        <!-- Customer -->
        <div class="footer-section">
            <h3>Customer Care</h3>

            <a href="${pageContext.request.contextPath}/orders">
                My Orders
            </a>

            <a href="${pageContext.request.contextPath}/profile">
                My Profile
            </a>

            <a href="${pageContext.request.contextPath}/contact">
                Contact Us
            </a>
        </div>

        <!-- Information -->
        <div class="footer-section">
            <h3>GENTLUX</h3>

            <a href="${pageContext.request.contextPath}/about">
                About Us
            </a>

            <a href="${pageContext.request.contextPath}/privacy">
                Privacy Policy
            </a>

            <a href="${pageContext.request.contextPath}/terms">
                Terms and Conditions
            </a>
        </div>

    </div>

    <div class="footer-bottom">
        <p>
            © 2026 GENTLUX. All Rights Reserved.
        </p>
    </div>

</footer>