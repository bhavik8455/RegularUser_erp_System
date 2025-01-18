<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.SalesPojo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: #321525;
            color: #e6d7e0;
            font-family: Poppins;
        }
        .card {
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .modal-content {
            background-color: #321525;
            color: #e6d7e0;
        }
        .form-control, .form-select {
            background-color: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.2);
            color: #e6d7e0;
        }
        .form-control:focus, .form-select:focus {
            background-color: rgba(255, 255, 255, 0.15);
            border-color: #4a2038;
            color: #e6d7e0;
        }
        .star-rating {
            color: #ffd700;
            font-size: 24px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="card-body">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="card-title mb-0">Product Feedback</h2>
        
    </div>
    
    <div class="container py-4">
    <div class="card">
        <div class="card-body">
            <!-- Flex container for the heading and button -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="card-title">Product Feedback</h2>
                <a href="HomePage" class="btn btn-primary">
                    <i class="bi bi-house-fill"></i> Go to Home
                </a>
            </div>
            
            <% if(request.getParameter("message") != null && request.getParameter("message").equals("success")) { %>
                <div class="alert alert-success" role="alert">
                    Thank you for your feedback!
                </div>
            <% } %>
            
            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    Failed to submit feedback. Please try again.
                </div>
            <% } %>
            
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Purchase Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<SalesPojo> purchases = (List<SalesPojo>) request.getAttribute("purchasedProducts");
                        if(purchases != null && !purchases.isEmpty()) {
                            for(SalesPojo sale : purchases) {
                        %>
                            <tr>
                                <td><%= sale.getProductName() %></td>
                                <td><%= sale.getProductCategory() %></td>
                                <td><%= sale.getDate() %></td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-sm" 
                                            onclick="openFeedbackModal(<%= sale.getProductId() %>)">
                                        Give Feedback
                                    </button>
                                </td>
                            </tr>
                        <%
                            }
                        } else {
                        %>
                            <tr>
                                <td colspan="4" class="text-center">No products available for feedback</td>
                            </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

    <!-- Feedback Modal -->
    <div class="modal fade" id="feedbackModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Submit Feedback</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="SubmitFeedback" method="POST">
                    <div class="modal-body">
                        <input type="hidden" id="productId" name="productId">
                        
                        <div class="mb-3">
                            <label class="form-label">Rating</label>
                            <div class="star-rating" id="starRating">
                                <i class="bi bi-star" data-rating="1"></i>
                                <i class="bi bi-star" data-rating="2"></i>
                                <i class="bi bi-star" data-rating="3"></i>
                                <i class="bi bi-star" data-rating="4"></i>
                                <i class="bi bi-star" data-rating="5"></i>
                            </div>
                            <input type="hidden" name="rating" id="ratingInput" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Comments</label>
                            <textarea class="form-control" name="comments" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Submit Feedback</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openFeedbackModal(productId) {
            document.getElementById('productId').value = productId;
            new bootstrap.Modal(document.getElementById('feedbackModal')).show();
        }

        document.getElementById('starRating').addEventListener('click', function(e) {
            if(e.target.matches('i')) {
                const rating = e.target.dataset.rating;
                document.getElementById('ratingInput').value = rating;
                
                // Update star display
                const stars = this.getElementsByTagName('i');
                for(let i = 0; i < stars.length; i++) {
                    stars[i].className = i < rating ? 'bi bi-star-fill' : 'bi bi-star';
                }
            }
        });

        document.getElementById('starRating').addEventListener('mouseover', function(e) {
            if(e.target.matches('i')) {
                const rating = e.target.dataset.rating;
                const stars = this.getElementsByTagName('i');
                for(let i = 0; i < stars.length; i++) {
                    stars[i].className = i < rating ? 'bi bi-star-fill' : 'bi bi-star';
                }
            }
        });
    </script>
</body>
</html>