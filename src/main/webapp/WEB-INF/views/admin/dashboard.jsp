<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !"ADMIN".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath() + "/login"
        );

        return;
    }

    Integer totalOrders =
            (Integer) request.getAttribute("totalOrders");

    Integer totalUsers =
            (Integer) request.getAttribute("totalUsers");

    Integer placedOrders =
            (Integer) request.getAttribute("placedOrders");

    Integer confirmedOrders =
            (Integer) request.getAttribute("confirmedOrders");

    Integer shippedOrders =
            (Integer) request.getAttribute("shippedOrders");

    Integer deliveredOrders =
            (Integer) request.getAttribute("deliveredOrders");

    Integer cancelledOrders =
            (Integer) request.getAttribute("cancelledOrders");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | GentLux</title>

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

        .admin-header {
            min-height: 72px;
            padding: 0 40px;
            background: #2e2723;
            color: #ffffff;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-logo {
            font-size: 22px;
            letter-spacing: 3px;
            font-weight: 600;
        }

        .admin-label {
            font-size: 11px;
            letter-spacing: 2px;
            opacity: 0.7;
        }

        .admin-container {
            width: min(1200px, 92%);
            margin: 45px auto;
        }

        .dashboard-heading {
            margin-bottom: 35px;
        }

        .dashboard-heading h1 {
            font-size: 30px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .dashboard-heading p {
            color: #81746d;
            font-size: 14px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(210px, 1fr));
            gap: 20px;
        }

        .dashboard-card {
            background: #ffffff;
            border: 1px solid #e6dfda;
            padding: 28px;
            min-height: 135px;
        }

        .dashboard-card-title {
            color: #8b7d75;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-bottom: 18px;
        }

        .dashboard-card-value {
            font-size: 32px;
            font-weight: 500;
            color: #2e2723;
        }

        .admin-menu {
            margin-top: 45px;
        }

        .admin-menu h2 {
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .admin-menu-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
        }

        .admin-menu-link {
            display: block;
            background: #ffffff;
            border: 1px solid #ddd5cf;
            padding: 20px;
            text-decoration: none;
            color: #2e2723;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: 0.2s ease;
        }

        .admin-menu-link:hover {
            background: #2e2723;
            color: #ffffff;
        }

        .logout-link {
            color: #ffffff;
            text-decoration: none;
            font-size: 10px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .logout-link:hover {
            opacity: 0.7;
        }
        
        
/* =========================================================
   ADMIN DASHBOARD - RESPONSIVE
========================================================= */

/* Prevent accidental horizontal overflow */
html,
body {
    width: 100%;
    overflow-x: hidden;
}


/* =========================================================
   TABLET - 1024px
========================================================= */

@media (max-width: 1024px) {

    .admin-header {
        padding: 0 28px;
    }

    .admin-container {
        width: 94%;
        margin: 35px auto;
    }

    .dashboard-grid {
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 16px;
    }

    .dashboard-card {
        padding: 24px;
        min-height: 125px;
    }

    .admin-menu-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}


/* =========================================================
   MOBILE - 768px
========================================================= */

@media (max-width: 768px) {

    .admin-header {
        min-height: 64px;
        padding: 0 18px;
    }

    .admin-logo {
        font-size: 19px;
        letter-spacing: 2.5px;
    }

    .admin-label {
        margin-top: 2px;
        font-size: 9px;
        letter-spacing: 1.5px;
    }

    .logout-link {
        font-size: 9px;
        letter-spacing: 1px;
    }

    .admin-container {
        width: auto;
        margin: 28px 16px 40px;
    }

    .dashboard-heading {
        margin-bottom: 24px;
    }

    .dashboard-heading h1 {
        font-size: 25px;
        margin-bottom: 7px;
    }

    .dashboard-heading p {
        font-size: 13px;
        line-height: 1.5;
    }

    /* 2 statistics per row */
    .dashboard-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 12px;
    }

    .dashboard-card {
        min-width: 0;
        min-height: 110px;
        padding: 18px;
    }

    .dashboard-card-title {
        margin-bottom: 14px;
        font-size: 9px;
        line-height: 1.4;
        letter-spacing: 1px;
    }

    .dashboard-card-value {
        font-size: 27px;
    }

    .admin-menu {
        margin-top: 35px;
    }

    .admin-menu h2 {
        margin-bottom: 16px;
        font-size: 18px;
    }

    .admin-menu-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 10px;
    }

    .admin-menu-link {
        min-width: 0;
        padding: 17px 14px;
        font-size: 10px;
        line-height: 1.4;
        letter-spacing: 0.8px;
    }
}


/* =========================================================
   SMALL MOBILE - 480px
========================================================= */

@media (max-width: 480px) {

    .admin-header {
        min-height: 60px;
        padding: 0 14px;
    }

    .admin-logo {
        font-size: 17px;
        letter-spacing: 2px;
    }

    .admin-label {
        font-size: 8px;
        letter-spacing: 1.2px;
    }

    .logout-link {
        font-size: 8px;
    }

    .admin-container {
        margin: 24px 12px 35px;
    }

    .dashboard-heading {
        margin-bottom: 20px;
    }

    .dashboard-heading h1 {
        font-size: 22px;
    }

    .dashboard-heading p {
        font-size: 12px;
    }

    /* Keep 2 cards side-by-side */
    .dashboard-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 8px;
    }

    .dashboard-card {
        min-height: 95px;
        padding: 14px 12px;
    }

    .dashboard-card-title {
        margin-bottom: 11px;
        font-size: 8px;
        letter-spacing: 0.7px;
        line-height: 1.35;
    }

    .dashboard-card-value {
        font-size: 24px;
    }

    .admin-menu {
        margin-top: 30px;
    }

    .admin-menu h2 {
        font-size: 17px;
    }

    /* Management actions are easier to tap full-width */
    .admin-menu-grid {
        grid-template-columns: 1fr;
        gap: 9px;
    }

    .admin-menu-link {
        padding: 15px 14px;
        font-size: 9px;
    }
}


/* =========================================================
   VERY SMALL MOBILE - 360px
========================================================= */

@media (max-width: 360px) {

    .admin-container {
        margin-left: 10px;
        margin-right: 10px;
    }

    .dashboard-grid {
        gap: 7px;
    }

    .dashboard-card {
        padding: 12px 10px;
        min-height: 90px;
    }

    .dashboard-card-title {
        font-size: 7.5px;
        letter-spacing: 0.5px;
    }

    .dashboard-card-value {
        font-size: 22px;
    }
}

    </style>

</head>


<body>


<header class="admin-header">

    <div>

        <div class="admin-logo">
            GENTLUX
        </div>

        <div class="admin-label">
            ADMIN PANEL
        </div>

    </div>


    <a
        href="${pageContext.request.contextPath}/logout"
        class="logout-link">

        LOGOUT

    </a>

</header>


<main class="admin-container">


    <section class="dashboard-heading">

        <h1>
            Admin Dashboard
        </h1>

        <p>
            Manage your GentLux store from one place.
        </p>

    </section>


    <section class="dashboard-grid">


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Total Users
            </div>

            <div class="dashboard-card-value">
                <%= totalUsers != null ? totalUsers : 0 %>
            </div>

        </div>


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Total Orders
            </div>

            <div class="dashboard-card-value">
                <%= totalOrders != null ? totalOrders : 0 %>
            </div>

        </div>


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Placed Orders
            </div>

            <div class="dashboard-card-value">
                <%= placedOrders != null ? placedOrders : 0 %>
            </div>

        </div>


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Confirmed Orders
            </div>

            <div class="dashboard-card-value">
                <%= confirmedOrders != null ? confirmedOrders : 0 %>
            </div>

        </div>


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Shipped Orders
            </div>

            <div class="dashboard-card-value">
                <%= shippedOrders != null ? shippedOrders : 0 %>
            </div>

        </div>


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Delivered Orders
            </div>

            <div class="dashboard-card-value">
                <%= deliveredOrders != null ? deliveredOrders : 0 %>
            </div>

        </div>


        <div class="dashboard-card">

            <div class="dashboard-card-title">
                Cancelled Orders
            </div>

            <div class="dashboard-card-value">
                <%= cancelledOrders != null ? cancelledOrders : 0 %>
            </div>

        </div>


    </section>


    <section class="admin-menu">

        <h2>
            Store Management
        </h2>


        <div class="admin-menu-grid">

            <a
                href="${pageContext.request.contextPath}/admin/orders"
                class="admin-menu-link">

                Manage Orders

            </a>


            <a
                href="${pageContext.request.contextPath}/admin/products"
                class="admin-menu-link">

                Manage Products

            </a>


            <a
                href="${pageContext.request.contextPath}/admin/users"
                class="admin-menu-link">

                Manage Users

            </a>


            <a
                href="${pageContext.request.contextPath}/admin/categories"
                class="admin-menu-link">

                Manage Categories

            </a>

        </div>

    </section>


</main>


</body>

</html>