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

    <style>

        /* =========================================================
           EDIT ADDRESS PAGE
        ========================================================= */

        .edit-address-section {
            width: 100%;
            min-height: 75vh;
            padding: 60px 20px;
            background: #f7f3ee;
            box-sizing: border-box;
        }

        .edit-address-container {
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

        .edit-address-heading {
            margin-bottom: 35px;
            text-align: center;
        }

        .edit-address-subtitle {
            margin: 0 0 8px;
            color: #9b7a68;
            font-size: 10px;
            letter-spacing: 3px;
        }

        .edit-address-heading h1 {
            margin: 0;
            color: #38251e;
            font-family: Georgia, serif;
            font-size: 36px;
            font-weight: 400;
            line-height: 1.25;
        }

        .edit-address-description {
            margin: 10px 0 0;
            color: #777777;
            font-size: 13px;
            line-height: 1.6;
        }


        /* =========================================================
           ERROR
        ========================================================= */

        .edit-address-error {
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

        .edit-address-field {
            margin-bottom: 18px;
        }

        .edit-address-field.pincode-field {
            margin-bottom: 28px;
        }

        .edit-address-field label {
            display: block;
            color: #38251e;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .edit-address-field input,
        .edit-address-field textarea {
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

        .edit-address-field input {
            height: 45px;
        }

        .edit-address-field textarea {
            min-height: 105px;
            padding: 12px;
            line-height: 1.6;
            resize: vertical;
        }

        .edit-address-field input:focus,
        .edit-address-field textarea:focus {
            border-color: #765747;
            box-shadow: 0 0 0 1px #765747;
        }


        /* =========================================================
           BUTTONS
        ========================================================= */

        .edit-address-actions {
            display: flex;
            gap: 15px;
        }

        .edit-address-save,
        .edit-address-cancel {
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

        .edit-address-save {
            border: 1px solid #38251e;
            background: #38251e;
            color: #ffffff;
        }

        .edit-address-save:hover {
            background: #56382c;
        }

        .edit-address-cancel {
            border: 1px solid #38251e;
            background: #ffffff;
            color: #38251e;
            text-decoration: none;
        }

        .edit-address-cancel:hover {
            background: #f5efeb;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 768px) {

            .edit-address-section {
                padding: 50px 20px 65px;
            }

            .edit-address-container {
                max-width: 600px;
                padding: 32px 28px;
            }

            .edit-address-heading {
                margin-bottom: 30px;
            }

            .edit-address-heading h1 {
                font-size: 31px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            .edit-address-section {
                min-height: 70vh;
                padding: 40px 14px 55px;
                overflow-x: hidden;
            }

            .edit-address-container {
                width: 100%;
                max-width: none;
                padding: 24px 16px;
            }


            /* HEADING */

            .edit-address-heading {
                margin-bottom: 26px;
            }

            .edit-address-subtitle {
                margin-bottom: 7px;
                font-size: 8px;
                letter-spacing: 2.2px;
            }

            .edit-address-heading h1 {
                font-size: 27px;
            }

            .edit-address-description {
                max-width: 280px;
                margin: 9px auto 0;
                font-size: 11px;
            }


            /* ERROR */

            .edit-address-error {
                margin-bottom: 20px;
                padding: 10px;
                font-size: 11px;
            }


            /* FORM */

            .edit-address-field {
                margin-bottom: 16px;
            }

            .edit-address-field.pincode-field {
                margin-bottom: 23px;
            }

            .edit-address-field label {
                font-size: 11px;
            }

            .edit-address-field input {
                height: 44px;
                margin-top: 6px;
                padding: 0 11px;
                font-size: 12px;
            }

            .edit-address-field textarea {
                min-height: 95px;
                margin-top: 6px;
                padding: 10px 11px;
                font-size: 12px;
            }


            /* BUTTONS */

            .edit-address-actions {
                flex-direction: column;
                gap: 10px;
            }

            .edit-address-save,
            .edit-address-cancel {
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

            .edit-address-section {
                padding: 34px 10px 48px;
            }

            .edit-address-container {
                padding: 20px 12px;
            }

            .edit-address-heading {
                margin-bottom: 23px;
            }

            .edit-address-heading h1 {
                font-size: 24px;
            }

            .edit-address-subtitle {
                font-size: 7px;
            }

            .edit-address-description {
                font-size: 10px;
            }

            .edit-address-field label {
                font-size: 10px;
            }

            .edit-address-field input {
                height: 42px;
                font-size: 11px;
            }

            .edit-address-field textarea {
                min-height: 90px;
                font-size: 11px;
            }

            .edit-address-save,
            .edit-address-cancel {
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

    <section class="edit-address-section">

        <div class="edit-address-container">


            <!-- =====================================================
                 HEADING
            ====================================================== -->

            <div class="edit-address-heading">

                <p class="edit-address-subtitle">
                    DELIVERY
                </p>

                <h1>
                    Edit Address
                </h1>

                <p class="edit-address-description">
                    Update your delivery address information.
                </p>

            </div>


            <!-- =====================================================
                 ERROR MESSAGE
            ====================================================== -->

            <% if (error != null) { %>

                <div class="edit-address-error">
                    <%= error %>
                </div>

            <% } %>


            <!-- =====================================================
                 FORM
            ====================================================== -->

            <form
                action="${pageContext.request.contextPath}/edit-address"
                method="post"
                autocomplete="off">


                <!-- ADDRESS -->

                <div class="edit-address-field">

                    <label for="address">
                        Address
                    </label>

                    <textarea
                        id="address"
                        name="address"
                        rows="4"
                        required><%= user != null
                                && user.getAddress() != null
                                ? user.getAddress()
                                : "" %></textarea>

                </div>


                <!-- CITY -->

                <div class="edit-address-field">

                    <label for="city">
                        City
                    </label>

                    <input
                        id="city"
                        type="text"
                        name="city"
                        value="<%= user != null
                                && user.getCity() != null
                                ? user.getCity()
                                : "" %>"
                        required>

                </div>


                <!-- STATE -->

                <div class="edit-address-field">

                    <label for="state">
                        State
                    </label>

                    <input
                        id="state"
                        type="text"
                        name="state"
                        value="<%= user != null
                                && user.getState() != null
                                ? user.getState()
                                : "" %>"
                        required>

                </div>


                <!-- PINCODE -->

                <div class="edit-address-field pincode-field">

                    <label for="pincode">
                        Pincode
                    </label>

                    <input
                        id="pincode"
                        type="text"
                        name="pincode"
                        maxlength="6"
                        inputmode="numeric"
                        value="<%= user != null
                                && user.getPincode() != null
                                ? user.getPincode()
                                : "" %>"
                        required>

                </div>


                <!-- =================================================
                     BUTTONS
                ================================================== -->

                <div class="edit-address-actions">

                    <button
                        type="submit"
                        class="edit-address-save">

                        SAVE ADDRESS

                    </button>


                    <a
                        href="${pageContext.request.contextPath}/profile"
                        class="edit-address-cancel">

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