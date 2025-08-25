<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>🎉 Order Placed - QuickKartKids</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #2267D8;
            --success-green: #388E3C;
            --success-light: #e5f8e7;
            --text-dark: #212121;
            --text-light: #878787;
            --bg-light: #f8f9fa;
            --card-bg: #ffffff;
            --shadow: rgba(0, 0, 0, 0.08);
            --border-color: #e0e0e0;
        }

        body {
            background: var(--bg-light);
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .success-box {
            max-width: 600px;
            width: 100%;
            padding: 40px;
            background-color: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 6px 20px var(--shadow);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        .success-icon-container {
            width: 90px;
            height: 90px;
            background-color: var(--success-light);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 20px;
        }

        .success-icon-container .bi {
            font-size: 3.5rem;
            color: var(--success-green);
        }

        h2 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--success-green);
            margin-bottom: 10px;
        }

        .message-text {
            font-size: 1rem;
            color: var(--text-dark);
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .message-text strong {
            color: var(--primary-blue);
        }

        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 300px;
            margin: 0 auto;
        }
        
        .btn-link {
            text-decoration: none;
            padding: 12px 24px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 6px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 2px 4px var(--shadow);
        }

        .btn-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px var(--shadow);
        }

        .btn-primary-action {
            background-color: var(--primary-blue);
            color: white;
        }

        .btn-primary-action:hover {
            background-color: var(--primary-hover);
            color: white;
        }
        
        .btn-secondary-action {
            background-color: var(--card-bg);
            color: var(--primary-blue);
            border: 1px solid var(--border-color);
        }
        
        .btn-secondary-action:hover {
            color: var(--primary-hover);
            border-color: var(--primary-hover);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>

<div class="success-box">
    <div class="success-icon-container">
        <i class="bi bi-check-circle-fill"></i>
    </div>
    
    <%
	    String membershipMessage = (String) session.getAttribute("membershipMessage");
	    if (membershipMessage != null) {
	%>
	        <div class="alert alert-success mt-4">
	            <strong><%= membershipMessage %></strong>
	        </div>
	<%
	        session.removeAttribute("membershipMessage"); // Display once then remove
	    }
	%>
    <h2>Order Placed Successfully!</h2>
    <p class="message-text">Thank you for shopping with <strong>QuickKartKids</strong>.<br>
       Your cute package will arrive soon!</p>

    <div class="btn-group">
        <a href="viewOrders.jsp" class="btn-link btn-primary-action">
            <i class="bi bi-box-seam"></i> View My Orders
        </a>
        <a href="<%= request.getContextPath() %>/HomeServlet" class="btn-link btn-secondary-action">
            <i class="bi bi-house-fill"></i> Go to Home
        </a>
    </div>
</div>

</body>
</html>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>🎉 Order Placed - QuickKartKids</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #fff8f1;
            font-family: 'Segoe UI', sans-serif;
        }

        .success-box {
            max-width: 600px;
            margin: 80px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        .success-box img {
            width: 100px;
            margin-bottom: 20px;
        }

        h2 {
            color: #4caf50;
            font-size: 28px;
            margin-bottom: 15px;
        }

        p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }

        .btn {
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 30px;
            margin: 10px;
        }

        .btn-home {
            background-color: #ff6f91;
            color: white;
        }

        .btn-orders {
            background-color: #007bff;
            color: white;
        }

        .btn-home:hover {
            background-color: #e05275;
        }

        .btn-orders:hover {
            background-color: #0056b3;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="success-box">
    <img src="https://cdn-icons-png.flaticon.com/512/1792/1792892.png" alt="Order Success Icon">
    <h2>🎉 Order Placed Successfully!</h2>
    <p>Thank you for shopping with <strong>QuickKartKids</strong>.<br>
       Your cute package will arrive soon!</p>

    <a href="home.jsp" class="btn btn-home">🏠 Go to Home</a>
    <a href="viewOrders.jsp" class="btn btn-orders">📦 View My Orders</a>
</div>

</body>
</html>
