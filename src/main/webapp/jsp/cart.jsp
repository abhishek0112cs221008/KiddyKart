<%@ page import="java.util.*, model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();
    double total = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart - QuickKartKids</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9ff;
            font-family: 'Segoe UI', sans-serif;
        }

        .header {
            background: #ff6f91;
            color: white;
            padding: 18px 30px;
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 1px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .cart-container {
            padding: 40px 20px;
            max-width: 960px;
            margin: auto;
        }

        .cart-table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        th {
            background: #fce4ec;
            color: #d81b60;
            padding: 15px;
        }

        td {
            text-align: center;
            padding: 15px;
            vertical-align: middle;
        }

        .product-img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            border-radius: 8px;
        }

        .btn-update {
            background: #00bcd4;
            color: white;
            border: none;
            border-radius: 50%;
            padding: 6px 10px;
            font-weight: bold;
        }

        .btn-remove {
            background: #f44336;
            color: white;
            border: none;
            border-radius: 50%;
            padding: 6px 10px;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-cart img {
            width: 160px;
        }

        .total-bar {
            font-size: 18px;
            background: #fff8e1;
            padding: 12px;
            text-align: right;
            font-weight: bold;
            color: #ff6f00;
            border-top: 2px solid #ffe082;
        }

        .btn-payment {
            background: #4caf50;
            color: white;
            font-size: 18px;
            border-radius: 30px;
            padding: 12px 30px;
            margin-top: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
            border: none;
        }

        .btn-payment:hover {
            background: #43a047;
        }

        input[type="number"] {
            width: 60px;
            padding: 4px;
        }
    </style>
</head>
<body>

<div class="header"> 🏍️ Your QuickKartKids Cart</div>
<a href="../HomeServlet" class="btn btn-link ms-4 mt-3">&larr; Back to home</a>
<div class="cart-container">
<%
    if (cart.isEmpty()) {
%>
    <div class="empty-cart">
        <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png" alt="Empty Cart" />
        <h4 class="mt-4">Oops! Your cart is empty 😔</h4>
        <p>Go explore magical items for kids 🏱</p>
        <a href="home.jsp" class="btn btn-warning mt-3">🥸 Browse Products</a>
    </div>
<%
    } else {
%>
    <form method="post" action="payment.jsp">
        <table class="table cart-table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
<%
    for (CartItem item : cart) {
        total += item.getTotalPrice();
%>
                <tr>
                    <td>
                        <% if (item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty()) { %>
                            <img class="product-img" src="<%= item.getProduct().getImageUrl() %>">
                        <% } else { %> 🏱 <% } %>
                    </td>
                    <td><%= item.getProduct().getName() %></td>
                    <td>₹<%= item.getProduct().getPrice() %></td>
                    <td>
                        <form method="post" action="../CartServlet" class="d-flex justify-content-center">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                            <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="10">
                            <button type="submit" class="btn-update ms-2">↻</button>
                        </form>
                    </td>
                    <td>₹<%= item.getTotalPrice() %></td>
                    <td>
                        <form method="post" action="../CartServlet">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                            <button type="submit" class="btn-remove">✖</button>
                        </form>
                    </td>
                </tr>
<%
    }
%>
                <tr>
                    <td colspan="6" class="total-bar">Total: ₹<%= total %></td>
                </tr>
            </tbody>
        </table>

        <input type="hidden" name="total" value="<%= total %>">
        <button type="submit" class="btn-payment">🚀 Proceed to Payment</button>
    </form>
<%
    }
%>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
