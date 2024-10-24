<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page import="com.example.model.UserBean" %>
<jsp:useBean id="user" class="com.example.model.UserBean" />
<jsp:setProperty property="*" name="user" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Result</title>
</head>
<body>
    <%
        UserDAO userDao = new UserDAO();
    
        try {
            UserBean loggedInUser = userDao.loginUser(user.getEmail(), user.getPassword());
            
            if (loggedInUser != null) {
                out.println("<h2>Login Successful!</h2>");
                out.println("<p>Welcome, " + loggedInUser.getName() + "!</p>");
            } 
            
            else {
                out.println("<h2>Login Failed</h2>");
                out.println("<p>Invalid email or password.</p>");
            }
        } 
        
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    %>
    <br>
    
    <a href="login.jsp">Back to Login</a>
</body>
</html>