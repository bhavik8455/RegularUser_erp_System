package operations.viewfeedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.FeedbackPojo;
import model.ProductPojo;

public class FeedbackImplementation implements FeedbackInterface {
    
    @Override
    public List<FeedbackPojo> getFeedbacksByCustomerId(int customerId) {
        List<FeedbackPojo> feedbacks = new ArrayList<>();
        String query = "SELECT f.*, p.P_Name, p.P_Category, p.P_SellingPrice " +
                      "FROM Feedback f " +
                      "JOIN Products p ON f.ProductID = p.id " +
                      "WHERE f.CustomerID = ? " +
                      "ORDER BY f.Timestamp DESC";
        
        try (Connection conn = db.GetConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setInt(1, customerId);
            
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    FeedbackPojo feedback = new FeedbackPojo();
                    feedback.setFeedbackId(rs.getInt("FeedbackID"));
                    feedback.setProductId(rs.getInt("ProductID"));
                    feedback.setCustomerId(rs.getInt("CustomerID"));
                    feedback.setComments(rs.getString("Comments"));
                    feedback.setRatings(rs.getInt("Ratings"));
                    feedback.setTimestamp(rs.getTimestamp("Timestamp"));
                    
                    // Set product details
                    ProductPojo product = new ProductPojo();
                    product.setId(rs.getInt("ProductID"));
                    product.setP_Name(rs.getString("P_Name"));
                    product.setP_Category(rs.getString("P_Category"));
                    product.setP_SellingPrice(rs.getDouble("P_SellingPrice"));
                    feedback.setProduct(product);
                    
                    feedbacks.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
}