package com.servlet;

import com.dao.FeePaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deletePayment")
public class DeleteFeePaymentServlet extends HttpServlet {
    private FeePaymentDAO dao;

    @Override
    public void init() {
        dao = new FeePaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String paymentIdStr = request.getParameter("paymentId");
        
        // Debug: Print received parameter
        System.out.println("Received paymentId parameter: " + paymentIdStr);
        
        try {
            // Validate input
            if (paymentIdStr == null || paymentIdStr.trim().isEmpty()) {
                System.out.println("Payment ID is null or empty");
                response.sendRedirect("feepaymentdisplay.jsp?error=Payment+ID+is+required");
                return;
            }

            int paymentId = Integer.parseInt(paymentIdStr.trim());
            System.out.println("Attempting to delete payment ID: " + paymentId);

            boolean isDeleted = dao.deletePayment(paymentId);

            if (isDeleted) {
                System.out.println("Payment deleted successfully");
                response.sendRedirect("feepaymentdisplay.jsp?message=Payment+deleted+successfully");
            } else {
                System.out.println("Payment not found or could not be deleted");
                response.sendRedirect("feepaymentdisplay.jsp?error=Payment+ID+" + paymentId + "+not+found+in+the+system");
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid number format: " + e.getMessage());
            response.sendRedirect("feepaymentdisplay.jsp?error=Invalid+Payment+ID+format");
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("feepaymentdisplay.jsp?error=Database+error+occurred");
        } catch (Exception e) {
            System.out.println("General Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("feepaymentdisplay.jsp?error=An+error+occurred+while+deleting+payment");
        }
    }
    
    // Also handle GET requests for testing
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}