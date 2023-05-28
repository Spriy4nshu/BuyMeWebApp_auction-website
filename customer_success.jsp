<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ page import="java.sql.*" %>


<% if ((session.getAttribute("user")==null)) { %>
    You are not logged in<br />
    <a href="login.jsp">Please Login</a>
<%} else { %>
    Welcome <%=session.getAttribute("user")%> with <%=session.getAttribute("role")%> role.
    <a href='logout.jsp'>Log out</a><br><br>
    What would you like to do?<br><br>
    
    <button type="button" onclick="location.href='wishlist.jsp'">Manage Wishlist</button>
    <button type="button" onclick="location.href='sell_form.jsp'">Sell Items</button>
    <button type="button" onclick="location.href='browse_buy.jsp?value=nofilter'">Buy Items</button><br><br>
    
    Get User Details:
    <form action="userdetails.jsp" method="POST">
   	<input type="text" name="username" required>
	<input type="submit" value="Submit"/><br/>
	</form>
    <br><br>
    

    <p style="color:red">ALERTS !!</p>
    <% 
    String userid=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from alerts where username='" +userid+"'");
    int sno=1;
    while(rs.next()){%>
    	<%=sno%>.)  <%=rs.getString("alert_comment") %> <br>
    	<% sno=sno+1;
    }
    if (sno==1){%>
    	No pending Alerts
    <% }%>
	<br><br>
	
    <button type="button" onclick="location.href='faq_display.jsp?value=all'">FAQ</button><br>
   
    
    <% } %>