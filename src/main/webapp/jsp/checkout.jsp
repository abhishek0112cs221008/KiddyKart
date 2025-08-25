<%@ page import="java.util.*, model.CartItem, model.Address, dao.AddressDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

    if (userEmail == null || cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    double subtotal = 0;
    for (CartItem item : cart) {
        subtotal += item.getTotalPrice();
    }

    Boolean isMember = (Boolean) session.getAttribute("isMember");
    if (isMember == null) isMember = false;

    double discountAmount = 0;
    double finalTotal = subtotal;
    if (isMember) {
        discountAmount = subtotal * 0.20;
        finalTotal = subtotal - discountAmount;
    }

    List<Address> addressList = AddressDAO.getAddressesByEmail(userEmail);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Review & Checkout - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="assets/logo2.png">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #1e63d4;
            --text-dark: #212121;
            --text-muted: #878787;
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
        .container-fluid { max-width: 1200px; }
        .checkout-page {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        @media (max-width: 992px) {
            .checkout-page { grid-template-columns: 1fr; }
        }
        .order-summary-card, .address-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-shadow: 0 4px 15px var(--shadow);
            padding: 2rem;
        }
        .order-item {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            align-items: center;
        }
        .order-item img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            border-radius: 4px;
            background: #f8f9fa;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        .total-price {
            font-size: 1.5rem;
            font-weight: 700;
            border-top: 1px dashed var(--border-color);
            padding-top: 1rem;
            margin-top: 1rem;
        }
        .address-option {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: border-color 0.2s ease;
        }
        .address-option:has(input:checked) {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 2px rgba(40, 116, 240, 0.25);
        }
        .address-option h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        .btn-payment {
            width: 100%;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            background-color: var(--primary-blue);
            color: white;
            border: none;
            border-radius: 8px;
            margin-top: 1rem;
        }
        .btn-payment:hover {
            background-color: var(--primary-hover);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <h2 class="text-center my-4">Review Your Order</h2>
        <form action="payment.jsp" method="post">
            <div class="checkout-page">
                <div class="order-summary-card">
                    <h4>Order Summary</h4>
                    <hr>
                    <% for (CartItem item : cart) { %>
                    <div class="order-item">
                        <img src="<%= item.getProduct().getImageUrl() %>" alt="<%= item.getProduct().getName() %>">
                        <div>
                            <h5><%= item.getProduct().getName() %></h5>
                            <p class="text-muted mb-0">Qty: <%= item.getQuantity() %></p>
                            <p class="fw-bold mb-0">₹<%= item.getTotalPrice() %></p>
                        </div>
                    </div>
                    <% } %>
                    <hr>
                    <div class="price-row"><span>Subtotal</span><span>₹<%= String.format("%.2f", subtotal) %></span></div>
                    <% if (isMember) { %>
                    <div class="price-row text-success"><span>Membership Discount (20%)</span><span>- ₹<%= String.format("%.2f", discountAmount) %></span></div>
                    <% } %>
                    <div class="price-row"><span>Delivery Charges</span><span class="text-success">FREE</span></div>
                    <div class="total-price price-row"><span>Total</span><span>₹<%= String.format("%.2f", finalTotal) %></span></div>
                    
                    <input type="hidden" name="total" value="<%= String.format("%.2f", finalTotal) %>">
                    <input type="hidden" name="paymentId" value="temp_<%= System.currentTimeMillis() %>">
                </div>

                <div class="address-card">
                    <h4>Select Delivery Address</h4>
                    <hr>
                    <% if (addressList.isEmpty()) { %>
                    <div class="alert alert-warning">
                        You have no saved addresses. <a href="addAddress.jsp">Add a new one</a>.
                    </div>
                    <% } else { %>
                        <% for (Address addr : addressList) { %>
                        <label class="address-option">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="addressId" id="address<%= addr.getId() %>" value="<%= addr.getId() %>" required>
                                <div class="ms-2">
                                    <h5 class="mb-1"><%= addr.getFullName() %></h5>
                                    <p class="mb-0"><%= addr.getStreet() %>, <%= addr.getCity() %>, <%= addr.getState() %> - <%= addr.getPincode() %></p>
                                    <p class="mb-0 text-muted"><%= addr.getPhone() %></p>
                                </div>
                            </div>
                        </label>
                        <% } %>
                    <% } %>
                    <button type="submit" class="btn-payment" <%= addressList.isEmpty() ? "disabled" : "" %>>Proceed to Payment</button>
                </div>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>