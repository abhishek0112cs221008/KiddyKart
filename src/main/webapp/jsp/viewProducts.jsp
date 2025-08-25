<<<<<<< HEAD
<%@ page import="java.util.*, model.Product, dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f8;
        }

        .navbar {
            background-color: #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .navbar-brand {
            font-weight: 600;
            color: #007aff !important;
        }

        .table-container {
            margin: 40px auto;
            max-width: 1100px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.05);
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #a71d2a;
        }

        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        footer {
            margin-top: 50px;
            padding: 20px;
            background-color: #fff;
            text-align: center;
            color: #777;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand" href="#">QuickKartKids Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 text-dark">👤 <%= adminEmail %></span>
            <a href="logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>
<a href ="../AdminServlet"><-Back to main</a>
<!-- Product Table -->
<div class="container table-container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>🛒 All Products</h3>
        <a href="addProduct.jsp" class="btn btn-success"><i class="bi bi-plus-circle"></i> Add Product</a>
    </div>

    <%
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();
        if (list.isEmpty()) {
    %>
        <div class="alert alert-warning text-center">No products found.</div>
    <%
        } else {
    %>
    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
            <thead class="table-primary">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price (₹)</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Description</th>
                    <th scope="col">Image</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Product p : list) {
            %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getCategory() %></td>
                    <td>₹<%= p.getPrice() %></td>
                    <td><%= p.getQuantity() %></td>
                    <td><%= p.getDescription() %></td>
                    <td>
                        <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
                            <img src="<%= p.getImageUrl() %>" class="product-img" alt="product image">
                        <% } else { %>
                            <span class="text-muted">No Image</span>
                        <% } %>
                    </td>
                    <td>
                        <a href="../ProductServlet?action=edit&id=<%= p.getId() %>" class="btn btn-sm btn-primary me-1">
                            <i class="bi bi-pencil-square"></i> Edit
                        </a>
                        <a href="../ProductServlet?action=delete&id=<%= p.getId() %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this product?');">
                            <i class="bi bi-trash3"></i> Delete
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 QuickKartKids | Admin Panel
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
=======
<%@ page import="java.util.*, model.Product, dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f8;
        }

        .navbar {
            background-color: #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .navbar-brand {
            font-weight: 600;
            color: #007aff !important;
        }

        .table-container {
            margin: 40px auto;
            max-width: 1100px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.05);
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #a71d2a;
        }

        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        footer {
            margin-top: 50px;
            padding: 20px;
            background-color: #fff;
            text-align: center;
            color: #777;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand" href="#">QuickKartKids Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 text-dark">👤 <%= adminEmail %></span>
            <a href="logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>
<a href ="../AdminServlet"><-Back to main</a>
<!-- Product Table -->
<div class="container table-container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>🛒 All Products</h3>
        <a href="addProduct.jsp" class="btn btn-success"><i class="bi bi-plus-circle"></i> Add Product</a>
    </div>

    <%
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();
        if (list.isEmpty()) {
    %>
        <div class="alert alert-warning text-center">No products found.</div>
    <%
        } else {
    %>
    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
            <thead class="table-primary">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price (₹)</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Description</th>
                    <th scope="col">Image</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Product p : list) {
            %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getCategory() %></td>
                    <td>₹<%= p.getPrice() %></td>
                    <td><%= p.getQuantity() %></td>
                    <td><%= p.getDescription() %></td>
                    <td>
                        <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
                            <img src="<%= p.getImageUrl() %>" class="product-img" alt="product image">
                        <% } else { %>
                            <span class="text-muted">No Image</span>
                        <% } %>
                    </td>
                    <td>
                        <a href="../ProductServlet?action=edit&id=<%= p.getId() %>" class="btn btn-sm btn-primary me-1">
                            <i class="bi bi-pencil-square"></i> Edit
                        </a>
                        <a href="../ProductServlet?action=delete&id=<%= p.getId() %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this product?');">
                            <i class="bi bi-trash3"></i> Delete
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 QuickKartKids | Admin Panel
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
