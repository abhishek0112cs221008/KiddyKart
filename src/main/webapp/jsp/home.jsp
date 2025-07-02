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
        .main-content { margin-left: 270px; padding: 20px; }
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
    </style>
</head>
<body>
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
            <a href="jsp/logout.jsp" class="btn btn-outline-danger">Logout</a>
        </div>
    </nav>
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