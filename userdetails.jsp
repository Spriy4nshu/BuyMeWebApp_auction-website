<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();

	String user_id=request.getParameter("username");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    ResultSet rs;
    ResultSet rs1;
    //String userid=(String)session.getAttribute("user");
    rs=st.executeQuery("select DISTINCT item_id from bid_history where username='" + user_id + "'");
    //rs.next();
	%>
	Auctions the user participated in: <br>
	<%while(rs.next()){%>
		<a href="showitem.jsp?value=<%=rs.getString("item_id") %>"><%=rs.getString("item_id") %></a><br>
	<%} %><br><br>
	<%
	rs=st.executeQuery("select DISTINCT item_id from item where highest_bider='" + user_id + "' AND sold_status='sold'");
    //rs.next();
	%>
	Auctions the user won: <br>
	<%while(rs.next()){%>
		<a href="showitem.jsp?value=<%=rs.getString("item_id") %>"><%=rs.getString("item_id") %></a><br>
	<%} %><br><br>
	<%
	rs=st.executeQuery("select DISTINCT item_id from item where username='" + user_id + "'");
    //rs.next();
	%>
	Auctions the user put up: <br>
	<%while(rs.next()){%>
		<a href="showitem.jsp?value=<%=rs.getString("item_id") %>"><%=rs.getString("item_id") %></a><br>
	<%} %><br><br>
	
	
	
