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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #2874F0;
            --primary-hover: #2267D8;
            --accent-pink: #FF4081;
            --accent-hover: #E91E63;
            --text-dark: #212121;
            --text-light: #878787;
            --bg-light: #f1f3f6;
            --card-bg: #ffffff;
            --shadow: rgba(0, 0, 0, 0.08);
            --border-color: #e0e0e0;
        }

        body {
            background: var(--bg-light);
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
        }

        .container {
            margin-top: 40px;
            margin-bottom: 40px;
            max-width: 960px;
        }

        /* Product Card */
        .product-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px var(--shadow);
        }
        .product-img {
            width: 100%;
            max-height: 400px;
            object-fit: contain;
            background: #fafafa;
            border-radius: 8px;
            padding: 15px;
        }
        .product-info h2 {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .product-info .category {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 10px;
        }
        .product-info .price {
            color: var(--primary-blue);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        .product-info .description {
            color: var(--text-dark);
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .btn-cart {
            background: var(--accent-pink);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            box-shadow: 0 4px 10px rgba(255, 64, 129, 0.4);
            transition: all 0.2s ease;
        }
        .btn-cart:hover {
            background: var(--accent-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(233, 30, 99, 0.5);
        }
        .qty-input {
            width: 80px;
            border-radius: 4px;
            border: 1px solid var(--border-color);
            padding: 8px;
            text-align: center;
        }

        /* Reviews Section */
        .reviews-section {
            background: var(--card-bg);
            padding: 30px;
            margin-top: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px var(--shadow);
        }
        .reviews-section h4, .write-review-section h5 {
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--primary-blue);
        }
        .review-card {
            background: var(--bg-light);
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .reviewer-name {
            font-weight: 600;
            color: var(--text-dark);
        }
        .review-rating .bi-star-fill {
            color: #FFC107;
            font-size: 1rem;
        }
        .review-comment {
            font-size: 0.95rem;
            color: var(--text-dark);
            line-height: 1.5;
            margin-bottom: 5px;
        }
        .review-date {
            font-size: 0.8rem;
            color: var(--text-light);
        }

        /* Write Review Section */
        .write-review-section {
            background: var(--card-bg);
            padding: 30px;
            margin-top: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px var(--shadow);
        }
        .write-review-section .form-control, .write-review-section .form-select {
            border-radius: 8px;
            border-color: var(--border-color);
            padding: 10px;
            font-size: 1rem;
        }
        .submit-btn {
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 8px;
            transition: background 0.2s ease;
        }
        .submit-btn:hover {
            background: var(--primary-hover);
        }

        .back-link {
            text-decoration: none;
            color: var(--text-light);
            font-weight: 500;
            display: inline-block;
            margin-bottom: 20px;
            transition: color 0.2s ease;
        }
        .back-link:hover {
            color: var(--primary-blue);
        }
    </style>
</head>
<body>
<div class="container">
    <a href="../HomeServlet" class="back-link"><i class="bi bi-arrow-left"></i> Back to Shopping</a>
    
    <div class="product-card row">
        <div class="col-md-5 text-center">
            <img src="<%= product.getImageUrl() %>" alt="Product Image" class="product-img">
        </div>
        <div class="col-md-7 product-info pt-3 pt-md-0">
            <h2><%= product.getName() %></h2>
            <p class="category">Category: <%= product.getCategory() %></p>
            <p class="price">&#8377; <%= product.getPrice() %></p>
            <p class="description"><%= product.getDescription() %></p>
            <form method="post" action="../CartServlet">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <div class="d-flex align-items-center mb-3">
                    <label class="me-2">Quantity:</label>
                    <input type="number" name="quantity" value="1" min="1" max="10" class="form-control qty-input">
                </div>
                <button type="submit" class="btn-cart"><i class="bi bi-cart-plus"></i> Add to Cart</button>
            </form>
        </div>
    </div>

    <section class="reviews-section mt-5">
        <h4><i class="bi bi-chat-dots-fill"></i> Customer Reviews</h4>
        <% if (reviews != null && !reviews.isEmpty()) {
            for (Review r : reviews) { %>
            <div class="review-card">
                <div class="review-header">
                    <span class="reviewer-name"><%= r.getUserName() %></span>
                    <div class="review-rating">
                        <% for (int i = 0; i < r.getRating(); i++) { %>
                            <i class="bi bi-star-fill"></i>
                        <% } %>
                    </div>
                </div>
                <p class="review-comment"><%= r.getComment() %></p>
                <div class="review-date">Reviewed on <%= r.getReviewDate() %></div>
            </div>
        <% } 
        } else { %>
            <p class="text-muted fst-italic text-center mt-3">No reviews yet for this product. Be the first to review!</p>
        <% } %>
    </section>

    <section class="write-review-section mt-4">
        <h5><i class="bi bi-pencil-square"></i> Write a Review</h5>
        <form action="../WriteReview" method="post">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="text" name="userName" placeholder="Your Name" class="form-control mb-3" required>
            <select name="rating" class="form-select mb-3" required>
                <option value="">Rate...</option>
                <option value="5">5 - Excellent</option>
                <option value="4">4 - Good</option>
                <option value="3">3 - Average</option>
                <option value="2">2 - Poor</option>
                <option value="1">1 - Bad</option>
            </select>
            <textarea name="comment" class="form-control mb-3" rows="4" placeholder="Write your review..." required></textarea>
            <button type="submit" class="btn submit-btn">Submit Review</button>
        </form>
    </section>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>