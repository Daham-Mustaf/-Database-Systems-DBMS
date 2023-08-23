package org.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {
    private static final Logger logger = LoggerFactory.getLogger(CoreOfSQL.class);

    public static void main(String[] args) {

        // Read SQL file
        try {
            BufferedReader reader = new BufferedReader(new FileReader("/Users/dahammhamad/Desktop/Database/Advanced SQL/Java-sql/src/main/resources/sql_queries.sql"));
            String line;
            StringBuilder sql = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                // Append each line to the SQL StringBuilder
                StringBuilder append = sql.append(line);
                System.out.println(append);


                // If the line ends with a semicolon, execute the SQL statement
                if (line.trim().endsWith(";")) {
//                    statement.execute(sql.toString());
                    String string = sql.toString();
                    System.out.println("\n ,,,,," + string);
                    sql.setLength(0); // Clear the SQL StringBuilder
                }
            }

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        String line;
        StringBuilder sql = new StringBuilder();
    }
}