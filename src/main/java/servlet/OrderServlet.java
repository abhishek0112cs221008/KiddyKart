package servlet;

import model.CartItem;
//import model.EmailUtil;
import dao.DBConnection;
import dao.OrderDAO;
import dao.UserDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import java.util.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            updateOrderStatus(req, res);
        } else {
            insertOrderFromCart(req, res);
        }
        
        
    }

    // -------------------------------------------
    // ✅ Admin: Update Order Status
    // -------------------------------------------
    private void updateOrderStatus(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String newStatus = req.getParameter("status");

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("UPDATE orders SET status=? WHERE id=?");
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            ps.executeUpdate();
            
            
         // Get user email for the order
//            String userEmail = "";
//            PreparedStatement psEmail = conn.prepareStatement("SELECT user_email FROM orders WHERE id=?");
//            psEmail.setInt(1, orderId);
//            ResultSet rs = psEmail.executeQuery();
//            if (rs.next()) {
//                userEmail = rs.getString("user_email");
//            }
//         // Send status update email
//            if (!userEmail.isEmpty()) {
//                String subject = "Your Order #" + orderId + " Status Updated!";
//                String body = "Hello,\n\nYour QuickKartKids order #" + orderId + " status has been updated to: " + newStatus +
//                        ".\n\nThank you for shopping with us!\nQuickKartKids Team";
//                EmailUtil.sendEmail(userEmail, subject, body);
//            }
            conn.close();

            res.sendRedirect("ViewOrdersAdmin"); // Refresh order table
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("ViewOrdersAdmin?error=1");
        }
    }

    // -------------------------------------------
    // ✅ User: Place Order from Cart
    // -------------------------------------------
    private void insertOrderFromCart(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        String paymentId = req.getParameter("paymentId");

        if (userEmail == null || cart == null || cart.isEmpty()) {
            res.sendRedirect("jsp/viewProducts.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // Get next ID
            int nextId = 1;
            PreparedStatement psId = conn.prepareStatement("SELECT MAX(id) FROM orders");
            ResultSet rsId = psId.executeQuery();
            if (rsId.next()) {
                nextId = rsId.getInt(1) + 1;
            }

            // Insert order
            String sql = "INSERT INTO orders (id, user_email, product_id, quantity, order_date, payment_id, status) VALUES (?, ?, ?, ?, ?, ?, 'Pending')";
            PreparedStatement ps = conn.prepareStatement(sql);
            Date currentDate = new Date(System.currentTimeMillis());
            
            

            for (CartItem item : cart) {
                ps.setInt(1, nextId++);
                ps.setString(2, userEmail);
                ps.setInt(3, item.getProduct().getId());
                ps.setInt(4, item.getQuantity());
                ps.setDate(5, currentDate);
                ps.setString(6, paymentId);
                ps.addBatch();
                
                PreparedStatement psUpdateQty = conn.prepareStatement(
                    "UPDATE products SET quantity = quantity - ? WHERE id = ?"
                );
                psUpdateQty.setInt(1, item.getQuantity());
                psUpdateQty.setInt(2, item.getProduct().getId());
                psUpdateQty.executeUpdate();
                psUpdateQty.close();
            }

            ps.executeBatch();
            session.removeAttribute("cart"); // clear cart
//            String subject = "🎉 Order Placed Successfully - QuickKartKids";
//            String body = "Dear User,\n\nYour order has been placed successfully! We have received your payment (" + paymentId + ")." +
//                    "\nYour items will be shipped soon.\n\nThank you for shopping with QuickKartKids!";
//            EmailUtil.sendEmail(userEmail, subject, body);
            
         // --- START: MEMBERSHIP CARD FUNCTIONALITY ---
            // Assuming your OrderDAO has a method to count total items
            int totalItemsPurchased = OrderDAO.getTotalItemsPurchased(userEmail);
            
            // Assuming your UserDAO has a method to update membership status
            if (totalItemsPurchased >= 10) {
                UserDAO.updateMembershipStatus(userEmail, true);
                session.setAttribute("isMember", true);
                session.setAttribute("membershipMessage", " Congratulations! You are now a KiddyKart Member!");
            } else {
                 session.setAttribute("isMember", false);
            }
            // --- END: MEMBERSHIP CARD FUNCTIONALITY ---
            
            
            res.sendRedirect("jsp/orderSuccess.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("jsp/viewCart.jsp?error=1");
        }
    }
}
