<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Add Fee Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        margin: 0;
        font-family: "Segoe UI", sans-serif;
        background-color: #0f0f0f;
        color: #f1f5f9;
        display: flex;
        justify-content: center;
        padding: 2rem;
      }

      .container {
        background-color: #18181b;
        border-radius: 16px;
        padding: 2rem;
        width: 100%;
        max-width: 640px;
        border: 1px solid #27272a;
      }

      h2 {
        font-size: 2rem;
        background: linear-gradient(to right, #d1d5db, #3b82f6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        font-weight: 700;
        text-align: center;
        margin-bottom: 1rem;
      }

      .subtitle {
        text-align: center;
        font-size: 1rem;
        color: #94a3b8;
        margin-bottom: 2rem;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #e2e8f0;
      }

      input,
      select {
        width: 100%;
        box-sizing: border-box;
        padding: 0.75rem;
        border: 1px solid #3f3f46;
        border-radius: 12px;
        font-size: 1rem;
        background-color: #1f1f23;
        color: #f1f5f9;
      }

      input:focus,
      select:focus {
        border-color: #3b82f6;
        outline: none;
        background-color: #27272a;
      }

      .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1.5rem;
      }

      .status-options {
        display: flex;
        gap: 1rem;
      }

      .status-option {
        flex: 1;
      }

      .status-option input[type="radio"] {
        display: none;
      }

      .status-option label {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 0.75rem 1rem;
        border: 1px solid #3f3f46;
        border-radius: 10px;
        cursor: pointer;
        font-size: 0.95rem;
        background-color: #1f1f23;
        color: #cbd5e1;
        transition: all 0.2s ease;
        width: 100%;
        box-sizing: border-box;
      }

      .status-option input[type="radio"]:checked + label {
        background: linear-gradient(to right, #1e40af, #2563eb);
        border-color: #60a5fa;
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
      }

      .status-option label:hover {
        border-color: #60a5fa;
        background-color: #27272a;
      }

      .submit-button {
        width: 100%;
        padding: 0.75rem;
        font-size: 1rem;
        background: linear-gradient(to right, #2563eb, #3b82f6);
        color: white;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.2s ease;
        margin-top: 1.5rem;
      }

      .submit-button:hover {
        background: linear-gradient(to right, #1d4ed8, #2563eb);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
      }

      .back-link {
        display: inline-block;
        margin-bottom: 1rem;
        color: #60a5fa;
        text-decoration: none;
        font-size: 0.9rem;
        transition: color 0.2s ease;
      }

      .back-link:hover {
        color: #93c5fd;
      }

      @media (max-width: 640px) {
        .form-row {
          grid-template-columns: 1fr;
        }

        .status-options {
          flex-direction: column;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <a href="index.jsp" class="back-link"
        ><i class="fas fa-arrow-left"></i> Back to Dashboard</a
      >
      <h2>Add Fee Payment</h2>
      <p class="subtitle">Quickly record a payment in seconds</p>

      <form action="addPayment" method="post">
        <div class="form-row">
          <div class="form-group">
            <label for="studentId">Student ID</label>
            <input
              type="text"
              id="studentId"
              name="studentId"
              placeholder="S12345"
              required
              pattern="[A-Za-z0-9]+"
            />
          </div>
          <div class="form-group">
            <label for="studentName">Student Name</label>
            <input
              type="text"
              id="studentName"
              name="studentName"
              placeholder="John Doe"
              required
            />
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label for="paymentDate">Payment Date</label>
            <input type="date" id="paymentDate" name="paymentDate" required />
          </div>
          <div class="form-group">
            <label for="amount">Amount</label>
            <input
              type="number"
              id="amount"
              name="amount"
              placeholder="0.00"
              required
              min="1"
              step="0.01"
            />
          </div>
        </div>

        <div class="form-group">
          <label>Payment Status</label>
          <div class="status-options">
            <div class="status-option">
              <input
                type="radio"
                id="paid"
                name="status"
                value="Paid"
                checked
              />
              <label for="paid"><i class="fas fa-check-circle"></i> Paid</label>
            </div>
            <div class="status-option">
              <input type="radio" id="overdue" name="status" value="Overdue" />
              <label for="overdue"
                ><i class="fas fa-exclamation-circle"></i> Overdue</label
              >
            </div>
          </div>
        </div>

        <button type="submit" class="submit-button">
          <i class="fas fa-save"></i> Save Payment
        </button>
      </form>
    </div>

    <script>
      // Set today's date as default
      document.getElementById("paymentDate").value = new Date()
        .toISOString()
        .split("T")[0];
    </script>
  </body>
</html>
