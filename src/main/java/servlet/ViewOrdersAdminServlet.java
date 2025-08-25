package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;
import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/ViewOrdersAdmin") 
public class ViewOrdersAdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<Map<String, String>> orders = new ArrayList<>();

        try {
        	Connection conn = DBConnection.getConnection();

        	String sql = "SELECT o.*, a.full_name, a.phone, a.street, a.city, a.state, a.pincode " +
        	             "FROM orders o " +
        	             "LEFT JOIN addresses a ON a.id = ( " +
        	             "   SELECT id FROM addresses WHERE user_email = o.user_email ORDER BY id DESC LIMIT 1 " +
        	             ")";

        	Statement stmt = conn.createStatement();
        	ResultSet rs = stmt.executeQuery(sql);


        	while (rs.next()) {
        	    Map<String, String> order = new HashMap<>();
        	    order.put("id", rs.getString("id"));
        	    order.put("user_email", rs.getString("user_email"));
        	    order.put("product_id", rs.getString("product_id"));
        	    order.put("quantity", rs.getString("quantity"));
        	    order.put("order_date", rs.getString("order_date"));
        	    order.put("status", rs.getString("status"));

        	    // Add address fields
        	    order.put("full_name", rs.getString("full_name"));
        	    order.put("phone", rs.getString("phone"));
        	    order.put("street", rs.getString("street"));
        	    order.put("city", rs.getString("city"));
        	    order.put("state", rs.getString("state"));
        	    order.put("pincode", rs.getString("pincode"));

        	    orders.add(order);
        	}

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("jsp/viewOrderbyAdmin.jsp").forward(req, res);
    }
}
//=======
//package servlet;
//
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import dao.DBConnection;
//import java.io.*;
//import java.sql.*;
//import java.util.*;
//
//@WebServlet("/ViewOrdersAdmin") 
//public class ViewOrdersAdminServlet extends HttpServlet {
//    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//        List<Map<String, String>> orders = new ArrayList<>();
//
//        try {
//        	Connection conn = DBConnection.getConnection();
//
//        	String sql = "SELECT o.*, a.full_name, a.phone, a.street, a.city, a.state, a.pincode " +
//        	             "FROM orders o " +
//        	             "LEFT JOIN addresses a ON a.id = ( " +
//        	             "   SELECT id FROM addresses WHERE user_email = o.user_email ORDER BY id DESC LIMIT 1 " +
//        	             ")";
//
//        	Statement stmt = conn.createStatement();
//        	ResultSet rs = stmt.executeQuery(sql);
//
//
//        	while (rs.next()) {
//        	    Map<String, String> order = new HashMap<>();
//        	    order.put("id", rs.getString("id"));
//        	    order.put("user_email", rs.getString("user_email"));
//        	    order.put("product_id", rs.getString("product_id"));
//        	    order.put("quantity", rs.getString("quantity"));
//        	    order.put("order_date", rs.getString("order_date"));
//        	    order.put("status", rs.getString("status"));
//
//        	    // Add address fields
//        	    order.put("full_name", rs.getString("full_name"));
//        	    order.put("phone", rs.getString("phone"));
//        	    order.put("street", rs.getString("street"));
//        	    order.put("city", rs.getString("city"));
//        	    order.put("state", rs.getString("state"));
//        	    order.put("pincode", rs.getString("pincode"));
//
//        	    orders.add(order);
//        	}
//
//            conn.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        req.setAttribute("orders", orders);
//        req.getRequestDispatcher("jsp/viewOrderbyAdmin.jsp").forward(req, res);
//    }
//}