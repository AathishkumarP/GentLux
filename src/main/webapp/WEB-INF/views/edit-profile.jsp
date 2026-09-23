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

    <style>

        /* =========================================================
           EDIT PROFILE PAGE
        ========================================================= */

        .edit-profile-section {
            width: 100%;
            min-height: 75vh;
            padding: 60px 20px;
            background: #f7f3ee;
            box-sizing: border-box;
        }

        .edit-profile-container {
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

        .edit-profile-heading {
            margin-bottom: 35px;
            text-align: center;
        }

        .edit-profile-subtitle {
            margin: 0 0 8px;
            color: #9b7a68;
            font-size: 10px;
            letter-spacing: 3px;
        }

        .edit-profile-heading h1 {
            margin: 0;
            color: #38251e;
            font-family: Georgia, serif;
            font-size: 36px;
            font-weight: 400;
            line-height: 1.25;
        }


        /* =========================================================
           ERROR MESSAGE
        ========================================================= */

        .edit-profile-error {
            margin-bottom: 25px;
            padding: 12px;
            background: #fff1f1;
            color: #a33b3b;
            font-size: 13px;
            line-height: 1.5;
        }


        /* =========================================================
           FORM
        ========================================================= */

        .edit-profile-field {
            margin-bottom: 18px;
        }

        .edit-profile-field.phone-field {
            margin-bottom: 28px;
        }

        .edit-profile-field label {
            display: block;
            color: #38251e;
            font-size: 12px;
            font-weight: 600;
        }

        .edit-profile-field input {
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

        .edit-profile-field input:focus {
            border-color: #765747;
            box-shadow: 0 0 0 1px #765747;
        }


        /* =========================================================
           BUTTONS
        ========================================================= */

        .edit-profile-actions {
            display: flex;
            gap: 15px;
        }

        .edit-profile-save,
        .edit-profile-cancel {
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

        .edit-profile-save {
            border: 1px solid #38251e;
            background: #38251e;
            color: #ffffff;
        }

        .edit-profile-save:hover {
            background: #56382c;
        }

        .edit-profile-cancel {
            border: 1px solid #38251e;
            background: #ffffff;
            color: #38251e;
            text-decoration: none;
        }

        .edit-profile-cancel:hover {
            background: #f5efeb;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 768px) {

            .edit-profile-section {
                padding: 50px 20px 65px;
            }

            .edit-profile-container {
                max-width: 600px;
                padding: 32px 28px;
            }

            .edit-profile-heading {
                margin-bottom: 30px;
            }

            .edit-profile-heading h1 {
                font-size: 31px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .edit-profile-section {
                min-height: 70vh;
                padding: 40px 14px 55px;
                overflow-x: hidden;
            }

            .edit-profile-container {
                width: 100%;
                max-width: none;

                padding: 24px 16px;

                box-sizing: border-box;
            }


            /* ================= HEADING ================= */

            .edit-profile-heading {
                margin-bottom: 26px;
            }

            .edit-profile-subtitle {
                margin-bottom: 7px;

                font-size: 8px;
                letter-spacing: 2.2px;
            }

            .edit-profile-heading h1 {
                font-size: 26px;
                line-height: 1.25;
            }


            /* ================= ERROR ================= */

            .edit-profile-error {
                margin-bottom: 20px;
                padding: 10px;

                font-size: 11px;
            }


            /* ================= FORM ================= */

            .edit-profile-field {
                margin-bottom: 16px;
            }

            .edit-profile-field.phone-field {
                margin-bottom: 23px;
            }

            .edit-profile-field label {
                font-size: 11px;
            }

            .edit-profile-field input {
                height: 44px;

                margin-top: 6px;
                padding: 0 11px;

                font-size: 12px;
            }


            /* ================= BUTTONS ================= */

            .edit-profile-actions {
                flex-direction: column;
                gap: 10px;
            }

            .edit-profile-save,
            .edit-profile-cancel {
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

            .edit-profile-section {
                padding: 34px 10px 48px;
            }

            .edit-profile-container {
                padding: 20px 12px;
            }

            .edit-profile-heading {
                margin-bottom: 23px;
            }

            .edit-profile-heading h1 {
                font-size: 23px;
            }

            .edit-profile-subtitle {
                font-size: 7px;
            }

            .edit-profile-field label {
                font-size: 10px;
            }

            .edit-profile-field input {
                height: 42px;
                font-size: 11px;
            }

            .edit-profile-save,
            .edit-profile-cancel {
                height: 42px;

                font-size: 8px;
            }
        }

    </style>

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

    <section class="edit-profile-section">

        <div class="edit-profile-container">


            <!-- =====================================================
                 PAGE HEADING
            ====================================================== -->

            <div class="edit-profile-heading">

                <p class="edit-profile-subtitle">
                    PERSONAL
                </p>

                <h1>
                    Edit Personal Information
                </h1>

            </div>


            <!-- =====================================================
                 ERROR MESSAGE
            ====================================================== -->

            <% if (error != null) { %>

                <div class="edit-profile-error">
                    <%= error %>
                </div>

            <% } %>


            <!-- =====================================================
                 EDIT PROFILE FORM
            ====================================================== -->

            <form
                action="${pageContext.request.contextPath}/edit-profile"
                method="post"
                autocomplete="off">


                <!-- FULL NAME -->

                <div class="edit-profile-field">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input
                        id="fullName"
                        type="text"
                        name="fullName"
                        value="<%= user != null
                                ? user.getFullName()
                                : "" %>"
                        required>

                </div>


                <!-- EMAIL -->

                <div class="edit-profile-field">

                    <label for="email">
                        Email
                    </label>

                    <input
                        id="email"
                        type="email"
                        name="email"
                        autocomplete="off"
                        value="<%= user != null
                                ? user.getEmail()
                                : "" %>"
                        required>

                </div>


                <!-- PHONE -->

                <div class="edit-profile-field phone-field">

                    <label for="phone">
                        Phone Number
                    </label>

                    <input
                        id="phone"
                        type="text"
                        name="phone"
                        maxlength="10"
                        value="<%= user != null
                                ? user.getPhone()
                                : "" %>"
                        required>

                </div>


                <!-- =================================================
                     BUTTONS
                ================================================== -->

                <div class="edit-profile-actions">

                    <button
                        type="submit"
                        class="edit-profile-save">

                        SAVE CHANGES

                    </button>


                    <a
                        href="${pageContext.request.contextPath}/profile"
                        class="edit-profile-cancel">

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