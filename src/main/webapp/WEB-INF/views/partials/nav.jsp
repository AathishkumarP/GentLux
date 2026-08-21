<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<nav class="navbar">

    <div class="navbar-brand">

        <a href="<%= request.getContextPath() %>/home">
            GENTLUX
        </a>

    </div>


    <div class="navbar-links">

        <a href="<%= request.getContextPath() %>/home">
            Home
        </a>

        <a href="<%= request.getContextPath() %>/products">
            Shop
        </a>

        <a href="<%= request.getContextPath() %>/categories">
            Categories
        </a>

        <a href="<%= request.getContextPath() %>/about">
            About
        </a>

    </div>


    <div class="navbar-actions">

        <a href="<%= request.getContextPath() %>/search"
           aria-label="Search">
            🔍
        </a>

        <a href="<%= request.getContextPath() %>/cart"
           aria-label="Cart">
            🛍
        </a>

        <a href="<%= request.getContextPath() %>/profile"
           aria-label="Profile">
            👤
        </a>

    </div>

</nav>