package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/quickkart";
    private static final String USER = "root";
    private static final String PASSWORD = "0000";
	
//	private static final String URL = "jdbc:mysql://root:JmPJnCtPssGYmpworOjayvavUVEZCRcF@caboose.proxy.rlwy.net:35778/railway";
//    private static final String USER = "root";
//    private static final String PASSWORD = "JmPJnCtPssGYmpworOjayvavUVEZCRcF";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
//=======
//package dao;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//
//public class DBConnection {
//    // private static final String URL = "jdbc:mysql://localhost:3306/quickkart";
//    // private static final String USER = "root";
//    // private static final String PASSWORD = "0000";
//	
//   private static final String URL = "jdbc:mysql://root:JmPJnCtPssGYmpworOjayvavUVEZCRcF@caboose.proxy.rlwy.net:35778/railway";
//   private static final String USER = "root";
//   private static final String PASSWORD = "JmPJnCtPssGYmpworOjayvavUVEZCRcF";
//
//    public static Connection getConnection() {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            return DriverManager.getConnection(URL, USER, PASSWORD);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return null;
//        }
//    }
//}
//>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
