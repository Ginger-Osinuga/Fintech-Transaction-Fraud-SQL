-- 1. DATABASE SETUP & REGISTRATION
CREATE TABLE Transactions (
    TransactionID INTEGER PRIMARY KEY,
    UserID INTEGER,
    Amount DECIMAL(10, 2),
    Category TEXT,
    Merchant TEXT,
    Country TEXT,
    TransactionDate DATETIME
);

INSERT INTO Transactions (UserID, Amount, Category, Merchant, Country, TransactionDate) VALUES
(101, 1500.00, 'Electronics', 'Best Buy', 'USA', '2023-01-05 10:30:00'),
(102, 12.50, 'Food', 'Starbucks', 'USA', '2023-01-05 10:45:00'),
(101, 2000.00, 'Travel', 'Delta Air', 'USA', '2023-01-05 11:15:00'),
(103, 45.00, 'Shopping', 'Amazon', 'USA', '2023-01-06 14:00:00'),
(104, 800.00, 'Finance', 'Crypto.com', 'UK', '2023-01-06 14:05:00'),
(102, 5.00, 'Food', 'Vending Machine', 'USA', '2023-01-06 16:00:00'),
(105, 3000.00, 'Luxury', 'Gucci', 'Italy', '2023-01-07 09:00:00'),
(104, 15.00, 'Food', 'McDonalds', 'USA', '2023-01-07 09:10:00');

-- 2. FRAUD DETECTION QUERY (Self-Joins & Time Analysis)
SELECT t1.UserID, t1.Country AS First_Country, t2.Country AS Second_Country, t1.TransactionDate AS Time_A, t2.TransactionDate AS Time_B, t1.Amount
FROM Transactions t1
JOIN Transactions t2 ON t1.UserID = t2.UserID AND t1.TransactionID <> t2.TransactionID
WHERE t1.Country <> t2.Country AND ABS(strftime('%s', t1.TransactionDate) - strftime('%s', t2.TransactionDate)) < 3600;

-- 3. REVENUE SUMMARY BY BUSINESS CATEGORY (Aggregations)
SELECT Category, COUNT(TransactionID) AS Total_Transactions, SUM(Amount) AS Total_Revenue, ROUND(AVG(Amount), 2) AS Avg_Transaction_Size
FROM Transactions
GROUP BY Category ORDER BY Total_Revenue DESC;

-- 4. MOST ACTIVE USERS PROFILE (Customer Segmentation)
SELECT UserID, COUNT(TransactionID) AS Frequency, SUM(Amount) AS Total_Spent    
FROM Transactions
GROUP BY UserID ORDER BY Frequency DESC;

-- 5. MONTHLY TRANSACTION TRENDS (Time-Series Metrics)
SELECT strftime('%Y-%m', TransactionDate) AS Month, COUNT(TransactionID) AS Transaction_Count, SUM(Amount) AS Monthly_Total
FROM Transactions
GROUP BY Month;
