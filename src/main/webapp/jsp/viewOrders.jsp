<<<<<<< HEAD
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #4a90e2;
            --primary-hover: #3a75c4;
            --text-dark: #333;
            --text-light: #555;
            --bg-light: #f7f9fc;
            --card-bg: #ffffff;
            --border-color: #e0e6ed;
            --shadow-light: rgba(0, 0, 0, 0.08);
            --shadow-hover: rgba(0, 0, 0, 0.12);
        }

        body {
            background: var(--bg-light);
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            padding-bottom: 50px;
        }

        .container {
            margin-top: 50px;
            max-width: 960px;
        }

        /* Heading */
        .page-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin-bottom: 30px;
            text-align: center;
        }

        .page-title i {
            margin-right: 12px;
            color: var(--primary-blue);
        }

        /* Order Card */
        .order-card {
            background: var(--card-bg);
            border-radius: 16px;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 12px var(--shadow-light);
            padding: 24px;
            margin-bottom: 24px;
            display: flex;
            gap: 24px;
            align-items: flex-start;
            transition: all 0.3s ease-in-out;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px var(--shadow-hover);
        }

        .product-image-container {
            flex-shrink: 0;
            width: 120px;
            height: 120px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 12px;
            background: #fafbfc;
            border: 1px solid #f0f2f5;
        }

        .product-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 10px;
        }

        .order-info {
            flex-grow: 1;
        }

        .order-info h5 {
            margin-bottom: 8px;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .order-info .category {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 12px;
        }

        .order-meta {
            font-size: 0.9rem;
            color: var(--text-light);
            line-height: 1.8;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 8px 16px;
        }
        
        .order-meta strong {
            color: var(--text-dark);
            font-weight: 600;
        }

        .status-badge {
            padding: 6px 16px;
            font-size: 0.85rem;
            border-radius: 30px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-top: 10px;
            border: 1px solid;
        }

        .status-pending {
            background-color: #fef9e7;
            color: #d4a72d;
            border-color: #f7e7c9;
        }

        .status-shipped {
            background-color: #e8f3ff;
            color: #4a90e2;
            border-color: #d1e3fa;
        }

        .status-delivered {
            background-color: #e5f8ec;
            color: #4CAF50;
            border-color: #d9f0e2;
        }

        /* Back Button */
        .back-btn {
            margin-bottom: 40px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background-color: var(--primary-blue);
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .back-btn:hover {
            background-color: var(--primary-hover);
            color: white;
        }
        
        .no-orders-message {
            text-align: center;
            font-size: 1.1rem;
            color: #777;
            padding: 40px 20px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        
        .no-orders-message .bi {
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--primary-blue);
        }
    </style>
</head>
<body>

<div class="container">
    <a href="../HomeServlet" class="back-btn"><i class="bi bi-arrow-left-circle"></i> Back to Home</a>
    <h3 class="page-title"><i class="bi bi-box-seam"></i> My Magical Orders</h3>

    <%
        boolean hasOrders = rs.isBeforeFirst();
        if (hasOrders) {
            while (rs.next()) {
                int pid = rs.getInt("product_id");
                model.Product product = dao.getProductById(pid);
                String image = (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty())
                                ? product.getImageUrl()
                                : "https://via.placeholder.com/100/f0f2f5/999999?text=No+Image";

                String status = rs.getString("status");
                String statusClass = "";
                String statusIcon = "";

                switch (status.toLowerCase()) {
                    case "pending":
                        statusClass = "status-badge status-pending";
                        statusIcon = "🕒";
                        break;
                    case "shipped":
                        statusClass = "status-badge status-shipped";
                        statusIcon = "🚚";
                        break;
                    case "delivered":
                        statusClass = "status-badge status-delivered";
                        statusIcon = "✅";
                        break;
                    default:
                        statusClass = "status-badge status-pending";
                        statusIcon = "⌛";
                }
    %>
        <div class="order-card">
            <div class="product-image-container">
                <img src="<%= image %>" class="product-image" alt="Product Image">
            </div>
            <div class="order-info">
                <h5><%= product != null ? product.getName() : "Unknown Product" %></h5>
                <div class="category">Category: <%= product != null ? product.getCategory() : "-" %></div>

                <div class="order-meta">
                    <div><strong>Qty:</strong> <%= rs.getInt("quantity") %></div>
                    <div><strong>Date:</strong> <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(rs.getTimestamp("order_date")) %></div>
                    <div><strong>Order ID:</strong> #<%= rs.getInt("id") %></div>
                    <div><strong>Payment ID:</strong> <%= rs.getString("payment_id") %></div>
                </div>
                 <span class="<%= statusClass %>"><%= statusIcon %> <%= status %></span>
            </div>
        </div>
    <%
            }
        } else {
    %>
        <div class="no-orders-message">
            <i class="bi bi-basket-fill"></i>
            <p>Looks like your order basket is empty. Time to start shopping!</p>
        </div>
    <%
        }
        conn.close();
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
=======
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
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
