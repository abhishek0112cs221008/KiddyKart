package servlet;

import java.sql.Connection;

import javax.servlet.http.HttpServlet;

import dao.DBConnection;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AdminServlet") 
public class AdminServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalProducts = 0, totalCustomers = 0, totalOrders = 0, pendingOrders = 0;

        try {
            
            Connection conn = DBConnection.getConnection();

            Statement stmt = conn.createStatement();

            ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM products");
            if (rs1.next()) totalProducts = rs1.getInt(1);

            ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role = 'customer'");
            if (rs2.next()) totalCustomers = rs2.getInt(1);

            ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM orders");
            if (rs3.next()) totalOrders = rs3.getInt(1);

            ResultSet rs4 = stmt.executeQuery("SELECT COUNT(*) FROM orders WHERE status = 'pending'");
            if (rs4.next()) pendingOrders = rs4.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);

        RequestDispatcher rd = request.getRequestDispatcher("jsp/admin.jsp");
        rd.forward(request, response);
    }
}

//=======
//package servlet;
//
//import java.sql.Connection;
//
//import javax.servlet.http.HttpServlet;
//
//import dao.DBConnection;
//
//import java.io.*;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.sql.*;
//
//@WebServlet("/AdminServlet") 
//public class AdminServlet extends HttpServlet {
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int totalProducts = 0, totalCustomers = 0, totalOrders = 0, pendingOrders = 0;
//
//        try {
//            
//            Connection conn = DBConnection.getConnection();
//
//            Statement stmt = conn.createStatement();
//
//            ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM products");
//            if (rs1.next()) totalProducts = rs1.getInt(1);
//
//            ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role = 'customer'");
//            if (rs2.next()) totalCustomers = rs2.getInt(1);
//
//            ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM orders");
//            if (rs3.next()) totalOrders = rs3.getInt(1);
//
//            ResultSet rs4 = stmt.executeQuery("SELECT COUNT(*) FROM orders WHERE status = 'pending'");
//            if (rs4.next()) pendingOrders = rs4.getInt(1);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        request.setAttribute("totalProducts", totalProducts);
//        request.setAttribute("totalCustomers", totalCustomers);
//        request.setAttribute("totalOrders", totalOrders);
//        request.setAttribute("pendingOrders", pendingOrders);
//
//        RequestDispatcher rd = request.getRequestDispatcher("jsp/admin.jsp");
//        rd.forward(request, response);
//    }
//}
