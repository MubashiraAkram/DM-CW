USE AMCUPCAKES;
GO

--basic queries
-- Query 1: Retrieve all payment records from the Payment table
SELECT * FROM Payment;

-- Query 2: Retrieve details of all employees who work as Bakers
SELECT EmployeeID, EmployeeName, JobRole, Salary
FROM Employee
WHERE JobRole='Baker';

-- Query 3: Retrieve all orders that currently have a 'Pending' status
SELECT OrderID, OrderDate, TotalAmt, OrderStatus
FROM [Order]
WHERE OrderStatus='Pending';

-- Query 4: Retrieve all cakes with a price greater than 3000
SELECT CakeID, CakeName, CakeSize, Price
FROM Cake
WHERE Price>3000;

-- Query 5: Retrieve all transactions with payment method as card
SELECT PaymentID, Amount, PaymentMethod, OrderID
FROM Payment
WHERE PaymentMethod='Card';


--advanced queries
-- Query 1: Find employees who have more than 1 order
SELECT e.EmployeeID, e.EmployeeName AS EmployeeName, COUNT(o.OrderID) AS TotalOrders
FROM Employee e
JOIN [Order] o ON e.EmployeeID=o.EmployeeID
GROUP BY e.EmployeeID, e.EmployeeName
HAVING COUNT(o.OrderID)>1
ORDER BY TotalOrders DESC;

-- Query 2: Find repeat customers who have placed more than 1 order
SELECT c.CustomerID, c.CustomerName AS CustomerName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customer c
JOIN [Order] o ON c.CustomerID=o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID)>1
ORDER BY NumberOfOrders DESC;

-- Query 3: Calculate total cakes sold per category for categories with more than 1 quantity sold
SELECT cat.CategoryID, cat.CategoryName, SUM(oi.Quantity) AS TotalCakesSold
FROM Category cat
JOIN Cake c ON cat.CategoryID=c.CategoryID
JOIN OrderItem oi ON c.CakeID=oi.CakeID
GROUP BY cat.CategoryID, cat.CategoryName
HAVING SUM(oi.Quantity)>1
ORDER BY TotalCakesSold DESC;

-- Query 4: Calculate total revenue per cake item for items with total price over 5000 in sales
SELECT c.CakeID, c.CakeName, SUM(oi.Quantity*oi.UnitPrice) AS TotalSales
FROM Cake c
JOIN OrderItem oi ON c.CakeID=oi.CakeID
GROUP BY c.CakeID, c.CakeName
HAVING SUM(oi.Quantity*oi.UnitPrice)>5000
ORDER BY TotalSales DESC;

-- Query 5: Calculate total order count and revenue per branch for branches exceeding total amt of 10000 in revenue
SELECT b.BranchID, b.BranchName, COUNT(o.OrderID) AS TotalOrders, SUM(o.TotalAmt) AS TotalSales
FROM Branch b
JOIN [Order] o ON b.BranchID=o.BranchID
GROUP BY b.BranchID, b.BranchName
HAVING SUM(o.TotalAmt)>10000
ORDER BY TotalSales DESC;


/* Write three SQL queries to join relevant tables and display different data.
1) Display each customer's full order details, including their name, order date, 
total amount, and payment details (Joins Customer, [Order], Payment) */
SELECT Customer.CustomerID,Customer.CustomerName,[Order].OrderID,[Order].OrderDate,Payment.Amount,Payment.PaymentMethod,[Order].OrderStatus
FROM Customer
INNER JOIN [Order] ON Customer.CustomerID = [Order].CustomerID
INNER JOIN Payment ON [Order].OrderID = Payment.OrderID
ORDER BY [Order].OrderID ASC;

/* 2) Which employee handled each customer order, along with their job role and the 
branch where the sale occurred?*/
SELECT [Order].OrderID,Employee.EmployeeName,Employee.JobRole,Branch.BranchName
FROM Employee
INNER JOIN [Order] ON Employee.EmployeeID = [Order].EmployeeID
INNER JOIN Branch ON [Order].BranchID = Branch.BranchID
ORDER BY [Order].OrderID ASC;

/* 3) Which branch processed each order, and what was the payment method and order 
status for that transaction?*/
SELECT Branch.BranchName,[Order].OrderID,Payment.PaymentMethod,[Order].OrderStatus
FROM Branch
INNER JOIN [Order] ON Branch.BranchID = [Order].BranchID
INNER JOIN Payment ON [Order].OrderID = Payment.OrderID
ORDER BY [Order].OrderID ASC;
