<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fee Payment Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --background-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --border-radius: 12px;
        }

        body {
            background: var(--background-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        .main-container {
            padding: 2rem 0;
            min-height: 100vh;
        }

        .header-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header-title {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header-subtitle {
            color: #666;
            font-size: 1.1rem;
            font-weight: 300;
        }

        .content-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(15px);
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .status-alert {
            border: none;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        .alert-success {
            background: linear-gradient(135deg, rgba(39, 174, 96, 0.1), rgba(39, 174, 96, 0.05));
            border-left: 4px solid var(--success-color);
            color: #1e7e34;
        }

        .alert-warning {
            background: linear-gradient(135deg, rgba(243, 156, 18, 0.1), rgba(243, 156, 18, 0.05));
            border-left: 4px solid var(--warning-color);
            color: #856404;
        }

        .alert-danger {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(231, 76, 60, 0.05));
            border-left: 4px solid var(--accent-color);
            color: #721c24;
        }

        .data-table {
            margin: 0;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .table-header {
            background: linear-gradient(135deg, var(--primary-color), #34495e);
            color: white;
        }

        .table-header th {
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 1.2rem;
            border: none;
            text-transform: uppercase;
            font-size: 0.85rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border: none;
        }

        .table tbody tr:hover {
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.1), rgba(52, 152, 219, 0.05));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .table tbody td {
            padding: 1.2rem;
            vertical-align: middle;
            border-color: #e9ecef;
            font-weight: 500;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-paid {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }

        .status-pending {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .status-overdue {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .amount-cell {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--success-color);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            text-align: center;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--secondary-color);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .no-data-illustration {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .no-data-icon {
            font-size: 4rem;
            color: var(--warning-color);
            margin-bottom: 1rem;
        }

        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid var(--secondary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .footer-info {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            text-align: center;
            color: #666;
            font-size: 0.9rem;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .header-title {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .table-responsive {
                border-radius: var(--border-radius);
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
                    <i class="fas fa-check-circle stat-icon" style="color: var(--success-color);"></i>
                    <div class="stat-number"><%= paidCount %></div>
                    <div class="stat-label">Paid</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-exclamation-triangle stat-icon" style="color: var(--accent-color);"></i>
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