# 📚 Library Management System - SQL Project

An intermediate-level SQL database project for learning essential database concepts including JOINs, aggregations, subqueries, and date operations.

## 📋 Table of Contents
- [Overview](#overview)
- [Database Schema](#database-schema)
- [Setup Instructions](#setup-instructions)
- [Features](#features)
- [Sample Queries](#sample-queries)
- [Learning Objectives](#learning-objectives)

## 🎯 Overview

This project simulates a library management system where you can track:
- Books and their authors
- Library members
- Book loans and returns
- Overdue books and fines
- Category-wise book distribution

**Skill Level:** Intermediate  
**Estimated Time:** 1-2 hours  
**Prerequisites:** Basic SQL knowledge (SELECT, WHERE, basic JOINs)

## 🗄️ Database Schema

### Tables Structure

**1. categories**
- Stores book categories (Fiction, Science, History, etc.)
- Fields: `category_id`, `category_name`, `description`

**2. authors**
- Author information
- Fields: `author_id`, `first_name`, `last_name`, `birth_year`, `nationality`

**3. books**
- Book catalog with inventory tracking
- Fields: `book_id`, `title`, `author_id`, `category_id`, `isbn`, `publication_year`, `total_copies`, `available_copies`, `price`

**4. members**
- Library members/users
- Fields: `member_id`, `first_name`, `last_name`, `email`, `phone`, `join_date`, `membership_type`, `is_active`

**5. loans**
- Tracks book borrowing and returns
- Fields: `loan_id`, `book_id`, `member_id`, `loan_date`, `due_date`, `return_date`, `fine_amount`, `status`

### Entity Relationships

```
categories (1) ----< (many) books
authors (1) ----< (many) books
members (1) ----< (many) loans
books (1) ----< (many) loans
```

## 🚀 Setup Instructions

### Option 1: DB Fiddle (Recommended for Beginners)

1. Go to [https://www.db-fiddle.com/](https://www.db-fiddle.com/)

2. **LEFT Panel (Schema SQL):**
   - Copy all code from the SQL file up to `-- INTERMEDIATE QUERIES`
   - This creates your tables and inserts sample data

3. **RIGHT Panel (Query SQL):**
   - Copy ONE query at a time (Query 1, 2, 3, etc.)
   - Run to see results

4. Select **MySQL 8.0** from the database dropdown

5. Click **"Run"** button

### Option 2: SQLite Online

1. Go to [https://sqliteonline.com/](https://sqliteonline.com/)

2. Paste the ENTIRE SQL file in the editor

3. Click **"Run"** (▶️ button)

4. View tables in left sidebar, results at bottom

### Option 3: Local MySQL/PostgreSQL

1. Install MySQL or PostgreSQL on your machine

2. Open your SQL client (MySQL Workbench, pgAdmin, DBeaver)

3. Create a new database:
   ```sql
   CREATE DATABASE library_system;
   USE library_system;
   ```

4. Run the entire SQL script

## ✨ Features

### What This Project Demonstrates

✅ **Multi-table JOINs**
- INNER JOIN for matching records
- LEFT JOIN for finding missing data
- Joining 3+ tables

✅ **Aggregate Functions**
- COUNT, SUM, AVG
- GROUP BY and HAVING clauses

✅ **Date Operations**
- DATEDIFF for calculating overdue days
- DATE_SUB for date ranges
- Date comparisons and filtering

✅ **Conditional Logic**
- CASE statements for status categorization
- Conditional counting with CASE

✅ **Subqueries**
- Nested SELECT statements
- Correlated subqueries

✅ **String Functions**
- CONCAT for combining fields
- String formatting

## 📊 Sample Queries

### Query 1: Books with Author Information
Shows all books with their authors and categories using INNER JOIN.

**Concepts:** Basic JOIN, SELECT with multiple tables

### Query 2: Currently Borrowed Books
Lists all active loans with overdue calculation.

**Concepts:** JOIN with filtering, date calculations, DATEDIFF

### Query 3: Books Borrowed per Category
Groups loans by category with active/returned breakdown.

**Concepts:** LEFT JOIN, GROUP BY, conditional COUNT

### Query 4: Most Active Members
Ranks members by borrowing activity and fines.

**Concepts:** GROUP BY with aggregation, HAVING clause

### Query 5: Popular Authors
Analyzes author popularity based on loan statistics.

**Concepts:** Multi-table aggregation, COUNT DISTINCT

### Query 6: Books Never Borrowed
Finds books that haven't been loaned yet.

**Concepts:** LEFT JOIN with NULL check, finding missing data

### Query 7: Overdue Books Report
Generates report of overdue books with fine calculations.

**Concepts:** Date arithmetic, filtering with dates

### Query 8: Availability Status by Category
Shows inventory status with percentage calculations.

**Concepts:** CASE statements, percentage calculations, status categorization

### Query 9: Member Activity Summary
Comprehensive member statistics using subqueries.

**Concepts:** Subqueries in SELECT, multiple aggregations

### Query 10: Recent Borrowing Trends
Shows books borrowed in the last 30 days.

**Concepts:** Date ranges with INTERVAL, GROUP BY with MAX

## 🎓 Learning Objectives

By completing this project, you will learn:

1. **JOIN Operations**
   - When to use INNER vs LEFT JOIN
   - Joining multiple tables
   - Understanding foreign key relationships

2. **Data Aggregation**
   - Grouping data with GROUP BY
   - Using aggregate functions (COUNT, SUM, AVG)
   - Filtering groups with HAVING

3. **Date Manipulation**
   - Calculating date differences
   - Working with date ranges
   - Filtering by dates

4. **Advanced SELECT**
   - CASE statements for conditional logic
   - Subqueries for complex data retrieval
   - String concatenation

5. **Real-World Scenarios**
   - Inventory management
   - Customer activity tracking
   - Overdue/fine calculations
   - Reporting and analytics

## 📈 Practice Exercises

Try modifying these queries to practice:

1. **Easy:**
   - Find all books by a specific author
   - List members who joined in 2024
   - Show books priced above $15

2. **Medium:**
   - Calculate total revenue if all books were sold
   - Find authors with books in multiple categories
   - Show average loan duration by member type

3. **Hard:**
   - Find the most borrowed book each month
   - Calculate member retention rate
   - Create a "recommended reading" list based on category popularity

## 🔧 Customization Ideas

Extend this project by:

- Adding a `reservations` table for booking unavailable books
- Creating a `staff` table to track who processes loans
- Adding `book_ratings` table for member reviews
- Implementing late fee tiers (Premium members get discounts)
- Adding inventory thresholds and reorder alerts

## 📝 Sample Data Overview

- **6 members** (5 active, 1 inactive)
- **8 authors** from different nationalities
- **10 books** across 5 categories
- **10 loan records** (mix of active and returned)
- **5 categories** (Fiction, Science, History, Technology, Mystery)

## ❓ Troubleshooting

**Error: Table doesn't exist**
- Make sure you run the CREATE TABLE statements first
- Check that you're in the correct database

**Error: Foreign key constraint fails**
- Run tables in order: categories → authors → books → members → loans
- Parent tables must be created before child tables

**No results returned**
- Check if sample data was inserted (run: `SELECT * FROM books;`)
- Verify your WHERE conditions aren't too restrictive

**Date functions not working**
- Some functions are database-specific
- Replace `CURRENT_DATE` with `NOW()` or `GETDATE()` based on your DB

## 🤝 Contributing

Feel free to:
- Add more sample data
- Create additional queries
- Suggest improvements
- Add new tables for extended functionality

## 📚 Additional Resources

- [SQL JOIN Tutorial](https://www.w3schools.com/sql/sql_join.asp)
- [SQL Aggregate Functions](https://www.w3schools.com/sql/sql_count_avg_sum.asp)
- [SQL Date Functions](https://www.w3schools.com/sql/sql_dates.asp)
- [SQL Subqueries](https://www.w3schools.com/sql/sql_subqueries.asp)

## 📄 License

This project is open source and available for educational purposes.

---

**Happy Learning! 🚀**

*Created for intermediate SQL learners to practice real-world database concepts.*
