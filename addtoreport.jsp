<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <%
    String itemid=request.getParameter("item_name");
    String Description=request.getParameter("reason");
    String userid=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
	st.executeUpdate("INSERT INTO report VALUES ('" +itemid+ "','" + userid +  "','" + Description + "',DEFAULT);");
	out.println("Report successful <a href='browse_buy.jsp?value=nofilter'>Back</a>");
    %>