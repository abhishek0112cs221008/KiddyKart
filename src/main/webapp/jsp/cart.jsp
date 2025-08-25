<<<<<<< HEAD
<%@ page import="java.util.*, model.CartItem, model.Product, dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Fetch cart and user details from session
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();

    double subtotal = 0;
    
    // Check for membership
    Boolean isMember = (Boolean) session.getAttribute("isMember");
    if (isMember == null) {
        isMember = false;
    }
    
    // Get all products to do a live stock check
    ProductDAO productDAO = new ProductDAO();
    List<Product> allProducts = productDAO.getAllProducts();
    Map<Integer, Product> allProductsMap = new HashMap<>();
    for(Product p : allProducts) {
        allProductsMap.put(p.getId(), p);
    }
    
    boolean hasInsufficientStock = false;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="assets/logo2.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2874F0; /* Flipkart's primary blue */
            --primary-hover: #2267D8;
            --accent-green: #388E3C;
            --accent-red: #E74C3C;
            --text-dark: #212121;
            --text-light: #878787;
            --bg-light: #f1f3f6;
            --card-bg: #ffffff;
            --border-color: #e0e0e0;
            --shadow: rgba(0, 0, 0, 0.05);
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
        }
        
        .header {
            background: var(--card-bg);
            border-bottom: 1px solid var(--border-color);
            box-shadow: 0 2px 4px var(--shadow);
            padding: 18px 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header h1 {
            font-size: 1.6rem;
            font-weight: 700;
            margin: 0;
        }

        .btn-utility {
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        .btn-utility:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .btn-back {
            background: var(--primary-blue);
            color: white;
            padding: 8px 15px;
        }
        .btn-back:hover {
            background: var(--primary-hover);
            color: white;
        }

        .cart-container {
            display: flex;
            gap: 20px;
            margin: 30px auto;
            max-width: 1200px;
            padding: 0 15px;
        }

        .cart-items {
            flex-grow: 1;
        }

        .cart-summary {
            flex-shrink: 0;
            width: 350px;
            background: var(--card-bg);
            border-radius: 8px;
            box-shadow: 0 2px 4px var(--shadow);
            padding: 20px;
            height: fit-content;
        }
        
        @media (max-width: 992px) {
            .cart-container {
                flex-direction: column;
            }
            .cart-summary {
                width: 100%;
            }
        }

        .cart-item-card {
            display: flex;
            background: var(--card-bg);
            border-radius: 8px;
            box-shadow: 0 2px 4px var(--shadow);
            padding: 15px;
            margin-bottom: 15px;
            align-items: flex-start;
            position: relative;
        }
        .product-img-box {
            width: 110px;
            height: 110px;
            flex-shrink: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 20px;
        }
        .product-img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        .item-details {
            flex-grow: 1;
        }
        .item-details h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .item-details p {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 10px;
        }
        .item-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        .price-text {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
        }
        .price-text-sm {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            overflow: hidden;
        }
        .quantity-control button {
            background: transparent;
            border: none;
            padding: 6px 12px;
            font-size: 1rem;
        }
        .quantity-control input {
            width: 40px;
            text-align: center;
            border: none;
            border-left: 1px solid var(--border-color);
            border-right: 1px solid var(--border-color);
            padding: 6px 0;
            background: #fcfcfc;
        }
        .btn-remove {
            background: none;
            border: none;
            color: var(--text-light);
            font-size: 0.95rem;
            margin-left: 15px;
            padding: 8px 12px;
            border-radius: 4px;
        }
        .btn-remove:hover {
            color: var(--accent-red);
            background: #fff0f0;
        }

        .price-details h4 {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-light);
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.95rem;
        }
        .price-row.total-price {
            font-size: 1.2rem;
            font-weight: 600;
            border-top: 1px dashed var(--border-color);
            padding-top: 15px;
            margin-top: 15px;
        }
        .price-row.discount-row {
            color: var(--accent-green);
            font-weight: 600;
        }
        .price-row.final-total-row {
            font-weight: 700;
            font-size: 1.3rem;
            border-top: 1px dashed var(--border-color);
            padding-top: 15px;
            margin-top: 15px;
        }
        
        .btn-payment {
            background: var(--primary-blue);
            color: white;
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 4px;
            border: none;
            display: block;
            width: 100%;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
        }
        .btn-payment:hover {
            background: var(--primary-hover);
        }
        
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: var(--card-bg);
            border-radius: 8px;
            box-shadow: 0 2px 4px var(--shadow);
        }
        .empty-cart img {
            width: 120px;
            margin-bottom: 20px;
        }
        .empty-cart a {
            background: var(--primary-blue);
            color: white;
            padding: 12px 25px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
        }
        
        .stock-message {
            position: absolute;
            top: 5px;
            right: 5px;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 4px;
        }
        .stock-message.insufficient {
            background-color: #fff3e0;
            color: #ff9800;
        }
        .stock-message.available {
            background-color: #d4edda;
            color: #155724;
        }
        
        .membership-status {
            margin-bottom: 20px;
            padding: 12px 15px;
            background-color: var(--primary-blue);
            color: white;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .membership-status.member {
            background-color: #ffd700;
            color: #333;
        }
    </style>
</head>
<body>

<div class="header">
    <h1><i class="bi bi-cart-fill text-primary"></i> Your KiddyKart Cart</h1>
    <a href="../HomeServlet" class="btn-utility btn-back"><i class="bi bi-arrow-left"></i> Back to Home</a>
</div>

<div class="cart-container">
<%
    if (cart.isEmpty()) {
%>
    <div class="empty-cart">
        <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png" alt="Empty Cart" />
        <h4 class="text-muted">Oops! Your cart is empty 😔</h4>
        <p>Go explore magical items for kids 🏰</p>
        <a href="../HomeServlet">Browse Products</a>
    </div>
<%
    } else {
%>
    <div class="cart-items">
        <h4 class="mb-4">My Cart (<%= cart.size() %>)</h4>
    <%
        for (CartItem item : cart) {
            Product currentProduct = allProductsMap.get(item.getProduct().getId());
            if (currentProduct != null) {
                subtotal += item.getTotalPrice();
                if (item.getQuantity() > currentProduct.getQuantity()) {
                    hasInsufficientStock = true;
                }
            } else {
                 // Handle case where product might have been deleted from the database
                 hasInsufficientStock = true;
            }
    %>
        <div class="cart-item-card">
            <div class="product-img-box">
                <% if (item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty()) { %>
                    <img class="product-img" src="<%= item.getProduct().getImageUrl() %>" onerror="this.src='assets/no-image.png'" alt="<%= item.getProduct().getName() %>">
                <% } else { %>
                    <img class="product-img" src="assets/no-image.png" alt="<%= item.getProduct().getName() %>">
                <% } %>
            </div>
            <div class="item-details">
                <h5><%= item.getProduct().getName() %></h5>
                <p>₹<%= item.getProduct().getPrice() %></p>
                <div class="item-actions">
                    <form method="post" action="../CartServlet" class="d-flex align-items-center">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                        <div class="quantity-control">
                            <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>" class="btn-minus" title="Decrease Quantity">-</button>
                            <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="10" required>
                            <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>" class="btn-plus" title="Increase Quantity">+</button>
                        </div>
                    </form>
                    <form method="post" action="../CartServlet">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                        <button type="submit" class="btn-remove" title="Remove Item"><i class="bi bi-trash"></i> REMOVE</button>
                    </form>
                </div>
            </div>
            <div class="ms-auto price-text">₹<%= item.getTotalPrice() %></div>
            <% if (currentProduct != null && item.getQuantity() > currentProduct.getQuantity()) { %>
                <span class="stock-message insufficient">Insufficient Stock!</span>
            <% } else if (currentProduct == null) { %>
                <span class="stock-message insufficient">Product Unavailable</span>
            <% } %>
        </div>
    <%
        }
    %>
    </div>
    
	<%
	    double discountAmount = 0;
	    double finalTotal = subtotal;
	    if (isMember) {
	        discountAmount = subtotal * 0.20;
	        finalTotal = subtotal - discountAmount;
	    }
	%>
    <div class="cart-summary">
        <h4 class="price-heading">PRICE DETAILS</h4>
        <div class="membership-status <%= isMember ? "member" : "" %>">
            <i class="bi bi-person-badge-fill"></i> <%= isMember ? "You are a KiddyKart Member!" : "Become a member for 20% off!" %>
        </div>
        <div class="price-row">
            <span>Price (<%= cart.size() %> items)</span>
            <span>₹<%= String.format("%.2f", subtotal) %></span>
        </div>
        <% if (isMember) { %>
            <div class="price-row discount-row">
                <span>Membership Discount (20%)</span>
                <span>- ₹<%= String.format("%.2f", discountAmount) %></span>
            </div>
        <% } %>
        <div class="price-row">
            <span>Delivery Charges</span>
            <span class="text-success">FREE</span>
        </div>
        <div class="price-row final-total-row">
            <span>Total Amount</span>
            <span>₹<%= String.format("%.2f", finalTotal) %></span>
        </div>
        <% if (!hasInsufficientStock) { %>
	        <%-- <a href="payment.jsp?total=<%= String.format("%.2f", finalTotal) %>" 
			   class="btn-payment <%= cart.isEmpty() ? "disabled" : "" %>"
			   <%= cart.isEmpty() ? "tabindex='-1' aria-disabled='true'" : "" %>>
			   Proceed to Checkout
			</a> --%>
			<a href="checkout.jsp" 
			   class="btn-payment <%= cart.isEmpty() ? "disabled" : "" %>"
			   <%= cart.isEmpty() ? "tabindex='-1' aria-disabled='true'" : "" %>>
			   Proceed to Checkout
			</a>
		<% } else { %>
			<button class="btn-payment" disabled title="Cannot proceed to payment. Check item quantities.">Proceed to Checkout</button>
		    <p style="color:var(--accent-red); font-weight:bold; margin-top:8px;">
		        Some items have insufficient stock.
		    </p>
		<% } %>
    </div>
<%
    }
%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
=======
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
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
