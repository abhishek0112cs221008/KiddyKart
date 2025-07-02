<%@ page import="java.util.*" %>
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
    <title>View Customers - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f8;
        }

        .navbar {
            background-color: #fff;
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

        h2 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }

        table th {
            background-color: #007aff;
            color: white;
        }

        footer {
            margin-top: 60px;
            padding: 20px;
            background-color: #fff;
            text-align: center;
            font-size: 14px;
            color: #666;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="#">QuickKartKids Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 text-dark"><%= adminEmail %></span>
            <a href="jsp/logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<a href ="AdminServlet"><-Back to main</a>

<!-- Table Section -->
<div class="container table-container">
    <h2>All Registered Customers</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead>
                <tr>
                    <th scope="col">Customer ID</th>
                    <th scope="col">Full Name</th>
                    <th scope="col">Email Address</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, String>> customers = (List<Map<String, String>>) request.getAttribute("customers");
                    if (customers != null && !customers.isEmpty()) {
                        for (Map<String, String> cust : customers) {
                %>
                <tr>
                    <td><%= cust.get("id") %></td>
                    <td><%= cust.get("name") %></td>
                    <td><%= cust.get("email") %></td>
                    <td>
                    
                        <a href="ViewCustomers?action=delete&id=<%= cust.get("id") %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this user?');">
                            <i class="bi bi-trash3"></i> Delete
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" class="text-center text-muted">No customers found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 QuickKartKids | Admin Panel
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
