package dao;

import model.CartItem;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO {

    // Add or update cart item
    public static void addOrUpdateCartItem(String userEmail, int productId, int quantity) {
        try (Connection conn = DBConnection.getConnection()) {
            // Check if item exists
            String checkSql = "SELECT quantity FROM cart_items WHERE user_email = ? AND product_id = ?";
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setString(1, userEmail);
                psCheck.setInt(2, productId);
                ResultSet rs = psCheck.executeQuery();
                if (rs.next()) {
                    // Update quantity
                    int existingQty = rs.getInt("quantity");
                    int newQty = existingQty + quantity; // Add to existing quantity
                    String updateSql = "UPDATE cart_items SET quantity = ? WHERE user_email = ? AND product_id = ?";
                    try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                        psUpdate.setInt(1, newQty);
                        psUpdate.setString(2, userEmail);
                        psUpdate.setInt(3, productId);
                        psUpdate.executeUpdate();
                    }
                } else {
                    // Insert new
                    String insertSql = "INSERT INTO cart_items (user_email, product_id, quantity) VALUES (?, ?, ?)";
                    try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                        psInsert.setString(1, userEmail);
                        psInsert.setInt(2, productId);
                        psInsert.setInt(3, quantity);
                        psInsert.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update quantity explicitly
    public static void updateCartItem(String userEmail, int productId, int quantity) {
        try (Connection conn = DBConnection.getConnection()) {
            String updateSql = "UPDATE cart_items SET quantity = ? WHERE user_email = ? AND product_id = ?";
            try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                psUpdate.setInt(1, quantity);
                psUpdate.setString(2, userEmail);
                psUpdate.setInt(3, productId);
                psUpdate.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Remove item from cart
    public static void removeCartItem(String userEmail, int productId) {
        try (Connection conn = DBConnection.getConnection()) {
            String deleteSql = "DELETE FROM cart_items WHERE user_email = ? AND product_id = ?";
            try (PreparedStatement psDelete = conn.prepareStatement(deleteSql)) {
                psDelete.setString(1, userEmail);
                psDelete.setInt(2, productId);
                psDelete.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Fetch all cart items for a user
    public static List<CartItem> getCartItemsByUserEmail(String userEmail) {
        List<CartItem> cart = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT ci.product_id, ci.quantity, p.name, p.category, p.price, p.quantity as stockQty, p.image_url, p.description "
                       + "FROM cart_items ci JOIN products p ON ci.product_id = p.id WHERE ci.user_email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setCategory(rs.getString("category"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("stockQty"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setDescription(rs.getString("description"));

                    int quantity = rs.getInt("quantity");
                    CartItem item = new CartItem(product, quantity);
                    cart.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    // Clear cart after order completion (optional)
    public static void clearCart(String userEmail) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM cart_items WHERE user_email = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, userEmail);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
