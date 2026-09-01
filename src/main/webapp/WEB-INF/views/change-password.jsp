<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Change Password | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>


<body>

<jsp:include page="partials/nav.jsp" />


<%
    String error =
            (String) request.getAttribute("error");

    String success =
            request.getParameter("success");
%>


<main>

    <section style="
        width: 100%;
        min-height: 75vh;
        padding: 60px 20px;
        background: #f7f3ee;
        box-sizing: border-box;
    ">

        <div style="
            width: 100%;
            max-width: 650px;
            margin: 0 auto;
            background: #ffffff;
            padding: 40px;
            box-sizing: border-box;
            border: 1px solid #e6ddd7;
        ">


            <!-- HEADING -->

            <div style="
                text-align: center;
                margin-bottom: 35px;
            ">

                <p style="
                    margin: 0 0 8px;
                    font-size: 10px;
                    letter-spacing: 3px;
                    color: #9b7a68;
                ">

                    SECURITY

                </p>


                <h1 style="
                    margin: 0;
                    font-family: Georgia, serif;
                    font-size: 36px;
                    font-weight: 400;
                    color: #38251e;
                ">

                    Change Password

                </h1>


                <p style="
                    margin-top: 10px;
                    color: #777;
                    font-size: 13px;
                ">

                    Update your account password.

                </p>

            </div>



            <!-- ERROR MESSAGE -->

            <% if (error != null) { %>

                <div style="
                    margin-bottom: 25px;
                    padding: 12px;
                    background: #fff1f1;
                    color: #a33b3b;
                    font-size: 13px;
                ">

                    <%= error %>

                </div>

            <% } %>



            <!-- SUCCESS MESSAGE -->

            <% if ("true".equals(success)) { %>

                <div style="
                    margin-bottom: 25px;
                    padding: 12px;
                    background: #eef8ee;
                    color: #3b6f3b;
                    font-size: 13px;
                ">

                    Password changed successfully.

                </div>

            <% } %>



            <!-- FORM -->

            <form
                action="${pageContext.request.contextPath}/change-password"
                method="post"
                autocomplete="off">


                <!-- CURRENT PASSWORD -->

                <div style="margin-bottom: 18px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        color: #38251e;
                    ">

                        Current Password

                    </label>


                    <input
                        type="password"
                        name="currentPassword"
                        autocomplete="current-password"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>



                <!-- NEW PASSWORD -->

                <div style="margin-bottom: 18px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        color: #38251e;
                    ">

                        New Password

                    </label>


                    <input
                        type="password"
                        name="newPassword"
                        minlength="6"
                        autocomplete="new-password"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>



                <!-- CONFIRM PASSWORD -->

                <div style="margin-bottom: 28px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        color: #38251e;
                    ">

                        Confirm New Password

                    </label>


                    <input
                        type="password"
                        name="confirmPassword"
                        minlength="6"
                        autocomplete="new-password"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>



                <!-- BUTTONS -->

                <div style="
                    display: flex;
                    gap: 15px;
                ">


                    <button
                        type="submit"
                        style="
                            flex: 1;
                            height: 48px;
                            border: 1px solid #38251e;
                            background: #38251e;
                            color: #ffffff;
                            font-size: 11px;
                            font-weight: 600;
                            letter-spacing: 1.5px;
                            cursor: pointer;
                        ">

                        CHANGE PASSWORD

                    </button>



                    <a
                        href="${pageContext.request.contextPath}/profile"
                        style="
                            flex: 1;
                            height: 48px;
                            border: 1px solid #38251e;
                            background: #ffffff;
                            color: #38251e;
                            text-decoration: none;
                            font-size: 11px;
                            font-weight: 600;
                            letter-spacing: 1.5px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            box-sizing: border-box;
                        ">

                        CANCEL

                    </a>


                </div>


            </form>


        </div>

    </section>

</main>


<jsp:include page="partials/footer.jsp" />


</body>
</html>