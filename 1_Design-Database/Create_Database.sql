USE [master]
GO

DROP DATABASE IF EXISTS [E-Commerce_System_DB];

CREATE DATABASE [E-Commerce_System_DB]

GO
USE [E-Commerce_System_DB]
GO

-- Create Customer Table.
CREATE TABLE [Customer] (
	[CustomerID] uniqueIdentifier NOT NULL default newid(),
	[CustomerName] nvarchar(200) NOT NULL,
	[CustomerEmail] nvarchar(100) NOT NULL,
	[CustomerPassword] nvarchar(50) NOT NULL,
	[CustomerPhone] nvarchar(50),
	[CustomerCountry] nvarchar(50) NOT NULL,
	[CustomerState] nchar(2),
	[CustomerCity] nvarchar(50)

	CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED ([CustomerID])
);

-- Create Order Table.
CREATE TABLE [Order] (
	[OrderID] uniqueIdentifier NOT NULL default newid(),
	[OrderStatus] nvarchar(50) NOT NULL,
	[OrderActualDate] datetime2 NOT NULL,
	[OrderEstimatedDate] datetime2 NOT NULL,
	[OrderDeliveredDate] datetime2 NOT NULL,
	[OrderPurchaseDate] datetime2 NOT NULL,
	[OrderPrice] decimal(10,2) NOT NULL,
	[OrderPaymentType] nvarchar(50) NOT NULL,
	[OrderPaymentDiscount] Decimal(10,2),
	[CustomerID] uniqueidentifier NOT NULL,
	[LocationID] uniqueidentifier NOT NULL

	CONSTRAINT PK_Order PRIMARY KEY CLUSTERED ([OrderID])
);

-- Create Review Table.
CREATE TABLE [Review] (
	[ReviewID] UniqueIdentifier NOT NULL default newid(),
	[ReviewCrationDate] datetime2 NOT NULL,
	[ReviewTitle] nvarchar(200) NOT NULL,
	[ReviewMessage] nvarchar(500) NOT NULL,
	[ReviewScore] tinyint NOT NULL,
	[ReviewResponseDate] datetime2,
	[ReviewResponseMessage] nvarchar(500),
	[CustomerID] uniqueidentifier NOT NULL,
	[ProductID] uniqueidentifier NOT NULL

	CONSTRAINT PK_Review PRIMARY KEY CLUSTERED ([ReviewID])
);

-- Create OrderItems Table.
CREATE TABLE [OrderItems] (
	[ItemID] UniqueIdentifier NOT NULL default newid(),
	[ItemQuantity] tinyint NOT NULL,
	[ItemFrightPrice] decimal(10,2) NOT NULL,
	[OrderID] uniqueidentifier NOT NULL,
	[ProductID] uniqueidentifier NOT NULL

	CONSTRAINT PK_Item PRIMARY KEY CLUSTERED ([ItemID])
);

-- Create Location Table.
CREATE TABLE [Location] (
	[LocationID] UniqueIdentifier NOT NULL default newid(),
	[RecipientName] nvarchar(200) NOT NULL,
	[RecipientPhone] nvarchar(50) NOT NULL,
	[LocationCountry] nvarchar(50)NOT NULL,
	[LocationState] nchar(2) NOT NULL,
	[LocationCity] nvarchar(50) NOT NULL,
	[LocationStreet] nvarchar(50) NOT NULL,
	[CustomerID] uniqueidentifier NOT NULL

	CONSTRAINT PK_Location PRIMARY KEY CLUSTERED ([LocationID])
);

-- Create Product Table.
CREATE TABLE [Product] (
	[ProductID] UniqueIdentifier NOT NULL default newid(),
	[ProductName] nvarchar(200) NOT NULL,
	[ProductDescription] nvarchar(500) NOT NULL,
	[ProductAmount] int NOT NULL,
	[ProductHeight] decimal(10,2),
	[ProductWidth] decimal(10,2),
	[ProductWight] decimal(10,2),
	[ProductLength] decimal(10,2),
	[ProductPhotoPath] nvarchar(500) NOT NULL,
	[SellerID] uniqueidentifier NOT NULL,
	[CategoryID] uniqueidentifier NOT NULL

	CONSTRAINT PK_Product PRIMARY KEY CLUSTERED ([ProductID])
);

-- Create Seller Table.
CREATE TABLE [Seller] (
	[SellerID] uniqueIdentifier NOT NULL default newid(),
	[SellerName] nvarchar(200) NOT NULL,
	[SellerEmail] nvarchar(100) NOT NULL,
	[SellerPassword] nvarchar(50) NOT NULL,
	[SellerPhone] nvarchar(50),
	[SellerCountry] nvarchar(50) NOT NULL,
	[SellerState] nchar(2),
	[SellerCity] nvarchar(50)

	CONSTRAINT PK_Seller PRIMARY KEY CLUSTERED ([SellerID])
);

-- Create Category Table.
CREATE TABLE [Category] (
	[CategoryID] uniqueIdentifier NOT NULL default newid(),
	[CategoryName] nvarchar(50),
	[CategoryDescription] nvarchar(500),
	[CategoryPhotoPath] nvarchar(500) NOT NULL,
	[SupCategoryID] uniqueidentifier
	
	CONSTRAINT PK_Category PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);

-- Create Photo Table.
CREATE TABLE [Photo](
	[PhotoID] uniqueidentifier NOT NULL default newid(),
	[PhotoPath] nvarchar(500) NOT NULL,
	[ProductID] uniqueidentifier

	CONSTRAINT PK_Photo PRIMARY KEY CLUSTERED ([PhotoID])
);

/* -- Adding Foreign Keys Between Tables -- */
--  Order Table
GO
ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT FK_Order_CustomerID_Customer FOREIGN KEY ([CustomerID])
REFERENCES [Customer] ([CustomerID]);

ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT FK_Order_LocationID_Location FOREIGN KEY ([LocationID])
REFERENCES [Location] ([LocationID]);

-- Review
GO
ALTER TABLE [Review] WITH CHECK ADD CONSTRAINT FK_Review_CustomerID_Customer FOREIGN KEY ([CustomerID])
REFERENCES [Customer] ([CustomerID]);

ALTER TABLE [Review] WITH CHECK ADD CONSTRAINT FK_Review_ProductID_Product FOREIGN KEY ([ProductID])
REFERENCES [Product] ([ProductID]);

-- OrderItems
GO
ALTER TABLE [OrderItems] WITH CHECK ADD CONSTRAINT FK_OrderItems_OrderID_Order FOREIGN KEY ([OrderID])
REFERENCES [Order] ([OrderID]);

ALTER TABLE [OrderItems] WITH CHECK ADD CONSTRAINT FK_OrderItems_ProductID_Product FOREIGN KEY ([ProductID])
REFERENCES [Product] ([ProductID]);

-- Location
GO
ALTER TABLE [Location] WITH CHECK ADD CONSTRAINT FK_Location_CustomerID_Customer FOREIGN KEY ([CustomerID])
REFERENCES [Customer] ([CustomerID]);

-- Product
GO
ALTER TABLE [Product] WITH CHECK ADD CONSTRAINT FK_Product_SellerID_Seller FOREIGN KEY ([SellerID])
REFERENCES [Seller] ([SellerID]);

ALTER TABLE [Product] WITH CHECK ADD CONSTRAINT FK_Product_CategoryID_Category FOREIGN KEY ([CategoryID])
REFERENCES [Category] ([CategoryID]);

-- Category
GO
ALTER TABLE [Category] WITH CHECK ADD CONSTRAINT FK_Category_CategoryID_Category FOREIGN KEY ([SupCategoryID])
REFERENCES [Category] ([CategoryID]);

-- Photo
GO
ALTER TABLE [Photo] WITH CHECK ADD CONSTRAINT FK_Photo_ProductID_Product FOREIGN KEY ([ProductID])
REFERENCES [Product] ([ProductID]);