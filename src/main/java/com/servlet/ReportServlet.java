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
import java.util.List;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private FeePaymentDAO dao;

    @Override
    public void init() {
        dao = new FeePaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        List<FeePayment> reportData = null;
        double total = 0.0;

        try {
            switch (reportType) {
                case "overdue":
                    reportData = dao.getOverduePayments();
                    break;

                case "notPaid":
                    if (endDate == null || endDate.isEmpty()) {
                        throw new IllegalArgumentException("End date is required for notPaid report.");
                    }
                    java.sql.Date endDateParsed = java.sql.Date.valueOf(endDate);
                    reportData = dao.getUnpaidBeforeDate(endDateParsed);
                    break;

                case "total":
                    if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
                        throw new IllegalArgumentException(
                                "Start and end dates are required for total collection report.");
                    }
                    java.sql.Date startDateParsed = java.sql.Date.valueOf(startDate);
                    java.sql.Date endDateParsed2 = java.sql.Date.valueOf(endDate);

                    // Get total amount
                    total = dao.getTotalCollection(startDateParsed, endDateParsed2);
                    request.setAttribute("totalCollection", total);

                    // Get actual payment records for display
                    reportData = dao.getPaymentsBetweenDates(startDateParsed, endDateParsed2);
                    break;

                default:
                    throw new IllegalArgumentException("Invalid report type: " + reportType);
            }

            // Always set these
            request.setAttribute("reportType", reportType);
            request.setAttribute("reportData", reportData);

        } catch (IllegalArgumentException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }

        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
}