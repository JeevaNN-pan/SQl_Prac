-- ================================================
-- INTERMEDIATE SQL PROJECT - Library Management System
-- Features: JOINs, Aggregations, Subqueries, GROUP BY, HAVING
-- ================================================

-- Drop existing tables
DROP TABLE IF EXISTS loan_history;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS categories;

-- ================================================
-- CREATE TABLES
-- ================================================

-- Categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INT,
    nationality VARCHAR(50)
);

-- Books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category_id INT,
    isbn VARCHAR(20) UNIQUE,
    publication_year INT,
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    price DECIMAL(8, 2),
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Members table
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE DEFAULT CURRENT_DATE,
    membership_type VARCHAR(20) DEFAULT 'Regular',
    is_active BOOLEAN DEFAULT TRUE
);

-- Loans table (current loans)
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(8, 2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- ================================================
-- INSERT SAMPLE DATA
-- ================================================

-- Insert categories
INSERT INTO categories VALUES
(1, 'Fiction', 'Fictional literature including novels and short stories'),
(2, 'Science', 'Scientific books and research'),
(3, 'History', 'Historical books and biographies'),
(4, 'Technology', 'Technology and computer science books'),
(5, 'Mystery', 'Mystery and thriller novels');

-- Insert authors
INSERT INTO authors VALUES
(1, 'George', 'Orwell', 1903, 'British'),
(2, 'Jane', 'Austen', 1775, 'British'),
(3, 'Isaac', 'Asimov', 1920, 'American'),
(4, 'Agatha', 'Christie', 1890, 'British'),
(5, 'Stephen', 'Hawking', 1942, 'British'),
(6, 'J.K.', 'Rowling', 1965, 'British'),
(7, 'Dan', 'Brown', 1964, 'American'),
(8, 'Yuval', 'Harari', 1976, 'Israeli');

-- Insert books
INSERT INTO books VALUES
(1, '1984', 1, 1, '978-0451524935', 1949, 5, 2, 15.99),
(2, 'Animal Farm', 1, 1, '978-0451526342', 1945, 4, 4, 12.99),
(3, 'Pride and Prejudice', 2, 1, '978-0141439518', 1813, 3, 1, 10.99),
(4, 'Foundation', 3, 1, '978-0553293357', 1951, 3, 2, 14.99),
(5, 'Murder on the Orient Express', 4, 5, '978-0062693662', 1934, 4, 3, 13.99),
(6, 'A Brief History of Time', 5, 2, '978-0553380163', 1988, 2, 0, 18.99),
(7, 'Harry Potter and the Philosopher Stone', 6, 1, '978-0439708180', 1997, 6, 4, 19.99),
(8, 'The Da Vinci Code', 7, 5, '978-0307474278', 2003, 5, 3, 16.99),
(9, 'Sapiens', 8, 3, '978-0062316097', 2011, 4, 2, 21.99),
(10, 'Death on the Nile', 4, 5, '978-0062073556', 1937, 3, 2, 12.99);

-- Insert members
INSERT INTO members VALUES
(1, 'Alice', 'Johnson', 'alice.j@email.com', '555-0101', '2023-01-15', 'Premium', TRUE),
(2, 'Bob', 'Smith', 'bob.smith@email.com', '555-0102', '2023-03-20', 'Regular', TRUE),
(3, 'Carol', 'White', 'carol.w@email.com', '555-0103', '2023-06-10', 'Premium', TRUE),
(4, 'David', 'Brown', 'david.b@email.com', '555-0104', '2023-08-05', 'Regular', TRUE),
(5, 'Emma', 'Davis', 'emma.d@email.com', '555-0105', '2024-01-12', 'Regular', TRUE),
(6, 'Frank', 'Miller', 'frank.m@email.com', '555-0106', '2024-02-28', 'Premium', FALSE);

-- Insert loans (some returned, some active, some overdue)
INSERT INTO loans VALUES
(1, 1, 1, '2024-10-01', '2024-10-15', '2024-10-14', 0.00, 'Returned'),
(2, 3, 2, '2024-10-05', '2024-10-19', '2024-10-22', 3.00, 'Returned'),
(3, 5, 3, '2024-10-10', '2024-10-24', NULL, 0.00, 'Active'),
(4, 6, 1, '2024-10-15', '2024-10-29', NULL, 0.00, 'Active'),
(5, 7, 4, '2024-11-01', '2024-11-15', NULL, 0.00, 'Active'),
(6, 8, 2, '2024-11-05', '2024-11-19', NULL, 0.00, 'Active'),
(7, 9, 5, '2024-11-10', '2024-11-24', NULL, 0.00, 'Active'),
(8, 4, 3, '2024-09-20', '2024-10-04', '2024-10-01', 0.00, 'Returned'),
(9, 2, 1, '2024-11-12', '2024-11-26', NULL, 0.00, 'Active'),
(10, 10, 4, '2024-10-28', '2024-11-11', '2024-11-18', 7.00, 'Returned');

-- ================================================
-- INTERMEDIATE QUERIES
-- ================================================

-- Query 1: Books with author information (INNER JOIN)
SELECT 
    b.book_id,
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    c.category_name,
    b.publication_year,
    b.available_copies,
    b.total_copies
FROM books b
INNER JOIN authors a ON b.author_id = a.author_id
INNER JOIN categories c ON b.category_id = c.category_id
ORDER BY b.title;

-- Query 2: Currently borrowed books (JOIN with date filtering)
SELECT 
    l.loan_id,
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    l.loan_date,
    l.due_date,
    DATEDIFF(CURRENT_DATE, l.due_date) AS days_overdue
FROM loans l
INNER JOIN books b ON l.book_id = b.book_id
INNER JOIN members m ON l.member_id = m.member_id
WHERE l.status = 'Active'
ORDER BY l.due_date;

-- Query 3: Books borrowed per category (GROUP BY with COUNT)
SELECT 
    c.category_name,
    COUNT(l.loan_id) AS total_loans,
    COUNT(CASE WHEN l.status = 'Active' THEN 1 END) AS active_loans,
    COUNT(CASE WHEN l.status = 'Returned' THEN 1 END) AS returned_loans
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
LEFT JOIN loans l ON b.book_id = l.book_id
GROUP BY c.category_id, c.category_name
ORDER BY total_loans DESC;

-- Query 4: Most active members (GROUP BY with aggregation)
SELECT 
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    m.membership_type,
    COUNT(l.loan_id) AS total_books_borrowed,
    SUM(l.fine_amount) AS total_fines,
    COUNT(CASE WHEN l.status = 'Active' THEN 1 END) AS currently_borrowed
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.first_name, m.last_name, m.membership_type
HAVING total_books_borrowed > 0
ORDER BY total_books_borrowed DESC;

-- Query 5: Popular authors (GROUP BY with multiple tables)
SELECT 
    a.author_id,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    a.nationality,
    COUNT(DISTINCT b.book_id) AS books_in_library,
    COUNT(l.loan_id) AS times_borrowed,
    ROUND(AVG(b.price), 2) AS avg_book_price
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
LEFT JOIN loans l ON b.book_id = l.book_id
GROUP BY a.author_id, a.first_name, a.last_name, a.nationality
ORDER BY times_borrowed DESC;

-- Query 6: Books never borrowed (LEFT JOIN with NULL check)
SELECT 
    b.book_id,
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    b.publication_year,
    b.price
FROM books b
INNER JOIN authors a ON b.author_id = a.author_id
LEFT JOIN loans l ON b.book_id = l.book_id
WHERE l.loan_id IS NULL
ORDER BY b.title;

-- Query 7: Overdue books report (date calculations)
SELECT 
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    m.email,
    l.loan_date,
    l.due_date,
    DATEDIFF(CURRENT_DATE, l.due_date) AS days_overdue,
    DATEDIFF(CURRENT_DATE, l.due_date) * 1.00 AS calculated_fine
FROM loans l
INNER JOIN books b ON l.book_id = b.book_id
INNER JOIN members m ON l.member_id = m.member_id
WHERE l.status = 'Active' 
  AND l.due_date < CURRENT_DATE
ORDER BY days_overdue DESC;

-- Query 8: Availability status by category (CASE statement)
SELECT 
    c.category_name,
    COUNT(b.book_id) AS total_books,
    SUM(b.total_copies) AS total_copies,
    SUM(b.available_copies) AS available_copies,
    ROUND(SUM(b.available_copies) * 100.0 / SUM(b.total_copies), 2) AS availability_percent,
    CASE 
        WHEN SUM(b.available_copies) * 100.0 / SUM(b.total_copies) > 50 THEN 'Good'
        WHEN SUM(b.available_copies) * 100.0 / SUM(b.total_copies) > 20 THEN 'Medium'
        ELSE 'Low'
    END AS availability_status
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_id, c.category_name
ORDER BY availability_percent DESC;

-- Query 9: Member activity summary (subquery)
SELECT 
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    m.membership_type,
    (SELECT COUNT(*) FROM loans WHERE member_id = m.member_id) AS total_loans,
    (SELECT COUNT(*) FROM loans WHERE member_id = m.member_id AND status = 'Active') AS active_loans,
    (SELECT SUM(fine_amount) FROM loans WHERE member_id = m.member_id) AS total_fines_paid
FROM members m
WHERE m.is_active = TRUE
ORDER BY total_loans DESC;

-- Query 10: Books borrowed in last 30 days (date filtering with aggregation)
SELECT 
    b.book_id,
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    COUNT(l.loan_id) AS times_borrowed_recently,
    MAX(l.loan_date) AS last_borrowed_date
FROM books b
INNER JOIN authors a ON b.author_id = a.author_id
INNER JOIN loans l ON b.book_id = l.book_id
WHERE l.loan_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY b.book_id, b.title, a.first_name, a.last_name
ORDER BY times_borrowed_recently DESC;