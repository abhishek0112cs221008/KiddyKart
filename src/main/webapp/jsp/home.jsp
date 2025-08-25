<%@ page import="java.util.*, model.Product, dao.ProductDAO, dao.ReviewDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    ProductDAO dao = new ProductDAO();
    List<Product> products = dao.getAllProducts();

    Map<String, List<Product>> categoryMap = new LinkedHashMap<>();
    for (Product p : products) {
        categoryMap.computeIfAbsent(p.getCategory(), k -> new ArrayList<>()).add(p);
    }

    String search = request.getParameter("search");

    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>KiddyKart – Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/home.css">

    <link rel="icon" href="assets/logo2.png">
</head>
<body class="light-mode">

<!-- NAVBAR -->
<nav class="glass-navbar">
    <div class="logo">
        <img src="assets/logo2.png" alt="Logo">
        <h1>KiddyKart</h1>
    </div>
    <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search products...">
    </div>
    <div class="nav-actions">
       <!-- <button id="themeToggle" class="nav-btn" title="Switch theme"></button> --> 
        <a href="jsp/cart.jsp" class="nav-btn">
            🛒 <span class="cart-count"><%= session.getAttribute("cart") != null ? ((List)session.getAttribute("cart")).size() : 0 %></span>
        </a>
        <a href="jsp/viewOrders.jsp" class="nav-btn">Your Orders</a>
        <a href="jsp/userProfile.jsp" class="nav-btn">👤</a>
        <a href="jsp/logout.jsp" style="color:#fff; background:#f44; padding:8px 16px; border-radius:20px; text-decoration:none; font-weight:bold;">Logout</a>

        <!-- <button id="themeToggle">%</button> -->
    </div>
</nav>

<!-- Hero Section -->
            <section class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">DISCOVER THE BEST KIDS COLLECTION'</h1>
                    <p class="hero-subtitle">Everything your little ones need - from toys to clothing, books to games</p>
                    <button class="hero-cta" onclick="showPage('toys')" >SHOP NOW</button>
                </div>
            </section>
            <style>
                 .hero-section {
			         background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			         color: white;
			         padding: 80px 0;
			         text-align: center;
			         position: relative;
			         overflow: hidden;
			     }
			     
			     .hero-content {
			         max-width: 800px;
			         margin: 0 auto;
			         padding: 0 20px;
			         position: relative;
			         z-index: 2;
			     }
			     
			     .hero-title {
			         font-size: 48px;
			         font-weight: 800;
			         margin-bottom: 16px;
			         letter-spacing: -1px;
			     }
			     
			     .hero-subtitle {
			         font-size: 18px;
			         margin-bottom: 32px;
			         opacity: 0.9;
			         font-weight: 400;
			     }
			     
			     .hero-cta {
			         background: #ff3f6c;
			         color: white;
			         border: none;
			         padding: 16px 32px;
			         font-size: 16px;
			         font-weight: 600;
			         border-radius: 4px;
			         cursor: pointer;
			         transition: all 0.3s;
			         text-transform: uppercase;
			         letter-spacing: 0.5px;
			     }
			     
			     .hero-cta:hover {
			         background: #e6366a;
			         transform: translateY(-2px);
			         box-shadow: 0 8px 25px rgba(255, 63, 108, 0.3);
			     }
            </style>

<!-- CATEGORY-WISE PRODUCTS -->
<% for (Map.Entry<String, List<Product>> entry : categoryMap.entrySet()) { %>
    <div class="category-section">
        <h3 class="category-title"><i class="bi bi-grid"></i> <%= entry.getKey() %></h3>
        <div class="products-grid">
            <% for (Product p : entry.getValue()) {
                if (search == null || search.isEmpty() || p.getName().toLowerCase().contains(search.toLowerCase())) {
                    double avgRating = ReviewDAO.getAverageRatingForProduct(p.getId());
                    int reviewCount = ReviewDAO.getReviewCountForProduct(p.getId());
            %>
            <div class="product-card glass-card">
            	<%
				    int productCount = p.getQuantity();
				    if (productCount < 5 && productCount > 0) {
				%>
				        <p class="low-stock-warning">
				            <i class="bi bi-exclamation-triangle-fill"></i> Only <%= productCount %> left. Hurry up!
				        </p>
				<%
				    } else if (productCount == 0) {
				%>
				        <p class="out-of-stock">
				            <i class="bi bi-x-circle-fill"></i> Out of Stock
				        </p>
				<%
				    }
				%>
				
                <div class="product-image">
                    <img src="<%= p.getImageUrl() != null && !p.getImageUrl().isEmpty() ? p.getImageUrl() : "assets/no-image.png" %>" 
                         alt="<%= p.getName() %>" 
                         onerror="this.src='assets/no-image.png'">
                </div>
                <h3><%= p.getName() %></h3>
                                                
                <%
                	if(p.getPrice() > 599.00) {
               	%>	
               		 <p class="extra-info">🚚 Free Shipping.</p>              		
               	<% 	
                	}
                %>
                <p class="price">₹ <%= p.getPrice() %></p>
                
                <% if (reviewCount > 0) { %>
                    <p class="rating">⭐ <%= String.format("%.1f", avgRating) %> (<%= reviewCount %>)</p>
                <% } else { %>
                    <p class="rating">⭐ No reviews yet</p>
                <% } %>
                <form method="post" action="CartServlet" class="add-to-cart-form">
				    <input type="hidden" name="action" value="add">
				    <input type="hidden" name="productId" value="<%= p.getId() %>">
				    <button type="submit" class="add-btn">
				        <i class="bi bi-cart-plus"></i> Add to Cart
				    </button>
				</form>
				
                <a href="jsp/productDetails.jsp?id=<%= p.getId() %>" class="details-btn">View Details</a>
            </div>
            <% } } %>
        </div>
    </div>
<% } %>


<footer class="footer-detailed">
    <div class="footer-content">
        <img src="assets/logo2.png" alt="kiddykart logo">
        <p class="footer-text">© 2025 KiddyKart. All Rights Reserved.</p>
    </div>
    
    <style>
    .footer-detailed {
    background-color: #ffffff;
    padding: 40px 20px;
    border-top: 1px solid #e0e0e0;
    text-align: center;
}

.footer-content {
    max-width: 600px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.footer-detailed img {
    width: 90px;
    height: auto;
    margin-bottom: 15px;
    transition: transform 0.3s ease;
}

.footer-detailed img:hover {
    transform: scale(1.05);
}

.footer-text {
    font-family: 'Poppins', sans-serif;
    font-size: 0.9rem;
    color: #6c757d;
    margin: 0;
}
</style>
</footer>

<script>
document.getElementById('searchInput').addEventListener('input', function () {
    const query = this.value.toLowerCase();
    document.querySelectorAll('.product-card').forEach(card => {
        const name = card.querySelector('h3').textContent.toLowerCase();
        card.style.display = name.includes(query) ? 'block' : 'none';
    });
});

document.getElementById('themeToggle').addEventListener('click', function () {
    document.body.classList.toggle('light-mode');
    document.body.classList.toggle('dark-mode');
    this.textContent = document.body.classList.contains('dark-mode') ? '🌙' : '☀️';
});
</script>

</body>
</html>