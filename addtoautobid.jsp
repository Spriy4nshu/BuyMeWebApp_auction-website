<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <%
    String itemid=request.getParameter("item_name");
    int limit=Integer.parseInt(request.getParameter("bidlimit"));
    String userid=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from auto_bid where username='" + userid + "' and item_id='" + itemid + "'");
    if (rs.next()) {
    	st.executeUpdate("UPDATE auto_bid SET upper_price="+ limit +" where username='" + userid + "' and item_id='" + itemid + "'");
        }
    else {
    	//out.println(userid);
	st.executeUpdate("INSERT INTO auto_bid VALUES ('" +itemid+ "','" + userid +  "','" + limit + "');");
    }
    
    response.sendRedirect("bid_handle.jsp?value=" + itemid+"&bidvalue=-1");
    //out.println(userid);
	//out.println("Auto Bid Added successfully <a href='browse_buy.jsp'>Back</a>");
    %>