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

    <title>Edit Address | GENTLUX</title>

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

                    DELIVERY

                </p>


                <h1 style="
                    margin: 0;
                    font-family: Georgia, serif;
                    font-size: 36px;
                    font-weight: 400;
                    color: #38251e;
                ">

                    Edit Address

                </h1>


                <p style="
                    margin-top: 10px;
                    color: #777;
                    font-size: 13px;
                ">

                    Update your delivery address information.

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



            <!-- FORM -->

            <form
                action="${pageContext.request.contextPath}/edit-address"
                method="post"
                autocomplete="off">


                <!-- ADDRESS -->

                <div style="margin-bottom: 18px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                        color: #38251e;
                    ">

                        Address

                    </label>


                    <textarea
                        name="address"
                        rows="4"
                        required
                        style="
                            width: 100%;
                            margin-top: 7px;
                            padding: 12px;
                            box-sizing: border-box;
                            resize: vertical;
                            font-family: inherit;
                        "><%= user != null
                                && user.getAddress() != null
                                ? user.getAddress()
                                : "" %></textarea>

                </div>



                <!-- CITY -->

                <div style="margin-bottom: 18px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                        color: #38251e;
                    ">

                        City

                    </label>


                    <input
                        type="text"
                        name="city"
                        value="<%= user != null
                                && user.getCity() != null
                                ? user.getCity()
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



                <!-- STATE -->

                <div style="margin-bottom: 18px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                        color: #38251e;
                    ">

                        State

                    </label>


                    <input
                        type="text"
                        name="state"
                        value="<%= user != null
                                && user.getState() != null
                                ? user.getState()
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



                <!-- PINCODE -->

                <div style="margin-bottom: 28px;">

                    <label style="
                        display: block;
                        font-size: 12px;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                        color: #38251e;
                    ">

                        Pincode

                    </label>


                    <input
                        type="text"
                        name="pincode"
                        maxlength="6"
                        inputmode="numeric"
                        value="<%= user != null
                                && user.getPincode() != null
                                ? user.getPincode()
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

                        SAVE ADDRESS

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