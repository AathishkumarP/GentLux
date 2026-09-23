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

    <style>

        /* =========================================================
           CHANGE PASSWORD PAGE
        ========================================================= */

        .change-password-section {
            width: 100%;
            min-height: 75vh;
            padding: 60px 20px;
            background: #f7f3ee;
            box-sizing: border-box;
        }

        .change-password-container {
            width: 100%;
            max-width: 650px;
            margin: 0 auto;
            padding: 40px;
            background: #ffffff;
            border: 1px solid #e6ddd7;
            box-sizing: border-box;
        }


        /* =========================================================
           HEADING
        ========================================================= */

        .change-password-heading {
            margin-bottom: 35px;
            text-align: center;
        }

        .change-password-subtitle {
            margin: 0 0 8px;
            color: #9b7a68;
            font-size: 10px;
            letter-spacing: 3px;
        }

        .change-password-heading h1 {
            margin: 0;
            color: #38251e;
            font-family: Georgia, serif;
            font-size: 36px;
            font-weight: 400;
            line-height: 1.25;
        }

        .change-password-description {
            margin: 10px 0 0;
            color: #777777;
            font-size: 13px;
            line-height: 1.6;
        }


        /* =========================================================
           MESSAGES
        ========================================================= */

        .change-password-message {
            margin-bottom: 25px;
            padding: 12px;
            font-size: 13px;
            line-height: 1.5;
            box-sizing: border-box;
        }

        .change-password-error {
            background: #fff1f1;
            color: #a33b3b;
        }

        .change-password-success {
            background: #eef8ee;
            color: #3b6f3b;
        }


        /* =========================================================
           FORM
        ========================================================= */

        .change-password-field {
            margin-bottom: 18px;
        }

        .change-password-field.confirm-field {
            margin-bottom: 28px;
        }

        .change-password-field label {
            display: block;
            color: #38251e;
            font-size: 12px;
            font-weight: 600;
        }

        .change-password-field input {
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

        .change-password-field input:focus {
            border-color: #765747;
            box-shadow: 0 0 0 1px #765747;
        }


        /* =========================================================
           BUTTONS
        ========================================================= */

        .change-password-actions {
            display: flex;
            gap: 15px;
        }

        .change-password-submit,
        .change-password-cancel {
            flex: 1;
            width: 100%;
            height: 48px;

            display: flex;
            align-items: center;
            justify-content: center;

            box-sizing: border-box;

            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 1.5px;

            cursor: pointer;

            transition:
                background 0.2s ease,
                color 0.2s ease;
        }

        .change-password-submit {
            border: 1px solid #38251e;
            background: #38251e;
            color: #ffffff;
        }

        .change-password-submit:hover {
            background: #56382c;
        }

        .change-password-cancel {
            border: 1px solid #38251e;
            background: #ffffff;
            color: #38251e;
            text-decoration: none;
        }

        .change-password-cancel:hover {
            background: #f5efeb;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 768px) {

            .change-password-section {
                padding: 50px 20px 65px;
            }

            .change-password-container {
                max-width: 600px;
                padding: 32px 28px;
            }

            .change-password-heading {
                margin-bottom: 30px;
            }

            .change-password-heading h1 {
                font-size: 31px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .change-password-section {
                min-height: 70vh;
                padding: 40px 14px 55px;
                overflow-x: hidden;
            }

            .change-password-container {
                width: 100%;
                max-width: none;
                padding: 24px 16px;
            }


            /* HEADING */

            .change-password-heading {
                margin-bottom: 26px;
            }

            .change-password-subtitle {
                margin-bottom: 7px;
                font-size: 8px;
                letter-spacing: 2.2px;
            }

            .change-password-heading h1 {
                font-size: 27px;
            }

            .change-password-description {
                max-width: 280px;
                margin: 9px auto 0;
                font-size: 11px;
            }


            /* MESSAGES */

            .change-password-message {
                margin-bottom: 20px;
                padding: 10px;
                font-size: 11px;
            }


            /* FORM */

            .change-password-field {
                margin-bottom: 16px;
            }

            .change-password-field.confirm-field {
                margin-bottom: 23px;
            }

            .change-password-field label {
                font-size: 11px;
            }

            .change-password-field input {
                height: 44px;
                margin-top: 6px;
                padding: 0 11px;
                font-size: 12px;
            }


            /* BUTTONS */

            .change-password-actions {
                flex-direction: column;
                gap: 10px;
            }

            .change-password-submit,
            .change-password-cancel {
                flex: none;
                width: 100%;
                height: 44px;

                font-size: 9px;
                letter-spacing: 1.2px;
            }
        }


        /* =========================================================
           SMALL MOBILE - 360px / 320px
        ========================================================= */

        @media (max-width: 400px) {

            .change-password-section {
                padding: 34px 10px 48px;
            }

            .change-password-container {
                padding: 20px 12px;
            }

            .change-password-heading {
                margin-bottom: 23px;
            }

            .change-password-heading h1 {
                font-size: 24px;
            }

            .change-password-subtitle {
                font-size: 7px;
            }

            .change-password-description {
                font-size: 10px;
            }

            .change-password-field label {
                font-size: 10px;
            }

            .change-password-field input {
                height: 42px;
                font-size: 11px;
            }

            .change-password-submit,
            .change-password-cancel {
                height: 42px;
                font-size: 8px;
                letter-spacing: 1px;
            }
        }

    </style>

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

    <section class="change-password-section">

        <div class="change-password-container">


            <!-- =====================================================
                 HEADING
            ====================================================== -->

            <div class="change-password-heading">

                <p class="change-password-subtitle">
                    SECURITY
                </p>

                <h1>
                    Change Password
                </h1>

                <p class="change-password-description">
                    Update your account password.
                </p>

            </div>


            <!-- =====================================================
                 ERROR MESSAGE
            ====================================================== -->

            <% if (error != null) { %>

                <div class="change-password-message change-password-error">
                    <%= error %>
                </div>

            <% } %>


            <!-- =====================================================
                 SUCCESS MESSAGE
            ====================================================== -->

            <% if ("true".equals(success)) { %>

                <div class="change-password-message change-password-success">
                    Password changed successfully.
                </div>

            <% } %>


            <!-- =====================================================
                 FORM
            ====================================================== -->

            <form
                action="${pageContext.request.contextPath}/change-password"
                method="post"
                autocomplete="off">


                <!-- CURRENT PASSWORD -->

                <div class="change-password-field">

                    <label for="currentPassword">
                        Current Password
                    </label>

                    <input
                        id="currentPassword"
                        type="password"
                        name="currentPassword"
                        autocomplete="current-password"
                        required>

                </div>


                <!-- NEW PASSWORD -->

                <div class="change-password-field">

                    <label for="newPassword">
                        New Password
                    </label>

                    <input
                        id="newPassword"
                        type="password"
                        name="newPassword"
                        minlength="6"
                        autocomplete="new-password"
                        required>

                </div>


                <!-- CONFIRM PASSWORD -->

                <div class="change-password-field confirm-field">

                    <label for="confirmPassword">
                        Confirm New Password
                    </label>

                    <input
                        id="confirmPassword"
                        type="password"
                        name="confirmPassword"
                        minlength="6"
                        autocomplete="new-password"
                        required>

                </div>


                <!-- =================================================
                     BUTTONS
                ================================================== -->

                <div class="change-password-actions">

                    <button
                        type="submit"
                        class="change-password-submit">

                        CHANGE PASSWORD

                    </button>


                    <a
                        href="${pageContext.request.contextPath}/profile"
                        class="change-password-cancel">

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