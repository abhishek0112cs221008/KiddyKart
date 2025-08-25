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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #1e63d4;
            --success-green: #28a745;
            --success-hover: #218838;
            --danger-red: #dc3545;
            --danger-hover: #c82333;
            --text-dark: #212529;
            --text-muted: #6c757d;
            --bg-light: #f1f3f6;
            --card-bg: #ffffff;
            --shadow: rgba(0, 0, 0, 0.05);
            --border-color: #dee2e6;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
        }

        /* Navbar */
        .navbar {
            background-color: var(--card-bg);
            box-shadow: 0 4px 10px var(--shadow);
            padding: 1rem;
        }
        .navbar-brand {
            font-weight: 700;
            color: var(--primary-blue) !important;
        }
        .logout-btn {
            font-weight: 500;
            border-radius: 6px;
        }
        .logout-btn:hover {
            background-color: var(--danger-red);
            color: white !important;
        }
        .text-dark {
            color: var(--text-dark) !important;
        }
        
        /* Back Link */
        .back-link {
            display: inline-block;
            margin-top: 20px;
            margin-left: 20px;
            color: var(--primary-blue);
            text-decoration: none;
            font-weight: 500;
        }
        .back-link:hover {
            color: var(--primary-hover);
        }

        /* Table Container */
        .table-container {
            margin-top: 40px;
            margin-bottom: 40px;
            max-width: 1100px;
            background: var(--card-bg);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 15px var(--shadow);
        }
        .table-header {
            font-weight: 600;
            margin-bottom: 25px;
            color: var(--primary-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        /* Table Styles */
        .table-responsive {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow-x: auto;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f8f9fa;
        }
        thead th {
            background-color: var(--primary-blue) !important;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            padding: 12px 15px;
        }
        tbody td {
            vertical-align: middle;
            padding: 12px 15px;
            font-size: 0.9rem;
            color: var(--text-dark);
        }

        /* Status Form */
        .status-form {
            display: flex;
            flex-direction: column;
            gap: 5px;
            min-width: 120px; /* Ensures the form is wide enough */
        }
        .status-form .btn-success {
            background-color: var(--success-green);
            border-color: var(--success-green);
            font-weight: 500;
            font-size: 0.85rem;
        }
        .status-form .btn-success:hover {
            background-color: var(--success-hover);
            border-color: var(--success-hover);
        }
        .status-form .form-select {
            font-size: 0.85rem;
            border-radius: 4px;
        }

        /* Footer */
        footer {
            background-color: var(--card-bg);
            border-top: 1px solid var(--border-color);
            color: var(--text-muted);
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">QuickKartKids Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 text-dark">👤 <%= adminEmail %></span>
            <a href="logout.jsp" class="btn btn-outline-danger btn-sm logout-btn">Logout</a>
        </div>
    </div>
</nav>
<a href ="AdminServlet" class="back-link"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
<div class="container table-container">
    <h2 class="table-header"><i class="bi bi-receipt"></i> All Orders</h2>

    <%
        List<Map<String, String>> orders = (List<Map<String, String>>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
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
                            <form action="<%= request.getContextPath() %>/OrderServlet" method="post" class="status-form">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                                <select name="status" class="form-select form-select-sm">
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

<footer>
    &copy; 2025 QuickKartKids | Admin Panel
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>