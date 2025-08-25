<%@ page import="java.sql.*, dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM addresses WHERE id = ? AND user_email = ?");
        ps.setInt(1, id);
        ps.setString(2, userEmail);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }

    response.sendRedirect("userProfile.jsp");
%>