<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Fee Payment Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
      /* === Dark themed base === */
      body {
        background-color: #0f0f0f;
        color: #e0e7ff;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        padding: 2rem 1rem;
        min-height: 100vh;
      }

      .main-container {
        max-width: 1000px;
        margin: auto;
        background-color: #1e1e2f;
        border-radius: 18px;
        padding: 2rem 2.5rem;
        box-shadow: 0 0 20px rgba(59, 130, 246, 0.3);
      }

      /* Header */
      .header-section {
        text-align: center;
        margin-bottom: 2rem;
      }

      .header-title {
        font-size: 2.4rem;
        font-weight: 900;
        background: linear-gradient(90deg, #3b82f6, #9333ea);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        user-select: none;
      }

      .header-subtitle {
        color: #94a3b8;
        font-weight: 500;
        margin-top: 0.25rem;
        font-size: 1.1rem;
        user-select: none;
      }

      /* Stats Grid */
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
      }

      .stat-card {
        background-color: #27272a;
        border-radius: 14px;
        padding: 1.5rem 1.25rem;
        text-align: center;
        box-shadow: 0 0 8px rgba(59, 130, 246, 0.25);
        user-select: none;
        transition: background-color 0.3s ease;
      }

      .stat-card:hover {
        background-color: #3b82f6;
        color: white;
        cursor: default;
      }

      .stat-icon {
        font-size: 2.2rem;
        margin-bottom: 0.5rem;
        color: #60a5fa;
      }

      .stat-number {
        font-size: 1.8rem;
        font-weight: 800;
        margin-bottom: 0.25rem;
      }

      .stat-label {
        font-weight: 600;
        color: #a5b4fc;
      }

      /* Content Card for table and no data message */
      .content-card {
        background-color: #27272a;
        border-radius: 18px;
        padding: 1.75rem 1.5rem;
        box-shadow: 0 0 14px rgba(59, 130, 246, 0.3);
      }

      /* Table Styles */
      .data-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        color: #f1f5f9;
      }

      .table-header {
        background-color: #3b3b46;
        user-select: none;
      }

      .table-header th {
        border-bottom: 2px solid #60a5fa;
        padding: 0.85rem 1rem;
        font-weight: 700;
        font-size: 1rem;
        color: #a5b4fc;
      }

      .data-table tbody tr {
        background-color: #1f1f23;
        transition: background-color 0.25s ease;
        cursor: default;
      }

      .data-table tbody tr:hover {
        background-color: #3b82f6;
        color: white;
      }

      .data-table tbody td {
        padding: 0.7rem 1rem;
        vertical-align: middle;
        font-size: 0.95rem;
      }

      .amount-cell {
        font-weight: 700;
      }

      /* Status badges */
      .status-badge {
        padding: 0.35em 0.8em;
        border-radius: 9999px;
        font-weight: 600;
        font-size: 0.85rem;
        user-select: none;
        display: inline-block;
        min-width: 70px;
        text-align: center;
      }
      .status-paid {
        background-color: #22c55e;
        color: #d1fae5;
      }
      .status-pending {
        background-color: #facc15;
        color: #713f12;
      }
      .status-overdue {
        background-color: #ef4444;
        color: #fef2f2;
      }

      /* No data illustration */
      .no-data-illustration {
        text-align: center;
        color: #f87171;
      }
      .no-data-icon {
        font-size: 5rem;
        margin-bottom: 1rem;
        opacity: 0.7;
      }

      /* Alerts style overrides */
      .status-alert {
        background-color: #2a2a37 !important;
        border-color: #3b82f6 !important;
        color: #cbd5e1 !important;
        user-select: text;
      }

      .status-alert h4, .status-alert h5 {
        color: #93c5fd !important;
      }

      /* Footer */
      .footer-info {
        margin-top: 2.5rem;
        text-align: center;
        font-size: 0.9rem;
        color: #94a3b8;
        user-select: none;
      }

      /* Responsive tweaks */
      @media (max-width: 768px) {
        .stats-grid {
          grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
        }

        .header-title {
          font-size: 2rem;
        }
      }
    </style>
</head>
<body>
<div class="container main-container">
    <div class="header-section">
        <h1 class="header-title">
            <i class="fas fa-university"></i>
            Fee Payment Management
        </h1>
        <p class="header-subtitle">Comprehensive Student Fee Tracking System</p>
    </div>

    <%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    int totalRecords = 0;
    double totalAmount = 0;
    int paidCount = 0, pendingCount = 0, overdueCount = 0;

    try {
        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/college_fees";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        // Execute query
        String sql = "SELECT * FROM FeePayments ORDER BY PaymentDate DESC";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        // Collect records and calculate statistics
        List<Map<String, Object>> records = new ArrayList<>();

        while (rs.next()) {
            Map<String, Object> record = new HashMap<>();
            record.put("PaymentID", rs.getInt("PaymentID"));
            record.put("StudentID", rs.getInt("StudentID"));
            record.put("StudentName", rs.getString("StudentName"));
            record.put("PaymentDate", rs.getDate("PaymentDate"));
            record.put("Amount", rs.getDouble("Amount"));
            record.put("Status", rs.getString("Status"));
            records.add(record);

            totalRecords++;
            totalAmount += rs.getDouble("Amount");

            String status = rs.getString("Status");
            if ("Paid".equalsIgnoreCase(status)) paidCount++;
            else if ("Pending".equalsIgnoreCase(status)) pendingCount++;
            else if ("Overdue".equalsIgnoreCase(status)) overdueCount++;
        }

        if (totalRecords == 0) {
    %>
            <div class="content-card">
                <div class="no-data-illustration">
                    <i class="fas fa-inbox no-data-icon"></i>
                    <h3>No Payment Records Found</h3>
                    <p>The FeePayments table exists but contains no data records.</p>
                    <div class="alert alert-warning status-alert mt-4">
                        <h5><i class="fas fa-exclamation-triangle"></i> Suggested Actions:</h5>
                        <p class="mb-2">To resolve this issue, please consider the following steps:</p>
                        <p class="mb-1">• Insert sample data into the FeePayments table</p>
                        <p class="mb-1">• Verify table structure matches expected schema</p>
                        <p class="mb-0">• Check if data exists using MySQL Workbench or command line</p>
                    </div>
                </div>
            </div>
    <%
        } else {
    %>
            <!-- Statistics Dashboard -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-receipt stat-icon"></i>
                    <div class="stat-number"><%= totalRecords %></div>
                    <div class="stat-label">Total Payments</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-rupee-sign stat-icon"></i>
                    <div class="stat-number">₹<%= String.format("%.2f", totalAmount) %></div>
                    <div class="stat-label">Total Amount</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-check-circle stat-icon" style="color: #22c55e;"></i>
                    <div class="stat-number"><%= paidCount %></div>
                    <div class="stat-label">Paid</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-exclamation-triangle stat-icon" style="color: #facc15;"></i>
                    <div class="stat-number"><%= overdueCount + pendingCount %></div>
                    <div class="stat-label">Pending/Overdue</div>
                </div>
            </div>

            <!-- Payment Records Table -->
            <div class="content-card">
                <div class="table-responsive">
                    <table class="table data-table mb-0">
                        <thead class="table-header">
                            <tr>
                                <th><i class="fas fa-hashtag"></i> Payment ID</th>
                                <th><i class="fas fa-user-graduate"></i> Student ID</th>
                                <th><i class="fas fa-user"></i> Student Name</th>
                                <th><i class="fas fa-calendar"></i> Payment Date</th>
                                <th><i class="fas fa-rupee-sign"></i> Amount</th>
                                <th><i class="fas fa-info-circle"></i> Status</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                for (Map<String, Object> record : records) {
                    String status = (String) record.get("Status");
                    String statusClass = "status-pending";
                    if ("Paid".equalsIgnoreCase(status)) statusClass = "status-paid";
                    else if ("Overdue".equalsIgnoreCase(status)) statusClass = "status-overdue";
        %>
                            <tr>
                                <td><strong><%= record.get("PaymentID") %></strong></td>
                                <td><%= record.get("StudentID") %></td>
                                <td><%= record.get("StudentName") %></td>
                                <td><%= record.get("PaymentDate") %></td>
                                <td class="amount-cell">₹<%= String.format("%.2f", (Double) record.get("Amount")) %></td>
                                <td><span class="status-badge <%= statusClass %>"><%= record.get("Status") %></span></td>
                            </tr>
        <%
                }
        %>
                        </tbody>
                    </table>
                </div>
            </div>
    <%
        }

    } catch (ClassNotFoundException e) {
    %>
        <div class="alert alert-danger status-alert">
            <h4><i class="fas fa-exclamation-circle"></i> Driver Configuration Error</h4>
            <p><strong>Issue:</strong> MySQL JDBC Driver not found in classpath.</p>
            <p><strong>Details:</strong> <%= e.getMessage() %></p>
            <p><strong>Solution:</strong> Ensure mysql-connector-java JAR is included in your project dependencies.</p>
        </div>
    <%
    } catch (SQLException e) {
    %>
        <div class="alert alert-danger status-alert">
            <h4><i class="fas fa-database"></i> Database Connection Error</h4>
            <p><strong>Issue:</strong> Failed to connect to database or execute query.</p>
            <p><strong>Details:</strong> <%= e.getMessage() %></p>
            <div class="mt-3">
                <p><strong>Possible Causes:</strong></p>
                <p>• MySQL server is not running on localhost:3306</p>
                <p>• Database 'college_fees' does not exist</p>
                <p>• Table 'FeePayments' does not exist</p>
                <p>• Connection credentials are incorrect</p>
            </div>
        </div>
    <%
    } catch (Exception e) {
    %>
        <div class="alert alert-danger status-alert">
            <h4><i class="fas fa-bug"></i> Unexpected System Error</h4>
            <p><strong>Error:</strong> <%= e.getMessage() %></p>
            <details class="mt-3">
                <summary>View Technical Details</summary>
                <pre class="mt-2" style="background: #f8f9fa; padding: 1rem; border-radius: 8px; font-size: 0.8rem;"><%= java.util.Arrays.toString(e.getStackTrace()) %></pre>
            </details>
        </div>
    <%
    } finally {
        // Clean up resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<div class='alert alert-warning status-alert'><i class='fas fa-exclamation-triangle'></i> Warning: Error closing database resources: " + e.getMessage() + "</div>");
        }
    }
    %>

    <div class="footer-info">
        <p><i class="fas fa-info-circle"></i> Fee Payment Management System | Database: college_fees | Table: FeePayments</p>
        <p class="mb-0"><small>System automatically refreshes data on each page load</small></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
