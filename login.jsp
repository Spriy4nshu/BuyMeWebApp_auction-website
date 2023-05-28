<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<!DOCTYPE html>
<html>
<head>
<title>Login Form</title>
</head>
<body>
<form action="checkLoginDetails.jsp" method="POST">
Username:<input type="text" name="username" required> <br/>
Password:<input type="password" name="password" required> <br/>
<input type="submit" value="Submit"/><br/>
New User?
<button type="button" onclick="location.href='register.jsp'">Register</button>
</form>
</body>
</html>