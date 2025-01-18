package model;

public class FeedbackPojo {
	 private int feedbackId;
	    private int productId;
	    private int customerId;
	    private String comments;
	    private int ratings;
	    private java.sql.Timestamp timestamp;
	    private ProductPojo product;

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

	    public java.sql.Timestamp getTimestamp() {
	        return timestamp;
	    }

	    public void setTimestamp(java.sql.Timestamp timestamp2) {
	        this.timestamp = timestamp2;
	    }
	    public ProductPojo getProduct() {
	        return product;
	    }

	    public void setProduct(ProductPojo product) {
	        this.product = product;
	    }
	

}
