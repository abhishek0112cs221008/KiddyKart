<%@ page import="model.Product, dao.ProductDAO, dao.ReviewDAO, model.Review" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String pidParam = request.getParameter("id");
    if (pidParam == null || pidParam.isEmpty()) {
        out.println("<p style='color:red;'>\u26A0\uFE0F Invalid or missing product ID</p>");
        return;
    }

    int productId = Integer.parseInt(pidParam);
    ProductDAO dao = new ProductDAO();
    Product product = dao.getProductById(productId);

    if (product == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Load dynamic reviews
    ReviewDAO reviewDAO = new ReviewDAO();
    java.util.List<Review> reviews = reviewDAO.getReviewsByProductId(productId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= product.getName() %> - KiddyKart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
    <style>
        body { background: #fffaf0; font-family: 'Segoe UI', sans-serif; }
        .container { margin-top: 50px; max-width: 900px; }
        .product-card { background: #fff; border-radius: 16px; padding: 30px; box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        .product-img { width: 100%; max-height: 320px; object-fit: contain; background: #f7f7f7; border-radius: 10px; }
        .btn-cart { background: #ff4081; border: none; padding: 10px 20px; border-radius: 30px; color: white; font-weight: 600; font-size: 16px; }
        .btn-cart:hover { background: #e91e63; }
        .review-card { background: #f9f9f9; padding: 15px 20px; margin-top: 20px; border-radius: 10px; box-shadow: 0 1px 5px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
<div class="container">
    <a href="../HomeServlet" class="btn btn-link"><i class="bi bi-arrow-left"></i> Back to Shopping</a>
    <div class="product-card row">
        <div class="col-md-5 text-center">
            <img src="<%= product.getImageUrl() %>" alt="Product Image" class="product-img">
        </div>
        <div class="col-md-7">
            <h2><%= product.getName() %></h2>
            <p class="text-muted">Category: <%= product.getCategory() %></p>
            <p class="text-success fw-bold fs-4">&#8377; <%= product.getPrice() %></p>
            <p><%= product.getDescription() %></p>
            <form method="post" action="../CartServlet">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <label>Quantity:</label>
                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control w-25 mb-2">
                <button type="submit" class="btn-cart"><i class="bi bi-cart-plus"></i> Add to Cart</button>
            </form>
        </div>
    </div>

    <!-- Customer Reviews -->
    <section class="mt-5">
        <h4>🗣️ Customer Reviews</h4>
        <% if (reviews != null && !reviews.isEmpty()) {
            for (Review r : reviews) { %>
            <div class="review-card">
                <strong><%= r.getUserName() %></strong>
                <span style="color: #f39c12;"> <%= "★".repeat(r.getRating()) %> </span>
                <p class="mt-2"><%= r.getComment() %></p>
                <div style="font-size: 12px; color: gray;">Reviewed on <%= r.getReviewDate() %></div>
            </div>
        <% } 
        } else { %>
            <p class="text-muted fst-italic mt-3">No reviews yet for this product. Be the first to review!</p>
        <% } %>
    </section>

    <!-- Submit Review -->
    <form class="mt-4" action="../WriteReview" method="post">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        <h5>✍️ Write a Review</h5>
        <input type="text" name="userName" placeholder="Your Name" class="form-control mb-2" required>
        <select name="rating" class="form-select mb-2" required>
            <option value="">Rate...</option>
            <option value="5">5 - Excellent</option>
            <option value="4">4 - Good</option>
            <option value="3">3 - Average</option>
            <option value="2">2 - Poor</option>
            <option value="1">1 - Bad</option>
        </select>
        <textarea name="comment" class="form-control mb-2" rows="4" placeholder="Write your review..." required></textarea>
        <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
    
    
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>