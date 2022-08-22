USE [master]
GO

DROP DATABASE IF EXISTS [Olist_E-Commerce_DWH];

CREATE DATABASE [Olist_E-Commerce_DWH]

ALTER DATABASE [Olist_E-Commerce_DWH] SET RECOVERY SIMPLE 

GO
USE [Olist_E-Commerce_DWH]
GO

-- Create Customer Dimension Table.
CREATE TABLE [DimCustomer] (
	[CustomerKey] int IDENTITY(1,1) NOT NULL,
	[CustomerID] nvarchar(50) NOT NULL,
	[CustomerName] nvarchar(200) NOT NULL,
	[CustomerCity] nvarchar(50),
	[CustomerState] nchar(2),
	[CustomerZipCode] nchar(5)

	CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED ([CustomerKey] ASC)
);


-- Create Product Dimension Table.
CREATE TABLE [DimProduct] (
	[ProductKey] int IDENTITY(1,1) NOT NULL,
	[ProductID] nvarchar(50) NOT NULL,
	[ProductName] nvarchar(200) NOT NULL,
	[ProductWight] int,
	[ProductLength] int,
	[ProductHeight] int,
	[ProductWidth] int,
	[ProductCategoryName] nvarchar(200)

	CONSTRAINT PK_Product PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);


-- Create Seller Dimension Table.
CREATE TABLE [DimSeller](
	[SellerKey] int IDENTITY(1,1) NOT NULL,
	[SellerID] nvarchar(50) NOT NULL,
	[SellerName]  nvarchar(250) NOT NULL,
	[SellerZipCode] nchar(5),
	[SellerCity] nvarchar(50),
	[SellerState] nchar(2)

	CONSTRAINT PK_Seller PRIMARY KEY CLUSTERED ([SellerKey] ASC)
);


-- Create Order Dimension Table.
CREATE TABLE [DimOrder] (
	[OrderKey] int IDENTITY(1,1) NOT NULL,
	[OrderID] nvarchar(50) NOT NULL,
	[OrderStatus] nvarchar(50),
	[OrderEstimatedDate] datetime2,
	[OrderActualDate] datetime2,
	[OrderPurchaseDate] datetime2,
	[OrderPaymentValue] decimal(18,10),
	[OrderPaymentType] nvarchar(50),
	[OrderReviewScore] int,
	[OrderReviewCreationDate] datetime2,
	[OrderReviewResponseDate] datetime2,

	CONSTRAINT PK_Order PRIMARY KEY CLUSTERED ([OrderKey] ASC)
);


-- Create Sales Fact Table.
CREATE TABLE [FactSales](
	[SalesID] int IDENTITY (1,1) NOT NULL,
	[CustomerKey] int NOT NULL,
	[SellerKey] int NOT NULL,
	[ProductKey] int NOT NULL,
	[OrderKey] int NOT NULL,
	[ItemUnitPrice] decimal(18,10),
	[ItemFrightValue] decimal(18,10),
	[ItemShippingDate] datetime2

	CONSTRAINT PK_Sales PRIMARY KEY CLUSTERED (SalesID ASC)
);



/* -- Adding Foreign Keys Between Dimention Tables and Fact Table-- */
-- Between DimOrder & FactSales
GO
ALTER TABLE [FactSales] WITH CHECK ADD CONSTRAINT FK_FactSales_OrderKey_DimOrder FOREIGN KEY ([OrderKey])
REFERENCES [DimOrder] ([OrderKey]);


-- Between DimProduct & FactSales
GO
ALTER TABLE [FactSales] WITH CHECK ADD CONSTRAINT FK_FactSales_ProductKey_DimProduct FOREIGN KEY ([ProductKey])
REFERENCES [DimProduct] ([ProductKey]);

-- Between DimSeller & FactSales
GO
ALTER TABLE [FactSales] WITH CHECK ADD CONSTRAINT FK_FactSales_SellerKey_DimSeller FOREIGN KEY ([SellerKey])
REFERENCES [DimSeller] ([SellerKey]);

-- Between DimCustomer & FactSales
GO
ALTER TABLE [FactSales] WITH CHECK ADD CONSTRAINT FK_FactSales_CustomerKey_DimCustomer FOREIGN KEY ([CustomerKey])
REFERENCES [DimCustomer] ([CustomerKey]);

