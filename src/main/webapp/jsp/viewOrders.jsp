<%@ page import="java.sql.*, model.Product, dao.ProductDAO" %>
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection conn = dao.DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM orders WHERE user_email='" + userEmail + "' ORDER BY order_date DESC");

    dao.ProductDAO dao = new dao.ProductDAO();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders - QuickKartKids</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        body {
            background: #f2f3f7;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            margin-top: 40px;
            max-width: 960px;
        }

        .order-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
            align-items: center;
            transition: 0.3s ease-in-out;
        }

        .order-card:hover {
            transform: scale(1.01);
        }

        .product-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            border-radius: 8px;
            background: #f8f8f8;
        }

        .order-info {
            flex-grow: 1;
        }

        .order-info h5 {
            margin-bottom: 5px;
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .order-info .category {
            color: #888;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .order-meta {
            font-size: 14px;
            color: #555;
        }

        .status-badge {
            padding: 5px 12px;
            font-size: 13px;
            border-radius: 30px;
            font-weight: 500;
            display: inline-block;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-shipped {
            background-color: #cfe2ff;
            color: #084298;
            border: 1px solid #b6d4fe;
        }

        .status-delivered {
            background-color: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }

        .back-btn {
            margin-bottom: 30px;
            display: inline-block;
            padding: 8px 20px;
            background-color: #007aff;
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
        }

        .back-btn:hover {
            background-color: #005fcc;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="../HomeServlet" class="back-btn"><i class="bi bi-arrow-left-circle"></i> Back to Home</a>
    <h3 class="mb-4 text-primary">📦 My Magical Orders</h3>

    <%
        boolean hasOrders = rs.isBeforeFirst();
        if (hasOrders) {
            while (rs.next()) {
                int pid = rs.getInt("product_id");
                model.Product product = dao.getProductById(pid);
                String image = (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty())
                                ? product.getImageUrl()
                                : "https://via.placeholder.com/100";

                String status = rs.getString("status");
                String statusClass = "";
                String statusIcon = "";

                switch (status) {
                    case "Pending":
                        statusClass = "status-badge status-pending";
                        statusIcon = "🕒";
                        break;
                    case "Shipped":
                        statusClass = "status-badge status-shipped";
                        statusIcon = "🚚";
                        break;
                    case "Delivered":
                        statusClass = "status-badge status-delivered";
                        statusIcon = "✅";
                        break;
                    default:
                        statusClass = "status-badge status-pending";
                        statusIcon = "⌛";
                }
    %>
        <div class="order-card">
            <img src="<%= image %>" class="product-image" alt="Product Image">
            <div class="order-info">
                <h5><%= product != null ? product.getName() : "Unknown Product" %></h5>
                <div class="category">Category: <%= product != null ? product.getCategory() : "-" %></div>

                <div class="order-meta">
                    <div><strong>Qty:</strong> <%= rs.getInt("quantity") %></div>
                    <div><strong>Date:</strong> <%= rs.getTimestamp("order_date") %></div>
                    <div><strong>Order ID:</strong> #<%= rs.getInt("id") %></div>
                    <div><strong>Payment ID:</strong> <%= rs.getString("payment_id") %></div>
                    <div class="mt-2">
                        <span class="<%= statusClass %>"><%= statusIcon %> <%= status %></span>
                    </div>
                </div>
            </div>
        </div>
    <%
            }
        } else {
    %>
        <div class="alert alert-info text-center">You haven't placed any orders yet.</div>
    <%
        }
        conn.close();
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
