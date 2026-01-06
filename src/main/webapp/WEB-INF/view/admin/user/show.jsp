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
                            <h1 class="mt-4">Manage Users</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Users</li>
                            </ol>
                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Table Users</h3>
                                            <a href="/admin/user/create" class="btn btn-primary">Create a user</a>
                                        </div>

                                        <hr />
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Email</th>
                                                    <th>Full Name</th>
                                                    <th>Role</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${users.content}">
                                                    <tr>
                                                        <td>${user.id}</td>
                                                        <td>${user.email}</td>
                                                        <td>${user.fullName}</td>
                                                        <td>${user.role.name}</td>
                                                        <td>
                                                            <a href="/admin/user/${user.id}"
                                                                class="btn btn-success">View</a>
                                                            <a href="/admin/user/update/${user.id}"
                                                                class="btn btn-warning mx-2">Update</a>
                                                            <a href="/admin/user/delete/${user.id}"
                                                                class="btn btn-danger">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <nav>
                                                    <ul class="pagination">

                                                        <!-- Previous -->
                                                        <li class="page-item ${users.first ? 'disabled' : ''}">
                                                            <a class="page-link"
                                                                href="?page=${users.number - 1}&size=${users.size}">Previous</a>
                                                        </li>

                                                        <!-- Page numbers (tối đa 3 số) -->
                                                        <c:set var="currentPage" value="${users.number}" />
                                                        <c:set var="totalPages" value="${users.totalPages}" />

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
                                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                                <a class="page-link"
                                                                    href="?page=${i}&size=${users.size}">${i
                                                                    + 1}</a>
                                                            </li>
                                                        </c:forEach>

                                                        <!-- Next -->
                                                        <li class="page-item ${users.last ? 'disabled' : ''}">
                                                            <a class="page-link"
                                                                href="?page=${users.number + 1}&size=${users.size}">Next</a>
                                                        </li>

                                                    </ul>
                                                </nav>
                                            </tbody>
                                        </table>

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
            <script src="js/scripts.js"></script>
        </body>

        </html>