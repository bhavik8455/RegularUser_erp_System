package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;
import model.SalesPojo;
import operations.sales.Sales_Interface;
import operations.sales.Sales_Implementation;
import java.util.Date;

@WebServlet("/ProcessSale")
public class SalesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Sales_Interface salesInterface = new Sales_Implementation();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        String paymentMethod = request.getParameter("paymentMethod");
        
        int customerId = 1; // Replace with actual logged-in customer ID
        
        if (cart != null && !cart.isEmpty()) {
            try {
                // Process each cart item as a separate sale
                for (CartItem item : cart) {
                    SalesPojo sale = new SalesPojo();
                    sale.setProductId(item.getProduct().getId());
                    sale.setCustomerId(customerId);
                    sale.setDate(new Date());
                    sale.setQuantity(item.getQuantity());
                    sale.setTotalAmount(item.getSubtotal());
                    sale.setPaymentMethod(paymentMethod);
                    
                    // Process the sale
                    boolean success = salesInterface.processSale(sale);
                    if (!success) {
                        throw new Exception("Sale processing failed");
                    }
                }
                
                // Clear the cart after successful purchase
                session.removeAttribute("cart");
                session.removeAttribute("cartCount");
                
                // Forward to feedback page instead of redirect
                response.sendRedirect("Feedback");
                
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("ViewCart?error=processingError");
            }
        } else {
            response.sendRedirect("ViewCart?error=emptyCart");
        }
    }
}