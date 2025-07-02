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
