<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String role=request.getParameter("value");
    String userid=request.getParameter("username");
    String pwd=request.getParameter("password");
    String eme=request.getParameter("email");
    String phone=request.getParameter("phone");
    String account=request.getParameter("acc");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from users where username='" + userid + "'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
if (rs.next()) {
	out.println("Username Already Exists");
    }
else {
	rs=st.executeQuery("SELECT managed_by, COUNT(managed_by) AS count_name FROM users GROUP BY managed_by ORDER BY count_name LIMIT 1 OFFSET 2;");
	rs.next();
	String most_available_staff = rs.getString("managed_by");
	//st.executeUpdate("INSERT INTO users VALUES ('" +userid+ "','" + pwd +  "','" + eme + "','" + phone + "','" + account + "','"+role+"','"+most_available_staff+"');");
	if (role.equals("customer")){
		st.executeUpdate("INSERT INTO users VALUES ('" +userid+ "','" + pwd +  "','" + eme + "','" + phone + "','" + account + "','"+role+"','"+most_available_staff+"');");
		out.println("Registration successful <a href='login.jsp'>login</a>");
	}
	else{
		st.executeUpdate("INSERT INTO users VALUES ('" +userid+ "','" + pwd +  "','" + eme + "','" + phone + "','" + account + "','"+role+"','not_set');");
		out.println("Registration For staff successful <a href='admin_success.jsp?value=blank'>BACK</a>");
	}
	//out.println("Registration successful <a href='login.jsp'>login</a>");
    }
    %>