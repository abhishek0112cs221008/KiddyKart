
package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;

@WebServlet("/WriteReview")
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String productId = req.getParameter("productId");
        String rating = req.getParameter("rating");
        String comment = req.getParameter("comment");
        String userName = req.getParameter("userName");

        HttpSession session = req.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        // Validate required parameters
        if (productId == null || productId.isEmpty() || rating == null || rating.isEmpty()) {
            session.setAttribute("reviewMsg", "❌ Error: Product ID or rating is missing.");
            res.sendRedirect(req.getContextPath() + "/jsp/productDetails.jsp?id=" + productId);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            int newId = 1;
            
            // Statement 1: Get the next available ID
            String selectSql = "SELECT MAX(id) FROM reviews";
            try (PreparedStatement selectPs = con.prepareStatement(selectSql);
                 ResultSet rs = selectPs.executeQuery()) {
                if (rs.next()) {
                    newId = rs.getInt(1) + 1;
                }
            }
            
            // Statement 2: Insert the new review
            String insertSql = "INSERT INTO reviews (id, product_id, user_email, user_name, rating, comment, review_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                
                Date currentDate = new Date(System.currentTimeMillis());
                
                insertPs.setInt(1, newId);
                insertPs.setInt(2, Integer.parseInt(productId));
                insertPs.setString(3, userEmail);
                insertPs.setString(4, userName);
                insertPs.setInt(5, Integer.parseInt(rating));
                insertPs.setString(6, comment);
                insertPs.setDate(7, currentDate);

                int rowsAffected = insertPs.executeUpdate();

                if (rowsAffected > 0) {
                    session.setAttribute("reviewMsg", "✅ Review submitted successfully!");
                } else {
                    session.setAttribute("reviewMsg", "⚠️ Failed to submit review.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("reviewMsg", "❌ Database Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("reviewMsg", "❌ General Error: " + e.getMessage());
        }
        
        // Redirect back to the product page with the new message
        res.sendRedirect(req.getContextPath() + "/jsp/productDetails.jsp?id=" + productId);
    }
}
//=======
//// ✅ ReviewServlet.java - corrected
//package servlet;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.Date;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import dao.DBConnection;
//
//@WebServlet("/WriteReview")
//public class ReviewServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//
//        String productId = req.getParameter("productId");
//        String rating = req.getParameter("rating");
//        String comment = req.getParameter("comment");
//        String userName = req.getParameter("userName");
//
//        HttpSession session = req.getSession();
//        String userEmail = (String) session.getAttribute("userEmail");
//
//        try {
//            Connection con = DBConnection.getConnection();
//            String sql = "INSERT INTO reviews (id, product_id, user_email, user_name, rating, comment,review_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
//
//            PreparedStatement ps = con.prepareStatement(sql);
//            
//            int newId = 1;
//        	ResultSet rs = ps.executeQuery("SELECT MAX(id) FROM reviews");
//        	if(rs.next()) {
//        		newId = rs.getInt(1) + 1;
//        	}
//        	Date currentdate = new Date(System.currentTimeMillis());
//        	
//        	ps.setInt(1, newId);
//            ps.setInt(2, Integer.parseInt(productId));
//            ps.setString(3, userEmail);
//            ps.setString(4, userName);
//            ps.setInt(5, Integer.parseInt(rating));
//            ps.setString(6, comment);
//            ps.setDate(7, currentdate);
//
//            int rows = ps.executeUpdate();
//            con.close();
//
//            if (rows > 0) {
//                session.setAttribute("reviewMsg", "✅ Review submitted successfully!");
//            } else {
//                session.setAttribute("reviewMsg", "⚠️ Failed to submit review.");
//            }
//            
//
//
//            res.sendRedirect(req.getContextPath() + "/jsp/productDetails.jsp?productId=" + productId);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            session.setAttribute("reviewMsg", "❌ Error: " + e.getMessage());
//        }
//    }
//}