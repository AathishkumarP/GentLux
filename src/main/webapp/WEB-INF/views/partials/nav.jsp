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

        navCartCount =
                (Integer) cartCountObject;

    }

%>


<nav class="navbar">


    <!-- BRAND -->

    <div class="navbar-brand">

        <a href="<%= request.getContextPath() %>/home">

            GENTLUX

        </a>

    </div>



    <!-- NAVIGATION LINKS -->

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



    <!-- NAVBAR ACTIONS -->

    <div class="navbar-actions">



        <!-- SEARCH -->

        <form
            action="<%= request.getContextPath() %>/search"
            method="get"

            style="
                display: flex;
                align-items: center;
                border: 1px solid #d8cec7;
                background: #ffffff;
                height: 34px;
                overflow: hidden;
            ">


            <input
                type="text"

                name="q"

                placeholder="Search..."

                autocomplete="off"

                aria-label="Search products"

                style="
                    width: 150px;
                    height: 100%;
                    padding: 0 10px;
                    border: none;
                    outline: none;
                    background: transparent;
                    color: #38251e;
                    font-size: 12px;
                ">


            <button
                type="submit"

                aria-label="Search"

                style="
                    height: 100%;
                    padding: 0 10px;
                    border: none;
                    background: transparent;
                    cursor: pointer;
                    font-size: 15px;
                ">

                🔍

            </button>


        </form>



        <!-- =====================================================
             WISHLIST
        ====================================================== -->

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



        <!-- CART WITH COUNT -->

        <a
            href="<%= request.getContextPath() %>/cart"

            aria-label="Cart"

            title="Cart"

            style="
                position: relative;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
            ">


            <span style="font-size: 18px;">

                🛍

            </span>



            <% if (navCartCount > 0) { %>


                <span
                    style="
                        position: absolute;

                        top: -8px;
                        right: -10px;

                        min-width: 17px;
                        height: 17px;

                        padding: 0 4px;

                        display: flex;
                        align-items: center;
                        justify-content: center;

                        background: #38251e;

                        color: #ffffff;

                        border-radius: 50%;

                        font-size: 9px;
                        font-weight: 600;

                        line-height: 17px;
                    ">

                    <%= navCartCount %>

                </span>


            <% } %>


        </a>



        <!-- PROFILE -->

        <a
            href="<%= request.getContextPath() %>/profile"

            aria-label="Profile"

            title="Profile">

            👤

        </a>



        <!-- LOGIN / LOGOUT -->

        <% if (isLoggedIn) { %>


            <a
                href="<%= request.getContextPath() %>/logout"

                aria-label="Logout">

                Logout

            </a>


        <% } else { %>


            <a
                href="<%= request.getContextPath() %>/login"

                aria-label="Login">

                Login

            </a>


        <% } %>


    </div>


</nav>