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
    
    Add Customer Representative <br>
   <form action="addtouser.jsp?value=staff" method="POST">
	Username:<input type="text" name="username" required> <br/>
	Password:<input type="password" name="password" required> <br/>
	email:<input type="email" name="email" required/> <br/>
	Phone Number:<input type="text" name="phone" required> <br/>
	<input type="text" name="acc" value="" readonly hidden>
	<input type="submit" value="Submit"/><br/>
	</form>
    
    <br>
    REPORTS<br>

    <% 
    String userid=(String)session.getAttribute("user");
    String flag=request.getParameter("value");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    ResultSet rs;
    ResultSet rs1;
    rs=st.executeQuery("SELECT SUM(start_bid) as earning FROM item WHERE sold_status = 'sold';");
    rs.next();
    %>
    Total earnings : <%=rs.getString("earning")%>
    <br><br>
    
    <% 
    rs=st.executeQuery("SELECT highest_bider, SUM(start_bid) AS total FROM item WHERE sold_status = 'sold' GROUP BY highest_bider ORDER BY total DESC LIMIT 1;");
    rs.next();
    %>
    
    Best Customer based on money spent : <%=rs.getString("highest_bider")%>(<%=rs.getString("total")%> dollar spent)
    <br>
    
    
    <% 
    rs=st.executeQuery("SELECT username, COUNT(username) AS count FROM bid_history GROUP BY username ORDER BY count DESC LIMIT 1;");	
    rs.next();
    %>
    
    Best Customer based on participation : <%=rs.getString("username")%>(<%=rs.getString("count")%> bids)
    <br><br>
    
    
    
    <% 
    rs=st.executeQuery("SELECT * FROM item WHERE sold_status = 'sold' ORDER BY start_bid DESC LIMIT 1;");
    rs.next();
    %>
    
    Best selling item based on money spent : <%=rs.getString("item_name")%>(<%=rs.getString("start_bid")%> dollar cost)
    <br>
    
    
    <% 
    rs=st.executeQuery("SELECT item_id, COUNT(item_id) AS count FROM bid_history GROUP BY item_id ORDER BY count DESC LIMIT 1;");	
    rs.next();
    %>
    
    Best item based on demand : <a href="showitem.jsp?value=<%=rs.getString("item_id") %>"><%=rs.getString("item_id") %></a>(<%=rs.getString("count")%> bids)
    <br><br>
    
    
    
    <br><br>
	Earning per Item
	<form action="admin_success.jsp?value=item" method="POST">
   	Item ID<input type="text" name="iid" required>
	<input type="submit" value="Submit"/>
	</form>
    <%
    if(flag.equals("item")){
    	String item_id=request.getParameter("iid");
    	rs=st.executeQuery("SELECT start_bid FROM item WHERE sold_status = 'sold' AND item_id='"+item_id+"'");
    	if(rs.next()){
    %>
   Total earnings from this Item : <%=rs.getString("start_bid")%> Dollar
    <%} 
   else{%>
	  This Item is still in auction or went Unsold
    <%}}%>
    
    
    
    
    <br><br>
	Earning per Customer
	<form action="admin_success.jsp?value=user" method="POST">
   	Customer Username<input type="text" name="username" required>
	<input type="submit" value="Submit"/>
	</form>
    <%
    if(flag.equals("user")){
    	String user_id=request.getParameter("username");
    	rs=st.executeQuery("SELECT SUM(start_bid) AS total FROM item WHERE sold_status = 'sold' AND highest_bider='"+user_id+"' GROUP BY highest_bider");
    	if(rs.next()){
    %>
   Total earnings from this customer : <%=rs.getString("total")%> Dollar
    <%} 
   else{%>
	  No earning from this customer
    <%}}%>
   
   
   
      <br><br>
	Earning per Category
	<form action="admin_success.jsp?value=cat" method="POST">
   	Category
   	<select name="cate">
    <option value="Mobile">Mobile</option>
    <option value="Laptop">Laptop</option>
    <option value="Tabet">Tablet</option>
    <option value="SmartWatch">SmartWatch</option>
  </select>
	<input type="submit" value="Submit"/>
	</form>
    <%
    if(flag.equals("cat")){
    	String cat=request.getParameter("cate");
    	rs=st.executeQuery("SELECT SUM(start_bid) AS total FROM item INNER JOIN category ON item.item_id = category.item_id WHERE sold_status = 'sold' AND subcategory='"+cat+"' GROUP BY subcategory");
        if(rs.next()){
    %>
   Total earnings for this category : <%=rs.getString("total")%> Dollar
   <%} 
   else{%>
	  No earning for this category
    <%}}%>
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
    <% } %>