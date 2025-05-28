<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Generate Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      /* === Base Styles === */
      body {
        margin: 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #0f0f0f;
        color: #f1f5f9;
        display: flex;
        justify-content: center;
        padding: 2rem;
        min-height: 100vh;
        box-sizing: border-box;
      }

      .container {
        background-color: #18181b;
        border-radius: 16px;
        padding: 2rem 2.5rem;
        width: 100%;
        max-width: 640px;
        border: 1px solid #27272a;
        box-sizing: border-box;
      }

      h2 {
        font-size: 2rem;
        font-weight: 700;
        background: linear-gradient(to right, #d1d5db, #3b82f6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 1rem;
        text-align: center;
      }

      p.description {
        text-align: center;
        font-size: 1rem;
        color: #94a3b8;
        margin-bottom: 2rem;
        user-select: none;
      }

      form {
        margin-top: 1rem;
      }

      /* Form groups */
      .form-group {
        margin-bottom: 1.5rem;
      }

      label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #e2e8f0;
      }

      select,
      input[type="date"] {
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

      select:focus,
      input[type="date"]:focus {
        border-color: #3b82f6;
        outline: none;
        background-color: #27272a;
      }

      /* Date inputs container side by side */
      .date-range {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
      }

      .date-range > div {
        flex: 1;
        min-width: 140px;
      }

      /* Button */
      button[type="submit"] {
        background: linear-gradient(to right, #2563eb, #3b82f6);
        border: none;
        border-radius: 12px;
        padding: 0.75rem 1.5rem;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: background 0.2s ease;
        user-select: none;
        width: 100%;
        max-width: 240px;
        display: block;
        margin: 2rem auto 0;
      }

      button[type="submit"]:hover {
        background: linear-gradient(to right, #1d4ed8, #2563eb);
      }

      /* Responsive adjustments */
      @media (max-width: 480px) {
        .date-range {
          flex-direction: column;
        }
        button[type="submit"] {
          max-width: 100%;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>Generate Reports</h2>
      <p class="description">Select the type of report you want to generate</p>
      <form action="report" method="post">
        <div class="form-group">
          <label for="reportType">Report Type</label>
          <select id="reportType" name="reportType" required>
            <option value="" disabled selected>Select report type</option>
            <option value="overdue">Students with Overdue Payments</option>
            <option value="notPaid">
              Students Who Haven't Paid in a Period
            </option>
            <option value="total">Total Collection Over a Date Range</option>
          </select>
        </div>

        <div class="form-group date-range">
          <div>
            <label for="startDate">Start Date</label>
            <input type="date" id="startDate" name="startDate" />
          </div>
          <div>
            <label for="endDate">End Date</label>
            <input type="date" id="endDate" name="endDate" />
          </div>
        </div>

        <button type="submit">
          <i class="fas fa-file-alt"></i> Generate Report
        </button>
      </form>
    </div>
  </body>
</html>
