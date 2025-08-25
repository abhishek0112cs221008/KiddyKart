package dao;

import model.User;
import java.sql.*;

public class UserDAO {

    public boolean registerUser(User user) {
    	int newId = 1;
    	
    	
        String sql = "INSERT INTO users (id, name, email, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
        	
        	ResultSet rs = stmt.executeQuery("SELECT MAX(id) FROM users");
        	if(rs.next()) {
        		newId = rs.getInt(1) + 1;
        	}
        	
        	stmt.setInt(1, newId);
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());
            stmt.setString(5, user.getRole());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    /**
     * Updates the membership status of a user in the database.
     *
     * @param userEmail The email of the user to update.
     * @param isMember  The new membership status (true for member, false otherwise).
     */
    public static void updateMembershipStatus(String userEmail, boolean isMember) {
        String sql = "UPDATE users SET is_member = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, isMember);
            ps.setString(2, userEmail);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    /**
     * Checks if a user is a member by looking up their email in the database.
     *
     * @param userEmail The email of the user.
     * @return true if the user is a member, false otherwise.
     */
    public static boolean isMember(String userEmail) {
        String sql = "SELECT is_member FROM users WHERE email = ?";
        boolean isMemberStatus = false;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userEmail);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isMemberStatus = rs.getBoolean("is_member");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return isMemberStatus;
    }
}
