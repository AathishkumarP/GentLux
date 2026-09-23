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

    <style>

        /* =========================================================
           GENTLUX LOGIN PAGE
        ========================================================= */

        .login-section {
            width: 100%;
            min-height: 80vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 60px 20px;

            background: #f7f3ee;

            box-sizing: border-box;
        }

        .login-container {
            width: 100%;
            max-width: 450px;

            padding: 40px;

            background: #ffffff;
            border: 1px solid #e3dad3;

            box-sizing: border-box;
        }


        /* =========================================================
           HEADING
        ========================================================= */

        .login-heading {
            margin-bottom: 30px;
            text-align: center;
        }

        .login-subtitle {
            margin: 0 0 8px;

            color: #9b7a68;

            font-size: 10px;
            letter-spacing: 3px;
        }

        .login-heading h1 {
            margin: 0;

            color: #38251e;

            font-family: Georgia, serif;
            font-size: 36px;
            font-weight: 400;
            line-height: 1.2;
        }


        /* =========================================================
           MESSAGES
        ========================================================= */

        .login-message {
            margin-bottom: 20px;
            padding: 12px;

            font-size: 13px;
            line-height: 1.5;

            box-sizing: border-box;
        }

        .login-success {
            background: #edf8ee;
            color: #2f7a3d;
        }

        .login-error {
            background: #fff1f1;
            color: #a33b3b;
        }


        /* =========================================================
           FORM
        ========================================================= */

        .login-field {
            margin-bottom: 18px;
        }

        .login-field.password-field {
            margin-bottom: 25px;
        }

        .login-field label {
            display: block;

            color: #38251e;

            font-size: 12px;
            font-weight: 600;
        }

        .login-field input {
            width: 100%;
            height: 45px;

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

        .login-field input:focus {
            border-color: #765747;
            box-shadow: 0 0 0 1px #765747;
        }


        /* =========================================================
           LOGIN BUTTON
        ========================================================= */

        .login-button {
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

        .login-button:hover {
            background: #56382c;
            border-color: #56382c;
        }


        /* =========================================================
           REGISTER LINK
        ========================================================= */

        .login-register-text {
            margin: 22px 0 0;

            text-align: center;

            color: #685e59;

            font-size: 13px;
            line-height: 1.5;
        }

        .login-register-text a {
            color: #38251e;

            font-weight: 600;
            text-decoration: none;
        }

        .login-register-text a:hover {
            text-decoration: underline;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 768px) {

            .login-section {
                min-height: 75vh;

                padding: 50px 20px 65px;
            }

            .login-container {
                max-width: 430px;

                padding: 34px 30px;
            }

            .login-heading h1 {
                font-size: 32px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .login-section {
                min-height: 70vh;

                align-items: flex-start;

                padding: 40px 14px 55px;

                overflow-x: hidden;
            }

            .login-container {
                width: 100%;
                max-width: 430px;

                padding: 26px 16px;
            }


            /* HEADING */

            .login-heading {
                margin-bottom: 25px;
            }

            .login-subtitle {
                margin-bottom: 7px;

                font-size: 8px;
                letter-spacing: 2.2px;
            }

            .login-heading h1 {
                font-size: 28px;
            }


            /* MESSAGES */

            .login-message {
                margin-bottom: 18px;

                padding: 10px;

                font-size: 11px;
            }


            /* FORM */

            .login-field {
                margin-bottom: 16px;
            }

            .login-field.password-field {
                margin-bottom: 22px;
            }

            .login-field label {
                font-size: 11px;
            }

            .login-field input {
                height: 44px;

                margin-top: 6px;
                padding: 0 11px;

                font-size: 12px;
            }


            /* BUTTON */

            .login-button {
                height: 44px;

                font-size: 9px;
                letter-spacing: 1.5px;
            }


            /* REGISTER */

            .login-register-text {
                margin-top: 19px;

                font-size: 11px;
            }
        }


        /* =========================================================
           SMALL MOBILE - 360px / 320px
        ========================================================= */

        @media (max-width: 400px) {

            .login-section {
                padding: 34px 10px 48px;
            }

            .login-container {
                padding: 22px 12px;
            }

            .login-heading {
                margin-bottom: 22px;
            }

            .login-subtitle {
                font-size: 7px;
            }

            .login-heading h1 {
                font-size: 25px;
            }

            .login-field label {
                font-size: 10px;
            }

            .login-field input {
                height: 42px;
                font-size: 11px;
            }

            .login-button {
                height: 42px;

                font-size: 8px;
                letter-spacing: 1.3px;
            }

            .login-register-text {
                margin-top: 17px;

                font-size: 10px;
            }
        }

    </style>

</head>


<body>

<jsp:include page="partials/nav.jsp" />


<main>

    <section class="login-section">

        <div class="login-container">


            <!-- =====================================================
                 HEADING
            ====================================================== -->

            <div class="login-heading">

                <p class="login-subtitle">
                    WELCOME BACK
                </p>

                <h1>
                    Login
                </h1>

            </div>


            <!-- =====================================================
                 REGISTRATION SUCCESS MESSAGE
            ====================================================== -->

            <% if ("true".equals(request.getParameter("registered"))) { %>

                <div class="login-message login-success">
                    Account created successfully. Please login.
                </div>

            <% } %>


            <!-- =====================================================
                 LOGIN ERROR MESSAGE
            ====================================================== -->

            <%
                String error =
                        (String) request.getAttribute("error");
            %>

            <% if (error != null) { %>

                <div class="login-message login-error">
                    <%= error %>
                </div>

            <% } %>


            <!-- =====================================================
                 LOGIN FORM
            ====================================================== -->

            <form
                action="<%= request.getContextPath() %>/login"
                method="post">


                <!-- EMAIL -->

                <div class="login-field">

                    <label for="email">
                        Email
                    </label>

                    <input
                        id="email"
                        type="email"
                        name="email"
                        autocomplete="email"
                        required>

                </div>


                <!-- PASSWORD -->

                <div class="login-field password-field">

                    <label for="password">
                        Password
                    </label>

                    <input
                        id="password"
                        type="password"
                        name="password"
                        autocomplete="current-password"
                        required>

                </div>


                <!-- LOGIN BUTTON -->

                <button
                    type="submit"
                    class="login-button">

                    LOGIN

                </button>

            </form>


            <!-- =====================================================
                 REGISTER
            ====================================================== -->

            <p class="login-register-text">

                Don't have an account?

                <a href="<%= request.getContextPath() %>/register">
                    Register
                </a>

            </p>

        </div>

    </section>

</main>


<jsp:include page="partials/footer.jsp" />


</body>
</html>