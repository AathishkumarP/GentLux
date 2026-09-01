<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | GENTLUX</title>

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">

</head>

<body>

<jsp:include page="partials/nav.jsp" />

<section style="
    min-height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f7f3ee;
    padding: 60px 20px;
">

    <div style="
        width: 100%;
        max-width: 450px;
        background: #ffffff;
        padding: 40px;
        box-sizing: border-box;
        border: 1px solid #e3dad3;
    ">

        <div style="
            text-align: center;
            margin-bottom: 30px;
        ">

            <p style="
                margin: 0 0 8px;
                color: #9b7a68;
                font-size: 10px;
                letter-spacing: 3px;
            ">
                WELCOME BACK
            </p>

            <h1 style="
                margin: 0;
                color: #38251e;
                font-family: Georgia, serif;
                font-weight: 400;
            ">
                Login
            </h1>

        </div>


        <% if ("true".equals(request.getParameter("registered"))) { %>

            <div style="
                margin-bottom: 20px;
                padding: 12px;
                background: #edf8ee;
                color: #2f7a3d;
                font-size: 13px;
            ">
                Account created successfully. Please login.
            </div>

        <% } %>


        <% String error = (String) request.getAttribute("error"); %>

        <% if (error != null) { %>

            <div style="
                margin-bottom: 20px;
                padding: 12px;
                background: #fff1f1;
                color: #a33b3b;
                font-size: 13px;
            ">
                <%= error %>
            </div>

        <% } %>


        <form
            action="<%= request.getContextPath() %>/login"
            method="post">

            <div style="margin-bottom: 18px;">

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    required
                    style="
                        width: 100%;
                        height: 45px;
                        margin-top: 7px;
                        padding: 0 12px;
                        box-sizing: border-box;
                    ">

            </div>


            <div style="margin-bottom: 25px;">

                <label>Password</label>

                <input
                    type="password"
                    name="password"
                    required
                    style="
                        width: 100%;
                        height: 45px;
                        margin-top: 7px;
                        padding: 0 12px;
                        box-sizing: border-box;
                    ">

            </div>


            <button
                type="submit"
                style="
                    width: 100%;
                    height: 50px;
                    border: none;
                    background: #38251e;
                    color: #ffffff;
                    font-weight: 600;
                    letter-spacing: 2px;
                    cursor: pointer;
                ">

                LOGIN

            </button>

        </form>


        <p style="
            text-align: center;
            margin-top: 22px;
            font-size: 13px;
        ">

            Don't have an account?

            <a href="<%= request.getContextPath() %>/register">
                Register
            </a>

        </p>

    </div>

</section>

<jsp:include page="partials/footer.jsp" />

</body>

</html>