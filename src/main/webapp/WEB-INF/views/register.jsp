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

    <style>

        /* =========================================================
           GENTLUX REGISTER PAGE
        ========================================================= */

        .register-section {
            width: 100%;
            min-height: 80vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 60px 20px;

            background: #f7f3ee;

            box-sizing: border-box;
        }

        .register-container {
            width: 100%;
            max-width: 500px;

            padding: 40px;

            background: #ffffff;
            border: 1px solid #e3dad3;

            box-sizing: border-box;
        }


        /* =========================================================
           HEADING
        ========================================================= */

        .register-heading {
            margin-bottom: 30px;
            text-align: center;
        }

        .register-subtitle {
            margin: 0 0 8px;

            color: #9b7a68;

            font-size: 10px;
            letter-spacing: 3px;
        }

        .register-heading h1 {
            margin: 0;

            color: #38251e;

            font-family: Georgia, serif;
            font-size: 36px;
            font-weight: 400;
            line-height: 1.2;
        }


        /* =========================================================
           ERROR MESSAGE
        ========================================================= */

        .register-error {
            margin-bottom: 20px;
            padding: 12px;

            background: #fff1f1;
            color: #a33b3b;

            font-size: 13px;
            line-height: 1.5;

            box-sizing: border-box;
        }


        /* =========================================================
           FORM
        ========================================================= */

        .register-field {
            margin-bottom: 18px;
        }

        .register-field.pincode-field {
            margin-bottom: 25px;
        }

        .register-field label,
        .register-location-field label {
            display: block;

            color: #38251e;

            font-size: 12px;
            font-weight: 600;
        }

        .register-field input,
        .register-field textarea,
        .register-location-field input {
            width: 100%;

            margin-top: 7px;
            padding: 0 12px;

            border: 1px solid #d8cec7;
            background: #ffffff;

            color: #38251e;

            font-family: inherit;
            font-size: 13px;

            outline: none;

            box-sizing: border-box;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }

        .register-field input,
        .register-location-field input {
            height: 45px;
        }

        .register-field textarea {
            min-height: 90px;
            padding: 12px;

            line-height: 1.6;

            resize: vertical;
        }

        .register-field input:focus,
        .register-field textarea:focus,
        .register-location-field input:focus {
            border-color: #765747;
            box-shadow: 0 0 0 1px #765747;
        }


        /* =========================================================
           CITY + STATE
        ========================================================= */

        .register-location-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;

            gap: 15px;

            margin-bottom: 18px;
        }

        .register-location-field {
            min-width: 0;
        }


        /* =========================================================
           CREATE ACCOUNT BUTTON
        ========================================================= */

        .register-button {
            width: 100%;
            height: 50px;

            border: 1px solid #38251e;

            background: #38251e;
            color: #ffffff;

            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 2px;

            cursor: pointer;

            transition:
                background 0.2s ease,
                border-color 0.2s ease;
        }

        .register-button:hover {
            background: #56382c;
            border-color: #56382c;
        }


        /* =========================================================
           LOGIN LINK
        ========================================================= */

        .register-login-text {
            margin: 22px 0 0;

            color: #685e59;

            text-align: center;

            font-size: 13px;
            line-height: 1.5;
        }

        .register-login-text a {
            color: #38251e;

            font-weight: 600;
            text-decoration: none;
        }

        .register-login-text a:hover {
            text-decoration: underline;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 768px) {

            .register-section {
                padding: 50px 20px 65px;
            }

            .register-container {
                max-width: 500px;
                padding: 34px 30px;
            }

            .register-heading h1 {
                font-size: 32px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .register-section {
                min-height: 70vh;

                align-items: flex-start;

                padding: 40px 14px 55px;

                overflow-x: hidden;
            }

            .register-container {
                width: 100%;
                max-width: 460px;

                padding: 26px 16px;
            }


            /* HEADING */

            .register-heading {
                margin-bottom: 25px;
            }

            .register-subtitle {
                margin-bottom: 7px;

                font-size: 8px;
                letter-spacing: 2.2px;
            }

            .register-heading h1 {
                font-size: 28px;
            }


            /* ERROR */

            .register-error {
                margin-bottom: 18px;

                padding: 10px;

                font-size: 11px;
            }


            /* FORM */

            .register-field {
                margin-bottom: 16px;
            }

            .register-field.pincode-field {
                margin-bottom: 22px;
            }

            .register-field label,
            .register-location-field label {
                font-size: 11px;
            }

            .register-field input,
            .register-location-field input {
                height: 44px;

                margin-top: 6px;
                padding: 0 11px;

                font-size: 12px;
            }

            .register-field textarea {
                min-height: 85px;

                margin-top: 6px;
                padding: 10px 11px;

                font-size: 12px;
            }


            /* CITY + STATE */

            .register-location-grid {
                grid-template-columns: 1fr;

                gap: 16px;

                margin-bottom: 16px;
            }


            /* BUTTON */

            .register-button {
                height: 44px;

                font-size: 9px;
                letter-spacing: 1.5px;
            }


            /* LOGIN */

            .register-login-text {
                margin-top: 19px;

                font-size: 11px;
            }
        }


        /* =========================================================
           SMALL MOBILE - 360px / 320px
        ========================================================= */

        @media (max-width: 400px) {

            .register-section {
                padding: 34px 10px 48px;
            }

            .register-container {
                padding: 22px 12px;
            }

            .register-heading {
                margin-bottom: 22px;
            }

            .register-subtitle {
                font-size: 7px;
            }

            .register-heading h1 {
                font-size: 25px;
            }

            .register-field label,
            .register-location-field label {
                font-size: 10px;
            }

            .register-field input,
            .register-location-field input {
                height: 42px;
                font-size: 11px;
            }

            .register-field textarea {
                min-height: 80px;
                font-size: 11px;
            }

            .register-button {
                height: 42px;

                font-size: 8px;
                letter-spacing: 1.3px;
            }

            .register-login-text {
                margin-top: 17px;

                font-size: 10px;
            }
        }

    </style>

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


<main>

    <section class="register-section">

        <div class="register-container">


            <!-- =====================================================
                 HEADING
            ====================================================== -->

            <div class="register-heading">

                <p class="register-subtitle">
                    CREATE ACCOUNT
                </p>

                <h1>
                    Register
                </h1>

            </div>


            <!-- =====================================================
                 ERROR MESSAGE
            ====================================================== -->

            <% if (error != null) { %>

                <div class="register-error">
                    <%= error %>
                </div>

            <% } %>


            <!-- =====================================================
                 REGISTER FORM
            ====================================================== -->

            <form
                action="<%= request.getContextPath() %>/register"
                method="post"
                autocomplete="off">


                <!-- FULL NAME -->

                <div class="register-field">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input
                        id="fullName"
                        type="text"
                        name="fullName"
                        value="<%= fullName %>"
                        required>

                </div>


                <!-- EMAIL -->

                <div class="register-field">

                    <label for="email">
                        Email
                    </label>

                    <input
                        id="email"
                        type="email"
                        name="email"
                        value="<%= email %>"
                        autocomplete="off"
                        required>

                </div>


                <!-- PHONE -->

                <div class="register-field">

                    <label for="phone">
                        Phone Number
                    </label>

                    <input
                        id="phone"
                        type="text"
                        name="phone"
                        value="<%= phone %>"
                        maxlength="10"
                        inputmode="numeric"
                        required>

                </div>


                <!-- PASSWORD -->

                <div class="register-field">

                    <label for="password">
                        Password
                    </label>

                    <input
                        id="password"
                        type="password"
                        name="password"
                        autocomplete="new-password"
                        minlength="6"
                        required>

                </div>


                <!-- ADDRESS -->

                <div class="register-field">

                    <label for="address">
                        Address
                    </label>

                    <textarea
                        id="address"
                        name="address"
                        rows="3"
                        required><%= address %></textarea>

                </div>


                <!-- =================================================
                     CITY + STATE
                ================================================== -->

                <div class="register-location-grid">


                    <!-- CITY -->

                    <div class="register-location-field">

                        <label for="city">
                            City
                        </label>

                        <input
                            id="city"
                            type="text"
                            name="city"
                            value="<%= city %>"
                            required>

                    </div>


                    <!-- STATE -->

                    <div class="register-location-field">

                        <label for="state">
                            State
                        </label>

                        <input
                            id="state"
                            type="text"
                            name="state"
                            value="<%= state %>"
                            required>

                    </div>

                </div>


                <!-- PINCODE -->

                <div class="register-field pincode-field">

                    <label for="pincode">
                        Pincode
                    </label>

                    <input
                        id="pincode"
                        type="text"
                        name="pincode"
                        value="<%= pincode %>"
                        maxlength="6"
                        inputmode="numeric"
                        required>

                </div>


                <!-- CREATE ACCOUNT -->

                <button
                    type="submit"
                    class="register-button">

                    CREATE ACCOUNT

                </button>

            </form>


            <!-- =====================================================
                 LOGIN LINK
            ====================================================== -->

            <p class="register-login-text">

                Already have an account?

                <a href="<%= request.getContextPath() %>/login">
                    Login
                </a>

            </p>

        </div>

    </section>

</main>


<jsp:include page="partials/footer.jsp" />


</body>
</html>