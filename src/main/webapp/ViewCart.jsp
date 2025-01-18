<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: #321525;
            background-size: cover;
            font-family: Poppins;
            color: #e6d7e0;
        }

        .navbar {
            background-color: rgba(255, 255, 255, 0.1) !important;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .table {
            color: #e6d7e0;
        }

        .table thead th {
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
            color: #fff;
        }

        .table td, .table th {
            border-color: rgba(255, 255, 255, 0.1);
        }

        .table-light {
            background-color: rgba(255, 255, 255, 0.1) !important;
            color: #fff !important;
        }

        .text-muted {
            color: #b39dae !important;
        }

        .btn-outline-primary {
            color: #e6d7e0;
            border-color: #e6d7e0;
        }

        .btn-outline-primary:hover {
            background-color: #4a2038;
            border-color: #4a2038;
            color: #fff;
        }

        .btn-success {
            background-color: #4a2038;
            border-color: #4a2038;
        }

        .btn-success:hover {
            background-color: #5c2847;
            border-color: #5c2847;
        }

        .btn-danger {
            background-color: #8b3049;
            border-color: #8b3049;
        }

        .btn-danger:hover {
            background-color: #a13857;
            border-color: #a13857;
        }

        .form-select {
            background-color: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.1);
            color: #e6d7e0;
        }

        .form-select option {
            background-color: #321525;
            color: #e6d7e0;
        }

        .card-title {
            color: #fff;
            font-weight: 600;
        }

        .table-total {
            background-color: #321525;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: #4a2038;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #5c2847;
        }

        /* Additional styles for JSP elements */
        .alert-danger {
            background-color: rgba(139, 48, 73, 0.2);
            border-color: #8b3049;
            color: #e6d7e0;
        }

        .btn-primary {
            background-color: #4a2038;
            border-color: #4a2038;
        }

        .btn-primary:hover {
            background-color: #5c2847;
            border-color: #5c2847;
        }

        .navbar-brand {
            color: #e6d7e0 !important;
        }

        .bi-cart-x {
            color: #8b3049;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg border-bottom">
        <div class="container">
            <a class="navbar-brand" href="HomePage">
                <img src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp"
                    class="rounded-circle"
                    alt=""
                    height="40"
                    width="40" />Home
            </a>
        </div>
    </nav>

    <div class="container py-4">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title mb-4">Shopping Cart</h2>
                
                <%-- Error message display --%>
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <% if(request.getParameter("error").equals("processingError")) { %>
                            Failed to process payment. Please try again.
                        <% } else if(request.getParameter("error").equals("emptyCart")) { %>
                            Your cart is empty. Please add items before checkout.
                        <% } %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                
                <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if(cart == null || cart.isEmpty()) {
                %>
                    <div class="text-center py-5">
                        <i class="bi bi-cart-x fs-1"></i>
                        <p class="mt-3">Your cart is empty</p>
                        <a href="HomePage" class="btn btn-primary">Continue Shopping</a>
                    </div>
                <%
                } else {
                %>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                double total = 0;
                                for(CartItem item : cart) {
                                    total += item.getSubtotal();
                                %>
                                    <tr>
                                        <td>
                                            <h6 class="mb-0"><%= item.getProduct().getP_Name() %></h6>
                                            <small class="text-muted"><%= item.getProduct().getP_Category() %></small>
                                        </td>
                                        <td>$<%= String.format("%.2f", item.getProduct().getP_SellingPrice()) %></td>
                                        <td><%= item.getQuantity() %></td>
                                        <td>$<%= String.format("%.2f", item.getSubtotal()) %></td>
                                        <td>
                                            <form action="RemoveFromCart" method="POST" style="display: inline;">
                                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('Are you sure you want to remove this item?')">
                                                    <i class="bi bi-trash"></i> Remove
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                <%
                                }
                                %>
                            </tbody>
                            <tfoot>
                                <tr class="table-total">
                                    <td colspan="3" class="text-end fw-bold">Total:</td>
                                    <td class="fw-bold">$<%= String.format("%.2f", total) %></td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <a href="HomePage" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Continue Shopping
                        </a>
                        
                        <form action="ProcessSale" method="POST" class="d-flex gap-3 align-items-center">
                            <select name="paymentMethod" class="form-select" style="width: auto;" required>
                                <option value="">Select Payment Method</option>
                                <option value="Cash">Cash</option>
                                <option value="GPay">GPay</option>
                            </select>
                            
                            <button type="submit" class="btn btn-success">
                                Pay Now <i class="bi bi-arrow-right"></i>
                            </button>
                        </form>
                    </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>