
package servlet;


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;
import dao.ProductDAO;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/ViewCustomers") 
public class ViewCustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<Map<String, String>> customers = new ArrayList<>();
        String action = req.getParameter("action");

        try {
        	Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE role='customer'");

            while (rs.next()) {
                Map<String, String> customer = new HashMap<>();
                customer.put("id", rs.getString("id"));
                customer.put("name", rs.getString("name"));
                customer.put("email", rs.getString("email"));
//                customer.put("phone", rs.getString("phone"));
                customers.add(customer);
            }
            
            if ("delete".equalsIgnoreCase(action)) {
        		String sql = "DELETE FROM users WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(req.getParameter("id")));
                
                ps.executeUpdate();
        	}

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("customers", customers);
        req.getRequestDispatcher("jsp/viewCustomers.jsp").forward(req, res);
    }
}
//=======
//package servlet;
//
//
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import dao.DBConnection;
//import dao.ProductDAO;
//
//import java.io.IOException;
//import java.sql.*;
//import java.util.*;
//
//@WebServlet("/ViewCustomers") 
//public class ViewCustomerServlet extends HttpServlet {
//    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//        List<Map<String, String>> customers = new ArrayList<>();
//        String action = req.getParameter("action");
//
//        try {
//        	Connection conn = DBConnection.getConnection();
//            Statement stmt = conn.createStatement();
//            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE role='customer'");
//
//            while (rs.next()) {
//                Map<String, String> customer = new HashMap<>();
//                customer.put("id", rs.getString("id"));
//                customer.put("name", rs.getString("name"));
//                customer.put("email", rs.getString("email"));
////                customer.put("phone", rs.getString("phone"));
//                customers.add(customer);
//            }
//            
//            if ("delete".equalsIgnoreCase(action)) {
//        		String sql = "DELETE FROM users WHERE id = ?";
//                PreparedStatement ps = conn.prepareStatement(sql);
//                ps.setInt(1, Integer.parseInt(req.getParameter("id")));
//                
//                ps.executeUpdate();
//        	}
//
//            conn.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        req.setAttribute("customers", customers);
//        req.getRequestDispatcher("jsp/viewCustomers.jsp").forward(req, res);
//    }