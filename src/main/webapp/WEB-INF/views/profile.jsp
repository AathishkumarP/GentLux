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

    <title>My Profile | GENTLUX</title>


    <!-- MAIN WEBSITE CSS -->

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">


    <!-- PROFILE PAGE CSS -->

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/profile.css">

</head>


<body>


    <jsp:include page="partials/nav.jsp" />


    <%

        User user =
                (User)
                request.getAttribute("user");

    %>


    <main>

        <section class="profile-section">


            <!-- PAGE HEADING -->

            <div class="section-heading">

                <p class="section-subtitle">

                    YOUR ACCOUNT

                </p>


                <h2>

                    MY PROFILE

                </h2>


                <p class="section-description">

                    Manage your personal and delivery information.

                </p>

            </div>



            <!-- PROFILE CONTAINER -->

            <div class="profile-container">



                <!-- =================================================
                     PROFILE SIDEBAR
                     ================================================= -->

                <aside class="profile-sidebar">


                    <div class="profile-avatar">

                        <span>

                            <%= user.getFullName() != null
                                    && !user.getFullName().isEmpty()

                                    ? user.getFullName()
                                          .substring(0, 1)
                                          .toUpperCase()

                                    : "G" %>

                        </span>

                    </div>



                    <h3>

                        <%= user.getFullName() %>

                    </h3>



                    <p>

                        <%= user.getEmail() %>

                    </p>



                    <div class="profile-sidebar-divider">

                    </div>



                    <a href="<%= request.getContextPath() %>/profile"
                       class="profile-menu-link active">

                        PROFILE

                    </a>



                    <a href="<%= request.getContextPath() %>/my-orders"
                       class="profile-menu-link">

                        MY ORDERS

                    </a>



                    <a href="#"
                       class="profile-menu-link">

                        CHANGE PASSWORD

                    </a>


                </aside>



                <!-- =================================================
                     PROFILE CONTENT
                     ================================================= -->

                <div class="profile-content">



                    <!-- =================================================
                         PERSONAL INFORMATION
                         ================================================= -->

                    <div class="profile-card">


                        <div class="profile-card-header">


                            <div>

                                <p>

                                    PERSONAL

                                </p>


                                <h3>

                                    PERSONAL INFORMATION

                                </h3>

                            </div>



                            <!--
                                Personal Information Edit

                                This opens:
                                /edit-profile
                            -->

                            <a href="<%= request.getContextPath() %>/edit-profile"
                               class="profile-edit-button">

                                EDIT

                            </a>


                        </div>



                        <div class="profile-info-grid">



                            <!-- FULL NAME -->

                            <div class="profile-info-item">

                                <span>

                                    FULL NAME

                                </span>


                                <strong>

                                    <%= user.getFullName() %>

                                </strong>

                            </div>



                            <!-- EMAIL -->

                            <div class="profile-info-item">

                                <span>

                                    EMAIL ADDRESS

                                </span>


                                <strong>

                                    <%= user.getEmail() %>

                                </strong>

                            </div>



                            <!-- PHONE -->

                            <div class="profile-info-item">

                                <span>

                                    PHONE NUMBER

                                </span>


                                <strong>

                                    <%= user.getPhone() != null
                                            && !user.getPhone().isEmpty()

                                            ? user.getPhone()

                                            : "-" %>

                                </strong>

                            </div>



                            <!-- MEMBER SINCE -->

                            <div class="profile-info-item">

                                <span>

                                    MEMBER SINCE

                                </span>


                                <strong>

                                    <%= user.getCreatedAt() != null

                                            ? user.getCreatedAt()

                                            : "-" %>

                                </strong>

                            </div>


                        </div>


                    </div>



                    <!-- =================================================
                         ADDRESS INFORMATION
                         ================================================= -->

                    <div class="profile-card">


                        <div class="profile-card-header">


                            <div>

                                <p>

                                    DELIVERY

                                </p>


                                <h3>

                                    ADDRESS INFORMATION

                                </h3>

                            </div>



                            <!--
                                Address Information Edit

                                This opens:
                                /edit-address
                            -->

                            <a href="<%= request.getContextPath() %>/edit-address"
                               class="profile-edit-button">

                                EDIT

                            </a>


                        </div>



                        <div class="profile-address">



                            <!-- ADDRESS -->

                            <div class="profile-info-item">

                                <span>

                                    ADDRESS

                                </span>


                                <strong>

                                    <%= user.getAddress() != null
                                            && !user.getAddress().isEmpty()

                                            ? user.getAddress()

                                            : "Not added" %>

                                </strong>

                            </div>



                            <!-- ADDRESS GRID -->

                            <div class="profile-info-grid profile-address-grid">



                                <!-- CITY -->

                                <div class="profile-info-item">

                                    <span>

                                        CITY

                                    </span>


                                    <strong>

                                        <%= user.getCity() != null
                                                && !user.getCity().isEmpty()

                                                ? user.getCity()

                                                : "-" %>

                                    </strong>

                                </div>



                                <!-- STATE -->

                                <div class="profile-info-item">

                                    <span>

                                        STATE

                                    </span>


                                    <strong>

                                        <%= user.getState() != null
                                                && !user.getState().isEmpty()

                                                ? user.getState()

                                                : "-" %>

                                    </strong>

                                </div>



                                <!-- PINCODE -->

                                <div class="profile-info-item">

                                    <span>

                                        PINCODE

                                    </span>


                                    <strong>

                                        <%= user.getPincode() != null
                                                && !user.getPincode().isEmpty()

                                                ? user.getPincode()

                                                : "-" %>

                                    </strong>

                                </div>


                            </div>


                        </div>


                    </div>


                </div>


            </div>


        </section>

    </main>



    <jsp:include page="partials/footer.jsp" />


</body>

</html>