package com.dao;

import com.model.FeePayment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeePaymentDAO {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/college_fees";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    private static final String INSERT_PAYMENT_SQL = "INSERT INTO FeePayments (StudentID, StudentName, PaymentDate, Amount, Status) VALUES (?, ?, ?, ?, ?)";
   // private static final String UPDATE_PAYMENT_SQL = "UPDATE FeePayments SET StudentID=?, StudentName=?, PaymentDate=?, Amount=?, Status=? WHERE PaymentID=?";
    //private static final String DELETE_PAYMENT_SQL = "DELETE FROM FeePayments WHERE PaymentID=?";
    private static final String SELECT_ALL_PAYMENTS_SQL = "SELECT * FROM FeePayments";
    private static final String SELECT_OVERDUE_SQL = "SELECT * FROM FeePayments WHERE Status='Overdue'";
    private static final String SELECT_UNPAID_SQL = "SELECT * FROM FeePayments WHERE PaymentDate < ? AND Status != 'Paid'";
    private static final String TOTAL_COLLECTION_SQL = "SELECT SUM(Amount) FROM FeePayments WHERE PaymentDate BETWEEN ? AND ? AND Status = 'Paid'";
    private static final String SELECT_PAYMENTS_BETWEEN_DATES_SQL = "SELECT * FROM FeePayments WHERE PaymentDate BETWEEN ? AND ? AND Status = 'Paid'";
    private static final String TOTAL_PAID_SQL = "SELECT SUM(Amount) FROM FeePayments WHERE Status = 'Paid'";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void insertPayment(FeePayment payment) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_PAYMENT_SQL)) {
            stmt.setString(1, payment.getStudentId());
            stmt.setString(2, payment.getStudentName());
            stmt.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
            stmt.setDouble(4, payment.getAmount());
            stmt.setString(5, payment.getStatus());
            stmt.executeUpdate();
        }
    }

    public boolean updatePayment(FeePayment payment) throws SQLException {
        // First check if payment exists
        String CHECK_PAYMENT_SQL = "SELECT COUNT(*) FROM FeePayments WHERE PaymentID = ?";
        String UPDATE_PAYMENT_SQL = "UPDATE FeePayments SET StudentID = ?, StudentName = ?, PaymentDate = ?, Amount = ?, Status = ? WHERE PaymentID = ?";
        
        try (Connection conn = getConnection()) {
            // Check if payment exists
            try (PreparedStatement checkStmt = conn.prepareStatement(CHECK_PAYMENT_SQL)) {
                checkStmt.setInt(1, payment.getPaymentId());
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next() && rs.getInt(1) == 0) {
                    // Payment ID doesn't exist
                    System.out.println("Payment ID " + payment.getPaymentId() + " not found in database");
                    return false;
                }
            }
            
            // If we reach here, payment exists - now update it
            try (PreparedStatement stmt = conn.prepareStatement(UPDATE_PAYMENT_SQL)) {
                if (payment.getStudentId() != null && !payment.getStudentId().trim().isEmpty()) {
                    stmt.setString(1, payment.getStudentId().trim());
                } else {
                    stmt.setNull(1, java.sql.Types.VARCHAR);
                }
                
                stmt.setString(2, payment.getStudentName());
                stmt.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
                stmt.setDouble(4, payment.getAmount());
                stmt.setString(5, payment.getStatus());
                stmt.setInt(6, payment.getPaymentId());
                
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected by update: " + rowsAffected);
                
                return rowsAffected > 0;
            }
        }
    }


    public FeePayment getPaymentById(int paymentId) throws SQLException {
        FeePayment payment = null;
        String GET_PAYMENT_BY_ID_SQL = "SELECT * FROM fee_payments WHERE payment_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_PAYMENT_BY_ID_SQL)) {
            
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                payment = new FeePayment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setStudentId(rs.getString("student_id"));
                payment.setStudentName(rs.getString("student_name"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setStatus(rs.getString("status"));
            }
        }
        
        return payment;
    }

    public boolean deletePayment(int paymentId) throws SQLException {
        boolean isDeleted = false;
        
        // SQL queries - make sure table name matches your database
        String CHECK_PAYMENT_SQL = "SELECT COUNT(*) FROM FeePayments WHERE PaymentID = ?";
        String DELETE_PAYMENT_SQL = "SELECT * FROM FeePayments WHERE PaymentID = ?"; // Changed this line
        
        try (Connection conn = getConnection()) {
            // Check if payment exists first
            try (PreparedStatement checkStmt = conn.prepareStatement(CHECK_PAYMENT_SQL)) {
                checkStmt.setInt(1, paymentId);
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next() && rs.getInt(1) == 0) {
                    // Payment ID doesn't exist
                    System.out.println("Payment ID " + paymentId + " not found in database");
                    return false;
                }
            }
            
            // If we reach here, payment exists - now delete it
            String DELETE_SQL = "DELETE FROM FeePayments WHERE PaymentID = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(DELETE_SQL)) {
                deleteStmt.setInt(1, paymentId);
                int rowsAffected = deleteStmt.executeUpdate();
                isDeleted = (rowsAffected > 0);
                
                System.out.println("Rows affected by delete: " + rowsAffected);
            }
        }
        
        return isDeleted;
    }

    public List<FeePayment> getAllPayments() throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_PAYMENTS_SQL);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                FeePayment fp = new FeePayment();
                fp.setPaymentId(rs.getInt("PaymentID"));
                fp.setStudentId(rs.getString("StudentID"));
                fp.setStudentName(rs.getString("StudentName"));
                fp.setPaymentDate(rs.getDate("PaymentDate"));
                fp.setAmount(rs.getDouble("Amount"));
                fp.setStatus(rs.getString("Status"));
                list.add(fp);
            }
        }
        return list;
    }

    public List<FeePayment> getOverduePayments() throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_OVERDUE_SQL);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                FeePayment fp = new FeePayment();
                fp.setPaymentId(rs.getInt("PaymentID"));
                fp.setStudentId(rs.getString("StudentID"));
                fp.setStudentName(rs.getString("StudentName"));
                fp.setPaymentDate(rs.getDate("PaymentDate"));
                fp.setAmount(rs.getDouble("Amount"));
                fp.setStatus(rs.getString("Status"));
                list.add(fp);
            }
        }
        return list;
    }

    public List<FeePayment> getUnpaidBeforeDate(Date date) throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_UNPAID_SQL)) {
            stmt.setDate(1, new java.sql.Date(date.getTime()));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FeePayment fp = new FeePayment();
                    fp.setPaymentId(rs.getInt("PaymentID"));
                    fp.setStudentId(rs.getString("StudentID"));
                    fp.setStudentName(rs.getString("StudentName"));
                    fp.setPaymentDate(rs.getDate("PaymentDate"));
                    fp.setAmount(rs.getDouble("Amount"));
                    fp.setStatus(rs.getString("Status"));
                    list.add(fp);
                }
            }
        }
        return list;
    }

    public double getTotalCollection(Date fromDate, Date toDate) throws SQLException {
        double total = 0;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(TOTAL_COLLECTION_SQL)) {
            stmt.setDate(1, new java.sql.Date(fromDate.getTime()));
            stmt.setDate(2, new java.sql.Date(toDate.getTime()));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble(1);
                }
            }
        }
        return total;
    }

    public List<FeePayment> getPaymentsBetweenDates(Date startDate, Date endDate) throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_PAYMENTS_BETWEEN_DATES_SQL)) {
            stmt.setDate(1, new java.sql.Date(startDate.getTime()));
            stmt.setDate(2, new java.sql.Date(endDate.getTime()));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FeePayment fp = new FeePayment();
                    fp.setPaymentId(rs.getInt("PaymentID"));
                    fp.setStudentId(rs.getString("StudentID"));
                    fp.setStudentName(rs.getString("StudentName"));
                    fp.setPaymentDate(rs.getDate("PaymentDate"));
                    fp.setAmount(rs.getDouble("Amount"));
                    fp.setStatus(rs.getString("Status"));
                    list.add(fp);
                }
            }
        }
        return list;
    }
    public double getTotalPaidAmount() throws SQLException {
        double totalPaid = 0.0;

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(TOTAL_PAID_SQL);
             ResultSet rs = stmt.executeQuery()) {
             
            if (rs.next()) {
                totalPaid = rs.getDouble(1);  
            }
        }

        return totalPaid;
    }

}
