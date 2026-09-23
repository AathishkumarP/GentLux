<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.gentlux.model.Category" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Categories | GENTLUX</title>

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/style.css">

    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/assets/css/categories.css">

</head>
<body>

    <jsp:include page="partials/nav.jsp" />


    <%
        List<Category> categories =
                (List<Category>)
                request.getAttribute("categories");
    %>


    <main>

        <section class="categories-page-section">


            <!-- PAGE HEADING -->

            <div class="section-heading">

                <p class="section-subtitle">
                    EXPLORE
                </p>

                <h2>
                    SHOP BY CATEGORY
                </h2>

                <p class="section-description">
                    Discover styles made for every occasion.
                </p>

            </div>


            <!-- CATEGORY GRID -->

            <div class="categories-page-grid">


                <%
                    if (categories != null
                            && !categories.isEmpty()) {

                        for (Category category : categories) {

                            String categoryClass =
                                    "category-default";

                            String categoryName =
                                    category.getCategoryName()
                                            .toLowerCase();


                            if (categoryName.contains("t-shirt")) {

                                categoryClass =
                                        "category-tshirts";

                            } else if (categoryName.contains("shirt")) {

                                categoryClass =
                                        "category-shirts";

                            } else if (categoryName.contains("jeans")) {

                                categoryClass =
                                        "category-jeans";

                            } else if (categoryName.contains("trouser")) {

                                categoryClass =
                                        "category-trousers";

                            } else if (categoryName.contains("jacket")) {

                                categoryClass =
                                        "category-jackets";

                            } else if (categoryName.contains("hoodie")) {

                                categoryClass =
                                        "category-hoodies";

                            } else if (categoryName.contains("sweatshirt")) {

                                categoryClass =
                                        "category-sweatshirts";

                            } else if (categoryName.contains("short")) {

                                categoryClass =
                                        "category-shorts";

                            } else if (categoryName.contains("ethnic")) {

                                categoryClass =
                                        "category-ethnic";

                            } else if (categoryName.contains("footwear")) {

                                categoryClass =
                                        "category-footwear";
                            }
                %>


                <a
                    href="<%= request.getContextPath() %>/products?categoryId=<%= category.getCategoryId() %>"
                    class="categories-page-card">


                    <div class="categories-page-image <%= categoryClass %>">

                        <div class="categories-page-overlay">

                            <span>
                                EXPLORE
                            </span>

                        </div>

                    </div>


                    <div class="categories-page-info">

                        <p>
                            COLLECTION
                        </p>

                        <h3>
                            <%= category.getCategoryName() %>
                        </h3>

                        <span>
                            SHOP NOW →
                        </span>

                    </div>


                </a>


                <%
                        }

                    } else {
                %>


                <div class="categories-empty">

                    <h3>
                        No categories available
                    </h3>

                    <p>
                        Categories will appear here once they are added.
                    </p>

                </div>


                <%
                    }
                %>


            </div>

        </section>

    </main>


    <jsp:include page="partials/footer.jsp" />


</body>

</html>