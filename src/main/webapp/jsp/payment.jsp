<<<<<<< HEAD
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Replace with actual cart total logic
    double totalAmount = Double.parseDouble(request.getParameter("total")); // hardcoded for demo, make dynamic later
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>KiddyKart - Pay by UPI</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #2267D8;
            --success-green: #388E3C;
            --success-hover: #2E7D32;
            --text-dark: #212121;
            --text-light: #878787;
            --bg-light: #f1f3f6;
            --card-bg: #ffffff;
            --shadow: rgba(0, 0, 0, 0.08);
            --border-color: #e0e0e0;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-light);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-dark);
        }
        
        .payment-card {
            background: var(--card-bg);
            padding: 30px 40px;
            width: 100%;
            max-width: 450px;
            border-radius: 12px;
            box-shadow: 0 4px 15px var(--shadow);
            text-align: center;
        }

        .payment-header {
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        
        .payment-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            color: var(--primary-blue);
        }

        .payment-details p {
            font-size: 1rem;
            color: var(--text-light);
            margin: 15px 0;
        }
        
        .upi-info {
            background: var(--bg-light);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: left;
        }
        
        .upi-info div {
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 10px;
        }
        
        .upi-info strong {
            display: block;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-top: 5px;
        }
        
        .amount {
            color: var(--primary-blue);
            font-weight: 700;
            font-size: 1.5rem;
            margin-top: 15px;
        }

        .cta-button {
            background-color: var(--success-green);
            color: white;
            padding: 15px 30px;
            border: none;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            border-radius: 8px;
            width: 100%;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .cta-button:hover {
            background-color: var(--success-hover);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            font-size: 0.9rem;
            color: var(--text-light);
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="payment-card">
        <div class="payment-header">
            <h2><i class="bi bi-wallet2"></i> Complete Payment</h2>
        </div>
        
        <div class="payment-details">
            <p>Please make a payment to the UPI ID below to confirm your order.</p>
            
            <div class="upi-info">
                <div>UPI ID: <strong>8770321224@okbizaxis</strong></div>
                <div>Amount: <span class="amount">&#8377;<%= totalAmount %></span></div>
            </div>
            
            <form action="../OrderServlet" method="post">
                <input type="hidden" name="paymentId" value="-UPI-<%= System.currentTimeMillis() %>">
                <input type="hidden" name="amount" value="<%= totalAmount %>">
                <button type="submit" class="cta-button">
                    <i class="bi bi-check-circle"></i> I Have Paid
                </button>
            </form>

            <a href="cart.jsp" class="back-link">Back to Cart</a>
        </div>
    </div>
</body>
