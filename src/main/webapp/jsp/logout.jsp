<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Destroy the session completely
    session.invalidate();

    // Redirect to login page or home
    response.sendRedirect("login.jsp"); // Or index.html if that's your entry point
%>
