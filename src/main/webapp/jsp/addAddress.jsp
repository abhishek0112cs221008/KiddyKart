<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Address</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
<h2>Add Delivery Address</h2>
<form action="../AddAddressServlet" method="post" class="w-50 mx-auto">
    <input type="text" name="fullName" class="form-control mb-2" placeholder="Full Name" required>
    <input type="text" name="phone" class="form-control mb-2" placeholder="Phone Number" required>
    <input type="text" name="street" class="form-control mb-2" placeholder="Street Address" required>
    <input type="text" name="city" class="form-control mb-2" placeholder="City" required>
    <input type="text" name="state" class="form-control mb-2" placeholder="State" required>
    <input type="text" name="pincode" class="form-control mb-2" placeholder="Pincode" required>
    <input type="submit" class="btn btn-primary" value="Save Address">
</form>
</body>
</html>