<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
    <% //HttpSession session = request.getSession();
    String userid=request.getParameter("username");
    String pwd=request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from users where username COLLATE utf8mb4_bin ='" + userid + "' and password COLLATE utf8mb4_bin ='" + pwd + "'");
if (rs.next()) {
	String role = rs.getString("role");
	session.setAttribute("role", role);
	session.setAttribute("user", userid); // the username will be stored in the session out.println("welcome " + userid);
	
	rs=st.executeQuery("select * from item where sold_status='not_sold'");
	
	
    //TO GET THE END DATE AND COMPARE
    String pattern = "yyyy-MM-dd HH:mm:ss.s";
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
    LocalDateTime current = LocalDateTime.now();
    
    while(rs.next()){
    String end_date=rs.getString("up_time");
    LocalDateTime end_auction = LocalDateTime.parse(end_date, formatter);
    
    if (current.compareTo(end_auction) > 0){
    	int item_id=Integer.parseInt(rs.getString("item_id"));
    	String h_bid=rs.getString("highest_bider");
    	int reserve=Integer.parseInt(rs.getString("min_price"));
    	int max_bid=Integer.parseInt(rs.getString("start_bid"));
    	if(max_bid>=reserve){
    		st1.executeUpdate("UPDATE item SET sold_status='sold' where item_id=" + item_id + ";");
    		st1.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+h_bid+ "','" + item_id +  ", has been bought',DEFAULT);");
    		st1.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+rs.getString("username")+ "','" + item_id +  ", SOLD',DEFAULT);");
    	}
    	else{
    		st1.executeUpdate("UPDATE item SET sold_status='never_sold' where item_id=" + item_id + ";");
    		st1.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+rs.getString("username")+ "','" + item_id +  ", failed to sell',DEFAULT);");
    	}
      }
    }
	
	//out.println(" <a href='logout.jsp'>Log out</a>");
    if(role.equals("customer")){
    	response.sendRedirect("customer_success.jsp");
    }
    else if(role.equals("admin")){
    	response.sendRedirect("admin_success.jsp?value=blank");
    }
    else{
    	response.sendRedirect("staff_success.jsp");
    }
    }
else {
    out.println("Invalid username/password <a href='login.jsp'>try again</a>");
    }
    %>