<%--
  Created by IntelliJ IDEA.
  User: learn
  Date: 5/4/2025
  Time: 6:59 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%
    session.invalidate();  // Ends the user session
    response.sendRedirect("index.jsp");  // Redirects to homepage
%>

