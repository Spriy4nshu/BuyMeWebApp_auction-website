<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%@ page import="java.sql.*" %>
    <% //HttpSession session = request.getSession();
    String item_id=request.getParameter("value");
	int increment=-1;
	try{
		increment = Integer.parseInt(request.getParameter("bidvalue"));
	}finally{}
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/buymedatabase","root", "Jamshedpur@123" );
    Statement st=con.createStatement();
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    ResultSet rs;

    rs=st.executeQuery("select * from item where item_id='" + item_id + "'");
    rs.next();
    String h_bid=rs.getString("highest_bider");
    int price = Integer.parseInt(rs.getString("start_bid"));
    int min_increment = Integer.parseInt(rs.getString("increase_bid"));
    if(increment==-1){
    	increment = Integer.parseInt(rs.getString("increase_bid"));
    }
    if (increment>=min_increment){
	    price=price+increment;
	    String userid=(String)session.getAttribute("user");
	    st.executeUpdate("UPDATE item SET start_bid="+ price +",highest_bider='"+ userid +"' where item_id='" + item_id + "'");
	    st2.executeUpdate("INSERT INTO bid_history VALUES ('"+ item_id + "','" + userid + "'," + price + ",CURRENT_TIMESTAMP);");
	    //out.println("="+h_bid+userid+"=");
	    if (!h_bid.equals(userid)){
	    	st.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+h_bid+ "','" + item_id +  ", where you were the highest bider is being bid',DEFAULT);");
	    }
	    
	    String user="";
	    //TEST if autobid is present
	    rs=st.executeQuery("select * from auto_bid where item_id='" + item_id + "' and upper_price >='" + price + "' and username != '"+userid+"'");
	    int flag=0;
	    while(rs.next()){
	    	user=rs.getString("username");
	    	int limit = Integer.parseInt(rs.getString("upper_price"));
	    	increment = min_increment;
	    	if (limit>price+increment){
	    		price=price + increment;
	    		st.executeUpdate("UPDATE item SET start_bid="+ price +",highest_bider='"+ user +"' where item_id='" + item_id + "'");
	    		st2.executeUpdate("INSERT INTO bid_history VALUES ('"+ item_id + "','" + user + "'," + price + ",CURRENT_TIMESTAMP);");
	    		flag=1;
	    	}
	    	rs=st.executeQuery("select * from auto_bid where item_id='" + item_id + "' and upper_price >='" + price + "' and username != '"+user+"'");
	    }
	    if (flag==1){
	    	userid=user;
	    }
	    rs=st.executeQuery("select * from auto_bid where item_id='" + item_id + "' and username != '"+userid+"'");
	    while(rs.next()){
	    	st1.executeUpdate("INSERT INTO alerts VALUES (NULL,'"+rs.getString("username")+ "','" + item_id +  " is being auctioned at higher price than set upper limit.',DEFAULT);");
	    }
    	response.sendRedirect("browse_buy.jsp?value=nofilter");
    }
    else{%>
    <script>
    	alert("Bid value must be greater than or equal to Minimum Increment");
    	</script>
    	<%response.sendRedirect("browse_buy.jsp?value=nofilteralert");
    }
    %>