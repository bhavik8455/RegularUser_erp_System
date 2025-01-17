<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductPojo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Catalog</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .category-btn.active {
            background-color: #0d6efd !important;
            color: white !important;
        }
        .cart-count {
            position: relative;
            top: -10px;
            right: -5px;
            padding: 2px 6px;
            border-radius: 50%;
            font-size: 12px;
        }
        .quantity-input {
            width: 80px !important;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
        <div class="container">
            <a class="navbar-brand" href="HomePage">Product Catalog</a>
            <div class="ms-auto">
                <a href="ViewCart" class="btn btn-outline-primary position-relative">
                    <i class="bi bi-cart3"></i> Cart
                    <span class="badge bg-danger cart-count">
                        <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : "0" %>
                    </span>
                </a>
            </div>
        </div>
    </nav>

    <!-- Error Message Section -->
    <% if(request.getAttribute("errorMessage") != null) { %>
    <div class="container mt-3">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= request.getAttribute("errorMessage") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
    <% } %>

    <div class="container py-4">
        <!-- Categories Section -->
        <div class="card mb-4">
            <div class="card-body">
                <h2 class="card-title mb-3">Product Categories</h2>
                <div class="d-flex flex-wrap gap-2">
                    <a href="HomePage" class="btn btn-outline-primary category-btn <%= request.getParameter("Category") == null ? "active" : "" %>">
                        All Products
                    </a>
                    <%
                    List<String> categories = (List<String>) request.getAttribute("categories");
                    if(categories != null) {
                        for(String category : categories) {
                            String isActive = category.equals(request.getParameter("Category")) ? "active" : "";
                    %>
                        <a href="HomePage?Category=<%= category %>" 
                           class="btn btn-outline-primary category-btn <%= isActive %>">
                            <%= category %>
                        </a>
                    <%
                        }
                    }
                    %>
                </div>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
            <%
            List<ProductPojo> products = (List<ProductPojo>) request.getAttribute("products");
            if(products != null) {
                for(ProductPojo product : products) {
            %>
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getP_Name() %></h5>
                            <p class="card-text text-muted">Category: <%= product.getP_Category() %></p>
                            <p class="card-text">
                                <span class="fs-5 text-success fw-bold">
                                    $<%= String.format("%.2f", product.getP_SellingPrice()) %>
                                </span>
                            </p>
                            
                            <% if(product.getP_Stock() > 0) { %>
                                <div class="alert alert-success py-2" role="alert">
                                    In Stock (<%= product.getP_Stock() %> available)
                                </div>
                                <form action="AddToCart" method="POST" class="mt-3">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <input type="hidden" name="currentCategory" 
                                           value="<%= request.getParameter("Category") %>">
                                    <div class="d-flex gap-2 align-items-center">
                                        <div class="input-group input-group-sm quantity-input">
                                            <span class="input-group-text">Qty</span>
                                            <input type="number" 
                                                   class="form-control" 
                                                   name="quantity" 
                                                   value="1" 
                                                   min="1" 
                                                   max="<%= product.getP_Stock() %>"
                                                   required>
                                        </div>
                                        <button type="submit" class="btn btn-success flex-grow-1">
                                            <i class="bi bi-cart-plus"></i> Add to Cart
                                        </button>
                                    </div>
                                </form>
                            <% } else { %>
                                <div class="alert alert-danger py-2" role="alert">
                                    Out of Stock
                                </div>
                                <button class="btn btn-success w-100" disabled>
                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                </button>
                            <% } %>
                        </div>
                    </div>
                </div>
            <%
                }
            }
            %>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>