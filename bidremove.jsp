<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String user_id=request.getParameter("username");
    String item_id=request.getParameter("itemid");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    String userid=(String)session.getAttribute("user");

    st.executeUpdate("DELETE FROM bid_history WHERE username='"+ user_id + "' and item_id="+item_id+"");
    
    rs=st.executeQuery("SELECT username,bid_price FROM bid_history WHERE bid_price = (SELECT MAX(bid_price) FROM bid_history WHERE item_id =" + item_id +") AND item_id ="+ item_id);
    if(rs.next()){
    	st.executeUpdate("UPDATE item SET start_bid="+ rs.getString("bid_price") +",highest_bider='"+ rs.getString("username") +"' where item_id='" + item_id + "'");
    }
    else{
    	rs=st.executeQuery("SELECT username FROM item WHERE item_id='"+item_id+"'");
    	st.executeUpdate("UPDATE item SET highest_bider='"+ rs.getString("username") +"' where item_id='" + item_id + "'");
    }
	response.sendRedirect("staff_success.jsp");
%>

