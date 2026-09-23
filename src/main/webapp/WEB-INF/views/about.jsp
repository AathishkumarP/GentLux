<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>About | GENTLUX</title>

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">


    <style>

        /* =========================================================
           ABOUT PAGE
        ========================================================= */

        .about-page {
            width: 100%;
            overflow-x: hidden;
        }


        /* =========================================================
           ABOUT HERO
        ========================================================= */

        .about-hero {
            padding: 90px 20px 70px;

            background: #f7f3ee;

            text-align: center;
        }

        .about-small-title {
            margin: 0 0 12px;

            color: #9b7a68;

            font-size: 11px;
            font-weight: 600;
            letter-spacing: 4px;
        }

        .about-hero h1 {
            margin: 0;

            color: #38251e;

            font-family: Georgia, "Times New Roman", serif;
            font-size: 48px;
            font-weight: 400;
            line-height: 1.15;
        }

        .about-hero-description {
            max-width: 720px;

            margin: 25px auto 0;

            color: #6e625d;

            font-size: 15px;
            line-height: 1.8;
        }


        /* =========================================================
           OUR STORY
        ========================================================= */

        .about-story {
            padding: 70px 20px;

            background: #ffffff;
        }

        .about-story-container {
            width: 100%;
            max-width: 1100px;

            margin: 0 auto;

            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);

            gap: 60px;

            align-items: center;
        }

        .about-story-content {
            min-width: 0;
        }

        .about-section-label {
            margin: 0 0 10px;

            color: #9b7a68;

            font-size: 10px;
            font-weight: 600;
            letter-spacing: 3px;
        }

        .about-story-content h2 {
            margin: 0 0 25px;

            color: #38251e;

            font-family: Georgia, "Times New Roman", serif;
            font-size: 38px;
            font-weight: 400;
            line-height: 1.2;
        }

        .about-story-content p {
            margin: 0 0 18px;

            color: #6e625d;

            font-size: 14px;
            line-height: 1.8;
        }

        .about-story-content p:last-child {
            margin-bottom: 0;
        }

        .about-story-image {
            width: 100%;
            min-height: 330px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #eee6df;
            color: #9b7a68;

            font-size: 12px;
            font-weight: 600;
            letter-spacing: 2px;

            text-align: center;

            box-sizing: border-box;
        }


        /* =========================================================
           WHY GENTLUX
        ========================================================= */

        .about-why {
            padding: 70px 20px;

            background: #f7f3ee;
        }

        .about-why-container {
            width: 100%;
            max-width: 1100px;

            margin: 0 auto;
        }

        .about-why-heading {
            margin-bottom: 45px;

            text-align: center;
        }

        .about-why-heading h2 {
            margin: 0;

            color: #38251e;

            font-family: Georgia, "Times New Roman", serif;
            font-size: 38px;
            font-weight: 400;
            line-height: 1.2;
        }

        .about-features {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));

            gap: 25px;
        }

        .about-feature-card {
            min-width: 0;

            padding: 35px 25px;

            background: #ffffff;
            border: 1px solid #e7ddd6;

            text-align: center;

            box-sizing: border-box;
        }

        .about-feature-card h3 {
            margin: 0 0 15px;

            color: #38251e;

            font-size: 16px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .about-feature-card p {
            margin: 0;

            color: #756963;

            font-size: 13px;
            line-height: 1.7;
        }


        /* =========================================================
           CTA
        ========================================================= */

        .about-cta {
            padding: 80px 20px;

            background: #38251e;

            text-align: center;
        }

        .about-cta-label {
            margin: 0 0 12px;

            color: #d8c1b3;

            font-size: 10px;
            font-weight: 600;
            letter-spacing: 4px;
        }

        .about-cta h2 {
            margin: 0 0 28px;

            color: #ffffff;

            font-family: Georgia, "Times New Roman", serif;
            font-size: 38px;
            font-weight: 400;
            line-height: 1.2;
        }

        .about-shop-btn {
            min-height: 46px;

            padding: 0 35px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            background: #ffffff;
            border: 1px solid #ffffff;

            color: #38251e;

            text-decoration: none;

            font-size: 11px;
            font-weight: 600;
            letter-spacing: 2px;

            box-sizing: border-box;

            transition:
                background 0.25s ease,
                color 0.25s ease;
        }

        .about-shop-btn:hover {
            background: transparent;
            color: #ffffff;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 1024px) {

            .about-hero {
                padding: 75px 30px 65px;
            }

            .about-hero h1 {
                font-size: 42px;
            }


            /* STORY */

            .about-story {
                padding: 65px 35px;
            }

            .about-story-container {
                gap: 40px;
            }

            .about-story-content h2 {
                font-size: 34px;
            }

            .about-story-image {
                min-height: 300px;
            }


            /* WHY */

            .about-why {
                padding: 65px 35px;
            }

            .about-features {
                gap: 18px;
            }

            .about-feature-card {
                padding: 30px 20px;
            }
        }


        /* =========================================================
           SMALL TABLET
        ========================================================= */

        @media (max-width: 768px) {

            /* HERO */

            .about-hero {
                padding: 60px 22px 55px;
            }

            .about-small-title {
                font-size: 9px;
                letter-spacing: 3px;
            }

            .about-hero h1 {
                font-size: 36px;
            }

            .about-hero-description {
                max-width: 600px;

                margin-top: 20px;

                font-size: 13px;
                line-height: 1.7;
            }


            /* STORY */

            .about-story {
                padding: 55px 22px;
            }

            .about-story-container {
                grid-template-columns: 1fr;

                gap: 32px;
            }

            .about-story-content {
                text-align: center;
            }

            .about-story-content h2 {
                margin-bottom: 20px;

                font-size: 32px;
            }

            .about-story-content p {
                font-size: 13px;
                line-height: 1.7;
            }

            .about-story-image {
                min-height: 280px;
            }


            /* WHY */

            .about-why {
                padding: 55px 22px;
            }

            .about-why-heading {
                margin-bottom: 32px;
            }

            .about-why-heading h2 {
                font-size: 32px;
            }

            .about-features {
                grid-template-columns: repeat(2, minmax(0, 1fr));

                gap: 15px;
            }

            .about-feature-card {
                padding: 28px 18px;
            }


            /* Third card centered nicely */

            .about-feature-card:last-child {
                grid-column: 1 / -1;

                width: calc(50% - 8px);

                justify-self: center;
            }


            /* CTA */

            .about-cta {
                padding: 65px 22px;
            }

            .about-cta h2 {
                font-size: 32px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 600px) {

            /* HERO */

            .about-hero {
                padding: 45px 16px 42px;
            }

            .about-small-title {
                margin-bottom: 9px;

                font-size: 8px;
                letter-spacing: 2.5px;
            }

            .about-hero h1 {
                max-width: 360px;

                margin: 0 auto;

                font-size: 30px;
                line-height: 1.2;
            }

            .about-hero-description {
                max-width: 420px;

                margin-top: 17px;

                font-size: 12px;
                line-height: 1.65;
            }


            /* STORY */

            .about-story {
                padding: 45px 16px;
            }

            .about-story-container {
                gap: 25px;
            }

            .about-section-label {
                margin-bottom: 8px;

                font-size: 8px;
                letter-spacing: 2.3px;
            }

            .about-story-content h2 {
                margin-bottom: 17px;

                font-size: 27px;
            }

            .about-story-content p {
                margin-bottom: 14px;

                font-size: 12px;
                line-height: 1.65;
            }

            .about-story-image {
                min-height: 220px;

                padding: 20px;

                font-size: 9px;
                letter-spacing: 1.5px;
            }


            /* WHY */

            .about-why {
                padding: 45px 12px;
            }

            .about-why-heading {
                margin-bottom: 25px;
            }

            .about-why-heading h2 {
                font-size: 27px;
            }


            /*
             * Keep feature cards compact on mobile:
             *
             * [ CARD ] [ CARD ]
             * [    CARD     ]
             */

            .about-features {
                grid-template-columns: repeat(2, minmax(0, 1fr));

                gap: 10px;
            }

            .about-feature-card {
                padding: 22px 10px;
            }

            .about-feature-card h3 {
                margin-bottom: 10px;

                font-size: 11px;
                line-height: 1.35;
                letter-spacing: 0.6px;
            }

            .about-feature-card p {
                font-size: 10px;
                line-height: 1.55;
            }

            .about-feature-card:last-child {
                grid-column: 1 / -1;

                width: calc(50% - 5px);

                justify-self: center;
            }


            /* CTA */

            .about-cta {
                padding: 50px 16px;
            }

            .about-cta-label {
                margin-bottom: 10px;

                font-size: 8px;
                letter-spacing: 2.5px;
            }

            .about-cta h2 {
                max-width: 360px;

                margin: 0 auto 22px;

                font-size: 27px;
            }

            .about-shop-btn {
                min-height: 43px;

                padding: 0 28px;

                font-size: 9px;
                letter-spacing: 1.5px;
            }
        }


        /* =========================================================
           SMALL MOBILE - 360px / 320px
        ========================================================= */

        @media (max-width: 400px) {

            .about-hero {
                padding: 40px 12px 38px;
            }

            .about-hero h1 {
                font-size: 26px;
            }

            .about-hero-description {
                font-size: 11px;
            }


            /* STORY */

            .about-story {
                padding: 40px 12px;
            }

            .about-story-content h2 {
                font-size: 24px;
            }

            .about-story-content p {
                font-size: 11px;
            }

            .about-story-image {
                min-height: 190px;
            }


            /* WHY */

            .about-why {
                padding: 40px 10px;
            }

            .about-why-heading h2 {
                font-size: 24px;
            }

            .about-features {
                gap: 8px;
            }

            .about-feature-card {
                padding: 18px 7px;
            }

            .about-feature-card h3 {
                font-size: 9px;
            }

            .about-feature-card p {
                font-size: 9px;
            }

            .about-feature-card:last-child {
                width: calc(50% - 4px);
            }


            /* CTA */

            .about-cta {
                padding: 44px 12px;
            }

            .about-cta h2 {
                font-size: 24px;
            }

            .about-shop-btn {
                min-height: 41px;

                padding: 0 24px;

                font-size: 8px;
            }
        }

    </style>

</head>


<body>


<jsp:include page="partials/nav.jsp" />


<main class="about-page">


    <!-- =========================================================
         ABOUT HERO
    ========================================================== -->

    <section class="about-hero">

        <p class="about-small-title">
            ABOUT GENTLUX
        </p>

        <h1>
            Modern Style for Modern Men
        </h1>

        <p class="about-hero-description">
            GENTLUX is a men's fashion e-commerce platform
            created to make stylish, comfortable and premium
            clothing easier to discover and shop.
        </p>

    </section>



    <!-- =========================================================
         OUR STORY
    ========================================================== -->

    <section class="about-story">

        <div class="about-story-container">


            <div class="about-story-content">

                <p class="about-section-label">
                    OUR STORY
                </p>

                <h2>
                    Fashion Made Simple
                </h2>

                <p>
                    GENTLUX was designed with one clear purpose:
                    to create a focused shopping experience
                    exclusively for men's fashion.
                </p>

                <p>
                    Instead of overwhelming customers with unrelated
                    categories, GENTLUX focuses on men's clothing
                    and fashion essentials in a clean and easy-to-use
                    shopping experience.
                </p>

            </div>


            <div class="about-story-image">
                GENTLUX FASHION IMAGE
            </div>


        </div>

    </section>



    <!-- =========================================================
         WHY GENTLUX
    ========================================================== -->

    <section class="about-why">

        <div class="about-why-container">


            <div class="about-why-heading">

                <p class="about-section-label">
                    WHY GENTLUX
                </p>

                <h2>
                    Designed Around You
                </h2>

            </div>


            <div class="about-features">


                <!-- CARD 1 -->

                <div class="about-feature-card">

                    <h3>
                        MEN'S FASHION
                    </h3>

                    <p>
                        A shopping experience focused exclusively
                        on men's fashion and lifestyle.
                    </p>

                </div>


                <!-- CARD 2 -->

                <div class="about-feature-card">

                    <h3>
                        SIMPLE SHOPPING
                    </h3>

                    <p>
                        Browse products, choose your size,
                        manage your cart and place orders easily.
                    </p>

                </div>


                <!-- CARD 3 -->

                <div class="about-feature-card">

                    <h3>
                        SECURE ACCOUNT
                    </h3>

                    <p>
                        Manage your personal information,
                        delivery address and orders from one account.
                    </p>

                </div>


            </div>

        </div>

    </section>



    <!-- =========================================================
         SHOP CTA
    ========================================================== -->

    <section class="about-cta">

        <p class="about-cta-label">
            DISCOVER YOUR STYLE
        </p>

        <h2>
            Explore the GENTLUX Collection
        </h2>

        <a href="<%= request.getContextPath() %>/products"
           class="about-shop-btn">
            SHOP NOW
        </a>

    </section>


</main>


<jsp:include page="partials/footer.jsp" />


</body>
</html>