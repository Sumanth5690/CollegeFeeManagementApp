<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
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
            max-width: 600px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-top: 0;
        }

        .subtitle {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            border-color: #3498db;
            outline: none;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 15px;
        }

        .submit-button:hover {
            background-color: #2980b9;
        }

        .back-link {
            display: inline-block;
            color: #3498db;
            text-decoration: none;
            margin-bottom: 15px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="back-link">← Back to Dashboard</a>
        <h2>Generate Reports</h2>
        <p class="subtitle">Select the type of report you want to generate</p>
        
        <form action="report" method="post">
            <div class="form-group">
                <label for="reportType">Report Type</label>
                <select id="reportType" name="reportType" required>
                    <option value="" disabled selected>Select report type</option>
                    <option value="overdue">Students with Overdue Payments</option>
                    <option value="notPaid">Students Who Haven't Paid in a Period</option>
                    <option value="total">Total Collection Over a Date Range</option>
                </select>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <input type="date" id="startDate" name="startDate" />
                </div>
                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="date" id="endDate" name="endDate" />
                </div>
            </div>

            <button type="submit" class="submit-button">
                <i class="fas fa-file-alt"></i> Generate Report
            </button>
        </form>
    </div>
</body>
</html>