<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

<nav class="navbar">

    <!-- Brand -->
    <div class="navbar-brand">
        <a href="${pageContext.request.contextPath}/home">
            GENTLUX
        </a>
    </div>

    <!-- Navigation Links -->
    <div class="navbar-links">

        <a href="${pageContext.request.contextPath}/home">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/products">
            Shop
        </a>

        <a href="${pageContext.request.contextPath}/categories">
            Categories
        </a>

        <a href="${pageContext.request.contextPath}/about">
            About
        </a>

    </div>

    <!-- Right Side -->
    <div class="navbar-actions">

        <a href="${pageContext.request.contextPath}/search"
           aria-label="Search">
            🔍
        </a>

        <a href="${pageContext.request.contextPath}/cart"
           aria-label="Cart">
            🛍
        </a>

        <a href="${pageContext.request.contextPath}/profile"
           aria-label="Profile">
            👤
        </a>

    </div>

</nav>