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
    FAQs to handle<br>
    <% 
    String userid=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("SELECT * FROM faq JOIN users ON faq.username = users.username WHERE users.managed_by ='" + userid + "' and faq_answer ='UNANSWERED'");
	int sno=1;
    while(rs.next()){%>
    	<%=sno%>.)  <%=rs.getString("faq_question") %> 
    	
    	<form action="faq_handle.jsp" method="POST">
    	<input type="text" name="faqid"  value=<%=rs.getString("faq_id")%> readonly> <br/>
		<textarea name="answer" rows="4" cols="50">Your Answer Here</textarea><br/>
		<input type="submit" value="Submit"/><br/>
		</form>
    	
    	<% sno=sno+1;
    }
    if (sno==1){%>
    	No pending FAQ
    <% }%>
	<br><br>
	Manage your customer
	<form action="edit_cust.jsp?value=edit" method="POST">
   	Customer Username<input type="text" name="username">
	<input type="submit" value="Submit"/><br/>
	</form>
    <br><br>
    
    Reports to handle<br>
    <%rs=st.executeQuery("SELECT * FROM report JOIN users ON report.username = users.username WHERE users.managed_by ='" + userid + "' and status ='Pending'");
	int sno1=1;
    while(rs.next()){%>
    	<%=sno1%>.)  <%=rs.getString("report_comment") %> 
    	<form action="itemdelete.jsp" method="POST">
		For item:<input type="text" name="itemid"  value=<%=rs.getString("item_id")%> readonly> 
		<input type="submit" value="Delete Item"/><br/>
		</form>
    	
    	
    	<% sno1=sno1+1;
    }
    if (sno1==1){%>
    	No pending reports
    <% }%>
   
   <br><br>
	Manage Bids(remove a customer from an auction)
	<form action="bidremove.jsp" method="POST">
   	Customer Username<input type="text" name="username">
   	For item:<input type="text" name="itemid">
	<input type="submit" value="Submit"/><br/>
	</form>
    <br><br>
   
   
   
   
   
   
   

    
    <% } %>