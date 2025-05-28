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
        try {
            String paymentIdStr = request.getParameter("paymentId");
            String studentId = request.getParameter("studentId"); // ✅ added
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
                throw new ServletException("All fields except Student ID are required.");
            }

            int paymentId = Integer.parseInt(paymentIdStr.trim());
            double amount = Double.parseDouble(amountStr.trim());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date paymentDate = sdf.parse(dateStr.trim());

            FeePayment payment = new FeePayment();
            payment.setPaymentId(paymentId);
            payment.setStudentId(studentId != null && !studentId.trim().isEmpty() ? studentId.trim() : null); // ✅
                                                                                                              // handle
                                                                                                              // null/empty
            payment.setStudentName(studentName.trim());
            payment.setPaymentDate(paymentDate);
            payment.setAmount(amount);
            payment.setStatus(status.trim());

            dao.updatePayment(payment);
            response.sendRedirect("feepaymentdisplay.jsp");

        } catch (NumberFormatException e) {
            throw new ServletException("Invalid number format: " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ServletException("Error updating fee payment: " + e.getMessage(), e);
        }
    }
}
