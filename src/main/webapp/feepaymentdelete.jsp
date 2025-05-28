<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Delete Fee Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      /* === Base Styles === */
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

      p.warning-text {
        color: #f87171; /* light red */
        font-size: 0.95rem;
        margin-bottom: 1.5rem;
        line-height: 1.4;
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
      input[type="checkbox"] {
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

      input[type="text"]:focus {
        border-color: #3b82f6;
        outline: none;
        background-color: #27272a;
      }

      /* Checkbox styling container */
      .checkbox-group {
        display: flex;
        align-items: flex-start;
        gap: 0.75rem;
        margin-bottom: 1.5rem;
      }
      .checkbox-group input[type="checkbox"] {
        width: auto;
        margin-top: 4px;
        flex-shrink: 0;
      }
      .checkbox-group label {
        flex: 1;
        font-size: 0.95rem;
        color: #cbd5e1;
        cursor: pointer;
        user-select: none;
        line-height: 1.3;
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
        justify-content: space-between;
        align-items: center;
        gap: 1rem;
        flex-wrap: wrap;
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
      }
      .form-actions a.cancel-link:hover {
        background-color: #3b82f6;
        color: white;
      }

      button#deleteBtn {
        flex-grow: 2;
        background: linear-gradient(to right, #dc2626, #ef4444);
        border: none;
        border-radius: 12px;
        padding: 0.75rem 1.5rem;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: background 0.2s ease;
        user-select: none;
      }
      button#deleteBtn:disabled {
        background: #7f1d1d;
        cursor: not-allowed;
      }
      button#deleteBtn:hover:not(:disabled) {
        background: linear-gradient(to right, #b91c1c, #ef4444);
      }

      /* Responsive */
      @media (max-width: 640px) {
        .form-actions {
          flex-direction: column;
        }
        .form-actions a.cancel-link,
        button#deleteBtn {
          flex-grow: unset;
          width: 100%;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <a href="index.jsp" class="back-link"
        ><i class="fas fa-arrow-left"></i> Back to Dashboard</a
      >

      <h2>Delete Fee Payment</h2>
      <p class="subtitle">Remove payment record from system</p>

      <h3>Permanent Action Warning</h3>
      <p class="warning-text">
        This action cannot be undone. The payment record will be permanently
        removed from the system and cannot be recovered.
      </p>

      <form action="deletePayment" method="post" id="deleteForm" novalidate>
        <div class="form-group">
          <label for="paymentId">Payment ID</label>
          <input
            type="text"
            id="paymentId"
            name="paymentId"
            placeholder="Enter payment ID to delete"
            required
            autocomplete="off"
            pattern="[A-Za-z0-9]+"
            title="Alphanumeric characters only"
          />
        </div>

        <div id="paymentPreview">
          <div>Payment Record Preview</div>
          <div id="previewDetails"><!-- Dynamic preview inserted here --></div>
        </div>

        <div class="checkbox-group">
          <input type="checkbox" id="confirmDelete" />
          <label for="confirmDelete">
            I understand that this action is permanent and cannot be reversed. I
            confirm that I want to delete this payment record.
          </label>
        </div>

        <div class="form-actions">
          <a href="index.jsp" class="cancel-link">Cancel</a>
          <button type="submit" id="deleteBtn" disabled>
            <i class="fas fa-trash-alt"></i> Delete Payment
          </button>
        </div>
      </form>
    </div>

    <script>
      // Form elements
      const deleteForm = document.getElementById("deleteForm");
      const paymentIdInput = document.getElementById("paymentId");
      const confirmCheckbox = document.getElementById("confirmDelete");
      const deleteButton = document.getElementById("deleteBtn");
      const paymentPreview = document.getElementById("paymentPreview");
      const previewDetails = document.getElementById("previewDetails");

      // Enable/disable delete button based on confirmation & input
      function updateDeleteButtonState() {
        const hasPaymentId = paymentIdInput.value.trim().length > 0;
        const isConfirmed = confirmCheckbox.checked;
        deleteButton.disabled = !(hasPaymentId && isConfirmed);
      }

      confirmCheckbox.addEventListener("change", updateDeleteButtonState);
      paymentIdInput.addEventListener("input", function (e) {
        // Auto-uppercase & strip non-alphanumeric
        e.target.value = e.target.value
          .replace(/[^a-zA-Z0-9]/g, "")
          .toUpperCase();

        updateDeleteButtonState();

        // Show preview if length >= 3
        if (e.target.value.length >= 3) {
          simulatePaymentLookup(e.target.value);
        } else {
          paymentPreview.style.display = "none";
        }
      });

      // Simulate payment record lookup (replace with real AJAX call)
      function simulatePaymentLookup(paymentId) {
        setTimeout(() => {
          const mockPaymentData = {
            id: paymentId,
            studentId: "STU" + Math.floor(Math.random() * 10000),
            studentName: "Sample Student Name",
            amount: "₹" + (Math.random() * 5000 + 500).toFixed(2),
            date: new Date().toLocaleDateString(),
            status: Math.random() > 0.5 ? "Paid" : "Overdue",
          };
          displayPaymentPreview(mockPaymentData);
        }, 500);
      }

      function displayPaymentPreview(paymentData) {
        previewDetails.innerHTML = `
        <div><span>Payment ID:</span><span>${paymentData.id}</span></div>
        <div><span>Student ID:</span><span>${paymentData.studentId}</span></div>
        <div><span>Student Name:</span><span>${paymentData.studentName}</span></div>
        <div><span>Amount:</span><span>${paymentData.amount}</span></div>
        <div><span>Date:</span><span>${paymentData.date}</span></div>
        <div><span>Status:</span><span>${paymentData.status}</span></div>
      `;
        paymentPreview.style.display = "block";
      }

      deleteForm.addEventListener("submit", function (e) {
        if (!confirmCheckbox.checked) {
          alert(
            "Please confirm that you understand this action cannot be undone."
          );
          e.preventDefault();
          return;
        }

        if (!paymentIdInput.value.trim()) {
          alert("Please enter a valid Payment ID.");
          e.preventDefault();
          return;
        }

        const confirmed = confirm(
          "Are you absolutely sure you want to delete this payment record? This action cannot be undone."
        );
        if (!confirmed) {
          e.preventDefault();
          return;
        }
      });
    </script>
  </body>
</html>
