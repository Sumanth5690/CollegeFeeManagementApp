<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Fee Payment Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        .main-container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Header */
        .header-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .header-title {
            font-size: 2.2rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .header-subtitle {
            color: #7f8c8d;
            font-size: 1.1rem;
            margin: 0;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            border: 1px solid #e9ecef;
        }

        .stat-card:hover {
            background-color: #3498db;
            color: white;
            transition: all 0.3s ease;
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            color: #3498db;
        }

        .stat-card:hover .stat-icon {
            color: white;
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            font-weight: 600;
            color: #7f8c8d;
        }

        .stat-card:hover .stat-label {
            color: white;
        }

        /* Content Card */
        .content-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 25px;
            border: 1px solid #e9ecef;
        }

        /* Table Styles */
        .table-responsive {
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }

        .data-table th {
            background-color: #3498db;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
            border-bottom: 2px solid #2980b9;
        }

        .data-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        .data-table tbody tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .data-table tbody tr:hover {
            background-color: #e3f2fd;
        }

        .amount-cell {
            font-weight: bold;
        }

        /* Status badges */
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
            min-width: 70px;
            text-align: center;
        }

        .status-paid {
            background-color: #27ae60;
            color: white;
        }

        .status-pending {
            background-color: #f39c12;
            color: white;
        }

        .status-overdue {
            background-color: #e74c3c;
            color: white;
        }

        /* No data illustration */
        .no-data-illustration {
            text-align: center;
            color: #7f8c8d;
            padding: 40px;
        }

        .no-data-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #bdc3c7;
        }

        .no-data-illustration h3 {
            color: #2c3e50;
            margin-bottom: 10px;
        }

        /* Alerts */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .alert-warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
        }

        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .alert h4, .alert h5 {
            color: inherit;
            margin-top: 0;
        }

        /* Footer */
        .footer-info {
            margin-top: 30px;
            text-align: center;
            font-size: 0.9rem;
            color: #7f8c8d;
            border-top: 1px solid #e9ecef;
            padding-top: 20px;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .main-container {
                padding: 20px;
                margin: 10px;
            }

            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
            }

            .header-title {
                font-size: 1.8rem;
            }

            .data-table {
                font-size: 0.9rem;
            }

            .data-table th,
            .data-table td {
                padding: 8px;
            }
        }

        /* Font Awesome icons fallback */
        .fas {
            display: inline-block;
            font-style: normal;
            font-variant: normal;
            text-rendering: auto;
            line-height: 1;
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
<div class="main-container">
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
                    <div class="alert alert-warning">
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
                    <i class="fas fa-check-circle stat-icon"></i>
                    <div class="stat-number"><%= paidCount %></div>
                    <div class="stat-label">Paid</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-exclamation-triangle stat-icon"></i>
                    <div class="stat-number"><%= overdueCount + pendingCount %></div>
                    <div class="stat-label">Pending/Overdue</div>
                </div>
            </div>

            <!-- Payment Records Table -->
            <div class="content-card">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
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
        <div class="alert alert-danger">
            <h4><i class="fas fa-exclamation-circle"></i> Driver Configuration Error</h4>
            <p><strong>Issue:</strong> MySQL JDBC Driver not found in classpath.</p>
            <p><strong>Details:</strong> <%= e.getMessage() %></p>
            <p><strong>Solution:</strong> Ensure mysql-connector-java JAR is included in your project dependencies.</p>
        </div>
    <%
    } catch (SQLException e) {
    %>
        <div class="alert alert-danger">
            <h4><i class="fas fa-database"></i> Database Connection Error</h4>
            <p><strong>Issue:</strong> Failed to connect to database or execute query.</p>
            <p><strong>Details:</strong> <%= e.getMessage() %></p>
            <div style="margin-top: 15px;">
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
        <div class="alert alert-danger">
            <h4><i class="fas fa-bug"></i> Unexpected System Error</h4>
            <p><strong>Error:</strong> <%= e.getMessage() %></p>
        </div>
    <%
    } finally {
        // Clean up resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<div class='alert alert-warning'><i class='fas fa-exclamation-triangle'></i> Warning: Error closing database resources: " + e.getMessage() + "</div>");
        }
    }
    %>

    <div class="footer-info">
        <p><i class="fas fa-info-circle"></i> Fee Payment Management System | Database: college_fees | Table: FeePayments</p>
        <p style="margin: 5px 0 0 0;"><small>System automatically refreshes data on each page load</small></p>
    </div>
</div>
</body>
</html>