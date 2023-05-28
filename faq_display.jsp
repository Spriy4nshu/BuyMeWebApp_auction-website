<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ page import="java.sql.*" %>
<style>
table, th, td {
  border: 1px solid black;
  text-align: center;
}
</style>
<% if ((session.getAttribute("user")==null)) { %>
    You are not logged in<br />
    <a href="login.jsp">Please Login</a>
<%} else { %>
	<a href='logout.jsp'>Log out</a><br><br>

	<form action="faq_display.jsp?value=specific" method="POST">
	Search:<input type="text" name="keyword"/>
	<input type="submit" value="Submit"/><br/>
	</form>


    <% //HttpSession session = request.getSession();
    String key=request.getParameter("value");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    
    if(key.equals("all")){
    	rs=st.executeQuery("select * from faq");
    }
    else{
    	String keyword=request.getParameter("keyword");
    	rs=st.executeQuery("select * from faq where faq_question LIKE '%" + keyword + "%'");
    }
    
    %>
    <table style="width:100%">
    <tr>
      <th>QUESTION</th>
      <th>ANSWER</th>
    </tr>
    
    <%
	while(rs.next())
        {
            %>
            <tr>
                <td><%=rs.getString("faq_question") %></td>
                <td><%=rs.getString("faq_answer") %></td>
  
            </tr>
            <%}%>
            </table><br><br><br>
	What is your query?
		<form action="addtofaq.jsp" method="POST">
		<textarea name="ques" rows="4" cols="150">Your Question here</textarea><br/>
		<input type="submit" value="Submit"/><br/>
		</form>
	<br>
	<button type="button" onclick="location.href='customer_success.jsp'">BACK</button><br>
    <%} %>