<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Fee Payment System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Inter', sans-serif;
            background: #0a0a0a;
            color: #ffffff;
            line-height: 1.6;
            overflow-x: hidden;
        }
        .card {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 100%; /* makes all cards equal height */
}
        	

        .nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(10, 10, 10, 0.9);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1rem 2rem;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #ffffff;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            list-style: none;
        }

        .nav-links a {
            color: #888;
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: 500;
        }

        .nav-links a:hover {
            color: #ffffff;
        }

        .cta-button {
            background: #3b82f6;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .cta-button:hover {
            background: #2563eb;
            transform: translateY(-1px);
        }

        .hero {
           
   padding: 2rem 1rem 1rem; /* Shrunk top and bottom padding */
    text-align: center;
    max-width: 1200px;
    margin: 0 auto;
        }

        .hero h1 {
            font-size: clamp(3rem, 8vw, 6rem);
            font-weight: 800;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #ffffff 0%, #888 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1.1;
        }

        .hero-highlight {
            background: linear-gradient(135deg, #3b82f6 0%, #06b6d4 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            font-size: 1.25rem;
            color: #888;
            max-width: 600px;
            margin: 0 auto 3rem;
            line-height: 1.6;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-primary {
            background: #3b82f6;
            color: white;
            padding: 1rem 2rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
        }

        .btn-secondary {
            background: transparent;
            color: #888;
            padding: 1rem 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            color: white;
            border-color: rgba(255, 255, 255, 0.4);
            transform: translateY(-2px);
        }

        .services {   
    padding: 2rem 1rem; /* Less vertical space */
    margin-top: -1rem; /* Pull cards upward */

        }

        .services-header {
            text-align: center;
            margin-bottom: 4rem;
        }

        .services-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #ffffff;
        }

        .services-subtitle {
            font-size: 1.125rem;
            color: #888;
            max-width: 600px;
            margin: 0 auto;
        }

       .services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  justify-content: center; /* center align last row if it's not full */
}

        .service-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 2rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.5), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .service-card:hover::before {
            opacity: 1;
        }

        .service-card:hover {
            transform: translateY(-4px);
            border-color: rgba(59, 130, 246, 0.3);
            background: rgba(255, 255, 255, 0.05);
        }

        .service-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #3b82f6, #06b6d4);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            color: white;
        }

        .service-card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            color: #ffffff;
        }

        .service-card p {
            color: #888;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .service-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .service-link:hover {
            color: #06b6d4;
            transform: translateX(4px);
        }

        .footer {
            background: rgba(255, 255, 255, 0.02);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding: 3rem 2rem 2rem;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: #888;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #ffffff;
        }

        .footer-bottom {
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #666;
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .hero {
    padding: 3rem 1rem 2rem;
}


            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }

            .services-grid {
                grid-template-columns: 1fr;
            }

            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .nav {
                padding: 1rem;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <nav class="nav">
        <div class="nav-container"></div>
    </nav>

    <section class="hero">
        <h1> College Fee Manager<br><span class="hero-highlight">App</span></h1>
    </section>

    <section class="services">
        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-plus"></i></div>
                <h3>Add feePayment</h3>
                <p>add new fee payments with our streamlined interface</p>
                <a href="feepaymentadd.jsp" class="service-link">Add Payment <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-edit"></i></div>
                <h3>Update feePayment</h3>
                <p>Update existing payment records with ease. Modify payment details with ease.</p>
                <a href="feepaymentupdate.jsp" class="service-link">Update Records <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-chart-bar"></i></div>
                <h3>FeePayment Reports</h3>
                <p>Generate comprehensive reports based on status like paid,unpaid or overdue payments.</p>
                <a href="report_form.jsp" class="service-link">View Reports <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-eye"></i></div>
                <h3>View allFeePayments</h3>
                <p>Monitor all payment transactions in real-time. Search, filter, and organize payment data efficiently.</p>
                <a href="feepaymentdisplay.jsp" class="service-link">Track Payments <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-trash-alt"></i></div>
                <h3>Delete feePayment</h3>
                <p>Clean up your database by removing outdated or incorrect payment records with proper authorization.</p>
                <a href="feepaymentdelete.jsp" class="service-link">Manage Records <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="footer-content">
            <div class="footer-links">
              <p>&copy; 2025 College Fee Payment System. All rights reserved.</p>
            </div>
            <div class="footer-bottom">
                
            </div>
        </div>
    </footer>
</body>
</html>
