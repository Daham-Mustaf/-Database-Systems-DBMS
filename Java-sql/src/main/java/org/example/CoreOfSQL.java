package org.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


public class CoreOfSQL {
    private static final Logger logger = LoggerFactory.getLogger(CoreOfSQL.class);

    public static void main(String[] args) {
        // Get the singleton instance of the connection manager
        DatabaseConnectionManager connectionManager = DatabaseConnectionManager.getInstance();

        try {
            // Get a connection
            Connection connection = connectionManager.getConnection();
            Statement statement = connection.createStatement();

            if (connection != null) {
                logger.info("Connected to the database.");
// Read SQL file
                BufferedReader reader = new BufferedReader(new FileReader("/Users/dahammhamad/IdeaProjects/Java-sql/src/main/resources/sql_queries.sql"));
                String line;
                StringBuilder sql = new StringBuilder();

                while ((line = reader.readLine()) != null) {
                    // Append each line to the SQL StringBuilder
                    sql.append(line);

                    // If the line ends with a semicolon, execute the SQL statement
                    if (line.trim().endsWith(";")) {
                        statement.execute(sql.toString());
                        sql.setLength(0); // Clear the SQL StringBuilder
                    }
                }

                // Close resources
                reader.close();
                statement.close();
                connection.close();

                logger.info("SQL file executed successfully.");

                // Close resources
                reader.close();
                statement.close();
                connection.close();

                logger.info("SQL file executed successfully.");
            } else {
                logger.error("Failed to connect to the database.");
            }
        } catch (SQLException e) {
            logger.error("Database connection error.", e);
        } catch (Exception e) {
            logger.error("Error reading SQL file.", e);
        }
    }
}