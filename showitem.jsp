<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<style>
table, th, td {
  border: 1px solid black;
  text-align: center;
}
</style>
<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String item_id=request.getParameter("value");
	String custid=request.getParameter("username");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    ResultSet rs;
    ResultSet rs1;
    String userid=(String)session.getAttribute("user");
    rs=st.executeQuery("select * from item where item_id='" + item_id + "'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
    rs.next();
    rs1=st1.executeQuery("select * from category where item_id='" + item_id + "'");
    rs1.next();
    String brand=rs1.getString("brand");
    String cat=rs1.getString("subcategory");
	%>
	<u><b>Item Details</b></u>: <br>
	<b>Item Name:</b><%=rs.getString("item_name")%> <br/>
	<b>Item Description:</b><%=rs.getString("item_description")%> <br/>
	<b>End Date and Time:</b><%=rs.getString("up_time")%> <br/>
	<b>Seller:</b><%=rs.getString("username")%> <br/>
	<b>Current Price:</b><%=rs.getString("start_bid")%> <br/>
	<b>Bid Increment Amount:</b><%=rs.getString("increase_bid")%> <br/>
	<b>Highest Bider:</b><%=rs.getString("highest_bider")%> <br/><br><br>
	<u><b>Category:</b></u><br>
	<b>Item Type:</b><%=rs1.getString("subcategory")%> <br/>
	<b>Brand:</b><%=rs1.getString("brand")%> <br/>
	<b>RAM:</b><%=rs1.getString("ram")%> <br/>
	<b>Disk Size:</b><%=rs1.getString("disk")%> <br/>
	<b>Screen Resolution:</b><%=rs1.getString("screen_resolution")%> <br/><br>
	<u><b>History of Bids for this Auction:</b></u><br><br>
		
	<%
	rs=st.executeQuery("select * from bid_history where item_id='" + item_id + "'");%>
	
	<table style="width:50%">
    <tr>
    <th>Bider/Buyer</th>
    <th>Bid Amount</th>
    <th>Bid Date and Time</th>
  </tr>
	
	
	<%while(rs.next()){%>
		<tr>
        <td><%=rs.getString("username") %></td>
        <td><%=rs.getString("bid_price") %></td>
        <td><%=rs.getString("timestamp") %></td>
    </tr>
	<%} %>
	</table><br><br>
	SIMILAR AUCTIONS:<br>
	<%
	rs=st.executeQuery("SELECT item.item_id AS item_ids FROM item INNER JOIN category ON item.item_id = category.item_id WHERE category.brand ='" + brand + "' AND category.subcategory ='"+cat+"' AND item.timestamp >= DATE_SUB(NOW(), INTERVAL 30 DAY)");
	%>
	<%while(rs.next()){%>
        <a href="showitem.jsp?value=<%=rs.getString("item_ids") %>"><%=rs.getString("item_ids") %></a><br>

	<%} %>
	
	
