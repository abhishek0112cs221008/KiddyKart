<<<<<<< HEAD
<%@ page session="true" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #1e63d4;
            --primary-text: #212121;
            --secondary-text: #878787;
            --bg-light: #f1f3f6;
            --card-bg: #ffffff;
            --card-shadow: rgba(0, 0, 0, 0.08);
        }
        
        body {
            font-family: 'Poppins', 'Inter', sans-serif;
            background: var(--bg-light);
            margin: 0;
            padding: 0;
            color: var(--primary-text);
        }

        .navbar {
            background-color: var(--card-bg);
            box-shadow: 0 2px 10px var(--card-shadow);
            padding: 1rem 1.5rem;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.6rem;
            color: var(--primary-blue) !important;
        }

        .dashboard-header {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-text);
            margin: 50px 0 30px;
            text-align: center;
        }

        .card {
            border: none;
            border-radius: 12px;
            background: var(--card-bg);
            box-shadow: 0 6px 20px var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        }
        
        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #ccc;
        }
        .card-icon.primary { color: #2874F0; }
        .card-icon.success { color: #388E3C; }
        .card-icon.info { color: #0097a7; }
        .card-icon.warning { color: #FFC107; }

        .card h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--secondary-text);
        }

        .card p {
            font-size: 2.2rem;
            color: var(--primary-text);
            font-weight: 700;
            margin: 0;
        }

        .profile-info {
            font-weight: 500;
            color: var(--primary-text);
            font-size: 0.95rem;
        }

        .nav-links-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
            margin-top: 50px;
        }
        
        .nav-link-btn {
            padding: 12px 24px;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
        }

        .nav-link-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.12);
        }

        .btn-primary-custom {
            background-color: var(--primary-blue);
            color: white;
        }
        .btn-primary-custom:hover {
            background-color: var(--primary-hover);
        }
        
        .btn-success-custom {
            background-color: #388E3C;
            color: white;
        }
        .btn-success-custom:hover {
            background-color: #2e6e32;
        }
        
        .btn-info-custom {
            background-color: #0097a7;
            color: white;
        }
        .btn-info-custom:hover {
            background-color: #007682;
        }

        footer {
            margin-top: 60px;
            padding: 20px;
            background-color: var(--card-bg);
            text-align: center;
            font-size: 0.9rem;
            color: var(--secondary-text);
            border-top: 1px solid var(--border-color);
        }
        
        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 4px;
        }
        .logout-btn:hover {
            background-color: #c0392b;
        }

        @media (max-width: 576px) {
            .dashboard-header {
                font-size: 1.8rem;
            }

            .card p {
                font-size: 1.8rem;
            }

            .nav-links-container {
                flex-direction: column;
            }

            .nav-link-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand" href="#">KiddyKart Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 profile-info"><i class="fas fa-user-circle"></i> <%= adminEmail %></span>
            <a href="jsp/logout.jsp" class="btn logout-btn btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="dashboard-header">KiddyKart Overview</div>

    <div class="row g-4">
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <i class="fas fa-box card-icon primary"></i>
                <h5>Total Products</h5>
                <p><%= request.getAttribute("totalProducts") %></p>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <i class="fas fa-users card-icon success"></i>
                <h5>Total Customers</h5>
                <p><%= request.getAttribute("totalCustomers") %></p>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <i class="fas fa-receipt card-icon info"></i>
                <h5>Total Orders</h5>
                <p><%= request.getAttribute("totalOrders") %></p>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <i class="fas fa-clock card-icon warning"></i>
                <h5>Pending Orders</h5>
                <p><%= request.getAttribute("pendingOrders") %></p>
            </div>
        </div>
    </div>

    <div class="nav-links-container">
        <a href="jsp/viewProducts.jsp" class="nav-link-btn btn-primary-custom"><i class="fas fa-boxes"></i> Manage Products</a>
        <a href="<%= request.getContextPath() %>/ViewCustomers" class="nav-link-btn btn-success-custom"><i class="fas fa-user-friends"></i> View Customers</a>
        <a href="<%= request.getContextPath() %>/ViewOrdersAdmin" class="nav-link-btn btn-info-custom"><i class="fas fa-truck"></i> View Orders</a>
    </div>
</div>

<footer>
    &copy; 2025 KiddyKart | Admin Panel. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
=======
<%@ page session="true" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to bottom right, #f5f7fa, #e2e8f0);
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #0d6efd !important;
        }

        .dashboard-header {
            font-size: 2.5rem;
            font-weight: 700;
            color: #222;
            margin: 50px 0 30px;
            text-align: center;
        }

        .card {
            border: none;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.08);
        }

        .card h5 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 2rem;
            color: #0d6efd;
            font-weight: 600;
        }

        .profile-info {
            font-weight: 500;
            color: #333;
        }

        .nav-links a {
            margin: 10px 8px;
            padding: 12px 24px;
            font-weight: 500;
            border-radius: 30px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
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

        @media (max-width: 576px) {
            .dashboard-header {
                font-size: 1.8rem;
            }

            .card p {
                font-size: 1.6rem;
            }

            .nav-links {
                flex-direction: column;
            }

            .nav-links a {
                margin-bottom: 10px;
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="#">KiddyKart Admin</a>
        <div class="d-flex align-items-center ms-auto">
            <span class="me-3 profile-info"><i class="fas fa-user-circle"></i> <%= adminEmail %></span>
            <a href="jsp/logout.jsp" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="dashboard-header"> KiddyKart Overview</div>

    <div class="row g-4">
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <h5><i class="fas fa-box text-primary"></i> Total Products</h5>
                <p><%= request.getAttribute("totalProducts") %></p>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <h5><i class="fas fa-users text-success"></i> Total Customers</h5>
                <p><%= request.getAttribute("totalCustomers") %></p>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <h5><i class="fas fa-receipt text-info"></i> Total Orders</h5>
                <p><%= request.getAttribute("totalOrders") %></p>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card p-4 text-center">
                <h5><i class="fas fa-clock text-warning"></i> Pending Orders</h5>
                <p><%= request.getAttribute("pendingOrders") %></p>
            </div>
        </div>
    </div>

    <!-- Navigation Links -->
    <div class="d-flex flex-wrap justify-content-center nav-links mt-5">
        <a href="jsp/viewProducts.jsp" class="btn btn-primary"><i class="fas fa-boxes"></i> Manage Products</a>
        <a href="<%= request.getContextPath() %>/ViewCustomers" class="btn btn-success"><i class="fas fa-user-friends"></i> View Customers</a>
        <a href="<%= request.getContextPath() %>/ViewOrdersAdmin" class="btn btn-info text-white"><i class="fas fa-truck"></i> View Orders</a>
    </div>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 KiddyKart | Admin Panel. All rights reserved.
</footer>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
