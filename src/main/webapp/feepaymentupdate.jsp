<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Update Fee Payment</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <style>
    /* === Base Styles === */
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
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

    a.back-link {
      display: inline-block;
      margin-bottom: 1rem;
      color: #60a5fa;
      text-decoration: none;
      font-size: 0.9rem;
    }
    a.back-link i {
      margin-right: 0.3rem;
    }

    h2 {
      font-size: 2rem;
      background: linear-gradient(to right, #d1d5db, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      font-weight: 700;
      text-align: center;
      margin-bottom: 0.25rem;
    }

    .subtitle {
      text-align: center;
      font-size: 1rem;
      color: #94a3b8;
      margin-bottom: 2rem;
    }

    h3 {
      font-weight: 600;
      color: #cbd5e1;
      margin-top: 2rem;
      margin-bottom: 0.5rem;
    }

    /* === Form Styles === */
    form {
      margin-top: 1rem;
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

    input[type="text"],
    input[type="number"],
    input[type="date"],
    select {
      font-size: 1rem;
      border-radius: 12px;
      border: 1px solid #3f3f46;
      background-color: #1f1f23;
      color: #f1f5f9;
      padding: 0.75rem;
      width: 100%;
      box-sizing: border-box;
      transition: border-color 0.2s, background-color 0.2s;
    }

    input[type="text"]:focus,
    input[type="number"]:focus,
    input[type="date"]:focus,
    select:focus {
      border-color: #3b82f6;
      outline: none;
      background-color: #27272a;
    }

    /* Payment preview box */
    #paymentPreview {
      background-color: #27272a;
      border-radius: 12px;
      padding: 1rem;
      margin-bottom: 1.5rem;
      display: none;
      color: #f1f5f9;
    }
    #paymentPreview > div:first-child {
      font-weight: 600;
      margin-bottom: 0.75rem;
      color: #3b82f6;
    }
    #previewDetails div {
      display: flex;
      justify-content: space-between;
      margin-bottom: 0.4rem;
      font-size: 0.95rem;
    }
    #previewDetails div span:first-child {
      color: #94a3b8;
    }

    /* Form action buttons container */
    .form-actions {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      gap: 1rem;
      flex-wrap: wrap;
      margin-top: 1rem;
    }
    .form-actions a.cancel-link {
      color: #60a5fa;
      text-decoration: none;
      font-size: 0.95rem;
      padding: 0.75rem 1.25rem;
      border-radius: 12px;
      border: 1px solid #3b82f6;
      transition: background-color 0.2s;
      flex-grow: 1;
      text-align: center;
      max-width: 140px;
    }
    .form-actions a.cancel-link:hover {
      background-color: #3b82f6;
      color: white;
    }

    button#updateBtn {
      flex-grow: 2;
      background: linear-gradient(to right, #2563eb, #3b82f6);
      border: none;
      border-radius: 12px;
      padding: 0.75rem 1.5rem;
      color: white;
      font-size: 1rem;
      cursor: pointer;
      transition: background 0.2s ease;
      user-select: none;
      max-width: 200px;
    }
    button#updateBtn:disabled {
      background: #1e40af;
      cursor: not-allowed;
    }
    button#updateBtn:hover:not(:disabled) {
      background: linear-gradient(to right, #1d4ed8, #2563eb);
    }

    /* Responsive */
    @media (max-width: 640px) {
      .form-actions {
        justify-content: center;
        flex-direction: column;
      }
      .form-actions a.cancel-link,
      button#updateBtn {
        flex-grow: unset;
        width: 100%;
        max-width: none;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <a href="index.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

    <h2>Update Fee Payment</h2>
    <p class="subtitle">Modify existing payment details</p>

    <form action="updatePayment" method="post" id="updateForm" novalidate>
      <div class="form-group">
        <label for="paymentId">Payment ID</label>
        <input
          type="text"
          id="paymentId"
          name="paymentId"
          placeholder="Enter payment ID to update"
          required
          autocomplete="off"
          pattern="[A-Za-z0-9]+"
          title="Alphanumeric characters only"
        />
      </div>

      <div id="paymentPreview">
        <div>Current Payment Details</div>
        <div id="previewDetails"><!-- Dynamic preview inserted here --></div>
      </div>

      <h3>Update Fields</h3>

      <div class="form-group">
        <label for="studentId">Student ID</label>
        <input
          type="text"
          id="studentId"
          name="studentId"
          placeholder="Enter student ID"
          autocomplete="off"
          required
        />
      </div>

      <div class="form-group">
        <label for="studentName">Student Name</label>
        <input
          type="text"
          id="studentName"
          name="studentName"
          placeholder="Enter updated student name"
          autocomplete="off"
          required
        />
      </div>

      <div class="form-group">
        <label for="amount">Amount (₹)</label>
        <input
          type="number"
          id="amount"
          name="amount"
          placeholder="Enter updated amount"
          min="0"
          step="0.01"
          required
        />
      </div>

      <div class="form-group">
        <label for="paymentDate">Payment Date</label>
        <input
          type="date"
          id="paymentDate"
          name="paymentDate"
          required
        />
      </div>

      <div class="form-group">
        <label for="status">Payment Status</label>
        <select id="status" name="status" required>
          <option value="" disabled selected>Select status</option>
          <option value="Paid">Paid</option>
          <option value="Pending">Pending</option>
          <option value="Overdue">Overdue</option>
        </select>
      </div>

      <div class="form-actions">
        <a href="index.jsp" class="cancel-link">Cancel</a>
        <button type="submit" id="updateBtn" disabled>
          <i class="fas fa-save"></i> Update Payment
        </button>
      </div>
    </form>
  </div>

  <script>
    const updateForm = document.getElementById('updateForm');
    const paymentIdInput = document.getElementById('paymentId');
    const updateBtn = document.getElementById('updateBtn');
    const paymentPreview = document.getElementById('paymentPreview');
    const previewDetails = document.getElementById('previewDetails');

    // Inputs for update fields
    const studentIdInput = document.getElementById('studentId');
    const studentNameInput = document.getElementById('studentName');
    const amountInput = document.getElementById('amount');
    const paymentDateInput = document.getElementById('paymentDate');
    const statusSelect = document.getElementById('status');

    // Enable update button only if paymentId is valid and required fields are filled
    function validateForm() {
      const validPaymentId = /^[A-Z0-9]+$/.test(paymentIdInput.value.trim());
      const requiredFieldsFilled = studentIdInput.value.trim() !== '' &&
                                  studentNameInput.value.trim() !== '' &&
                                  amountInput.value.trim() !== '' &&
                                  paymentDateInput.value.trim() !== '' &&
                                  statusSelect.value !== '';
      updateBtn.disabled = !(validPaymentId && requiredFieldsFilled);
    }

    // Auto-uppercase paymentId & validate pattern
    paymentIdInput.addEventListener('input', (e) => {
      e.target.value = e.target.value.replace(/[^a-zA-Z0-9]/g, '').toUpperCase();
      validateForm();

      // Show preview if length >= 3 (simulate fetch)
      if (e.target.value.length >= 3) {
        simulatePaymentLookup(e.target.value);
      } else {
        paymentPreview.style.display = 'none';
      }
    });

    // Update button enabled state on other inputs
    [studentIdInput, studentNameInput, amountInput, paymentDateInput, statusSelect].forEach(el =>
      el.addEventListener('input', validateForm)
    );

    // Simulate fetching existing payment data by paymentId (replace with AJAX in real app)
    function simulatePaymentLookup(paymentId) {
      setTimeout(() => {
        const mockPaymentData = {
          id: paymentId,
          studentId: 'STU001',
          studentName: 'John Doe',
          amount: '₹2500.00',
          date: new Date().toISOString().slice(0,10), // yyyy-mm-dd format
          status: 'Paid',
        };
        displayPaymentPreview(mockPaymentData);

        // Pre-fill update fields with mock data
        studentIdInput.value = mockPaymentData.studentId;
        studentNameInput.value = mockPaymentData.studentName;
        amountInput.value = parseFloat(mockPaymentData.amount.replace(/[₹,]/g, '')).toFixed(2);
        paymentDateInput.value = mockPaymentData.date;
        statusSelect.value = mockPaymentData.status;

        validateForm();
      }, 500);
    }

    function displayPaymentPreview(data) {
      previewDetails.innerHTML = `
        <div><span>Payment ID:</span><span>${data.id}</span></div>
        <div><span>Student ID:</span><span>${data.studentId}</span></div>
        <div><span>Student Name:</span><span>${data.studentName}</span></div>
        <div><span>Amount:</span><span>${data.amount}</span></div>
        <div><span>Date:</span><span>${data.date}</span></div>
        <div><span>Status:</span><span>${data.status}</span></div>
      `;
      paymentPreview.style.display = 'block';
    }

    updateForm.addEventListener('submit', function(e) {
      // Optional: Add final validations or confirmation if needed
      if (updateBtn.disabled) {
        alert('Please fill all required fields with valid data.');
        e.preventDefault();
      }
    });
  </script>
</body>
</html>