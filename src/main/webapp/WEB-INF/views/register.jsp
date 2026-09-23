<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Register | GENTLUX</title>

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">

</head>


<body>


<jsp:include page="partials/nav.jsp" />


<%
    String error =
            (String) request.getAttribute("error");

    String fullName =
            request.getAttribute("fullName") != null
                    ? (String) request.getAttribute("fullName")
                    : "";

    String email =
            request.getAttribute("email") != null
                    ? (String) request.getAttribute("email")
                    : "";

    String phone =
            request.getAttribute("phone") != null
                    ? (String) request.getAttribute("phone")
                    : "";

    String address =
            request.getAttribute("address") != null
                    ? (String) request.getAttribute("address")
                    : "";

    String city =
            request.getAttribute("city") != null
                    ? (String) request.getAttribute("city")
                    : "";

    String state =
            request.getAttribute("state") != null
                    ? (String) request.getAttribute("state")
                    : "";

    String pincode =
            request.getAttribute("pincode") != null
                    ? (String) request.getAttribute("pincode")
                    : "";
%>


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
        max-width: 500px;
        background: #ffffff;
        padding: 40px;
        box-sizing: border-box;
        border: 1px solid #e3dad3;
    ">


        <!-- HEADING -->

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

                CREATE ACCOUNT

            </p>


            <h1 style="
                margin: 0;
                color: #38251e;
                font-family: Georgia, serif;
                font-weight: 400;
            ">

                Register

            </h1>

        </div>


        <!-- ERROR MESSAGE -->

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


        <!-- REGISTER FORM -->

        <form
            action="<%= request.getContextPath() %>/register"
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
                    value="<%= fullName %>"
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
                    value="<%= email %>"
                    autocomplete="off"
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

            <div style="margin-bottom: 18px;">

                <label>
                    Phone Number
                </label>


                <input
                    type="text"
                    name="phone"
                    value="<%= phone %>"
                    maxlength="10"
                    inputmode="numeric"
                    required
                    style="
                        width: 100%;
                        height: 45px;
                        margin-top: 7px;
                        padding: 0 12px;
                        box-sizing: border-box;
                    ">

            </div>


            <!-- PASSWORD -->

            <div style="margin-bottom: 18px;">

                <label>
                    Password
                </label>


                <input
                    type="password"
                    name="password"
                    autocomplete="new-password"
                    minlength="6"
                    required
                    style="
                        width: 100%;
                        height: 45px;
                        margin-top: 7px;
                        padding: 0 12px;
                        box-sizing: border-box;
                    ">

            </div>


            <!-- ADDRESS -->

            <div style="margin-bottom: 18px;">

                <label>
                    Address
                </label>


                <textarea
                    name="address"
                    rows="3"
                    required
                    style="
                        width: 100%;
                        margin-top: 7px;
                        padding: 12px;
                        box-sizing: border-box;
                    "><%= address %></textarea>

            </div>


            <!-- CITY AND STATE -->

            <div style="
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 18px;
            ">


                <!-- CITY -->

                <div>

                    <label>
                        City
                    </label>


                    <input
                        type="text"
                        name="city"
                        value="<%= city %>"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>


                <!-- STATE -->

                <div>

                    <label>
                        State
                    </label>


                    <input
                        type="text"
                        name="state"
                        value="<%= state %>"
                        required
                        style="
                            width: 100%;
                            height: 45px;
                            margin-top: 7px;
                            padding: 0 12px;
                            box-sizing: border-box;
                        ">

                </div>

            </div>


            <!-- PINCODE -->

            <div style="margin-bottom: 25px;">

                <label>
                    Pincode
                </label>


                <input
                    type="text"
                    name="pincode"
                    value="<%= pincode %>"
                    maxlength="6"
                    inputmode="numeric"
                    required
                    style="
                        width: 100%;
                        height: 45px;
                        margin-top: 7px;
                        padding: 0 12px;
                        box-sizing: border-box;
                    ">

            </div>


            <!-- CREATE ACCOUNT BUTTON -->

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

                CREATE ACCOUNT

            </button>


        </form>


        <p style="
            text-align: center;
            margin-top: 22px;
            font-size: 13px;
        ">

            Already have an account?

            <a href="<%= request.getContextPath() %>/login">

                Login

            </a>

        </p>


    </div>


</section>


<jsp:include page="partials/footer.jsp" />


</body>

</html>