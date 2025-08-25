package servlet;

import dao.CartItemDAO;
import dao.OrderDAO;
import dao.UserDAO;
import dao.ProductDAO;
import model.CartItem;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

/**
 * Handles all cart-related actions (add, remove, update) for both logged-in users and guests.
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private static final String AJAX_HEADER = "X-Requested-With";
    private static final String XML_HTTP_REQUEST = "XMLHttpRequest";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String referer = req.getHeader("referer");
        HttpSession session = req.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        String productIdStr = req.getParameter("productId");
        
        // Determine if it's an AJAX request
        boolean isAjaxRequest = XML_HTTP_REQUEST.equals(req.getHeader(AJAX_HEADER));

        // Set response content type for JSON
        if (isAjaxRequest) {
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
        }

        try {
            if (productIdStr == null || action == null) {
                if (isAjaxRequest) {
                    res.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid request. Missing parameters.\"}");
                } else {
                    session.setAttribute("message", "Invalid request. Missing parameters.");
                    res.sendRedirect(referer != null ? referer : "HomeServlet");
                }
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            
            // Get product once, as it's needed for both user types
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                 if (isAjaxRequest) {
                    res.getWriter().write("{\"status\":\"error\", \"message\":\"Product not found.\"}");
                } else {
                    session.setAttribute("message", "Product not found.");
                    res.sendRedirect(referer != null ? referer : "HomeServlet");
                }
                return;
            }

            int quantity = 1;
            if ("update".equals(action)) {
                String qtyStr = req.getParameter("quantity");
                if (qtyStr != null) {
                    quantity = Integer.parseInt(qtyStr);
                    if (quantity < 1) {
                        quantity = 1;
                    }
                }
            }
            // --- START: MEMBERSHIP CHECK ---
            if (userEmail != null) {
                int totalItemsPurchased = OrderDAO.getTotalItemsPurchased(userEmail);
                if (totalItemsPurchased >= 10) {
                    UserDAO.updateMembershipStatus(userEmail, true);
                    session.setAttribute("isMember", true);
                } else {
                     session.setAttribute("isMember", false);
                }
            }
            // --- END: MEMBERSHIP CHECK ---

            if (userEmail != null) {
                handleLoggedInUserCart(userEmail, productId, quantity, action, session);
            } else {
                handleGuestUserCart(product, productId, quantity, action, session);
            }
            
            // Final Response
            List<CartItem> updatedCart = (List<CartItem>) session.getAttribute("cart");
            int cartSize = updatedCart != null ? updatedCart.size() : 0;
            
            if (isAjaxRequest) {
                res.getWriter().write(String.format("{\"status\":\"success\", \"message\":\"Cart updated successfully!\", \"cartSize\":%d}", cartSize));
            } else {
                res.sendRedirect(referer != null ? referer : "HomeServlet");
            }

        } catch (NumberFormatException e) {
            if (isAjaxRequest) {
                res.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid product ID or quantity format.\"}");
            } else {
                session.setAttribute("message", "Invalid product ID or quantity format.");
                res.sendRedirect(referer != null ? referer : "HomeServlet");
            }
        }
    }

    private void handleLoggedInUserCart(String userEmail, int productId, int quantity, String action, HttpSession session) {
        if ("add".equals(action)) {
            CartItemDAO.addOrUpdateCartItem(userEmail, productId, 1);
        } else if ("remove".equals(action)) {
            CartItemDAO.removeCartItem(userEmail, productId);
        } else if ("update".equals(action)) {
            CartItemDAO.updateCartItem(userEmail, productId, quantity);
        }
        
        List<CartItem> cart = CartItemDAO.getCartItemsByUserEmail(userEmail);
        session.setAttribute("cart", cart);
    }

    private void handleGuestUserCart(Product product, int productId, int quantity, String action, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if ("add".equals(action)) {
            boolean exists = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                cart.add(new CartItem(product, 1));
            }
        } else if ("remove".equals(action)) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
        } else if ("update".equals(action)) {
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        }

        session.setAttribute("cart", cart);
    }
}