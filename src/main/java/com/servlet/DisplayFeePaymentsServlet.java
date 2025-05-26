package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


public class DisplayFeePaymentsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeePaymentDAO dao = new FeePaymentDAO();
        try {
            List<FeePayment> list = dao.getAllPayments();
            System.out.println("Fetching payments...");
            System.out.println("Number of payments: " + list.size());
            for (FeePayment p : list) {
                System.out.println(p.getStudentName() + " paid " + p.getAmount());
            }

            request.setAttribute("paymentList", list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("feepaymentdisplay.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error fetching fee payments");
        }
    }
}
