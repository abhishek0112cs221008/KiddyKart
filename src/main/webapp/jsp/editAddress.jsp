
<%@ page import="model.Address, dao.AddressDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Address address = null;
    for (Address a : AddressDAO.getAddressesByEmail(userEmail)) {
        if (a.getId() == id) {
            address = a;
            break;
        }
    }

    if (address == null) {
        out.println("Address not found or unauthorized access.");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Address</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
<h2>Edit Delivery Address</h2>
<form action="../UpdateAddressServlet" method="post" class="w-50 mx-auto">
    <input type="hidden" name="id" value="<%= address.getId() %>">
    <input type="text" name="fullName" class="form-control mb-2" placeholder="Full Name" value="<%= address.getFullName() %>" required>
    <input type="text" name="phone" class="form-control mb-2" placeholder="Phone" value="<%= address.getPhone() %>" required>
    <input type="text" name="street" class="form-control mb-2" placeholder="Street" value="<%= address.getStreet() %>" required>
    <input type="text" name="city" class="form-control mb-2" placeholder="City" value="<%= address.getCity() %>" required>
    <input type="text" name="state" class="form-control mb-2" placeholder="State" value="<%= address.getState() %>" required>
    <input type="text" name="pincode" class="form-control mb-2" placeholder="Pincode" value="<%= address.getPincode() %>" required>
    <input type="submit" class="btn btn-primary" value="Update Address">
</form>
</body>
</html>