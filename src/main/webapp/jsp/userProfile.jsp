<%@ page import="java.util.*, model.Address, dao.AddressDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Address> addressList = AddressDAO.getAddressesByEmail(userEmail);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - KiddyKart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', sans-serif;
        }
        .profile-container {
            max-width: 800px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .profile-pic {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
        }
        .address-box {
            background: #f9f9f9;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .address-box h6 {
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
<div class="profile-container text-center">
    <img src="https://api.dicebear.com/7.x/fun-emoji/svg?seed=<%= userName %>" alt="Profile" class="profile-pic">
    <h3><%= userName %></h3>
    <p class="text-muted mb-4">📧 <%= userEmail %></p>

    <hr>

    <h5 class="text-start mb-3">📍 Saved Delivery Addresses</h5>
    <% if (addressList.isEmpty()) { %>
        <p class="text-muted">You have not added any address yet.</p>
        <a href="addAddress.jsp" class="btn btn-success">➕ Add Address</a>
    <% } else { %>
        <% for (Address addr : addressList) { %>
            <div class="address-box text-start">
                <h6>👤 <%= addr.getFullName() %></h6>
                <p><%= addr.getStreet() %>, <%= addr.getCity() %>, <%= addr.getState() %> - <%= addr.getPincode() %></p>
                <p>📞 <%= addr.getPhone() %></p>
                <a href="editAddress.jsp?id=<%= addr.getId() %>" class="btn btn-sm btn-outline-primary">✏️ Edit</a>
                <a href="deleteAddress.jsp?id=<%= addr.getId() %>" class="btn btn-sm btn-outline-danger ms-2">🗑 Delete</a>
            </div>
        <% } %>
        <a href="addAddress.jsp" class="btn btn-success mt-3">➕ Add Another Address</a>
    <% } %>

    <hr>
    <a href="../HomeServlet" class="btn btn-outline-secondary">🏠 Back to Home</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
