<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String flag=request.getParameter("value");
	String custid=request.getParameter("username");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    String userid=(String)session.getAttribute("user");
    rs=st.executeQuery("select * from users where username='" + custid + "' AND role='customer'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
    if (rs.next()){
		if (flag.equals("edit")){
		%>
		Edit User <br>
		<form action="edit_cust.jsp?value=edited" method="POST">
		username:<input type="text" name="username"  value=<%=rs.getString("username")%> readonly> <br/>
		password:<input type="text" name="pass"  value=<%=rs.getString("password")%>> <br/>
		email:<input type="email" name="email"  value=<%=rs.getString("email")%>> <br/>
		role:<input type="text" name="role"  value=<%=rs.getString("role")%> readonly> <br/>
		managed by:<input type="text" name="staff"  value=<%=rs.getString("managed_by")%>> <br/>
		<input type="submit" value="Update User"/><br/>
		</form>
		
		Delete User<br>
		<form action="userdelete.jsp" method="POST">
		username:<input type="text" name="username"  value=<%=rs.getString("username")%> readonly> 
		<input type="submit" value="Delete User"/><br/>
		</form>

		<%}
		else if (flag.equals("edited")){
			String pwd=request.getParameter("pass");
		    String eme=request.getParameter("email");
		    String role=request.getParameter("role");
		    String uid=request.getParameter("username");
		    String mb=request.getParameter("staff");
		    st.executeUpdate("UPDATE users SET email='"+ eme +"',password='"+pwd+"',managed_by='"+ mb +"' where username='" + uid + "'");
		    response.sendRedirect("staff_success.jsp");
		}
		else{
			st.executeUpdate("DELETE FROM users WHERE username='"+ flag + "'");
			response.sendRedirect("staff_success.jsp");
		}
		%>
	
	<%} 
    else{
    	out.println("Not a valid username for customer");
    }
	%>
	
	