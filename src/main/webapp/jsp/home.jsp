<<<<<<< HEAD
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
=======
<%@ page import="java.util.*, model.Product, dao.ProductDAO, dao.ReviewDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    ProductDAO dao = new ProductDAO();
    List<Product> products = dao.getAllProducts();
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;700&display=swap" rel="stylesheet">
    <link rel="icon" href="assets/logo2.png">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f9fbfc; }
        .sidebar { background-color: #fff; width: 250px; height: 100vh; position: fixed; left: 0; top: 0; box-shadow: 2px 0 10px rgba(0,0,0,0.05); padding: 20px; overflow-y: auto; }
        .sidebar h4 { font-weight: 700; color: #007aff; margin-bottom: 20px; }
        .profile-box { text-align: center; margin-bottom: 30px; }
        .profile-box img { width: 90px; height: 90px; border-radius: 50%; object-fit: cover; }
        .profile-box p { margin: 10px 0 5px; font-weight: bold; }
        .profile-box small { color: #777; font-size: 0.85em; }
        .category-list button { display: block; width: 100%; text-align: left; padding: 10px; background-color: #f2f2f2; border: none; margin-bottom: 10px; border-radius: 8px; font-weight: 500; transition: all 0.3s ease; }
        .category-list button:hover { background-color: #007aff; color: white; transform: scale(1.03); }
        .main-content { margin: 0px; padding-bottom: 20px; }
        .navbar { background-color: #fff; box-shadow: 0 4px 8px rgba(0,0,0,0.05); padding: 10px 30px; position: sticky; top: 0; z-index: 1000; }
        .navbar .search-form input { width: 300px; border-radius: 30px; }
        .card-img-top { height: 180px; object-fit: contain; background-color: #f8f9fa; border-bottom: 1px solid #eee; }
        .badge-rating { background: #ffc107; color: #000; font-weight: 600; border-radius: 20px; padding: 5px 10px; display: inline-block; margin-bottom: 10px; }
        footer { background: #222; color: white; padding: 50px 20px; margin-top: 40px; }
        .footer-section h5 { font-size: 1.3rem; margin-bottom: 15px; }
        .footer-section a { color: #ddd; text-decoration: none; display: block; margin: 6px 0; font-size: 0.95rem; }
        .footer-section a:hover { color: #ff6f61; }
        .footer-social a { color: white; margin-right: 15px; font-size: 1.4rem; }
        .copyright { margin-top: 30px; text-align: center; font-size: 0.9rem; color: #aaa; }
        @media(max-width: 768px) { .sidebar { position: relative; width: 100%; height: auto; } .main-content { margin-left: 0; } .navbar .search-form input { width: 100%; } }
        ::-webkit-scrollbar { width: 5px; height: 4px; }
        ::-webkit-scrollbar-thumb { background-color: #aaa; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: pink; }
        ::-webkit-scrollbar-track { background: transparent; }
        .banner_container{
		    
		}
		.banner_image{
		    width: 100%;
		    
		}
    </style>
</head>
<body>
<%-- 
<div class="sidebar">
    <h4><img src="assets/logo2.png" alt="Logo" style="width: 80px; margin-right: 10px;"> Welcome</h4>
    <div class="profile-box">
        <img src="https://api.dicebear.com/7.x/fun-emoji/svg?seed=<%= session.getAttribute("userName") %>" alt="Profile">
        <p><%= session.getAttribute("userName") %></p>
        <small><%= session.getAttribute("userEmail") %></small>
        <div class="text-end me-4 mt-3">
	    	<a href="jsp/userProfile.jsp" class="btn btn-outline-primary">
		        👤 View Profile
		    </a>
		</div>
    </div>
    
	    
    <div class="category-list">
        <button onclick="filterCategory('All')">🛒 All Items</button>
        <button onclick="filterCategory('Toys')">🧸 Toys & Games</button>
        <button onclick="filterCategory('Clothes')">👕 Baby Care</button>
        <button onclick="filterCategory('School')">🎒 Clothing</button>
        <button onclick="filterCategory('learning')">📚 Books & Learning</button>
        <button onclick="filterCategory('sports')">🏀 Outdoor & Sports</button>
    </div>
</div>
--%>

<div class="main-content">
    <nav class="navbar d-flex justify-content-between align-items-center">
        <img src="assets/logo2.png" alt="Logo" style="width: 80px; margin-right: 10px;">
        <div class="d-flex search-form">
            <input type="text" id="searchInput" class="form-control me-2" placeholder="🔍 Search items...">
        </div>
        <div>
            <a href="jsp/cart.jsp" class="btn btn-outline-dark position-relative me-3">
                🛒 Cart
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    <%= session.getAttribute("cart") != null ? ((List)session.getAttribute("cart")).size() : 0 %>
                </span>
            </a>
            <a href="jsp/viewOrders.jsp" class="btn btn-outline-dark me-3">Your Orders</a>
           <%--  <a href="jsp/logout.jsp" class="btn btn-outline-danger">Logout</a> --%>
            <a href="jsp/userProfile.jsp" class="btn btn-outline-primary">👤</a>
        </div>
    </nav>
    
    <div class="banner_container">
        <img class="banner_image" src="assets/kids-shop-poster2.png" alt="banner_image" />
     </div>
    
    <div class="container-fluid mt-4">
        <div class="row">
            <% for (Product p : products) {
                if (search == null || search.isEmpty() || p.getName().toLowerCase().contains(search.toLowerCase())) {
                    double avgRating = ReviewDAO.getAverageRatingForProduct(p.getId());
                    int reviewCount = ReviewDAO.getReviewCountForProduct(p.getId());
            %>
            <div class="col-md-3 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="<%= p.getImageUrl() %>" class="card-img-top" alt="<%= p.getName() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= p.getName() %></h5>
                        <p class="card-text text-muted">Category: <%= p.getCategory() %></p>
                        <h6 class="text-success">₹ <%= p.getPrice() %></h6>
                        <% if (reviewCount > 0) { %>
                            <div class="badge-rating">⭐ <%= String.format("%.1f", avgRating) %> (<%= reviewCount %> reviews)</div>
                        <% } %>
                        <form method="post" action="CartServlet">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <button type="submit" class="btn btn-sm btn-primary w-100 mb-2">Add to Cart</button>
                        </form>
                        <a href="jsp/productDetails.jsp?id=<%= p.getId() %>" class="btn btn-sm btn-outline-secondary w-100">View Details</a>
                    </div>
                </div>
            </div>
            <% } } %>
        </div>
    </div>
    
    
    <footer>
        <div class="row text-start">
            <div class="col-md-3 footer-section">
                <h5>About <img src="assets/logo2.png" alt="Logo" style="width: 80px; margin-right: 10px;"></h5>
                <p>India's most playful destination for kids' shopping – trusted by parents. Safe, colorful, fun!</p>
            </div>
            <div class="col-md-3 footer-section">
                <h5>Quick Links</h5>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms & Conditions</a>
            </div>
            <div class="col-md-3 footer-section">
                <h5>Help & Support</h5>
                <a href="#">FAQs</a>
                <a href="#">Return Policy</a>
                <a href="#">Shipping Info</a>
                <a href="#">Customer Support</a>
            </div>
            <div class="col-md-3 footer-section">
                <h5>Follow Us</h5>
                <div class="footer-social">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
        </div>
        <div class="copyright">© 2025 KiddyKart. Built with ❤️ for happy childhood memories.</div>
    </footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function filterCategory(category) {
        const cards = document.querySelectorAll('.col-md-3');
        cards.forEach(card => {
            const catText = card.querySelector('.card-text').textContent.toLowerCase();
            card.style.display = category === 'All' || catText.includes(category.toLowerCase()) ? 'block' : 'none';
        });
    }
    document.getElementById('searchInput').addEventListener('input', function () {
        const query = this.value.toLowerCase();
        const cards = document.querySelectorAll('.col-md-3');
        cards.forEach(card => {
            const name = card.querySelector('.card-title').textContent.toLowerCase();
            card.style.display = name.includes(query) ? 'block' : 'none';
        });
    });
</script>
</body>
</html>
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
