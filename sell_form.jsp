<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<!DOCTYPE html>
<html>
<head>
<title>Register Form</title>
</head>
<body>
<form action="addtoitems.jsp" method="POST">
Item Name:<input type="text" name="item_name"/> <br/>
Description:<br/>
<textarea name="describe" rows="4" cols="50">Item Description here</textarea><br/>
Auction end date:<input type="datetime-local" name="uptime"/> <br/>
Starting Bid($):<input type="number" name="start"/> <br/>
Increment Bid($):<input type="number" name="increments"/> <br/>
Minimum Value($):<input type="number" name="min_price"/> <br/>
Sub-category:<!-- <input type="text" name="subcategory"/> <br/> -->
<select name="subcategory">
    <option value="Mobile">Mobile</option>
    <option value="Laptop">Laptop</option>
    <option value="Tabet">Tablet</option>
    <option value="SmartWatch">SmartWatch</option>
  </select>
<br>
Brand:<input type="text" name="brand"/> <br/>
RAM:<input type="text" name="ram"/> <br/>
Disk:<input type="text" name="disk"/> <br/>
Screen-resolution:<input type="text" name="scr_reso"/> <br/>

<input type="submit" value="Submit"/><br/>
</form>
</body>
</html>