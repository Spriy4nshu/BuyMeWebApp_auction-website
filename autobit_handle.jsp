<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String item_id=request.getParameter("value");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    String userid=(String)session.getAttribute("user");
    rs=st.executeQuery("select * from report where username='" + userid + "' and item_id='" + item_id + "'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
%>
	SET Autobid
	<form action="addtoautobid.jsp" method="POST">
	Item ID:<input type="text" name="item_name"  value=<%=item_id%> readonly> <br/>
	Auto Bid Limit:<input type="number" name="bidlimit"> <br/>
	<input type="submit" value="Submit"/><br/>
	</form>
