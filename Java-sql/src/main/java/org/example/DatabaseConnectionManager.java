package org.example;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnectionManager {
    // Database connection parameters
    private String jdbcUrl;
    private String username;
    private String password;
    private Connection connection;

    // Singleton instance
    private static DatabaseConnectionManager instance;

    private DatabaseConnectionManager() {
        // Load database connection parameters from the properties file
        Properties properties = new Properties();
        try (FileInputStream input = new FileInputStream("/Users/dahammhamad/Desktop/Database/Advanced SQL/Java-sql/src/main/resources/database.properties")) {
            properties.load(input);
            jdbcUrl = properties.getProperty("jdbc.url");
            username = properties.getProperty("jdbc.username");
            password = properties.getProperty("jdbc.password");
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Error initializing database connection", e);
        }
    }

    public static DatabaseConnectionManager getInstance() {
        if (instance == null) {
            instance = new DatabaseConnectionManager();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(jdbcUrl, username, password);
        }
        return connection;
    }
}
