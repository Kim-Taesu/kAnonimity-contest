package user;
 
public class UserDTO {
    
    private String userID;
    private String userPW;

    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getUserPW() {
        return userPW;
    }
    public void setUserPW(String userPassword) {
        this.userPW = userPassword;
    }   
}