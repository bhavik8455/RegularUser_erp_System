package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserPojo;
import operations.regularuser.RegularUserInterface;
import operations.regularuser.RegularUserImplementation;

@WebServlet("/UserProfile")
public class UserProfileServlet extends HttpServlet {
    private final RegularUserInterface userService = new RegularUserImplementation();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // For demo purposes, using userId = 1
        UserPojo user = userService.getUserById(1);
        request.setAttribute("user", user);
        // Changed path to direct JSP file
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // For demo purposes, using userId = 1
        int userId = 1;
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        boolean updated = userService.updateUserDetails(userId, name, email);
        
        if (updated) {
            request.setAttribute("message", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        // Reload user data and show the page
        UserPojo user = userService.getUserById(userId);
        request.setAttribute("user", user);
        // Changed path to direct JSP file
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }
}