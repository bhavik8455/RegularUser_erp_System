package model;

import java.security.Timestamp;

public class FeedbackPojo {
	 private int feedbackId;
	    private int productId;
	    private int customerId;
	    private String comments;
	    private int ratings;
	    private Timestamp timestamp;

	    // Getters and Setters
	    public int getFeedbackId() {
	        return feedbackId;
	    }

	    public void setFeedbackId(int feedbackId) {
	        this.feedbackId = feedbackId;
	    }

	    public int getProductId() {
	        return productId;
	    }

	    public void setProductId(int productId) {
	        this.productId = productId;
	    }

	    public int getCustomerId() {
	        return customerId;
	    }

	    public void setCustomerId(int customerId) {
	        this.customerId = customerId;
	    }

	    

	    public String getComments() {
	        return comments;
	    }

	    public void setComments(String comments) {
	        this.comments = comments;
	    }

	    public int getRatings() {
	        return ratings;
	    }

	    public void setRatings(int ratings) {
	        this.ratings = ratings;
	    }

	    public Timestamp getTimestamp() {
	        return timestamp;
	    }

	    public void setTimestamp(Timestamp timestamp) {
	        this.timestamp = timestamp;
	    }
	

}
