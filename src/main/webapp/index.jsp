<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Fee Payment System</title>
   <style>
    body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px 0;
    }

    header {
        background: #f8f9fa;
        padding: 20px 0;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    h1 {
        color: #2c3e50;
    }

    .highlight {
        color: #3498db;
    }
.services-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 5 equal-width columns */
    gap: 20px;
    padding-bottom: 10px;
}

.service-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    text-align: center;
    transition: all 0.3s ease;
    background-color: #fff;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    min-height: 260px;
}



    .service-card:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .service-icon {
        font-size: 2.5rem;
        color: #3498db;
        margin-bottom: 10px;
    }

    .service-link {
        display: inline-block;
        margin-top: 15px;
        color: #3498db;
        text-decoration: none;
        font-weight: bold;
    }

    .service-link:hover {
        text-decoration: underline;
    }

    footer {
        background: #f8f9fa;
        text-align: center;
        padding: 20px 0;
        margin-top: 40px;
        border-top: 1px solid #ddd;
    }
    
    @media (max-width: 1024px) {
    .services-grid {
        grid-template-columns: repeat(3, 1fr); /* 3 columns on tablets */
    }
}

@media (max-width: 768px) {
    .services-grid {
        grid-template-columns: repeat(2, 1fr); /* 2 columns on phones */
    }
}

@media (max-width: 480px) {
    .services-grid {
        grid-template-columns: 1fr; /* 1 column on very small screens */
    }
}
    

    @media (max-width: 768px) {
        .services-grid {
            grid-template-columns: 1fr;
        }

        .service-card {
            width: 100%;
        }
    }
</style>

</head>
<body>
    <header>
        <div class="container">
            <h1>College Fee <span class="highlight">Manager</span></h1>
        </div>
    </header>

    <main class="container">
        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon">+</div>
                <h3>Add feePayment</h3>
                <p>Add new fee payments with our streamlined interface</p>
                <a href="feepaymentadd.jsp" class="service-link">Add Payment →</a>
            </div>
            <div class="service-card">
                <div class="service-icon">✎</div>
                <h3>Update feePayment</h3>
                <p>Update existing payment records with ease</p>
                <a href="feepaymentupdate.jsp" class="service-link">Update Records →</a>
            </div>
            <div class="service-card">
                <div class="service-icon">📊</div>
                <h3>FeePayment Reports</h3>
                <p>Generate comprehensive reports on payment status</p>
                <a href="report_form.jsp" class="service-link">View Reports →</a>
            </div>
            <div class="service-card">
                <div class="service-icon">👁️</div>
                <h3>View allFeePayments</h3>
                <p>Monitor all payment transactions</p>
                <a href="feepaymentdisplay.jsp" class="service-link">Track Payments →</a>
            </div>
            <div class="service-card">
                <div class="service-icon">🗑️</div>
                <h3>Delete feePayment</h3>
                <p>Remove outdated payment records</p>
                <a href="feepaymentdelete.jsp" class="service-link">Manage Records →</a>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 College Fee Payment System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>