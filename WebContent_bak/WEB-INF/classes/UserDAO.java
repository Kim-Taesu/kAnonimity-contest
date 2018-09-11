
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


 
 
public class UserDAO {
    
    private Connection conn;           
    private PreparedStatement pstmt;   
    private ResultSet rs;                
    
    public UserDAO(){
        try {
            String dbURL = "jdbc:mysql://192.168.0.6:3306/accountinfo";
            String dbID = "root";
            String dbPassword = "root";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    public int join(User user) {
    	StringBuffer sb = new StringBuffer();
 
    	String SQL = "insert into user(userID, userPW) values(";
    	
    	sb.append(SQL);
    	sb.append("'");
    	sb.append(user.getUserID());
    	sb.append("'");
    	sb.append(",");
    	sb.append("'");
    	sb.append(user.getUserPW());
    	sb.append("'");
    	sb.append(")");
    	System.out.println(sb);
    	try {
    		Connection conn = DatabaseUtil.getConnection();
    		pstmt = conn.prepareStatement(sb.toString());
//    		pstmt.setString(1, user.getUserID());
//    		pstmt.setString(2, user.getUserPW());
    		return pstmt.executeUpdate(sb.toString());
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -1;
    }
    
    public int login(String userID, String userPW) {
    	System.out.println("LOGIN!!!!!!!!!!!!!!!");
        String SQL = "SELECT userPW FROM user WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals(userPW))
                    return 1;    
                else
                    return 0; // 
            }
            return -1; // 
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 
        
    }
 
}