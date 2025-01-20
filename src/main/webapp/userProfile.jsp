<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.CustomerPojo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 60px;
            margin-bottom: 20px;
        }
        .readonly-field {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-container">
            <div class="profile-header">
                <img src="https://cdn-icons-png.flaticon.com/512/10813/10813372.png" 
                     alt="Profile Avatar" 
                     class="profile-avatar">
                <h2>Customer Profile</h2>
            </div>

            <% if(request.getAttribute("message") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("message") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <% CustomerPojo customer = (CustomerPojo) request.getAttribute("customer"); %>
            <form action="UserProfile" method="POST">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" 
                           class="form-control" 
                           id="name" 
                           name="name" 
                           value="<%= customer != null ? customer.getName() : "" %>" 
                           required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" 
                           class="form-control" 
                           id="email" 
                           name="email" 
                           value="<%= customer != null ? customer.getEmail() : "" %>" 
                           required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="tel" 
                           class="form-control" 
                           id="phone" 
                           name="phone" 
                           value="<%= customer != null ? customer.getPhone() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <textarea class="form-control" 
                              id="address" 
                              name="address" 
                              rows="3"><%= customer != null ? customer.getAddress() : "" %></textarea>
                </div>
                <div class="mb-3">
                    <label for="loyaltyPoints" class="form-label">Loyalty Points</label>
                    <input type="text" 
                           class="form-control readonly-field" 
                           id="loyaltyPoints" 
                           value="<%= customer != null ? customer.getLoyaltyPoints() : "0" %>" 
                           readonly>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                    <a href="HomePage" class="btn btn-secondary">Back to Home</a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>