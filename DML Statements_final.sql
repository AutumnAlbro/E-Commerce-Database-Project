-- DML Statements for the Stores table
-- Three insert statements provide four entries for the Stores table
INSERT INTO Stores
(AddressLine1, City, State, Zipcode, PhoneNumber)
VALUES ('200 2nd St', 'Louisville', 'KY', '40018', '502-555-5558');
 
INSERT INTO Stores
(AddressLine1, City, State, Zipcode, PhoneNumber)
VALUES ('123 4th St', 'Cleveland', 'OH', '44101', '216-555-5559');
 
INSERT INTO Stores
(AddressLine1, City, State, Zipcode, PhoneNumber)
VALUES ('789 10th St', 'Great Falls', 'MT', '59401', '406-555-5560'),
	('4556 Hickory Ln', 'Waldo', 'WI', '53903', '920-555-5561');
 
-- Update statement changes the AddressLine1 data for StoreNumber 1
UPDATE Stores
SET AddressLine1 = '123 S 4th St'
WHERE StoreNumber = 1;
 
-- Delete statement deletes the entry for StoreNumber 4
DELETE Stores
WHERE StoreNumber = 4;


-- DML Statements for the Customers table
-- Three insert statements provide four entries to the Customers table
INSERT INTO Customers 
(FirstName, LastName, PhoneNumber, EmailAddress)
VALUES ('Jake', 'Ryan', '419-788-2546', '86porsche@yahoo.com');

INSERT INTO Customers
VALUES ('Michelle', 'Smith', '937-789-1234', 'iloveunicorns@hotmail.com', 1), 
	('Jenny', 'Springfield', '867-5309', 'rockinthe80s@aol.com', 3);

INSERT INTO Customers 
(FirstName, LastName, PhoneNumber, EmailAddress, FavoriteStoreID)
VALUES ('Marty', 'McFly', '607-423-9127', 'outoftime@gmail.com', 2);

-- Update changes FavoriteStoreID for the customer with the provided email address
UPDATE Customers
SET FavoriteStoreID = 2
WHERE EmailAddress = '86porsche@yahoo.com';

-- Delete removes the entry for the customer with CustomerID 2
DELETE Customers
WHERE CustomerID = 2;


-- DML Statements for the Addresses table
-- Three insert statements provide five entries to the Addresses table
INSERT INTO Addresses (CustomerID, Line1, City, State, ZipCode, Phone) 
VALUES
(1, '100 Land Ave.', 'Paramus', 'NJ', '90123', '123-456-7890'),
(1, '12 Rosewood Rd.', 'Woodcliff Lake', 'NJ', '07677', '345-123-8745');

INSERT INTO Addresses (CustomerID, Line1, City, State, ZipCode, Phone, Disabled) 
VALUES
(4, '172 Wendy Ave.', 'Omaha', 'NE', '12390', '152-896-1265', 0),
(3, '365 World Rd.', 'Beaverton', 'OR', '67890', '503-654-1291', 0);

INSERT INTO Addresses (CustomerID, Line1, Line2, City, State, ZipCode, Phone) 
VALUES
(4, '500 Bill St.', 'Apt. 56', 'San Francisco', 'CA', '12345', '415-578-1258');

-- Update changes the State column for entries with a CustomerID of 1
UPDATE addresses
SET State = 'OH'
WHERE CustomerID = 1;

-- Delete removes the entry with an AddressID of 5
DELETE FROM Addresses
WHERE AddressID = 5;


-- DML Statements for the CustomerPayments table
-- Three insert statements provide six entries to the CustomerPayments table
INSERT INTO CustomerPayments
(CustomerID, PaymentNickname, Type, NameOnCard, CardNumber, ExpirationDate, SecurityCode, BillingAddressID, DefaultPayment)
VALUES (3, 'Teacher Credit Union', 'creditcard', 'Jenny Springfield', '7983471098647429', '04/32', '513', 2, 1);

INSERT INTO CustomerPayments
VALUES (1, NULL, 'giftcard', NULL, '049763288741', NULL, NULL, NULL, 19.85, 0); 

INSERT INTO CustomerPayments
(CustomerID, Type, CardNumber, Balance)
VALUES (4, 'giftcard', '497326340988', 0.01), 
(3, 'giftcard', '936875986317', 107.01),
(1, 'giftcard', '453976829436', 44.13),
(1, 'giftcard', '697834361025', 0.00);

-- Update changes the PaymentNickname for the entry with a CustomerPaymentID of 4
UPDATE CustomerPayments
SET PaymentNickname = 'Birthday Giftcard'
WHERE CustomerPaymentID = 4;

-- Update changes the Balance for the entry with a CustomerPaymentID of 3
UPDATE CustomerPayments
SET Balance = 1489.22
WHERE CustomerPaymentID = 3;

-- Delete removes the entry with a CustomerPaymentID of 2
DELETE CustomerPayments
WHERE CustomerPaymentID = 2;


-- DML Statements for the Categories table
-- Three insert statements provide three entries to the Categories table
INSERT INTO Categories
(CategoryName)
Values ('Shirts');
 
INSERT INTO Categories
(CategoryName)
Values ('Backpacks');
 
INSERT INTO Categories
(CategoryName)
Values ('Scarfs'), ('Hats');
 
-- Update changes the CategoryName for the entry with a CategoryID of 2
UPDATE Categories
SET CategoryName = 'MISC'
WHERE CategoryID = 2;
 
-- Delete removes the entry with a CategoryID of 3
DELETE Categories
WHERE CategoryID = 3;


-- DML Statements for the Products table
-- Three insert statements provide four entries to the Products table
INSERT INTO Products
(ProductName, CategoryID, Description, ListPrice, DateAdded)
Values ('Shirt3', 1, 'Red Shirt', 9.99, '2022/07/13');
 
INSERT INTO Products
(ProductName, CategoryID, Description, ListPrice, DateAdded)
Values ('Shirt4', 1, 'Blue Shirt', 10.99, '2022/07/13');
 
INSERT INTO Products
(ProductName, CategoryID, Description, ListPrice, DateAdded)
Values ('Hat5', 4, 'Green Hat', 12.99, '2022/07/13'), ('Hat7', 4, 'Pink Hat', 11.99, '2022/07/13');
 
 -- Update changes the ListPrice for the entry with a ProductID of 2
UPDATE Products
SET ListPrice = 9.99
Where ProductID = 2;
 
-- Delete removes the entry with a ProductID of 1
DELETE Products
WHERE ProductID = 1;


-- DML Statements for the Discounts table
-- Three insert statements provide four entries to the Discounts table
INSERT INTO Discounts (DiscountAmount)
VALUES (10);
 
INSERT INTO Discounts (DiscountAmount)
VALUES (20), (15);
 
INSERT INTO Discounts (DiscountAmount)
VALUES (30);
 
--Update changes the DiscountAmount for the entry with a DiscountID of 2
UPDATE Discounts
SET DiscountAmount = 25
WHERE DiscountID = 2;
 
-- Delete removes the entries with a DiscountAmount of 30
DELETE Discounts
WHERE DiscountAmount = 30;


-- DML Statements for the OrderSummary table
-- Three insert statements provide four entries to the OrderSummary table
INSERT INTO OrderSummary (CustomerID, OrderDate, ShippingAddressID, DiscountID)
Values (4, '7/11/2022', 2, 3)
 
INSERT INTO OrderSummary (CustomerID, OrderDate, ShippingAddressID, DiscountID)
VALUES (1, '7/1/2022', 3, 1)
 
INSERT INTO OrderSummary (CustomerID, OrderDate, ShippingAddressID, DiscountID)
 VALUES (3, '7/7/2022', 1, 1), (1, '7/7/2022', 4, 2)
 
-- Update changes the OrderDate for the entry with the OrderID of 3
UPDATE OrderSummary
SET OrderDate = '7/8/2022'
WHERE OrderID = 3

-- Delete removes the entry with an OrderID of 4
DELETE OrderSummary
WHERE OrderID = 4


-- DML Statements for the OrderItems table
-- Three insert statements provide six entries to the OrderItems table
INSERT INTO OrderItems (OrderID, ProductID, ItemPrice, Quantity) 
VALUES (1, 2, 10.99, 1), (1, 4, 11.99, 2);

INSERT INTO OrderItems 
VALUES (3, 3, 12.99, 1), (3, 2, 9.99, 3);

INSERT INTO OrderItems (OrderID, ProductID, ItemPrice, Quantity) 
VALUES (2, 4, 12.99, 2), (2, 3, 12.99, 1);

-- Update changes the Quantity for the entry with ItemID 2
UPDATE OrderItems
SET Quantity = 1
WHERE ItemID = 2;

-- Delete removes the entry with an ItemID of 6
DELETE FROM OrderItems
WHERE ItemID = 6;


-- DML Statements for the OrderPayments table
-- Three insert statements provide five entries to the OrderPayments table
INSERT INTO OrderPayments (OrderID, CustomerPaymentID, Amount) VALUES
(1, 3, 7.98),
(2, 6, 11.63),
(2, 5, 4.35),
(3, 3, 25.00),
(3, 1, 8.96);

-- Update changes the Amount for the entry with an OrderPaymentID of 5
UPDATE OrderPayments
SET Amount = 7.96
WHERE OrderPaymentID = 5;

-- Delete removes the entry with an OrderPaymentID of 3
DELETE FROM OrderPayments
WHERE OrderPaymentID = 3;
