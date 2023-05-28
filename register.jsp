<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<!DOCTYPE html>
<html>
<head>
<title>Register Form</title>
</head>
<body>
<form action="addtouser.jsp?value=customer" method="POST">
Username:<input type="text" name="username" required> <br/>
Password:<input type="password" name="password" required> <br/>
Email:<input type="email" name="email" required/> <br/>
Phone Number:<input type="text" name="phone" required> <br/>
Bank Account Number:<input type="text" name="acc" required> <br/>
<input type="submit" value="Submit"/><br/>
Existing User?
<button type="button" onclick="location.href='login.jsp'">Login</button>
</form>
</body>
</html>