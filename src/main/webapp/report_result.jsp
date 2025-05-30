<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.model.FeePayment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            width: 100%;
            max-width: 900px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-top: 0;
            margin-bottom: 10px;
        }

        .report-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #7f8c8d;
            text-align: center;
            margin-bottom: 10px;
        }

        .date-range {
            text-align: center;
            color: #7f8c8d;
            font-size: 1rem;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #ddd;
        }

        thead {
            background-color: #3498db;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 0.95rem;
        }

        th {
            font-weight: 600;
            color: white;
        }

        td {
            color: #333;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr td[colspan="6"] {
            text-align: center;
            font-style: italic;
            color: #e74c3c;
            font-weight: 600;
        }

        .total-amount {
            font-weight: 700;
            font-size: 1.1rem;
            color: #2c3e50;
            text-align: right;
            margin-top: 15px;
            padding: 10px;
            background-color: #ecf0f1;
            border-radius: 4px;
        }

        .back-link {
            display: inline-block;
            color: #3498db;
            text-decoration: none;
            margin-top: 20px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        /* Responsive */
        @media (max-width: 640px) {
            th, td {
                font-size: 0.85rem;
                padding: 8px 10px;
            }
            
            table {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        
        <h2>Report Results</h2>

        <%
            String reportType = (String) request.getAttribute("reportType");
            List<FeePayment> reportData = (List<FeePayment>) request.getAttribute("reportData");
            Double totalCollection = (Double) request.getAttribute("totalCollection");
            String startDate = (String) request.getAttribute("startDate");
            String endDate = (String) request.getAttribute("endDate");

            String reportTitle = "Report";
            if ("overdue".equals(reportType)) {
                reportTitle = "Students with Overdue Payments";
            } else if ("notPaid".equals(reportType)) {
                reportTitle = "Students Who Haven't Paid";
            } else if ("total".equals(reportType)) {
                reportTitle = "Total Collection Report";
            }
        %>
        
        <div class="report-title"><%= reportTitle %></div>

        <% if (startDate != null && endDate != null) { %>
            <div class="date-range">
                <strong>Date Range:</strong> <%= startDate %> to <%= endDate %>
            </div>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Payment Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (reportData != null && !reportData.isEmpty()) {
                        for (FeePayment p : reportData) {
                %>
                    <tr>
                        <td><%= p.getPaymentId() %></td>
                        <td><%= p.getStudentId() %></td>
                        <td><%= p.getStudentName() %></td>
                        <td><%= p.getPaymentDate() != null ? p.getPaymentDate() : "N/A" %></td>
                        <td>₹<%= String.format("%.2f", p.getAmount()) %></td>
                        <td><%= p.getStatus() != null ? p.getStatus() : "N/A" %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6">No records found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <% if ("total".equals(reportType) && totalCollection != null) { %>
            <div class="total-amount">
                Total Collected Amount: ₹<%= String.format("%.2f", totalCollection) %>
            </div>
        <% } %>
    </div>
</body>
</html>