<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductPojo" %>
<!DOCTYPE html>
<html lang="en">
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
            background-color: #702963 !important;
            color: white !important;
        }
        .category-btn.active:hover {
    background-color: #5a1f5f !important; /* Darker purple for hover */
    color: white !important; /* Maintain white text color */
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
        .main-heading {
            font-size: 40px;
        }
        .colors span {
            width: 15px;
            height: 15px;
            margin-right: 6px;
            display: inline-block;
            cursor: pointer;
        }
        body {
            background: rgb(255, 255, 255);
            background-size: cover;
            font-family: Poppins;
        }
        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            background: #000833;
            top: 0;
            left: 0;
            z-index: -1;
        }
        .dropdown-menu {
            background-color: #321535;
        }
        .dropdown-item {
            background-color: #e2c2f6;
            transition: background-color 0.3s, transform 0.3s;
        }
        .dropdown-item:hover {
            background-color: #321535;
            color: white;
            transform: translateX(10px);
        }
        .btn:hover {
            background-color: rgba(203, 139, 242, 0.5);
        }
        .form-control:focus {
            outline: none;
            box-shadow: none; 
        }
        .custom-navbar {
            background-color: #2e1a36;
        }
        .custom-card {
            background-color: #eed9f8;
            border-radius: 10px;
        }
        .custom-card img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }
        /* Adding some space between buttons */
/* Adding some space between buttons */
.btn {
    margin-right: 10px;
}

/* Styling for both buttons to have the same transparent background and transitions */
.view-feedbacks-button,
.cart-button {
    background-color: transparent; /* Transparent background */
    color: white; /* White text */
    border: 1px solid white; /* White border */
    padding: 10px 15px;
    transition: background-color 0.3s, color 0.3s, border-color 0.3s;
}

/* Hover effect for both buttons */
.view-feedbacks-button:hover,
.cart-button:hover {
    background-color: #6f42c1; /* Purple background on hover */
    color: white; /* Keep text color white */
    border-color: #6f42c1; /* Match border with hover color */
}

.cart-count {
    position: relative;
    top: -10px;
    right: -5px;
    padding: 2px 6px;
    border-radius: 50%;
    font-size: 12px;
}
.cart-count {
    background-color: #702963 !important; /* Light purple background */
}
.card-body {
    background-color: #e6ccf7; /* Lightish purple background for the card */
}


/* Set the background color of the category buttons to #702963 (dark purple) */
.category-btn {
    background-color: #702963; /* Dark purple color for buttons */
    color: white; /* White text color */
    border: 1px solid #702963; /* Dark purple border */
}



        
    </style>
</head>
<body class="bg-light">
    <div id="particles-js"></div>
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
            <div class="container">
                <img
                    src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp"
                    class="rounded-circle"
                    alt=""
                    height="40"
                    width="40"
                />
                <div class="collapse navbar-collapse" id="collapsibleNavId">
                    <ul class="navbar-nav me-auto mt-2 mt-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="Home.jsp" aria-current="page">Home <span class="visually-hidden">(current)</span></a>
                        </li>
                    </ul>
                   <button class="btn btn-outline-light my-2 my-sm-0 ms-1 view-feedbacks-button" type="button">View My Feedbacks</button>

<button type="button" class="btn ms-1 cart-button" onclick="window.location.href='ViewCart'">
    <i class="bi bi-cart3"></i> Cart
    <span class="badge bg-danger cart-count">
        <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : "0" %>
    </span>
</button>

<button type="button" class="btn ms-1" onclick="window.location.href='login.html';">
    <img class="rounded-circle" src="https://cdn-icons-png.flaticon.com/512/10813/10813372.png" alt="Button Image" height="40" width="40" />
</button>

                </div>
            </div>
        </nav>
    </header>
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
                    <a href="HomePage" class="btn btn-outline-purple category-btn <%= request.getParameter("Category") == null ? "active" : "" %>">
                        All Products
                    </a>
                    <%
                    List<String> categories = (List<String>) request.getAttribute("categories");
                    if(categories != null) {
                        for(String category : categories) {
                            String isActive = category.equals(request.getParameter("Category")) ? "active" : "";
                    %>
                        <a href="HomePage?Category=<%= category %>" 
                           class="btn btn-outline-purple category-btn <%= isActive %>">
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
    <script src="https://cdn.jsdelivr.net/npm/particles.js"></script>
    <script>
    particlesJS("particles-js", {
        "particles": {
            "number": {
                "value": 80,
                "density": {
                    "enable": true,
                    "value_area": 800
                }
            },
            "color": {
                "value": "#ffffff"
            },
            "shape": {
                "type": "circle",
                "stroke": {
                    "width": 0,
                    "color": "#000000"
                },
                "polygon": {
                    "nb_sides": 5
                }
            },
            "opacity": {
                "value": 0.5,
                "random": false,
                "anim": {
                    "enable": true,
                    "speed": 1,
                    "opacity_min": 0.1,
                    "sync": false
                }
            },
            "size": {
                "value": 3,
                "random": true,
                "anim": {
                    "enable": true,
                    "speed": 40,
                    "size_min": 0.1,
                    "sync": false
                }
            },
            "line_linked": {
                "enable": true,
                "distance": 150,
                "color": "#ffffff",
                "opacity": 0.4,
                "width": 1
            },
            "move": {
                "enable": true,
                "speed": 6,
                "direction": "none",
                "random": false,
                "straight": false,
                "out_mode": "out",
                "bounce": false,
                "attract": {
                    "enable": false,
                    "rotateX": 600,
                    "rotateY": 1200
                }
            }
        },
        "interactivity": {
            "detect_on": "canvas",
            "events": {
                "onhover": {
                    "enable": true,
                    "mode": "repulse"
                },
                "onclick": {
                    "enable": true,
                    "mode": "push"
                }
            }
        },
        "retina_detect": true
    });
    </script>
</body>
</html>