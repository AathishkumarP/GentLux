package com.gentlux.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/gentlux";

    private static final String USER =
            "root";

    private static final String PASSWORD =
            "Aathish@24";


    static {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println(
                    "MySQL JDBC Driver loaded successfully."
            );

        } catch (ClassNotFoundException e) {

            System.out.println(
                    "MySQL JDBC Driver not found."
            );

            e.printStackTrace();
        }
    }


    public static Connection getConnection() throws Exception {

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}