<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession navSession = request.getSession(false);

    boolean isLoggedIn =
            navSession != null
            && navSession.getAttribute("userId") != null;

    Object cartCountObject =
            request.getAttribute("cartCount");

    int navCartCount = 0;

    if (cartCountObject != null) {
        navCartCount = (Integer) cartCountObject;
    }
%>


<nav class="navbar">

    <!-- =====================================================
         BRAND
    ====================================================== -->

    <div class="navbar-brand">

        <a href="<%= request.getContextPath() %>/home">
            GENTLUX
        </a>

    </div>


    <!-- =====================================================
         DESKTOP NAVIGATION LINKS
    ====================================================== -->

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


    <!-- =====================================================
         NAVBAR ACTIONS
    ====================================================== -->

    <div class="navbar-actions">


        <!-- =================================================
             DESKTOP SEARCH
        ================================================== -->

        <form
            class="navbar-search"
            action="<%= request.getContextPath() %>/search"
            method="get">

            <input
                type="text"
                name="q"
                placeholder="Search..."
                autocomplete="off"
                aria-label="Search products">

            <button
                type="submit"
                aria-label="Search">

                🔍

            </button>

        </form>


        <!-- =================================================
             WISHLIST
        ================================================== -->

        <a
            href="<%= request.getContextPath() %>/wishlist"
            class="nav-wishlist-link"
            aria-label="Wishlist"
            title="Wishlist">

            <svg
                class="nav-wishlist-heart"
                viewBox="0 0 24 24"
                aria-hidden="true">

                <path
                    d="M20.84 4.61
                       a5.5 5.5 0 0 0-7.78 0
                       L12 5.67
                       l-1.06-1.06
                       a5.5 5.5 0 0 0-7.78 7.78
                       L12 21.23
                       l8.84-8.84
                       a5.5 5.5 0 0 0 0-7.78z">
                </path>

            </svg>

        </a>


        <!-- =================================================
             CART
        ================================================== -->

        <a
            href="<%= request.getContextPath() %>/cart"
            class="navbar-cart-link"
            aria-label="Cart"
            title="Cart">

            <span class="navbar-cart-icon">
                🛍
            </span>


            <% if (navCartCount > 0) { %>

                <span class="navbar-cart-count">

                    <%= navCartCount %>

                </span>

            <% } %>

        </a>


        <!-- =================================================
             DESKTOP LOGIN / PROFILE / LOGOUT
        ================================================== -->

        <div class="navbar-account-desktop">

            <% if (isLoggedIn) { %>

                <a
                    href="<%= request.getContextPath() %>/profile"
                    aria-label="Profile"
                    title="Profile"
                    class="navbar-profile-link">

                    👤

                </a>

                <a
                    href="<%= request.getContextPath() %>/logout"
                    class="navbar-auth-link">

                    Logout

                </a>

            <% } else { %>

                <a
                    href="<%= request.getContextPath() %>/login"
                    class="navbar-auth-link">

                    Login

                </a>

            <% } %>

        </div>


        <!-- =================================================
             MOBILE MENU BUTTON
        ================================================== -->

        <button
            type="button"
            class="navbar-menu-button"
            id="navbarMenuButton"
            aria-label="Open navigation menu"
            aria-expanded="false"
            aria-controls="navbarMobileMenu">

            <span></span>
            <span></span>
            <span></span>

        </button>

    </div>


    <!-- =====================================================
         MOBILE NAVIGATION MENU
    ====================================================== -->

    <div
        class="navbar-mobile-menu"
        id="navbarMobileMenu">


        <!-- MOBILE SEARCH -->

        <form
            class="navbar-mobile-search"
            action="<%= request.getContextPath() %>/search"
            method="get">

            <input
                type="text"
                name="q"
                placeholder="Search products..."
                autocomplete="off"
                aria-label="Search products">

            <button
                type="submit"
                aria-label="Search">

                🔍

            </button>

        </form>


        <!-- MOBILE LINKS -->

        <div class="navbar-mobile-links">

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

            <a href="<%= request.getContextPath() %>/wishlist">
                Wishlist
            </a>

            <a href="<%= request.getContextPath() %>/cart">

                Cart

                <% if (navCartCount > 0) { %>

                    <span class="mobile-cart-count">
                        <%= navCartCount %>
                    </span>

                <% } %>

            </a>


            <% if (isLoggedIn) { %>

                <a href="<%= request.getContextPath() %>/profile">
                    My Profile
                </a>

                <a href="<%= request.getContextPath() %>/my-orders">
                    My Orders
                </a>

                <a
                    href="<%= request.getContextPath() %>/logout"
                    class="mobile-logout-link">

                    Logout

                </a>

            <% } else { %>

                <a href="<%= request.getContextPath() %>/login">
                    Login
                </a>

                <a href="<%= request.getContextPath() %>/register">
                    Create Account
                </a>

            <% } %>

        </div>

    </div>

</nav>


<!-- =========================================================
     MOBILE NAVBAR SCRIPT
========================================================= -->

<script>

document.addEventListener("DOMContentLoaded", function () {

    const menuButton =
            document.getElementById("navbarMenuButton");

    const mobileMenu =
            document.getElementById("navbarMobileMenu");


    if (!menuButton || !mobileMenu) {
        return;
    }


    menuButton.addEventListener("click", function () {

        const isOpen =
                mobileMenu.classList.toggle("navbar-mobile-menu-open");

        menuButton.classList.toggle(
                "navbar-menu-button-open",
                isOpen
        );

        menuButton.setAttribute(
                "aria-expanded",
                isOpen
        );
    });


    /*
     * Close menu when a menu link is selected.
     */
    const mobileLinks =
            mobileMenu.querySelectorAll("a");

    mobileLinks.forEach(function (link) {

        link.addEventListener("click", function () {

            mobileMenu.classList.remove(
                    "navbar-mobile-menu-open"
            );

            menuButton.classList.remove(
                    "navbar-menu-button-open"
            );

            menuButton.setAttribute(
                    "aria-expanded",
                    "false"
            );
        });

    });


    /*
     * Close mobile menu when screen becomes desktop size.
     */
    window.addEventListener("resize", function () {

        if (window.innerWidth > 900) {

            mobileMenu.classList.remove(
                    "navbar-mobile-menu-open"
            );

            menuButton.classList.remove(
                    "navbar-menu-button-open"
            );

            menuButton.setAttribute(
                    "aria-expanded",
                    "false"
            );
        }

    });

});

</script>