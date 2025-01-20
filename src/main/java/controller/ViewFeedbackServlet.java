package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FeedbackPojo;
import operations.viewfeedback.FeedbackInterface;
import operations.viewfeedback.FeedbackImplementation;

@WebServlet("/ViewFeedbacks")
public class ViewFeedbackServlet extends HttpServlet {
    private final FeedbackInterface feedbackService = new FeedbackImplementation();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<FeedbackPojo> feedbacks = feedbackService.getFeedbacksByCustomerId(1);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving feedbacks");
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
        }
    }
}