<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Fruitables - Vegetable Website Template</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

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
                    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


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


                    <!-- Navbar start -->
                    <jsp:include page="../layout/header.jsp" />


                    <!-- Checkout Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <h1 class="mb-4">Billing details</h1>
                            <form:form action="/checkout/success" method="post" modelAttribute="checkout">
                                <c:set var="errorFirstName">
                                    <form:errors path="firstName" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorLastName">
                                    <form:errors path="lastName" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorHouseNumber">
                                    <form:errors path="houseNumber" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorWard">
                                    <form:errors path="ward" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorTown">
                                    <form:errors path="town" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorProvince">
                                    <form:errors path="province" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorPhone">
                                    <form:errors path="phone" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorEmail">
                                    <form:errors path="email" cssClass="invalid-feedback" />
                                </c:set>
                                <div class="row g-5">
                                    <div class="col-md-12 col-lg-6 col-xl-7">
                                        <div class="row">
                                            <div class="col-md-12 col-lg-6">
                                                <div class="form-item w-100">
                                                    <label class="form-label my-3">First Name<sup>*</sup></label>
                                                    <form:input type="text" class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}" path="firstName" />
                                                    ${errorFirstName}
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-lg-6">
                                                <div class="form-item w-100">
                                                    <label class="form-label my-3">Last Name<sup>*</sup></label>
                                                    <form:input type="text" class="form-control ${not empty errorLastName ? 'is-invalid' : ''}" path="lastName" />
                                                    ${errorLastName}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">House Number<sup>*</sup></label>
                                            <form:input type="text" class="form-control ${not empty errorHouseNumber ? 'is-invalid' : ''}" path="houseNumber" />
                                            ${errorHouseNumber}
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Ward <sup>*</sup></label>
                                            <form:input type="text" class="form-control ${not empty errorWard ? 'is-invalid' : ''}"
                                                placeholder="House Number Street Name" path="ward" />
                                                ${errorWard}
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Town<sup>*</sup></label>
                                            <form:input type="text" class="form-control ${not empty errorTown ? 'is-invalid' : ''}" path="town" />
                                            ${errorTown}
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Province<sup>*</sup></label>
                                            <form:input type="text" class="form-control ${not empty errorProvince ? 'is-invalid' : ''}" path="province" />
                                            ${errorProvince}
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Phone Number<sup>*</sup></label>
                                            <form:input type="tel" class="form-control ${not empty errorPhone ? 'is-invalid' : ''}" path="phone" />
                                            ${errorPhone}
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Email Address<sup>*</sup></label>
                                            <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" path="email" />
                                            ${errorEmail}
                                        </div>
                                        <hr>
                                        <div class="form-check my-3">
                                            <input class="form-check-input" type="checkbox" id="Address-1"
                                                name="Address" value="Address">
                                            <label class="form-check-label" for="Address-1">Ship to a different
                                                address?</label>
                                        </div>
                                        <div class="form-item">
                                            <form:textarea name="text" class="form-control" spellcheck="false" cols="30"
                                                rows="11" placeholder="Oreder Notes (Optional)" path="note" />
                                        </div>
                                    </div>
                                    <div class="col-md-12 col-lg-6 col-xl-5">
                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">Products</th>
                                                        <th scope="col">Name</th>
                                                        <th scope="col">Price</th>
                                                        <th scope="col">Quantity</th>
                                                        <th scope="col">Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${cartDetails}">
                                                        <tr>
                                                            <th scope="row">
                                                                <div class="d-flex align-items-center mt-2">
                                                                    <img src="/images/product/${item.product.productImage}"
                                                                        class="img-fluid rounded-circle"
                                                                        style="width: 90px; height: 90px;" alt="">
                                                                </div>
                                                            </th>
                                                            <td class="py-5">${item.product.name}</td>
                                                            <td class="py-5">
                                                                <fmt:formatNumber type="number" value="${item.price}" />
                                                                đ
                                                            </td>
                                                            <td class="py-5">${item.quantity}</td>
                                                            <td class="py-5">
                                                                <fmt:formatNumber type="number" value="${item.total}" />
                                                                đ
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <tr>
                                                        <th scope="row">
                                                        </th>
                                                        <td class="py-5"></td>
                                                        <td class="py-5"></td>
                                                        <!-- <td class="py-5">
                                                            <p class="mb-0 text-dark py-3">Subtotal</p>
                                                        </td>
                                                        <td class="py-5">
                                                            <div class="py-3 border-bottom border-top">
                                                                <p class="mb-0 text-dark">$414.00</p>
                                                            </div>
                                                        </td> -->
                                                    </tr>
                                                    <!-- <tr>
                                                        <th scope="row">
                                                        </th>
                                                        <td class="py-5">
                                                            <p class="mb-0 text-dark py-4">Shipping</p>
                                                        </td>
                                                        <td colspan="3" class="py-5">
                                                            <div class="form-check text-start">
                                                                <input type="checkbox"
                                                                    class="form-check-input bg-primary border-0"
                                                                    id="Shipping-1" name="Shipping-1" value="Shipping">
                                                                <label class="form-check-label" for="Shipping-1">Free
                                                                    Shipping</label>
                                                            </div>
                                                            <div class="form-check text-start">
                                                                <input type="checkbox"
                                                                    class="form-check-input bg-primary border-0"
                                                                    id="Shipping-2" name="Shipping-1" value="Shipping">
                                                                <label class="form-check-label" for="Shipping-2">Flat
                                                                    rate:
                                                                    $15.00</label>
                                                            </div>
                                                            <div class="form-check text-start">
                                                                <input type="checkbox"
                                                                    class="form-check-input bg-primary border-0"
                                                                    id="Shipping-3" name="Shipping-1" value="Shipping">
                                                                <label class="form-check-label" for="Shipping-3">Local
                                                                    Pickup: $8.00</label>
                                                            </div>
                                                        </td>
                                                    </tr> -->
                                                    <tr>
                                                        <th scope="row">
                                                        </th>
                                                        <td class="py-5">
                                                            <p class="mb-0 text-dark text-uppercase py-3">TOTAL</p>
                                                        </td>
                                                        <td class="py-5"></td>
                                                        <td class="py-5"></td>
                                                        <td class="py-5">
                                                            <div class="py-3 border-bottom border-top">
                                                                <p class="mb-0 text-dark">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${totalPrice}" /> đ
                                                                </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div
                                            class="row g-4 text-center align-items-center justify-content-center border-bottom py-3">
                                            <div class="col-12">
                                                <div class="form-check text-start my-3">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0"
                                                        id="Transfer-1" name="Transfer" value="Transfer">
                                                    <label class="form-check-label" for="Transfer-1">Direct Bank
                                                        Transfer</label>
                                                </div>
                                                <p class="text-start text-dark">Make your payment directly into our bank
                                                    account. Please use your Order ID as the payment reference. Your
                                                    order
                                                    will not be shipped until the funds have cleared in our account.</p>
                                            </div>
                                        </div>
                                        <div
                                            class="row g-4 text-center align-items-center justify-content-center border-bottom py-3">
                                            <div class="col-12">
                                                <div class="form-check text-start my-3">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0"
                                                        id="Payments-1" name="Payments" value="Payments">
                                                    <label class="form-check-label" for="Payments-1">Check
                                                        Payments</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div
                                            class="row g-4 text-center align-items-center justify-content-center border-bottom py-3">
                                            <div class="col-12">
                                                <div class="form-check text-start my-3">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0"
                                                        id="Delivery-1" name="Delivery" value="Delivery">
                                                    <label class="form-check-label" for="Delivery-1">Cash On
                                                        Delivery</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div
                                            class="row g-4 text-center align-items-center justify-content-center border-bottom py-3">
                                            <div class="col-12">
                                                <div class="form-check text-start my-3">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0"
                                                        id="Paypal-1" name="Paypal" value="Paypal">
                                                    <label class="form-check-label" for="Paypal-1">Paypal</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                                            <button type="submit"
                                                class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary">Place
                                                Order</button>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                    <!-- Checkout Page End -->


                    <!-- Footer Start -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- Footer End -->


                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


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