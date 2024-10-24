package com.example.dao;

import com.example.model.UserBean;
import com.example.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    
    public boolean registerUser(UserBean user) throws ClassNotFoundException {
    	
        String INSERT_USERS_SQL = "INSERT INTO USERS (name, email, password) VALUES (?, ?, ?)";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) 
        {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());

            int rowsInserted = preparedStatement.executeUpdate();
            return rowsInserted > 0;
        } 
        
        catch (SQLException e) 
        {
            if (e.getErrorCode() == 1062) {
                System.out.println("Email already exists. Please try a different email");
            } else {
                e.printStackTrace();
            }
            return false;
        }
    }

    public UserBean loginUser(String email, String password) throws ClassNotFoundException {
    	
        String SELECT_USER_SQL = "SELECT * FROM USERS WHERE email = ? AND password = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_SQL)) 
        {
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) 
            {
                UserBean user = new UserBean();
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                return user;
            }
        } 
        
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
        
        return null;
    }

    public boolean validate(UserBean user) throws ClassNotFoundException {
    	
        return loginUser(user.getEmail(), user.getPassword()) != null;
    }
}
