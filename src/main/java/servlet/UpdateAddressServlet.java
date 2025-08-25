
package servlet;

import dao.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/UpdateAddressServlet")
public class UpdateAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE addresses SET full_name=?, phone=?, street=?, city=?, state=?, pincode=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, street);
            ps.setString(4, city);
            ps.setString(5, state);
            ps.setString(6, pincode);
            ps.setInt(7, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("jsp/userProfile.jsp");
    }
}
//=======
//package servlet;
//
//import dao.DBConnection;
//
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//
//@WebServlet("/UpdateAddressServlet")
//public class UpdateAddressServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        String fullName = request.getParameter("fullName");
//        String phone = request.getParameter("phone");
//        String street = request.getParameter("street");
//        String city = request.getParameter("city");
//        String state = request.getParameter("state");
//        String pincode = request.getParameter("pincode");
//
//        try (Connection conn = DBConnection.getConnection()) {
//            String sql = "UPDATE addresses SET full_name=?, phone=?, street=?, city=?, state=?, pincode=? WHERE id=?";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, fullName);
//            ps.setString(2, phone);
//            ps.setString(3, street);
//            ps.setString(4, city);
//            ps.setString(5, state);
//            ps.setString(6, pincode);
//            ps.setInt(7, id);
//            ps.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        response.sendRedirect("jsp/userProfile.jsp");
//    }
//}