<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    int faqid=Integer.parseInt(request.getParameter("faqid"));
    String answer=request.getParameter("answer");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
	st.executeUpdate("UPDATE faq SET faq_answer='"+ answer +"' where faq_id=" + faqid);
    		
    response.sendRedirect("staff_success.jsp");
    %>