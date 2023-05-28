<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ page import="java.sql.*" %>

<% if ((session.getAttribute("user")==null)) { %>
    You are not logged in<br />
    <a href="login.jsp">Please Login</a>
<%} else { %>
	<a href='logout.jsp'>Log out</a><br><br>

    <% //HttpSession session = request.getSession();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from wishlist where username='" + session.getAttribute("user") + "'");
    //INSERT INTO `users` VALUES ('admin','admin123','admin@buyme.com','admin','NONE'),
	while(rs.next())
        {
            %>
            <tr>
                <td><%=rs.getString("Serial_no") %></td>
                <td><%=rs.getString("username") %></td>
                <td><%=rs.getString("brand") %></td>
                <td><%=rs.getString("ram") %></td>
                <td><%=rs.getString("disk") %></td>
            </tr><br>
            <%}%>
	<button type="button" onclick="location.href='add_wish.jsp'">Add to Wishlist</button>
    <%} %>