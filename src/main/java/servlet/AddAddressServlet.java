package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;

@WebServlet("/AddAddressServlet")
public class AddAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        try (Connection conn = DBConnection.getConnection()) {
            // Get max ID
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT MAX(id) FROM addresses");
            int newId = 1;
            if (rs.next()) {
                newId = rs.getInt(1) + 1;
            }

            String sql = "INSERT INTO addresses (id, user_email, full_name, phone, street, city, state, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newId);
            ps.setString(2, userEmail);
            ps.setString(3, fullName);
            ps.setString(4, phone);
            ps.setString(5, street);
            ps.setString(6, city);
            ps.setString(7, state);
            ps.setString(8, pincode);

            ps.executeUpdate();
            response.sendRedirect("jsp/userProfile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
//=======
//package servlet;
//
//import java.io.IOException;
//import java.sql.*;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import dao.DBConnection;
//
//@WebServlet("/AddAddressServlet")
//public class AddAddressServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String userEmail = (String) request.getSession().getAttribute("userEmail");
//
//        String fullName = request.getParameter("fullName");
//        String phone = request.getParameter("phone");
//        String street = request.getParameter("street");
//        String city = request.getParameter("city");
//        String state = request.getParameter("state");
//        String pincode = request.getParameter("pincode");
//
//        try (Connection conn = DBConnection.getConnection()) {
//            // Get max ID
//            Statement st = conn.createStatement();
//            ResultSet rs = st.executeQuery("SELECT MAX(id) FROM addresses");
//            int newId = 1;
//            if (rs.next()) {
//                newId = rs.getInt(1) + 1;
//            }
//
//            String sql = "INSERT INTO addresses (id, user_email, full_name, phone, street, city, state, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setInt(1, newId);
//            ps.setString(2, userEmail);
//            ps.setString(3, fullName);
//            ps.setString(4, phone);
//            ps.setString(5, street);
//            ps.setString(6, city);
//            ps.setString(7, state);
//            ps.setString(8, pincode);
//
//            ps.executeUpdate();
//            response.sendRedirect("jsp/userProfile.jsp");
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}