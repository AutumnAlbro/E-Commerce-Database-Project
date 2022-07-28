-- Query returns the average discount amount for orders by customer
SELECT OrderSummary.CustomerID, FirstName, LastName, 
-- This retrieves the CustomerID, FirstName, and LastName columns
	AVG(DiscountAmount) AS DiscountAmountAVG
	-- Returns the average DiscountAmount
FROM Customers JOIN OrderSummary
	ON Customers.CustomerID = OrderSummary.CustomerID
	-- Joins the Customer and OrderSummary tables using CustomerID
	JOIN Discounts
	ON OrderSummary.DiscountID = Discounts.DiscountID
	-- Joins a third table (Discounts) using DiscountID
WHERE OrderSummary.DiscountID IS NOT NULL
-- Filters out Orders without a DiscountID
GROUP BY OrderSummary.CustomerID, FirstName, LastName
-- Groups the data and calculates the average based on customer
ORDER BY DiscountAmountAVG DESC;
-- The results are sorted by the DiscountAmountAVG in descending order


-- Query returns order information including customer name, subtotal, discount amount, and total
SELECT FirstName, LastName, OrderSummary.OrderID, OrderSubtotal, DiscountAmount, 
-- Retrieves FirstName, LastName, OrderID, OrderSubtotal, and DiscountAmount columns
	OrderSubtotal - DiscountAmount AS OrderTotal
	-- Subtracts the DiscountAmount from OrderSubtotal to get the customer's OrderTotal
FROM Customers JOIN OrderSummary
	ON Customers.CustomerID = OrderSummary.CustomerID
	-- Joins the Customers and OrderSummary tables by CustomerID
	JOIN (SELECT OrderID, SUM(ItemPrice * Quantity) AS OrderSubtotal
	-- This subquery retrieves OrderID and the calculated OrderSubtotal columns
	FROM OrderItems
	-- This subquery data comes from the OrderItems table
	GROUP BY OrderID) AS OrderSummaryTotals
	-- The data is grouped by the OrderID and the derived table alias is OrderSummaryTotals
	ON OrderSummary.OrderID = OrderSummaryTotals.OrderID
	-- The derived table is join to the OrderSummary table via the OrderID
	JOIN Discounts
	ON OrderSummary.DiscountID = Discounts.DiscountID
	-- The Discounts table is also joined to the OrderSummary table but via the DiscountID
ORDER BY OrderTotal DESC;
-- The returned data is sorted by the OrderTotal in descending order


-- Query returns custumer order data, including the average, min, and max number of items ordered
SELECT LastName, FirstName, AVG(ItemsOrdered) AS AvgItemsOrdered,
-- Retrieves the LastName, FirstName, and calculated average of ItemsOrder
	MIN(ItemsOrdered) AS MinItemsOrdered, MAX(ItemsOrdered) AS MaxItemsOrdered
	-- Returns the minimum and maximum values for ItemsOrdered
FROM Customers JOIN OrderSummary
	ON Customers.CustomerID = OrderSummary.CustomerID
	-- Joins the Customers and OrderSummary tables using the CustomeriD
	JOIN (SELECT OrderID, COUNT(ItemID) AS ItemsOrdered
	-- This subquery retrieves the OrderID and the count of the ItemID
	FROM OrderItems
	-- The data comes from the OrderItems table
	GROUP BY OrderID) AS ItemsPerOrder
	-- The data is group by the OrderID and the derived table alias is ItemsPerOrder
	ON OrderSummary.OrderID = ItemsPerOrder.OrderID
	-- The derived table is joined with the OrderSummary table using the OrderID
GROUP BY LastName, FirstName
-- The outer query is grouped by the customer LastName and FirstName
ORDER BY LastName, FirstName;
-- The result set is sorted by the customer LastName and FirstName


-- Query returns category data such as number of products, min price and max price
SELECT CategoryName, COUNT(ProductID) AS NumberOfProducts,
-- Retrieves the CategoryName column and a count of the ProductiD column
	MIN(ListPrice) as MinPrice, MAX(ListPrice) as MaxPrice
	-- Calculates and returns the min and max prices
FROM Products p JOIN Categories c
	ON p.CategoryID = c.CategoryID
	-- Joins the Products and Categories tables using the CategoryID
GROUP BY CategoryName
-- Groups the data by the CategoryName
ORDER BY CategoryName;
-- Sorts the data by the CategoryName


-- Query provides a comparison of the amount paid and the order total amount for each order
SELECT OrderSummaryTotals.OrderID, SUM(Amount) As PaymentTotal, OrderTotal, 
-- Retreives the OrderID column, the sum of the Amount, and Ordertotal column 
	OrderTotal - SUM(Amount) AS RemainingOrderBalance
	-- Calculates and returns the RemaingOrderBalance from the OrderTotal and Amount sum
FROM OrderPayments
	RIGHT JOIN (SELECT OrderItems.OrderID, SUM(ItemPrice * Quantity) - DiscountAmount AS OrderTotal
	-- The subquery retrieves the OrderID and calculated OrderTotal columns
	FROM OrderItems JOIN OrderSummary
	ON OrderItems.OrderID = OrderSummary.OrderID
	-- Joins the OrderItems and OrderSummary tables using OrderID
	JOIN Discounts
	ON OrderSummary.DiscountID = Discounts.DiscountID
	-- Joins the DIscounts and OrderSummary tables using DiscountID
	GROUP BY OrderItems.OrderID, DiscountAmount) AS OrderSummaryTotals
	-- Groups the subquery data by OrderID and DiscountAmount
	ON OrderPayments.OrderID = OrderSummaryTotals.OrderID
	-- Joins the OrderPayments table and the derived table using OrderID
GROUP BY OrderSummaryTotals.OrderID, OrderTotal
-- Groups the outer query data by OrderID and OrderTotal
ORDER BY RemainingOrderBalance DESC;
-- Sorts the result set by RemainingOrderBalance in descending order


-- Query returns product data such as ID, name, quantity sold, and last purchase date
SELECT Products.ProductID, ProductName, 
-- Retrieves the ProductID and ProductName
	SUM(Quantity) AS TotalNumberPurchased, MAX(OrderDate) AS LatestPurchaseDate
	-- Returns the calculated columns of the Quantity sum and OrderDate maximum
FROM Products LEFT JOIN OrderItems
-- Joins Products and OrderItems tables with a left join, to include all products
	ON Products.ProductID = OrderItems.ProductID
	-- Uses the ProductID to join the two tables
	JOIN OrderSummary
	ON OrderItems.OrderID = OrderSummary.OrderID
	-- Joins the OrderItems and OrderSummary tables using OrderID
GROUP BY Products.ProductID, ProductName
-- Groups the data by the ProductID and ProductName
ORDER BY LatestPurchaseDate DESC;
-- Sorts the result set by LatestPurchaseDate in descending order
