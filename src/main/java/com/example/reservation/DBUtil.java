package com.example.reservation;

import java.sql.*;

public class DBUtil {
    private static final String URL = "jdbc:postgresql://localhost:5432/neocinema";
    private static final String USER = "yusei";
    private static final String PASSWORD = "postgres";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
