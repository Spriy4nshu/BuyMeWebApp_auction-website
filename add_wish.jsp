<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<!DOCTYPE html>
<html>
<head>
<title>Register Form</title>
</head>
<body>
<form action="addtowish.jsp" method="POST">
Category:
<select name="category">
    <option value="Mobile">Mobile</option>
    <option value="Laptop">Laptop</option>
    <option value="Tabet">Tablet</option>
    <option value="SmartWatch">SmartWatch</option>
  </select><br>
Brand:<input type="text" name="brand"/> <br/>
Ram:<input type="text" name="ram"/> <br/>
Disk:<input type="text" name="disk"/> <br/>
Screen Resolution:<input type="text" name="scr_reso"/> <br/>
<input type="submit" value="Submit"/><br/>
</form>
</body>
</html>