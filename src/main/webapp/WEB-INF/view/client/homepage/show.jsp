<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang chủ - Laptopshop</title>

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                <!-- Customized Bootstrap Stylesheet -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="/client/css/style.css" rel="stylesheet">

            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />


                <jsp:include page="../layout/banner.jsp" />




                <!-- Fruits Shop Start-->
                <div class="container-fluid fruite py-5">
                    <div class="container py-5">
                        <div class="row g-4">

                            <!-- Sidebar Filter -->
                            <div class="col-lg-3 col-md-4">
                                <div class="bg-light p-4 rounded position-sticky w-100" style="top: 100px;">
                                    <h5 class="mb-3">Bộ lọc tìm kiếm</h5>

                                    <!-- Hãng sản xuất -->
                                    <div class="mb-4">
                                        <h6>Hãng sản xuất</h6>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-factory" type="checkbox"
                                                value="ASUS" id="brandAsus">
                                            <label class="form-check-label" for="brandAsus">ASUS</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-factory" type="checkbox"
                                                value="DELL" id="brandDell">
                                            <label class="form-check-label" for="brandDell">Dell</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-factory" type="checkbox"
                                                value="LENOVO" id="brandLenovo">
                                            <label class="form-check-label" for="brandLenovo">Lenovo</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-factory" type="checkbox"
                                                value="APPLE" id="brandApple">
                                            <label class="form-check-label" for="brandApple">Apple</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-factory" type="checkbox" value="LG"
                                                id="brandLG">
                                            <label class="form-check-label" for="brandLG">LG</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-factory" type="checkbox"
                                                value="ACER" id="brandAcer">
                                            <label class="form-check-label" for="brandAcer">Acer</label>
                                        </div>
                                    </div>

                                    <!-- Nhu cầu -->
                                    <div class="mb-4">
                                        <h6>Nhu cầu</h6>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-target" type="checkbox"
                                                value="GAMING" id="gaming">
                                            <label class="form-check-label" for="gaming">Gaming</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-target" type="checkbox"
                                                value="SINHVIEN-VANPHONG" id="sv-vp">
                                            <label class="form-check-label" for="sv-vp">Sinh viên - văn phòng</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-target" type="checkbox"
                                                value="THIET-KE-DO-HOA" id="tkdh">
                                            <label class="form-check-label" for="tkdh">Thiết kế đồ họa</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-target" type="checkbox"
                                                value="DOANH-NHAN" id="dn">
                                            <label class="form-check-label" for="dn">Doanh nhân</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input checkbox-target" type="checkbox"
                                                value="MONG-NHE" id="mn">
                                            <label class="form-check-label" for="mn">Mỏng nhẹ</label>
                                        </div>
                                    </div>

                                    <!-- Mức giá -->
                                    <div class="mb-4">
                                        <h6>Mức giá</h6>
                                        <div class="form-check">
                                            <input class="form-check-input price-radio" type="radio" name="priceRange"
                                                value="" id="price1">
                                            <label class="form-check-label" for="price1">Tất cả</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input price-radio" type="radio" name="priceRange"
                                                value="<10000000" id="price2">
                                            <label class="form-check-label" for="price2">Dưới 10 triệu</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input price-radio" type="radio" name="priceRange"
                                                value="10000000-15000000" id="price3">
                                            <label class="form-check-label" for="price3">10 - 15 triệu</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input price-radio" type="radio" name="priceRange"
                                                value="15000000-20000000" id="price4">
                                            <label class="form-check-label" for="price4">15 - 20 triệu</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input price-radio" type="radio" name="priceRange"
                                                value="20000000-30000000" id="price5">
                                            <label class="form-check-label" for="price5">20 - 30 triệu</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input price-radio" type="radio" name="priceRange"
                                                value=">30000000" id="price6">
                                            <label class="form-check-label" for="price6">Trên 30 triệu</label>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="col-lg-9 col-md-8">
                                <div class="tab-class text-center">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <h1>Sản phẩm nổi bật</h1>
                                        </div>
                                        <div class="col-lg-12 text-end">
                                            <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                                <li class="nav-item">
                                                    <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                                                        data-bs-toggle="pill" href="#tab-1">
                                                        <span class="text-dark" style="width: 130px;">All
                                                            Products</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="tab-content">
                                        <div id="tab-1" class="tab-pane fade show p-0 active">
                                            <div class="row g-4">
                                                <div class="col-lg-12">
                                                    <div class="row g-4" id="product-list">
                                                        <c:forEach var="product" items="${products.content}">
                                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                                <div class="rounded position-relative fruite-item">
                                                                    <div class="fruite-img">
                                                                        <a href="/product/${product.id}">
                                                                            <img src="/images/product/${product.productImage}"
                                                                                class="img-fluid w-100 rounded-top"
                                                                                alt="">
                                                                        </a>
                                                                    </div>
                                                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                        style="top: 10px; left: 10px;">Laptop</div>
                                                                    <div
                                                                        class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                        <h4 style="font-size: 15px;">
                                                                            <a href="/product/${product.id}">
                                                                                ${product.name}
                                                                            </a>
                                                                        </h4>
                                                                        <p style="font-size: 13px;">${product.shortDesc}
                                                                        </p>
                                                                        <div
                                                                            class="d-flex flex-lg-wrap justify-content-center">
                                                                            <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                                class="text-dark fw-bold mb-3">
                                                                                <fmt:formatNumber type="number"
                                                                                    value="${product.price}" /> đ
                                                                            </p>
                                                                            <form
                                                                                action="/add-product-to-cart/${product.id}"
                                                                                method="post">
                                                                                <input type="hidden"
                                                                                    name="${_csrf.parameterName}"
                                                                                    value="${_csrf.token}" />
                                                                                <button
                                                                                    class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                        class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                    Add to cart
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                        <nav>
                                                            <ul class="pagination justify-content-center">

                                                                <!-- Previous -->
                                                                <li
                                                                    class="page-item ${products.first ? 'disabled' : ''}">
                                                                    <a class="page-link"
                                                                        href="?page=${products.number - 1}&size=${products.size}">Previous</a>
                                                                </li>

                                                                <!-- Page numbers (tối đa 3 số) -->
                                                                <c:set var="currentPage" value="${products.number}" />
                                                                <c:set var="totalPages"
                                                                    value="${products.totalPages}" />

                                                                <c:set var="start" value="${currentPage - 1}" />
                                                                <c:set var="end" value="${currentPage + 1}" />

                                                                <!-- đảm bảo không vượt quá range -->
                                                                <c:if test="${start < 0}">
                                                                    <c:set var="start" value="0" />
                                                                </c:if>
                                                                <c:if test="${end >= totalPages}">
                                                                    <c:set var="end" value="${totalPages - 1}" />
                                                                </c:if>

                                                                <c:forEach var="i" begin="${start}" end="${end}">
                                                                    <li
                                                                        class="page-item ${i == currentPage ? 'active' : ''}">
                                                                        <a class="page-link"
                                                                            href="?page=${i}&size=${products.size}">${i
                                                                            + 1}</a>
                                                                    </li>
                                                                </c:forEach>

                                                                <!-- Next -->
                                                                <li
                                                                    class="page-item ${products.last ? 'disabled' : ''}">
                                                                    <a class="page-link"
                                                                        href="?page=${products.number + 1}&size=${products.size}">Next</a>
                                                                </li>

                                                            </ul>
                                                        </nav>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <!-- Fruits Shop End-->





                            <!-- Back to Top -->
                            <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                                    class="fa fa-arrow-up"></i></a>



                        </div>
                    </div>
                </div>
                <div class="container-fluid py-2">
                    <jsp:include page="../layout/feature.jsp" />
                    <jsp:include page="../layout/footer.jsp" />
                </div>

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>
            </body>

            </html>