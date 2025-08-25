package dao;

import java.sql.*;

public class OrderDAO {
    public static int getOrderCountByUserEmail(String userEmail) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS orderCount FROM orders WHERE user_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("orderCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    /**
     * Calculates the total number of items purchased by a user across all their orders.
     *
     * @param userEmail The email of the user.
     * @return The sum of all quantities from the user's orders, or 0 if no orders are found.
     */
    public static int getTotalItemsPurchased(String userEmail) {
        String sql = "SELECT SUM(quantity) FROM orders WHERE user_email = ?";
        int totalItems = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userEmail);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalItems = rs.getInt(1); // SUM will be 0 if no rows are found
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalItems;
    }
}
