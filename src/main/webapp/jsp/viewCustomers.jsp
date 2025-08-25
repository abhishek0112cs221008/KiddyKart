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
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #1e63d4;
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
            font-size: 0.95rem;
            color: var(--text-dark);
        }

        /* Action Button */
        .btn-delete {
            background-color: var(--danger-red);
            border-color: var(--danger-red);
            color: white;
            font-weight: 500;
            border-radius: 4px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-delete:hover {
            background-color: var(--danger-hover);
            border-color: var(--danger-hover);
            color: white;
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

<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">QuickKartKids Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 text-dark">👤 <%= adminEmail %></span>
            <a href="jsp/logout.jsp" class="btn btn-outline-danger btn-sm logout-btn">Logout</a>
        </div>
    </div>
</nav>

<a href ="AdminServlet" class="back-link"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>

<div class="container table-container">
    <h2 class="table-header"><i class="bi bi-people-fill"></i> All Registered Customers</h2>
    <div class="table-responsive">
        <table class="table table-striped align-middle">
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
                        <a href="ViewCustomers?action=delete&id=<%= cust.get("id") %>" class="btn btn-sm btn-delete"
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
                    <td colspan="4" class="text-center text-muted">No customers found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    &copy; 2025 QuickKartKids | Admin Panel
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>