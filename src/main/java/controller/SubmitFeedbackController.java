package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FeedbackPojo;
import operations.feedback.Feedback_Implementation;
import operations.feedback.Feedback_Interface;

@WebServlet("/SubmitFeedback")
public class SubmitFeedbackController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Feedback_Interface feedbackInterface = new Feedback_Implementation();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int customerId = 1; // Replace with actual logged-in customer ID
        String comments = request.getParameter("comments");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        FeedbackPojo feedback = new FeedbackPojo();
        feedback.setProductId(productId);
        feedback.setCustomerId(customerId);
        feedback.setComments(comments);
        feedback.setRatings(rating);
        
        boolean success = feedbackInterface.submitFeedback(feedback);
        
        if (success) {
            response.sendRedirect("Feedback?message=success");
        } else {
            response.sendRedirect("Feedback?error=true");
        }
    }
}