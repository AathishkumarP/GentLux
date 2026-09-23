<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.gentlux.model.User" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Personal Information | GENTLUX</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>


<body>

<jsp:include page="partials/nav.jsp" />


<%
    User user =
            (User) request.getAttribute("user");

    String error =
            (String) request.getAttribute("error");
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
                    PERSONAL
                </p>


                <h1 style="
                    margin: 0;
                    font-family: Georgia, serif;
                    font-size: 36px;
                    font-weight: 400;
                    color: #38251e;
                ">
                    Edit Personal Information
                </h1>

            </div>


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


            <form
                action="${pageContext.request.contextPath}/edit-profile"
                method="post"
                autocomplete="off">


                <!-- FULL NAME -->

                <div style="margin-bottom: 18px;">

                    <label>
                        Full Name
                    </label>

                    <input
                        type="text"
                        name="fullName"
                        value="<%= user != null
                                ? user.getFullName()
                                : "" %>"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>


                <!-- EMAIL -->

                <div style="margin-bottom: 18px;">

                    <label>
                        Email
                    </label>

                    <input
                        type="email"
                        name="email"
                        autocomplete="off"
                        value="<%= user != null
                                ? user.getEmail()
                                : "" %>"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>


                <!-- PHONE -->

                <div style="margin-bottom: 28px;">

                    <label>
                        Phone Number
                    </label>

                    <input
                        type="text"
                        name="phone"
                        maxlength="10"
                        value="<%= user != null
                                ? user.getPhone()
                                : "" %>"
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

                        SAVE CHANGES

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