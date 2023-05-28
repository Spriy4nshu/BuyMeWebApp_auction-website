<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<% if ((session.getAttribute("user")==null)) { %>
    You are not logged in<br />
    <a href="login.jsp">Please Login</a>
<%} else { %>
    Welcome <%=session.getAttribute("user")%> with <%=session.getAttribute("role")%> role.
    <a href='logout.jsp'>Log out</a>
    <% } %>