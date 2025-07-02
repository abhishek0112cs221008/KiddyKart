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
<html>
<head>
    <title>KiddyKart - Pay by UPI</title>
    <link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        body { font-family: Arial; background: #f2f2f2; text-align: center; }
        .box { background: #fff; padding: 30px; margin: 50px auto; width: 400px; border-radius: 10px; box-shadow: 0 0 10px #aaa; }
        img { width: 200px; margin-bottom: 20px; }
        button { background-color: green; color: white; padding: 10px 20px; border: none; font-size: 16px; cursor: pointer; border-radius: 5px; }
        button:hover { background-color: darkgreen; }
    </style>
</head>
<body>
    <div class="box">
        <h2>UPI Payment</h2>
        <p><strong>Scan and Pay:</strong></p>
        <img src="../assets/qr.png" alt="UPI QR Code">
        <p>UPI ID: <strong>8770321224@okbizaxis</strong></p>
        <p>Amount: &#8377;<%= totalAmount %></p>

        <form action="../OrderServlet" method="post">
            <input type="hidden" name="paymentId" value="-UPI-<%= System.currentTimeMillis() %>">
            <input type="hidden" name="amount" value="<%= totalAmount %>">
            <button type="submit">I Have Paid</button>
        </form>
    </div>
</body>
</html>