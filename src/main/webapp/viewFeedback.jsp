<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.FeedbackPojo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Feedbacks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(to bottom right, #e9ecef, #dee2e6);
            font-family: 'Roboto', sans-serif;
        }
        .custom-navbar {
            background: linear-gradient(to right, #4b134f, #2e1a36);
            color: white;
        }
        .custom-navbar .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .feedback-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 15px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .feedback-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .feedback-header h2 {
            background: linear-gradient(to right, #4b134f, #2e1a36);
            color: white;
            padding: 10px;
            border-radius: 5px;
        }
        .feedback-card {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        .feedback-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }
        .star-rating {
            color: #ffc107;
            margin-top: 5px;
        }
        .timestamp, .customer-info {
            font-size: 0.85rem;
            color: #6c757d;
        }
        .feedback-card .product-details, .feedback-card .customer-details {
            margin-bottom: 15px;
        }
        .feedback-empty {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-top: 30px;
        }
        .btn-secondary {
            background: linear-gradient(to right, #6c757d, #495057);
            color: white;
            border: none;
        }
        .btn-secondary:hover {
            background: linear-gradient(to right, #5a6268, #343a40);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp" class="rounded-circle" alt="" height="40" width="40"/>
                Feedback Hub
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="HomePage">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container feedback-container">
        <div class="feedback-header">
            <h2>Your Feedbacks</h2>
        </div>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%
        List<FeedbackPojo> feedbacks = (List<FeedbackPojo>) request.getAttribute("feedbacks");
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        
        if(feedbacks != null && !feedbacks.isEmpty()) {
            for(FeedbackPojo feedback : feedbacks) {
        %>
            <div class="feedback-card p-3">
                <div class="product-details mb-2">
                    <h5><%= feedback.getProduct().getP_Name() %></h5>
                    <p class="text-muted">Category: <%= feedback.getProduct().getP_Category() %></p>
                    
                </div>
                <div class="ratings-details d-flex justify-content-between align-items-center">
                    <div class="star-rating">
                        <% for(int i = 0; i < feedback.getRatings(); i++) { %>
                            <i class="bi bi-star-fill"></i>
                        <% } %>
                        <% for(int i = feedback.getRatings(); i < 5; i++) { %>
                            <i class="bi bi-star"></i>
                        <% } %>
                    </div>
                    <div class="timestamp">
                        <i class="bi bi-clock me-1"></i>
                        <%= dateFormat.format(feedback.getTimestamp()) %>
                    </div>
                </div>
                <p class="mt-3"><%= feedback.getComments() %></p>
            </div>
        <%
            }
        } else {
        %>
            <div class="feedback-empty">
                <i class="bi bi-info-circle me-2"></i>
                No feedbacks available yet. Share your thoughts with us!
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
