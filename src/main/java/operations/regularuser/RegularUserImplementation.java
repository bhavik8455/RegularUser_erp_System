package operations.regularuser;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.UserPojo;


public class RegularUserImplementation implements RegularUserInterface {
    
    @Override
    public UserPojo getUserById(int userId) {
        UserPojo user = null;
        String query = "SELECT UserID, Name, MailID, Role FROM Users WHERE UserID = ?";
        
        try (Connection conn = db.GetConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setInt(1, userId);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new UserPojo();
                    user.setUserId(rs.getInt("UserID"));
                    user.setName(rs.getString("Name"));
                    user.setMailId(rs.getString("MailID"));
                    user.setRole(rs.getString("Role"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean updateUserDetails(int userId, String name, String email) {
        try (Connection conn = db.GetConnection.getConnection();
             CallableStatement cst = conn.prepareCall("{CALL EditUserDetails(?, ?, ?, ?)}")) {
            
            // Get current user to preserve role
            UserPojo currentUser = getUserById(userId);
            if (currentUser == null) return false;
            
            cst.setInt(1, userId);
            cst.setString(2, name);
            cst.setString(3, email);
            cst.setString(4, currentUser.getRole()); // Preserve existing role
            
            try (ResultSet rs = cst.executeQuery()) {
                if (rs.next()) {
                    return "Edited Successfully in both Users and Customers tables".equals(rs.getString("Message"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}