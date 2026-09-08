<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.User" %>

<%
    List<User> users =
            (List<User>) request.getAttribute("users");

    Integer totalUsers =
            (Integer) request.getAttribute("totalUsers");

    Integer customerCount =
            (Integer) request.getAttribute("customerCount");

    Integer adminCount =
            (Integer) request.getAttribute("adminCount");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Manage Users | GentLux Admin</title>


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


        /* =========================================
           HEADER
           ========================================= */

        .admin-header {

            min-height: 72px;

            padding: 0 40px;

            background: #2e2723;

            color: white;

            display: flex;

            align-items: center;

            justify-content: space-between;
        }


        .admin-logo {

            font-size: 22px;

            font-weight: 600;

            letter-spacing: 3px;
        }


        .header-links {

            display: flex;

            align-items: center;

            gap: 25px;
        }


        .header-links a {

            color: white;

            text-decoration: none;

            font-size: 10px;

            letter-spacing: 1.5px;

            text-transform: uppercase;
        }


        .header-links a:hover {

            opacity: 0.75;
        }


        /* =========================================
           MAIN
           ========================================= */

        .container {

            width: min(1250px, 94%);

            margin: 45px auto;
        }


        /* =========================================
           HEADING
           ========================================= */

        .page-heading {

            margin-bottom: 25px;
        }


        .page-heading h1 {

            font-size: 30px;

            font-weight: 500;

            margin-bottom: 8px;
        }


        .page-heading p {

            color: #82766f;

            font-size: 13px;
        }


        /* =========================================
           STATS
           ========================================= */

        .stats {

            display: grid;

            grid-template-columns:
                repeat(3, minmax(0, 1fr));

            gap: 15px;

            margin-bottom: 30px;
        }


        .stat-card {

            background: white;

            border: 1px solid #e2dad5;

            padding: 22px;
        }


        .stat-label {

            font-size: 10px;

            letter-spacing: 1.2px;

            color: #857970;

            text-transform: uppercase;

            margin-bottom: 10px;
        }


        .stat-value {

            font-size: 27px;

            font-weight: 500;
        }


        /* =========================================
           TABLE
           ========================================= */

        .table-wrapper {

            background: white;

            border: 1px solid #e2dad5;

            overflow-x: auto;
        }


        table {

            width: 100%;

            border-collapse: collapse;

            min-width: 950px;
        }


        thead {

            background: #eee7e1;
        }


        th {

            padding: 15px 16px;

            text-align: left;

            font-size: 9px;

            letter-spacing: 1.1px;

            text-transform: uppercase;

            color: #655b55;
        }


        td {

            padding: 17px 16px;

            border-top: 1px solid #eee8e4;

            font-size: 12px;

            vertical-align: middle;
        }


        tbody tr:hover {

            background: #faf8f6;
        }


        /* =========================================
           USER DATA
           ========================================= */

        .user-id {

            color: #8b7d74;

            font-size: 11px;
        }


        .user-name {

            font-weight: 600;
        }


        .email {

            color: #685e58;
        }


        .role-badge {

            display: inline-block;

            padding: 6px 10px;

            font-size: 9px;

            font-weight: 600;

            letter-spacing: 1px;

            text-transform: uppercase;
        }


        .role-admin {

            background: #2e2723;

            color: white;
        }


        .role-customer {

            background: #eee7e1;

            color: #5e534d;
        }


        .no-data {

            text-align: center;

            padding: 50px;

            color: #897d76;
        }


        /* =========================================
           BACK LINK
           ========================================= */

        .back-link {

            display: inline-block;

            margin-top: 25px;

            color: #2e2723;

            text-decoration: none;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 1.2px;
        }


        .back-link:hover {

            opacity: 0.7;
        }


        /* =========================================
           RESPONSIVE
           ========================================= */

        @media (max-width: 750px) {

            .admin-header {

                padding: 0 20px;
            }


            .header-links {

                gap: 12px;

                flex-wrap: wrap;
            }


            .stats {

                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


<header class="admin-header">


    <div class="admin-logo">

        GENTLUX

    </div>


    <div class="header-links">


        <a href="${pageContext.request.contextPath}/admin/dashboard">

            Dashboard

        </a>


        <a href="${pageContext.request.contextPath}/admin/products">

            Products

        </a>


        <a href="${pageContext.request.contextPath}/admin/orders">

            Orders

        </a>


        <a href="${pageContext.request.contextPath}/admin/categories">

            Categories

        </a>


        <a href="${pageContext.request.contextPath}/logout">

            Logout

        </a>


    </div>


</header>



<main class="container">


    <!-- =========================================
         HEADING
         ========================================= -->

    <section class="page-heading">


        <h1>

            Manage Users

        </h1>


        <p>

            View registered GentLux customers and administrators.

        </p>


    </section>



    <!-- =========================================
         USER STATS
         ========================================= -->

    <section class="stats">


        <div class="stat-card">


            <div class="stat-label">

                Total Users

            </div>


            <div class="stat-value">

                <%= totalUsers != null
                        ? totalUsers
                        : 0 %>

            </div>


        </div>



        <div class="stat-card">


            <div class="stat-label">

                Customers

            </div>


            <div class="stat-value">

                <%= customerCount != null
                        ? customerCount
                        : 0 %>

            </div>


        </div>



        <div class="stat-card">


            <div class="stat-label">

                Administrators

            </div>


            <div class="stat-value">

                <%= adminCount != null
                        ? adminCount
                        : 0 %>

            </div>


        </div>


    </section>



    <!-- =========================================
         USER TABLE
         ========================================= -->

    <div class="table-wrapper">


        <table>


            <thead>


                <tr>


                    <th>
                        User ID
                    </th>


                    <th>
                        Name
                    </th>


                    <th>
                        Email
                    </th>


                    <th>
                        Phone
                    </th>


                    <th>
                        Role
                    </th>


                    <th>
                        City
                    </th>


                    <th>
                        State
                    </th>


                    <th>
                        Joined
                    </th>


                </tr>


            </thead>



            <tbody>


            <%

                if (users != null
                        && !users.isEmpty()) {


                    for (User user : users) {


                        String role =
                                user.getRole();


                        if (role == null
                                || role.isBlank()) {

                            role = "CUSTOMER";
                        }


                        boolean admin =
                                role.equalsIgnoreCase("ADMIN");

            %>



                <tr>


                    <td class="user-id">

                        #<%= user.getUserId() %>

                    </td>



                    <td class="user-name">

                        <%= user.getFullName() != null
                                ? user.getFullName()
                                : "-" %>

                    </td>



                    <td class="email">

                        <%= user.getEmail() != null
                                ? user.getEmail()
                                : "-" %>

                    </td>



                    <td>

                        <%= user.getPhone() != null
                                ? user.getPhone()
                                : "-" %>

                    </td>



                    <td>


                        <span class="role-badge
                            <%= admin
                                    ? "role-admin"
                                    : "role-customer" %>">


                            <%= role %>


                        </span>


                    </td>



                    <td>

                        <%= user.getCity() != null
                                && !user.getCity().isBlank()
                                ? user.getCity()
                                : "-" %>

                    </td>



                    <td>

                        <%= user.getState() != null
                                && !user.getState().isBlank()
                                ? user.getState()
                                : "-" %>

                    </td>



                    <td>

                        <%= user.getCreatedAt() != null
                                ? user.getCreatedAt()
                                : "-" %>

                    </td>


                </tr>



            <%

                    }


                } else {

            %>



                <tr>


                    <td
                        colspan="8"
                        class="no-data">

                        No users found.

                    </td>


                </tr>



            <%

                }

            %>


            </tbody>


        </table>


    </div>



    <a
        href="${pageContext.request.contextPath}/admin/dashboard"
        class="back-link">

        ← BACK TO DASHBOARD

    </a>


</main>


</body>

</html>