package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/updatePayment")
public class UpdateFeePaymentServlet extends HttpServlet {
    private FeePaymentDAO dao;

    @Override
    public void init() {
        dao = new FeePaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String paymentIdStr = request.getParameter("paymentId");
        
        // Debug: Print received parameters
        System.out.println("Received paymentId parameter: " + paymentIdStr);
        
        try {
            String studentId = request.getParameter("studentId");
            String studentName = request.getParameter("studentName");
            String dateStr = request.getParameter("paymentDate");
            String amountStr = request.getParameter("amount");
            String status = request.getParameter("status");

            // Validate required fields (studentId can be optional)
            if (paymentIdStr == null || studentName == null ||
                    dateStr == null || amountStr == null || status == null ||
                    paymentIdStr.trim().isEmpty() || studentName.trim().isEmpty() ||
                    dateStr.trim().isEmpty() || amountStr.trim().isEmpty() ||
                    status.trim().isEmpty()) {
                
                System.out.println("Validation failed: Missing required fields");
                response.sendRedirect("feepaymentdisplay.jsp?error=All+fields+except+Student+ID+are+required");
                return;
            }

            int paymentId = Integer.parseInt(paymentIdStr.trim());
            double amount = Double.parseDouble(amountStr.trim());
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date paymentDate = sdf.parse(dateStr.trim());

            System.out.println("Attempting to update payment ID: " + paymentId);

            FeePayment payment = new FeePayment();
            payment.setPaymentId(paymentId);
            payment.setStudentId(studentId != null && !studentId.trim().isEmpty() ? studentId.trim() : null);
            payment.setStudentName(studentName.trim());
            payment.setPaymentDate(paymentDate);
            payment.setAmount(amount);
            payment.setStatus(status.trim());

            boolean isUpdated = dao.updatePayment(payment);

            if (isUpdated) {
                System.out.println("Payment updated successfully");
                response.sendRedirect("feepaymentdisplay.jsp?message=Payment+updated+successfully");
            } else {
                System.out.println("Payment ID not found: " + paymentId);
                response.sendRedirect("feepaymentdisplay.jsp?error=Payment+ID+" + paymentId + "+not+found+in+the+system");
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid number format: " + e.getMessage());
            response.sendRedirect("feepaymentdisplay.jsp?error=Invalid+number+format+in+Payment+ID+or+Amount");
        } catch (java.text.ParseException e) {
            System.out.println("Invalid date format: " + e.getMessage());
            response.sendRedirect("feepaymentdisplay.jsp?error=Invalid+date+format.+Use+YYYY-MM-DD");
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("feepaymentdisplay.jsp?error=Database+error+occurred+while+updating+payment");
        } catch (Exception e) {
            System.out.println("General Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("feepaymentdisplay.jsp?error=An+error+occurred+while+updating+payment");
        }
    }

    // Also handle GET requests for testing
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}