<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #3498db;
            outline: none;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .message {
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .message-error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .message-info {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
        }

        .button-group {
            text-align: center;
            margin-top: 30px;
        }

        .required {
            color: #e74c3c;
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-edit"></i> Update Payment Record</h1>
        <p>Modify payment information below</p>
    </div>

    <%
    String error = request.getParameter("error");
    if (error != null && !error.trim().isEmpty()) {
    %>
        <div class="message message-error">
            <i class="fas fa-exclamation-circle"></i> <%= error %>
        </div>
    <%
    }

    // Get payment ID from URL parameter
    String paymentIdParam = request.getParameter("id");
    Map<String, Object> paymentData = null;

    if (paymentIdParam != null && !paymentIdParam.trim().isEmpty()) {
        try {
            int paymentId = Integer.parseInt(paymentIdParam);

            String jdbcURL = "jdbc:mysql://localhost:3306/college_fees";
            String jdbcUsername = "root";
            String jdbcPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "SELECT * FROM FeePayments WHERE PaymentID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                paymentData = new HashMap<>();
                paymentData.put("PaymentID", rs.getInt("PaymentID"));
                paymentData.put("StudentID", rs.getString("StudentID"));
                paymentData.put("StudentName", rs.getString("StudentName"));
                paymentData.put("PaymentDate", rs.getDate("PaymentDate"));
                paymentData.put("Amount", rs.getDouble("Amount"));
                paymentData.put("Status", rs.getString("Status"));
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (paymentData == null && paymentIdParam != null) {
    %>
        <div class="message message-error">
            <i class="fas fa-exclamation-circle"></i> Payment ID <%= paymentIdParam %> not found in the system.
        </div>
    <%
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    %>

    <form action="updatePayment" method="POST">
        <div class="form-group">
            <label for="paymentId">Payment ID <span class="required">*</span></label>
            <input type="number" id="paymentId" name="paymentId"
                   value="<%= paymentData != null ? paymentData.get("PaymentID") : (paymentIdParam != null ? paymentIdParam : "") %>"
                   required <%= paymentData != null ? "readonly" : "" %>>
        </div>

        <div class="form-group">
            <label for="studentId">Student ID</label>
            <input type="text" id="studentId" name="studentId"
                   value="<%= paymentData != null && paymentData.get("StudentID") != null ? paymentData.get("StudentID") : "" %>">
        </div>

        <div class="form-group">
            <label for="studentName">Student Name <span class="required">*</span></label>
            <input type="text" id="studentName" name="studentName"
                   value="<%= paymentData != null ? paymentData.get("StudentName") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <label for="paymentDate">Payment Date <span class="required">*</span></label>
            <input type="date" id="paymentDate" name="paymentDate"
                   value="<%= paymentData != null ? sdf.format((java.util.Date) paymentData.get("PaymentDate")) : "" %>"
                   required>
        </div>

        <div class="form-group">
            <label for="amount">Amount (₹) <span class="required">*</span></label>
            <input type="number" id="amount" name="amount" step="0.01" min="0"
                   value="<%= paymentData != null ? paymentData.get("Amount") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <label for="status">Status <span class="required">*</span></label>
            <select id="status" name="status" required>
                <option value="">Select Status</option>
                <option value="Paid" <%= paymentData != null && "Paid".equals(paymentData.get("Status")) ? "selected" : "" %>>Paid</option>
                <option value="Pending" <%= paymentData != null && "Pending".equals(paymentData.get("Status")) ? "selected" : "" %>>Pending</option>
                <option value="Overdue" <%= paymentData != null && "Overdue".equals(paymentData.get("Status")) ? "selected" : "" %>>Overdue</option>
            </select>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Update Payment
            </button>
            <a href="feepaymentdisplay.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to List
            </a>
        </div>
    </form>

</div>
</body>
</html>
