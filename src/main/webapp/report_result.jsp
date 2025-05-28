<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.model.FeePayment" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Report Results</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <style>
    /* === Base Styles === */
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #0f0f0f;
      color: #f1f5f9;
      display: flex;
      justify-content: center;
      padding: 2rem;
      min-height: 100vh;
      box-sizing: border-box;
    }

    .container {
      background-color: #18181b;
      border-radius: 16px;
      padding: 2rem 2.5rem;
      width: 100%;
      max-width: 900px;
      border: 1px solid #27272a;
      box-sizing: border-box;
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }

    h2 {
      font-size: 2rem;
      font-weight: 700;
      background: linear-gradient(to right, #d1d5db, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 0;
      text-align: center;
    }

    .report-title {
      font-size: 1.25rem;
      font-weight: 600;
      color: #94a3b8;
      text-align: center;
      user-select: none;
    }

    .date-range {
      text-align: center;
      color: #94a3b8;
      font-size: 1rem;
      user-select: none;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #1f1f23;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 0 8px rgba(59, 130, 246, 0.3);
    }

    thead {
      background-color: #27272a;
      user-select: none;
    }

    th, td {
      padding: 0.75rem 1rem;
      text-align: left;
      border-bottom: 1px solid #3f3f46;
      color: #f1f5f9;
      font-size: 0.95rem;
    }

    th {
      font-weight: 600;
      color: #a5b4fc;
    }

    tbody tr:hover {
      background-color: #3b82f6;
      color: #fff;
      cursor: default;
    }

    tbody tr:last-child td {
      border-bottom: none;
    }

    tbody tr td[colspan="6"] {
      text-align: center;
      font-style: italic;
      color: #f87171;
      font-weight: 600;
    }

    .total-amount {
      font-weight: 700;
      font-size: 1.1rem;
      color: #3b82f6;
      text-align: right;
      margin-top: 1rem;
      user-select: none;
    }

    a.back-link {
      align-self: center;
      margin-top: 2rem;
      color: #60a5fa;
      text-decoration: none;
      font-size: 1rem;
      font-weight: 600;
      border: 1px solid #3b82f6;
      padding: 0.5rem 1.5rem;
      border-radius: 12px;
      transition: background-color 0.2s ease;
      user-select: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    a.back-link:hover {
      background-color: #3b82f6;
      color: white;
    }

    /* Responsive */
    @media (max-width: 640px) {
      th, td {
        font-size: 0.85rem;
        padding: 0.5rem 0.75rem;
      }
      a.back-link {
        width: 100%;
        justify-content: center;
      }
    }
  </style>
</head>
<body>
  <div class="container">
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

    <a href="index.jsp" class="back-link">
      <i class="fas fa-arrow-left"></i> Back to Home
    </a>
  </div>
</body>
</html>
