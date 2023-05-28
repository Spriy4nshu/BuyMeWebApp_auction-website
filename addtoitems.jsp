<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String item_name=request.getParameter("item_name");
    String describe=request.getParameter("describe");
    String uptime=request.getParameter("uptime");
    int start=Integer.parseInt(request.getParameter("start"));
    int increments=Integer.parseInt(request.getParameter("increments"));
    int min_price=Integer.parseInt(request.getParameter("min_price"));
    String userid=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    ResultSet rs;
    //rs=st.executeQuery("select * from wishlist where username='" + session.getAttribute("user") + "' and subcategory='" + category + "' and brand='" + brand +"' and ram='" + ram +"' and disk='" + disk +"' and screen_resolution='" + scr_reso +"'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
//if (rs.next()) {
//	out.println("This Wish Already exists <a href='add_wish.jsp'>try again</a>");
//    }
//else {
	st.executeUpdate("INSERT INTO item VALUES (NULL,'" +item_name+ "','" + describe +  "',DEFAULT,'" + userid + "','" + uptime + "',DEFAULT," + start + ",'" + userid +"'," + increments + "," + min_price + ",CURRENT_TIMESTAMP);");
	
	rs=st.executeQuery("SELECT item_id FROM item ORDER BY timestamp DESC LIMIT 1;");
	rs.next();
	String item_id=rs.getString("item_id");
	String category=request.getParameter("subcategory");
    String brand=request.getParameter("brand");
    String ram=request.getParameter("ram");
    String disk=request.getParameter("disk");
    String scr_reso=request.getParameter("scr_reso");
	
    st.executeUpdate("INSERT INTO category VALUES (NULL,'" +item_id+ "','" + category +  "','" + brand + "'," + ram + "," + disk + ",'" + scr_reso +"');");
	
    
    
    rs=st.executeQuery("SELECT * FROM wishlist WHERE subcategory ='"+category+"' AND brand ='"+brand+"' AND ram ='"+ram+"' AND disk ='"+disk+"' AND screen_resolution ='"+scr_reso+"';");
    while(rs.next()){
    	st1.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+rs.getString("username")+ "','" + item_id +  " is being available which matches your wishlist',DEFAULT);");
    }
    

	out.println("Item posted successful <a href='customer_success.jsp'>back</a>");
 //   }
    %>