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
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
        <div class="container">
            <a class="navbar-brand" href="HomePage">Product Catalog</a>
        </div>
    </nav>

    <div class="container py-4">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title mb-4">Shopping Cart</h2>
                
                <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if(cart == null || cart.isEmpty()) {
                %>
                    <div class="text-center py-5">
                        <i class="bi bi-cart-x fs-1 text-muted"></i>
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
                                <tr class="table-light">
                                    <td colspan="3" class="text-end fw-bold">Total:</td>
                                    <td class="fw-bold">$<%= String.format("%.2f", total) %></td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="HomePage" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Continue Shopping
                        </a>
                        <button class="btn btn-success">
                            Proceed to Checkout <i class="bi bi-arrow-right"></i>
                        </button>
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