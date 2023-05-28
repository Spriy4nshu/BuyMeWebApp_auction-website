<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String category=request.getParameter("category");
    String brand=request.getParameter("brand");
    String ram=request.getParameter("ram");
    String disk=request.getParameter("disk");
    String scr_reso=request.getParameter("scr_reso");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from wishlist where username='" + session.getAttribute("user") + "' and subcategory='" + category + "' and brand='" + brand +"' and ram='" + ram +"' and disk='" + disk +"' and screen_resolution='" + scr_reso +"'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
if (rs.next()) {
	out.println("This Wish Already exists <a href='add_wish.jsp'>try again</a>");
    }
else {
	st.executeUpdate("INSERT INTO wishlist VALUES (NULL,'" +session.getAttribute("user")+ "','" + category +  "','" + brand + "','" + ram + "','" + disk + "','" + scr_reso + "');");
	
	rs=st.executeQuery("SELECT * FROM category INNER JOIN item ON category.item_id = item.item_id WHERE category.subcategory ='"+category+"' AND category.brand ='"+brand+"' AND category.ram ='"+ram+"' AND category.disk ='"+disk+"' AND category.screen_resolution ='"+scr_reso+"' AND item.sold_status ='not_sold';");
    while(rs.next()){
    	st1.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+(String)session.getAttribute("user")+ "','" + rs.getString("item_id") +  " is available which matches your wishlist',DEFAULT);");
    }
	
	
	
	
	
	
	
	out.println("Added successfully <a href='wishlist.jsp'>back</a>");
    }
    %>