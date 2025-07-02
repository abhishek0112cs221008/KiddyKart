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
    <title>Admin - View Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
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
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.05);
        }
        h2 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }
        .table th {
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
        select.form-select-sm {
            font-size: 0.9rem;
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
            <a href="jsp/logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>
<a href ="AdminServlet"><-Back to main</a>
<!-- Orders Table -->
<div class="container table-container">
    <h2>📦 All Orders</h2>

    <%
        List<Map<String, String>> orders = (List<Map<String, String>>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
    <div class="table-responsive">
        <table class="table table-striped table-bordered align-middle">
            <thead>
			    <tr>
			        <th>Order ID</th>
			        <th>Customer Email</th>
			        <th>Product ID</th>
			        <th>Quantity</th>
			        <th>Order Date</th>
			        <th>Status</th>
			        <th>Full Name</th>
			        <th>Phone</th>
			        <th>Delivery Address</th>
			    </tr>
			</thead>
			
			            <tbody>
                <% for (Map<String, String> order : orders) { %>
                    <tr>
    <td><%= order.get("id") %></td>
    <td><%= order.get("user_email") %></td>
    <td><%= order.get("product_id") %></td>
    <td><%= order.get("quantity") %></td>
    <td><%= order.get("order_date") %></td>
    <td>
        <form action="<%= request.getContextPath() %>/OrderServlet" method="post" class="d-flex flex-column">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="orderId" value="<%= order.get("id") %>">
            <select name="status" class="form-select form-select-sm mb-1">
                <option value="Pending" <%= "Pending".equals(order.get("status")) ? "selected" : "" %>>Pending</option>
                <option value="Shipped" <%= "Shipped".equals(order.get("status")) ? "selected" : "" %>>Shipped</option>
                <option value="Delivered" <%= "Delivered".equals(order.get("status")) ? "selected" : "" %>>Delivered</option>
            </select>
            <button type="submit" class="btn btn-sm btn-success">Update</button>
        </form>
    </td>
    <td><%= order.get("full_name") != null ? order.get("full_name") : "-" %></td>
    <td><%= order.get("phone") != null ? order.get("phone") : "-" %></td>
    <td>
        <% if (order.get("street") != null) { %>
            <%= order.get("street") %>, <%= order.get("city") %>, <%= order.get("state") %> - <%= order.get("pincode") %>
        <% } else { %>
            Not Available
        <% } %>
    </td>
</tr>

                <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
        <div class="alert alert-warning text-center">No orders available.</div>
    <% } %>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 QuickKartKids | Admin Panel
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
