<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String item_id=request.getParameter("itemid");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    String userid=(String)session.getAttribute("user");

    st.executeUpdate("DELETE FROM item WHERE item_id='"+ item_id + "'");
    st.executeUpdate("DELETE FROM report WHERE item_id='"+ item_id + "'");
	response.sendRedirect("staff_success.jsp");
%>

