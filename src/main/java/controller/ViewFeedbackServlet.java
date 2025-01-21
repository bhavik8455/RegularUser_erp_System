package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        	  HttpSession session = request.getSession();
              Integer customerId = (Integer) session.getAttribute("CustomerID");
        	
            List<FeedbackPojo> feedbacks = feedbackService.getFeedbacksByCustomerId(customerId);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving feedbacks");
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
        }
    }
}