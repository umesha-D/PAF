<%@ page import="com.Item"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%

	//insert items
	if (request.getParameter("ItemCode") != null) {
		
		Item itemObj = new Item();
		
		String stsMsg = itemObj.insertItem(request.getParameter("ItemCode"),
						 request.getParameter("ItemName"),
				         request.getParameter("ItemPrice"),
				         request.getParameter("ItemDesc"));
		
		session.setAttribute("statusMsg", stsMsg);
		
	}


	//update items
	
	if (request.getParameter("ItemID") != null) {
		Item itemObj = new Item();
		session.setAttribute("is_in_update_mode", request.getParameter("ItemID"));
	}
	
	//setting data
	
	String itemCode;
	String itemName;
	String itemPrice;
	String itemDesc;
	
	if (String.valueOf(session.getAttribute("is_in_update_mode")) == ""|| session.getAttribute("is_in_update_mode") == null) {
		
		itemCode = "";
		itemName = "";
		itemPrice = "";
		itemDesc = "";
		
	} else {
		Item itemObj = new Item();
		
		System.out.println(session.getAttribute("is_in_update_mode"));
		
		String temp[] = itemObj.readSingleItems(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))));
		itemCode = temp[0];
		itemName = temp[1];
		itemPrice = temp[2];
		itemDesc = temp[3];
	}
	// insert when click save button
	//update
	
	if (request.getParameter("ItemCode") != null && (session.getAttribute("is_in_update_mode") != null)) {
		
			Item itemObj = new Item();
			
			String stsMsg = itemObj.updateItem(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))),
					
			request.getParameter("ItemCode"), request.getParameter("ItemName"), request.getParameter("ItemPrice"),request.getParameter("ItemDesc"));
			itemCode = "";
			itemName = "";
			itemPrice = "";
			itemDesc = "";
			
			
		session.setAttribute("is_in_update_mode", "");
		session.setAttribute("statusMsg", stsMsg);
		
	} else if (request.getParameter("itemCode") != null) {
		//insert new
		Item itemObj = new Item();
		String stsMsg = itemObj.insertItem(request.getParameter("ItemCode"), request.getParameter("ItemName"),request.getParameter("ItemPrice"), request.getParameter("ItemDesc"));
		session.setAttribute("statusMsg", stsMsg);
	
	}
	
	//delete items
	
	if (request.getParameter("ItemID") != null) 
 	{ 
	 Item itemObj = new Item(); 
	 String stsMsg = itemObj.deleteItem(request.getParameter("ItemID")); 
	 session.setAttribute("statusMsg", stsMsg); 
	} 
	
	
%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="Views/bootstrap.min.css">
<meta charset="ISO-8859-1">
<title>Items Management</title>
</head>
<body>
<div class = "container">
<div class = "row">
<div class = "col">
	<h1>Items Management</h1>
	<form method="post" action="item.jsp">
		Item code: <input name="ItemCode" type="text" class="from-control"><br> 
		Item name: <input name="ItemName" type="text" class="from-control"><br> 
		Item price: <input name="ItemPrice" type="text" class ="form-control">"<br> 
		Item description: <input name="ItemDesc" type="text" class ="from-control" ><br>
		<input name="btnSubmit" type="submit" value="Save" class="btn btn-primary"><br>
	</form>
	
	<br/>
	<!-- Show output -->

	<div class="alert alert-success">
 		<% out.print(session.getAttribute("statusMsg")); %>
 		
 	</div>
	
	<br>
	<%
	 Item itemObj = new Item(); 
	 out.print(itemObj.readItems()); 
	%>

</body>
</html> 