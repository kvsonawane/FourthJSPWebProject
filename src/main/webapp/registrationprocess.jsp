<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page import="com.example.model.UserBean" %>
<jsp:useBean id="user" class="com.example.model.UserBean" />
<jsp:setProperty property="*" name="user" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Result</title>
</head>
<body>
    <%
        UserDAO userDao = new UserDAO();
        try {
            if (userDao.registerUser(user)) {
                out.println("<h2>Registration Successful!</h2>");
                out.println("<p>Welcome, " + user.getName() + "! You can now <a href='login.jsp'>login</a>.</p>");
            } else {
                out.println("<h2>Registration Failed</h2>");
                out.println("<p>Please try again or use a different email.</p>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    %>
    <br>
    <a href="registration.jsp">Back to Registration</a>
</body>
</html>