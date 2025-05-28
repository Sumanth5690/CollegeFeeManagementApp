package com.servlet;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/addPayment")
public class AddFeePaymentServlet extends HttpServlet {
    private FeePaymentDAO dao;
    
    @Override
    public void init() {
        dao = new FeePaymentDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Changed from int to String to handle alphanumeric student IDs
            String studentId = request.getParameter("studentId");
            String studentName = request.getParameter("studentName");
            String dateStr = request.getParameter("paymentDate");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = request.getParameter("status");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date paymentDate = sdf.parse(dateStr);
            
            FeePayment payment = new FeePayment();
            payment.setStudentId(studentId); // Now passing as String
            payment.setStudentName(studentName);
            payment.setPaymentDate(paymentDate);
            payment.setAmount(amount);
            payment.setStatus(status);
            
            dao.insertPayment(payment);
            response.sendRedirect("feepaymentdisplay.jsp");
            
        } catch (Exception e) {
            e.printStackTrace(); // Add this for debugging
            throw new ServletException("Error processing payment: " + e.getMessage(), e);
        }
    }
}