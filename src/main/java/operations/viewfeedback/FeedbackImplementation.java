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

    String query = "SELECT f.*, p.Name AS ProductName, p.Category AS ProductCategory, p.SellingPrice AS ProductSellingPrice " +
                   "FROM Feedback f " +
                   "JOIN Products p ON f.ProductID = p.ProductID " +
                   "WHERE f.CustomerID = ? " +
                   "ORDER BY f.Timestamp DESC";

    try (Connection conn = db.GetConnection.getConnection();
         PreparedStatement pst = conn.prepareStatement(query)) {

        pst.setInt(1, customerId);

        try (ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                // Create and populate feedback object
                FeedbackPojo feedback = new FeedbackPojo();
                feedback.setFeedbackId(rs.getInt("FeedbackID"));
                feedback.setProductId(rs.getInt("ProductID"));
                feedback.setCustomerId(rs.getInt("CustomerID"));
                feedback.setComments(rs.getString("Comments"));
                feedback.setRatings(rs.getInt("Ratings"));
                feedback.setTimestamp(rs.getTimestamp("Timestamp"));

                // Create and populate product object
                ProductPojo product = new ProductPojo();
                product.setId(rs.getInt("ProductID"));
                product.setP_Name(rs.getString("ProductName"));
                product.setP_Category(rs.getString("ProductCategory"));
                product.setP_SellingPrice(rs.getDouble("ProductSellingPrice"));

                // Set product in feedback
                feedback.setProduct(product);

                feedbacks.add(feedback);
            }
        }
    } catch (SQLException e) {
        System.out.println("Error fetching feedbacks: " + e.getMessage());
        e.printStackTrace();
    }
    return feedbacks;
}

}
