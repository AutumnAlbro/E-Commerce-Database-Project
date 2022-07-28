/********************************************************
* This script creates the database named RetailStore
*********************************************************/
USE master;
GO

-- If the RetailStore satabase exists delete it
IF  DB_ID('RetailStore') IS NOT NULL
    DROP DATABASE RetailStore;
GO

-- Creates the database RetailStore
CREATE DATABASE RetailStore;
GO

USE RetailStore;

-- Creates the tables for the RetailStore database
CREATE TABLE Stores (
  StoreNumber	INT 	PRIMARY KEY	IDENTITY,
  AddressLine1	VARCHAR(60)	NOT NULL,
  AddressLine2	VARCHAR(60),
  City	VARCHAR(40)	NOT NULL,
  State	VARCHAR(2)	NOT NULL,
  Zipcode	VARCHAR(10)	NOT NULL,
  PhoneNumber	VARCHAR(12) 	NOT NULL,
);


CREATE TABLE Customers (
  CustomerID	INT 		PRIMARY KEY	IDENTITY,
  FirstName	VARCHAR(50)	NOT NULL,		
  LastName	VARCHAR(50)	NOT NULL,
  PhoneNumber	VARCHAR(12)	NOT NULL,
  EmailAddress	VARCHAR(255)	NOT NULL		UNIQUE,
  FavoriteStoreID	INT			REFERENCES Stores (StoreNumber)	
);	

CREATE TABLE Addresses (
  AddressID         	INT           	PRIMARY KEY	IDENTITY,
  CustomerID       	INT           	REFERENCES Customers (CustomerID),
  Line1            	VARCHAR(60)   	NOT NULL,
  Line2           	VARCHAR(60)                  	DEFAULT NULL,
  City              	VARCHAR(40)   	NOT NULL,
  State             	VARCHAR(2)    	NOT NULL,
  ZipCode           	VARCHAR(10)    	NOT NULL,
  Phone              	VARCHAR(12)    	NOT NULL,
  Disabled           	INT            	NOT NULL     	DEFAULT 0
);

CREATE TABLE CustomerPayments (
  CustomerPaymentID	INT			PRIMARY KEY	IDENTITY,
  CustomerID	INT			REFERENCES Customers (CustomerID),	
  PaymentNickname	VARCHAR(50),
  Type	VARCHAR(20)	NOT NULL,
  NameOnCard	VARCHAR(50),
  CardNumber	VARCHAR(16)	NOT NULL,
  ExpirationDate	VARCHAR(5),
  SecurityCode	VARCHAR(4),	
  BillingAddressID	INT 			REFERENCES Addresses (AddressID),
  Balance	MONEY,
  DefaultPayment	BIT						DEFAULT 0
);

CREATE TABLE Categories (
  CategoryID 	INT	PRIMARY KEY	IDENTITY,
  CategoryName	VARCHAR(50) 	NOT NULL		UNIQUE
);

CREATE TABLE Products (
  ProductID	INT	PRIMARY KEY	IDENTITY,
  ProductName 	VARCHAR(50)	NOT NULL,
  CategoryID	INT	REFERENCES Categories (CategoryID),
  Description	TEXT,
  ListPrice	MONEY	NOT NULL,
  DateAdded	SMALLDATETIME	NOT NULL
);

CREATE TABLE Discounts (
  DiscountID	INT	PRIMARY KEY 	IDENTITY, 
  DiscountAmount	MONEY	NOT NULL
);


CREATE TABLE OrderSummary (
  OrderID	INT 	PRIMARY KEY 	IDENTITY,
  CustomerID	INT	REFERENCES Customers (CustomerID),
  OrderDate	DATETIME	NOT NULL,
  ShippingAddressID	INT	REFERENCES Addresses (AddressID),
  DiscountID	INT	REFERENCES Discounts (DiscountID),
);

CREATE TABLE OrderItems (
  ItemID            	INT           	PRIMARY KEY	IDENTITY,
  OrderID           	INT           	REFERENCES OrderSummary (OrderID),
  ProductID         	INT           	REFERENCES Products (ProductID),
  ItemPrice         	MONEY	NOT NULL,
  Quantity          	INT          	NOT NULL    
);

CREATE TABLE OrderPayments (
  OrderPaymentID 	INT	PRIMARY KEY 	IDENTITY,
  OrderID 	INT 	REFERENCES OrderSummary (OrderID),
  CustomerPaymentID	INT 	REFERENCES CustomerPayments (CustomerPaymentID),
  Amount 	MONEY	NOT NULL
);