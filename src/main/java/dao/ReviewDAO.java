package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Review;

public class ReviewDAO {

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT user_name, rating, comment, review_date FROM reviews WHERE product_id = ? ORDER BY review_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setUserName(rs.getString("user_name"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setReviewDate(rs.getTimestamp("review_date"));

                reviews.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reviews;
    }
    
    public static double getAverageRatingForProduct(int productId) {
        double avg = 0.0;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT AVG(rating) FROM reviews WHERE product_id = ?");
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                avg = rs.getDouble(1);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return avg;
    }

    public static int getReviewCountForProduct(int productId) {
        int count = 0;
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM reviews WHERE product_id = ?");
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
