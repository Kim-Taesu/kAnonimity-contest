//Connect Database
package util;

import java.sql.*;

public class DatabaseUtil {
	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://192.168.0.6:3306/accountinfo";
			String dbID = "root";
			String dbPW = "root";
			Class.forName("com.mysql.jdbc.Driver");
			
			return DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;		
	}
}
