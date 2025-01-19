<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.FeedbackPojo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Feedbacks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .custom-navbar {
            background-color: #2e1a36;
        }
        .feedback-container {
            max-width: 800px;
            margin: 30px auto;
        }
        .star-rating {
            color: #ffc107;
        }
        .feedback-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .feedback-card:hover {
            transform: translateY(-5px);
        }
        .timestamp {
            font-size: 0.85rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container">
            <img src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp"
                 class="rounded-circle" alt="" height="40" width="40"/>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="HomePage">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container feedback-container">
        <h2 class="text-center mb-4">My Feedbacks</h2>
        
        <%
        List<FeedbackPojo> feedbacks = (List<FeedbackPojo>) request.getAttribute("feedbacks");
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        
        if(feedbacks != null && !feedbacks.isEmpty()) {
            for(FeedbackPojo feedback : feedbacks) {
        %>
            <div class="feedback-card p-3">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <h5 class="mb-1"><%= feedback.getProduct().getP_Name() %></h5>
                        <p class="text-muted mb-2">Category: <%= feedback.getProduct().getP_Category() %></p>
                    </div>
                    <div class="text-end">
                        <div class="star-rating mb-1">
                            <% for(int i = 0; i < feedback.getRatings(); i++) { %>
                                <i class="bi bi-star-fill"></i>
                            <% } %>
                            <% for(int i = feedback.getRatings(); i < 5; i++) { %>
                                <i class="bi bi-star"></i>
                            <% } %>
                        </div>
                        <div class="timestamp">
                            <%= dateFormat.format(feedback.getTimestamp()) %>
                        </div>
                    </div>
                </div>
                <p class="mt-3 mb-0"><%= feedback.getComments() %></p>
            </div>
        <%
            }
        } else {
        %>
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle me-2"></i>
                You haven't provided any feedback yet.
            </div>
        <%
        }
        %>
        
        <div class="text-center mt-4">
            <a href="HomePage" class="btn btn-secondary">
                <i class="bi bi-arrow-left me-2"></i>Back to Home
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>