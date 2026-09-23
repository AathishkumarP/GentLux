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

</head>


<body>


<jsp:include page="partials/nav.jsp" />


<main>


    <!-- =========================================================
         ABOUT HERO
         ========================================================= -->

    <section style="
        padding: 90px 20px 70px;
        background: #f7f3ee;
        text-align: center;
    ">

        <p style="
            margin: 0 0 12px;
            color: #9b7a68;
            font-size: 11px;
            letter-spacing: 4px;
        ">

            ABOUT GENTLUX

        </p>


        <h1 style="
            margin: 0;
            color: #38251e;
            font-family: Georgia, serif;
            font-size: 48px;
            font-weight: 400;
        ">

            Modern Style for Modern Men

        </h1>


        <p style="
            max-width: 720px;
            margin: 25px auto 0;
            color: #6e625d;
            font-size: 15px;
            line-height: 1.8;
        ">

            GENTLUX is a men's fashion e-commerce platform
            created to make stylish, comfortable and premium
            clothing easier to discover and shop.

        </p>

    </section>



    <!-- =========================================================
         OUR STORY
         ========================================================= -->

    <section style="
        padding: 70px 20px;
        background: #ffffff;
    ">

        <div style="
            max-width: 1100px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        ">


            <div>

                <p style="
                    margin: 0 0 10px;
                    color: #9b7a68;
                    font-size: 10px;
                    letter-spacing: 3px;
                ">

                    OUR STORY

                </p>


                <h2 style="
                    margin: 0 0 25px;
                    color: #38251e;
                    font-family: Georgia, serif;
                    font-size: 38px;
                    font-weight: 400;
                ">

                    Fashion Made Simple

                </h2>


                <p style="
                    margin-bottom: 18px;
                    color: #6e625d;
                    font-size: 14px;
                    line-height: 1.8;
                ">

                    GENTLUX was designed with one clear purpose:
                    to create a focused shopping experience
                    exclusively for men's fashion.

                </p>


                <p style="
                    color: #6e625d;
                    font-size: 14px;
                    line-height: 1.8;
                ">

                    Instead of overwhelming customers with unrelated
                    categories, GENTLUX focuses on men's clothing
                    and fashion essentials in a clean and easy-to-use
                    shopping experience.

                </p>

            </div>



            <div style="
                min-height: 330px;
                background: #eee6df;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #9b7a68;
                font-size: 12px;
                letter-spacing: 2px;
            ">

                GENTLUX FASHION IMAGE

            </div>


        </div>

    </section>



    <!-- =========================================================
         WHY GENTLUX
         ========================================================= -->

    <section style="
        padding: 70px 20px;
        background: #f7f3ee;
    ">


        <div style="
            max-width: 1100px;
            margin: 0 auto;
        ">


            <div style="
                text-align: center;
                margin-bottom: 45px;
            ">

                <p style="
                    margin: 0 0 10px;
                    color: #9b7a68;
                    font-size: 10px;
                    letter-spacing: 3px;
                ">

                    WHY GENTLUX

                </p>


                <h2 style="
                    margin: 0;
                    color: #38251e;
                    font-family: Georgia, serif;
                    font-size: 38px;
                    font-weight: 400;
                ">

                    Designed Around You

                </h2>

            </div>



            <div style="
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 25px;
            ">


                <!-- CARD 1 -->

                <div style="
                    background: #ffffff;
                    padding: 35px 25px;
                    text-align: center;
                    border: 1px solid #e7ddd6;
                ">

                    <h3 style="
                        margin-bottom: 15px;
                        color: #38251e;
                        font-size: 16px;
                        letter-spacing: 1px;
                    ">

                        MEN'S FASHION

                    </h3>


                    <p style="
                        margin: 0;
                        color: #756963;
                        font-size: 13px;
                        line-height: 1.7;
                    ">

                        A shopping experience focused exclusively
                        on men's fashion and lifestyle.

                    </p>

                </div>



                <!-- CARD 2 -->

                <div style="
                    background: #ffffff;
                    padding: 35px 25px;
                    text-align: center;
                    border: 1px solid #e7ddd6;
                ">

                    <h3 style="
                        margin-bottom: 15px;
                        color: #38251e;
                        font-size: 16px;
                        letter-spacing: 1px;
                    ">

                        SIMPLE SHOPPING

                    </h3>


                    <p style="
                        margin: 0;
                        color: #756963;
                        font-size: 13px;
                        line-height: 1.7;
                    ">

                        Browse products, choose your size,
                        manage your cart and place orders easily.

                    </p>

                </div>



                <!-- CARD 3 -->

                <div style="
                    background: #ffffff;
                    padding: 35px 25px;
                    text-align: center;
                    border: 1px solid #e7ddd6;
                ">

                    <h3 style="
                        margin-bottom: 15px;
                        color: #38251e;
                        font-size: 16px;
                        letter-spacing: 1px;
                    ">

                        SECURE ACCOUNT

                    </h3>


                    <p style="
                        margin: 0;
                        color: #756963;
                        font-size: 13px;
                        line-height: 1.7;
                    ">

                        Manage your personal information,
                        delivery address and orders from one account.

                    </p>

                </div>


            </div>

        </div>

    </section>



    <!-- =========================================================
         SHOP CTA
         ========================================================= -->

    <section style="
        padding: 80px 20px;
        background: #38251e;
        text-align: center;
    ">


        <p style="
            margin: 0 0 12px;
            color: #d8c1b3;
            font-size: 10px;
            letter-spacing: 4px;
        ">

            DISCOVER YOUR STYLE

        </p>


        <h2 style="
            margin: 0 0 28px;
            color: #ffffff;
            font-family: Georgia, serif;
            font-size: 38px;
            font-weight: 400;
        ">

            Explore the GENTLUX Collection

        </h2>


        <a href="<%= request.getContextPath() %>/products"
           style="
               display: inline-block;
               padding: 15px 35px;
               background: #ffffff;
               color: #38251e;
               text-decoration: none;
               font-size: 11px;
               font-weight: 600;
               letter-spacing: 2px;
           ">

            SHOP NOW

        </a>


    </section>


</main>


<jsp:include page="partials/footer.jsp" />


</body>

</html>