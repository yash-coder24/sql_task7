-- 1. A view is a virtual table based on a SQL SELECT query.
-- You can treat it like a regular table in your queries, but it's not stored physically (unless it's a materialized view).

-- 2. Create a Complex View
-- create a view that shows total amount spent per customer with total books ordered:
use library
CREATE VIEW Customer_Purchase_Summary AS
SELECT 
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Quantity) AS Total_Books_Ordered,
    SUM(o.Quantity * b.Price) AS Total_Amount_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name;


select * from books

-- 3. Use the View
-- Find customers who spent more than ₹1300
SELECT * 
FROM Customer_Purchase_Summary
WHERE Total_Amount_Spent > 1300;

-- 4.Use Views for Security
-- Hide sensitive info (like email) by creating a restricted view:
CREATE VIEW Public_Customers AS
SELECT Customer_ID, Name
FROM Customers;

-- Grant access only to the view
GRANT SELECT ON Public_Customers TO 'readonly_user'@'localhost';
-- Prevents unauthorized access to full Customers table.

-- 4. Benefits of Views:
--     Purpose	                           Benefit
-- 1. Abstraction	           Hides complex joins and calculations
-- 2. Reusability	           Use same logic in multiple queries
-- 3. Security	               Restrict access to specific columns or rows
-- 4. Maintainability	       Easy to update logic in one place
