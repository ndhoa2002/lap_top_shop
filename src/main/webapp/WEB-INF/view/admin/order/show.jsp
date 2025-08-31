<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <meta name="_csrf" content="${_csrf.token}" />
            <meta name="_csrf_header" content="${_csrf.headerName}" />
            <title>Dashboard - SB Admin</title>
            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Manage Orders</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Orders</li>
                            </ol>
                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Table products</h3>
                                        </div>

                                        <hr />
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Mã đơn hàng</th>
                                                    <th>Khách hàng</th>
                                                    <th>Địa chỉ</th>
                                                    <th>SĐT</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Ngày đặt</th>
                                                    <th>Trạng thái</th>
                                                    <th>Kiểm tra</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td>${order.id}</td>
                                                        <td>${order.fullName}</td>
                                                        <td>${order.address}</td>
                                                        <td>${order.phone}</td>
                                                        <td>${order.totalPrice}</td>
                                                        <td>${order.orderDate}</td>
                                                        <td>${order.status.getLabel()}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when
                                                                    test="${order.status eq 'COMPLETED' or order.status eq 'CANCEL'}">
                                                                    <!-- Nếu đơn đã giao hoặc hủy thì disable -->
                                                                    <button class="btn btn-secondary btn-sm"
                                                                        disabled>✔</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <!-- Nút mở modal -->
                                                                    <button class="btn btn-primary btn-sm"
                                                                        onclick="openConfirmModal('${order.id}', '${order.status}')">
                                                                        <i class="fa fa-check"></i>
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>


                                        <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title"></h5>
                                                        <button type="button" class="btn-close"
                                                            data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-danger"
                                                            id="btnCancelOrder">Hủy đơn</button>
                                                        <button type="button" class="btn btn-success"
                                                            id="btnApproveOrder">Xác nhận</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="/js/scripts.js"></script>
        </body>

        </html>