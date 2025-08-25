<%@ page import="java.util.*, model.Address, dao.AddressDAO" %>
<%@ page import="dao.OrderDAO, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    User user = (User) session.getAttribute("user");

    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Address> addressList = AddressDAO.getAddressesByEmail(userEmail);
    int addressCount = addressList.size();

    int orderCount = 0;
    if (userEmail != null) {
        // Assuming OrderDAO has this method
        orderCount = OrderDAO.getOrderCountByUserEmail(userEmail);
    }
    
    // Get membership status from the session
    Boolean isMember = (Boolean) session.getAttribute("isMember");
    if (isMember == null) {
        isMember = false; // Default to false if not found
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="assets/logo2.png">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        * {
            box-sizing: border-box;
            transition: background 0.3s ease, color 0.3s ease, box-shadow 0.3s ease, transform 0.3s ease;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            min-height: 100vh;
        }

        /* Theme Variables */
        .light-mode {
            --bg-color: #f1f3f6;
            --card-bg: #ffffff;
            --border-color: #e0e0e0;
            --text-color: #212121;
            --text-muted: #878787;
            --primary-blue: #2874F0;
            --primary-hover: #1e63d4;
            --danger-red: #d9534f;
            --danger-hover: #c9302c;
            --shadow-light: rgba(0, 0, 0, 0.08);
            --shadow-hover: rgba(0, 0, 0, 0.12);
        }

        .dark-mode {
            --bg-color: #1a1a1a;
            --card-bg: #2b2b2b;
            --border-color: #444;
            --text-color: #f1f1f1;
            --text-muted: #bbb;
            --primary-blue: #3e96ff;
            --primary-hover: #2d89e5;
            --danger-red: #e74c3c;
            --danger-hover: #c0392b;
            --shadow-light: rgba(0, 0, 0, 0.3);
            --shadow-hover: rgba(0, 0, 0, 0.4);
        }

        /* Navbar */
        .glass-navbar {
            background: var(--card-bg);
            border-bottom: 1px solid var(--border-color);
            box-shadow: 0 2px 4px var(--shadow-light);
            padding: 12px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .glass-navbar img {
            height: 40px;
        }
        .nav-btn {
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 8px 18px;
            border-radius: 4px;
            margin-left: 10px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
        }
        .nav-btn:hover {
            background: var(--primary-hover);
        }
        #themeToggle {
            background: #f0f0f0;
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }
        .dark-mode #themeToggle {
            background: #444;
        }
        
        /* Layout */
        .profile-wrapper {
            max-width: 1140px;
            margin: 40px auto 60px auto;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            padding: 0 15px;
        }
        @media (max-width: 768px) {
            .profile-wrapper {
                grid-template-columns: 1fr;
            }
        }

        /* Profile Card */
        .profile-card {
            background: var(--card-bg);
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 4px var(--shadow-light);
            text-align: center;
            border: 1px solid var(--border-color);
        }
        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid var(--primary-blue);
            object-fit: cover;
            margin-bottom: 20px;
        }
        .profile-card h3 {
            font-weight: 600;
            font-size: 1.6rem;
            margin-bottom: 5px;
        }
        .profile-card p {
            color: var(--text-muted);
            font-size: 0.95rem;
        }
        .stats {
            display: flex;
            justify-content: space-around;
            margin-top: 25px;
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
        }
        .stat h4 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-blue);
        }
        .stat small {
            font-size: 0.85rem;
            color: var(--text-muted);
            text-transform: uppercase;
        }
        .btn-outline-primary {
            border-color: var(--primary-blue);
            color: var(--primary-blue);
            margin-top: 15px;
        }
        .btn-outline-primary:hover {
            background-color: var(--primary-blue);
            color: white;
        }
        
        /* Simpler Membership Card Styling */
        .membership-card-wrapper {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        .membership-card {
            width: 350px;
            height: 220px;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background: #2874F0; /* Flipkart Blue */
            color: white;
        }
        .card-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .card-logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
        }
        .card-logo-sm {
            height: 35px;
        }
        .card-number {
            font-family: 'Poppins', sans-serif;
            font-size: 1.2rem;
            letter-spacing: 1px;
            font-weight: 500;
            color: #fff;
            margin-top: 15px;
        }
        .card-name {
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            color: #FFD700; /* Gold */
        }
        .card-valid {
            font-size: 0.9rem;
            color: #e0e0e0;
        }
        .card-chip {
            width: 45px;
            height: 35px;
            background-color: #000000;
            border-radius: 4px;
        }
        .card-type {
            font-weight: 700;
            font-size: 1rem;
            color: white;
            text-transform: uppercase;
        }
        
        /* Address Section */
        .address-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .address-header h5 {
            font-size: 1.2rem;
            font-weight: 600;
        }
        .address-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .address-box {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px var(--shadow-light);
            border: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            position: relative;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .address-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px var(--shadow-hover);
        }
        .address-box h6 {
            font-weight: 600;
            color: var(--primary-blue);
            margin-bottom: 8px;
        }
        .address-box p {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 5px;
        }
        .address-actions {
            margin-top: auto;
            display: flex;
            gap: 10px;
            padding-top: 10px;
        }
        .address-actions a {
            font-size: 0.9rem;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .btn-edit {
            background-color: #f0f0f0;
            color: var(--primary-blue);
        }
        .btn-edit:hover {
            background-color: #e0e0e0;
        }
        .btn-delete {
            background-color: var(--danger-red);
            color: white;
        }
        .btn-delete:hover {
            background-color: var(--danger-hover);
            color: white;
        }
    </style>
</head>
<body class="light-mode">

<nav class="glass-navbar">
    <div class="d-flex align-items-center">
        <img src="../assets/logo2.png" alt="Logo">
        <span class="ms-2 fw-bold" style="color:var(--text-color);">KiddyKart</span>
    </div>
    <div>
        <a href="../HomeServlet" class="nav-btn"><i class="bi bi-house-door-fill"></i> Home</a>
        <button id="themeToggle" class="nav-btn"><i class="bi bi-sun-fill"></i></button>
        <a href="logout.jsp" class="nav-btn"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </div>
</nav>

<div class="profile-wrapper">
    <div class="profile-card">
        <img src="https://api.dicebear.com/7.x/fun-emoji/svg?seed=<%= userName %>" alt="Profile" class="profile-pic">
        <h3><%= userName %></h3>
        <p>📧 <%= userEmail %></p>
        
        <% if (isMember) { %>
            <div class="membership-card-wrapper">
                <div class="membership-card">
                    <div class="card-row">
                        <span class="card-chip"></span>
                        <img src="../assets/logo2.png" alt="KiddyKart Logo" class="card-logo-sm">
                    </div>
                    <div class="card-number">
                        <span>0608</span>
                        <span>••••</span>
                        <span>••••</span>
                        <span><%= String.format("%04d", user.getId()) %></span>
                    </div>
                    <div class="card-row">
                        <div class="card-details">
                            <small>MEMBER NAME</small><br>
                            <span class="card-name"><%= userName.toUpperCase() %></span>
                        </div>
                        <div class="card-details text-end">
                            <small>MEMBERSHIP</small><br>
                            <span class="card-type">PREMIUM</span>
                        </div>
                    </div>
                </div>
            </div>
        <% } else { %>
            <a href="membership.jsp" class="btn btn-sm btn-outline-primary">Learn about Membership</a>
        <% } %>

        <div class="stats">
            <div class="stat">
                <h4><%= orderCount %></h4>
                <small>Orders</small>
            </div>
            <div class="stat">
                <h4><%= addressCount %></h4>
                <small>Addresses</small>
            </div>
        </div>
    </div>
    
    <div>
        <div class="address-header">
            <h5>Saved Delivery Addresses</h5>
            <a href="addAddress.jsp" class="nav-btn"><i class="bi bi-plus-circle"></i> Add New</a>
        </div>
        <% if (addressList.isEmpty()) { %>
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i> You have not added any address yet.
            </div>
        <% } else { %>
            <div class="address-list">
                <% for (Address addr : addressList) { %>
                    <div class="address-box">
                        <h6><i class="bi bi-person-fill"></i> <%= addr.getFullName() %></h6>
                        <p><i class="bi bi-geo-alt-fill"></i> <%= addr.getStreet() %>, <%= addr.getCity() %>, <%= addr.getState() %> - <%= addr.getPincode() %></p>
                        <p><i class="bi bi-telephone-fill"></i> <%= addr.getPhone() %></p>
                        <div class="address-actions">
                            <a href="editAddress.jsp?id=<%= addr.getId() %>" class="btn-edit"><i class="bi bi-pencil-fill"></i> Edit</a>
                            <a href="deleteAddress.jsp?id=<%= addr.getId() %>" class="btn-delete"><i class="bi bi-trash-fill"></i> Delete</a>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</div>

<script>
    document.getElementById('themeToggle').addEventListener('click', function () {
        document.body.classList.toggle('dark-mode');
        this.innerHTML = document.body.classList.contains('dark-mode') ? '<i class="bi bi-moon-fill"></i>' : '<i class="bi bi-sun-fill"></i>';
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>