	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <title>Add Fee Payment</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	
	        .status-options {
	            display: flex;
	            gap: 10px;
	        }
	
	        .status-option {
	            flex: 1;
	        }
	
	        .status-option input {
	            display: none;
	        }
	
	        .status-option label {
	            display: block;
	            padding: 8px;
	            border: 1px solid #ddd;
	            border-radius: 4px;
	            text-align: center;
	            cursor: pointer;
	        }
	
	        .status-option input:checked + label {
	            background-color: #3498db;
	            color: white;
	            border-color: #3498db;
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
	            
	            .status-options {
	                flex-direction: column;
	            }
	        }
	    </style>
	</head>
	<body>
	    <div class="container">
	        <a href="index.jsp" class="back-link">Back to Dashboard</a>
	        <h2>Add Fee Payment</h2>
	        <p class="subtitle">Quickly record a payment</p>
	
	        <form action="addPayment" method="post">
	            <div class="form-row">
	                <div class="form-group">
	                    <label for="studentId">Student ID</label>
	                    <input type="text" id="studentId" name="studentId" placeholder="S12345" required>
	                </div>
	                <div class="form-group">
	                    <label for="studentName">Student Name</label>
	                    <input type="text" id="studentName" name="studentName" placeholder="John Doe" required>
	                </div>
	            </div>
	
	            <div class="form-row">
	                <div class="form-group">
	                    <label for="paymentDate">Payment Date</label>
	                    <input type="date" id="paymentDate" name="paymentDate" required>
	                </div>
	                <div class="form-group">
	                    <label for="amount">Amount</label>
	                    <input type="number" id="amount" name="amount" placeholder="0.00" required min="1" step="0.01">
	                </div>
	            </div>
	
	            <div class="form-group">
	                <label>Payment Status</label>
	                <div class="status-options">
	                    <div class="status-option">
	                        <input type="radio" id="paid" name="status" value="Paid" checked>
	                        <label for="paid">Paid</label>
	                    </div>
	                    <div class="status-option">
	                        <input type="radio" id="overdue" name="status" value="Overdue">
	                        <label for="overdue">Overdue</label>
	                    </div>
	                </div>
	            </div>
	
	            <button type="submit" class="submit-button">Save Payment</button>
	        </form>
	    </div>
	
	    <script>
	        // Set today's date as default
	        document.getElementById("paymentDate").value = new Date().toISOString().split("T")[0];
	    </script>
	</body>
	</html>