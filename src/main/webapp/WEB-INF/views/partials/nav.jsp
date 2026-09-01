<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession navSession = request.getSession(false);

    boolean isLoggedIn =
            navSession != null
            && navSession.getAttribute("userId") != null;
%>


<nav class="navbar">


    <!-- =========================================================
         BRAND
         ========================================================= -->

    <div class="navbar-brand">

        <a href="<%= request.getContextPath() %>/home">
            GENTLUX
        </a>

    </div>



    <!-- =========================================================
         NAVIGATION LINKS
         ========================================================= -->

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



    <!-- =========================================================
         NAVBAR ACTIONS
         ========================================================= -->

    <div class="navbar-actions">


        <!-- =====================================================
             SEARCH
             ===================================================== -->

        <form action="<%= request.getContextPath() %>/search"
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
     CART WITH ITEM COUNT
     ===================================================== -->

<a href="<%= request.getContextPath() %>/cart"
   aria-label="Cart"
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


    <%
        Object cartCountObject =
                request.getAttribute("cartCount");

        int navCartCount = 0;

        if (cartCountObject != null) {
            navCartCount =
                    (Integer) cartCountObject;
        }

        if (navCartCount > 0) {
    %>

        <span style="
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

    <%
        }
    %>

</a>



        <!-- =====================================================
             PROFILE
             ===================================================== -->

        <a href="<%= request.getContextPath() %>/profile"
           aria-label="Profile">

            👤

        </a>



        <!-- =====================================================
             LOGIN / LOGOUT
             ===================================================== -->

        <% if (isLoggedIn) { %>


            <a href="<%= request.getContextPath() %>/logout"
               aria-label="Logout">

                Logout

            </a>


        <% } else { %>


            <a href="<%= request.getContextPath() %>/login"
               aria-label="Login">

                Login

            </a>


        <% } %>


    </div>


</nav>