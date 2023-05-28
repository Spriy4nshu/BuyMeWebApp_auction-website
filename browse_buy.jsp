<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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

    <% //HttpSession session = request.getSession();
    String option=request.getParameter("value");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from item where sold_status='not_sold'");
    if(option.equals("nofilter")){
    	rs=st.executeQuery("select * from item where sold_status='not_sold'");
    }
    else if(option.equals("nofilteralert")){
    	rs=st.executeQuery("select * from item where sold_status='not_sold'");
    	%>
        <script>
        	alert("Bid value must be greater than or equal to Minimum Increment");
        	</script>
        	<%
    }
    else if(option.equals("sortpricea")){
    	rs=st.executeQuery("select * from item where sold_status='not_sold' order by start_bid");
    }
    else if(option.equals("sortpriced")){
    	rs=st.executeQuery("select * from item where sold_status='not_sold' order by start_bid DESC");
    }
    else if(option.equals("sortenda")){
    	rs=st.executeQuery("select * from item where sold_status='not_sold' order by up_time");
    }
    else if(option.equals("sortendd")){
    	rs=st.executeQuery("select * from item where sold_status='not_sold' order by up_time DESC");
    }
    else if(option.equals("filter")){
    	String category=request.getParameter("category");
        String brand=request.getParameter("brand");
        String ram=request.getParameter("ram");
        String disk=request.getParameter("disk");
        String scr_reso=request.getParameter("scr_reso");
    	String pre_c="=";
    	String pre_b="=";
    	String pre_r="=";
    	String pre_d="=";
    	String pre_s="=";
    	if(category.equals("")){
    		category="%";
        	pre_c="LIKE";
        }
    	if(brand.equals("")){
    		brand="%";
        	pre_b="LIKE";
        }
    	if(ram.equals("")){
    		ram="%";
        	pre_r="LIKE";
        }
    	if(disk.equals("")){
    		disk="%";
        	pre_d="LIKE";
        }
    	if(scr_reso.equals("")){
    		scr_reso="%";
        	pre_s="LIKE";
        }
    	
    	
    	rs=st.executeQuery("select * from item INNER JOIN category ON item.item_id = category.item_id where sold_status='not_sold' AND subcategory "+pre_c+" '"+category+"' AND brand "+pre_b+" '"+brand+"' AND ram "+pre_r+" '"+ram+"' AND disk "+pre_d+" '"+disk+"' AND screen_resolution "+pre_s+" '"+scr_reso+"'");
    }
        
    //rs=st.executeQuery("select * from item where sold_status='not_sold'");
    
    %>
    Filter:
	<form action="browse_buy.jsp?value=filter" method="POST">
	Category:<input type="text" name="category" value=""> 
	Brand:<input type="text" name="brand" value=""> 
	Ram:<input type="text" name="ram" value="">
	Disk:<input type="text" name="disk" value=""> 
	Screen Resolution:<input type="text" name="scr_reso" value=""> <br/>
	<input type="submit" value="Search"/><br/>
	</form>
    
    
    <br>
    <table style="width:100%">
  <tr>
    <th>Item Name</th>
    <th>Item Description</th>
    <th>Seller</th>
    <th>Current Price <button type="button" onclick="location.href='browse_buy.jsp?value=sortpricea'">&#x2191</button> <button type="button" onclick="location.href='browse_buy.jsp?value=sortpriced'">&#x2193</button></th>
    <th>Increments</th>
    <th>Highest Bider</th>
    <th>End Date <button type="button" onclick="location.href='browse_buy.jsp?value=sortenda'">&#x2191</button> <button type="button" onclick="location.href='browse_buy.jsp?value=sortendd'">&#x2193</button></th>
    <th></th>
    <th></th>
    <th></th>
  </tr>
    
    <%
	while(rs.next())
        {
            %>
            <tr>
                <td><a href="showitem.jsp?value=<%=rs.getString("item_id") %>"><%=rs.getString("item_name") %></a></td>
                <td><%=rs.getString("item_description") %></td>
                <td><%=rs.getString("username") %></td>
                <td><%=rs.getString("start_bid") %></td>
                <td ><%=rs.getString("increase_bid") %></td>
                <td><%=rs.getString("highest_bider") %></td>
                <td><%=rs.getString("up_time") %></td>
            
            <td>
            <form action="bid_handle.jsp?value=+<%=rs.getString("item_id")%>" method="POST">
   	<input type="text" name="bidvalue" required>
	<input type="submit" value="Bid"/>
	</form>
            <%-- <button type="button" onclick="location.href='bid_handle.jsp?value='+<%=rs.getString("item_id")%>">Bid</button> --%>
            </td>
            <td><button type="button" onclick="location.href='autobit_handle.jsp?value='+<%=rs.getString("item_id")%>">Set Auto-Bid</button></td>
            <td><button type="button" onclick="location.href='report_handle.jsp?value='+<%=rs.getString("item_id")%>">Report</button></td>
            </tr>
            
            <%}%>
    </table>
	<br>
	<button type="button" onclick="location.href='customer_success.jsp'">BACK</button><br>
    <%} %>
    
    
    
    
    
    