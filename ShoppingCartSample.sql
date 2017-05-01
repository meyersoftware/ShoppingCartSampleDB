--don'tdancewhileyoureating

CREATE TABLE dbo.Customer
	(
	CustomerID int NOT NULL IDENTITY (1, 1),
	UserID nvarchar(200) NOT NULL,
	Firstname nvarchar(200) NOT NULL,
	Middlename nvarchar(200) NULL,
	Lastname nvarchar(200) NULL,
        Address nvarchar(200) NOT NULL,
	Address2 nvarchar(200) NULL,
	City nvarchar(100) NOT NULL,
	State nvarchar(50) NOT NULL,
	Zip nvarchar(50) NOT NULL
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.Customer ADD CONSTRAINT
	PK_Customer PRIMARY KEY CLUSTERED 
	(
	CustomerID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ProductDescription] [text] NOT NULL,
	[Price] [money] NOT NULL,
	[Stock] [int] NOT NULL,
	[SortOrder] [int] NULL,
	[Image] [nvarchar](255) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE dbo.Orders
	(
	[OrderID] int NOT NULL IDENTITY (1, 1),
	[CustomerID] int NOT NULL,
	[ProductID] int NOT NULL,
	[Count] int,

 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE dbo.Customer ADD CONSTRAINT
	PK_Customer PRIMARY KEY CLUSTERED 
	(
	CustomerID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO


ALTER TABLE dbo.Product ADD CONSTRAINT
	PK_Product PRIMARY KEY CLUSTERED 
	(
	ProductID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

insert into Product (Name, ProductDescription,Price, Stock, SortOrder, [Image])
values ('thing a ma bob', 'Many people confuse this with ''thing a man bob'', but you can''t buy people.  It''s the next best thing I suppose.',10.00, 1, 1, 'thingamabob.jpg')

insert into Product (Name, ProductDescription,Price, Stock, SortOrder, [Image])
values ('thing a ma jig', 'War broke out centuries ago based on whether this was superior to thing a ma bob. It ended in a stalemate. Also, it''s possible it never happened.',20.00, 2, 2, 'thingamajig.jpg')

insert into Product (Name, ProductDescription,Price , Stock, SortOrder, [Image])
values ('a hearty jig', 'Think Ireland. Think dancing. Think feeling truly alive.', 50.00, 2, 3, 'jig.jpg')

insert into Product (Name, ProductDescription, Price, Stock, SortOrder, [Image])
values ('some hearty soup', 'Like mom used to make when you were faking sick from school, to make you feel guilty. Good stuff.',25.00, 4, 4, 'heartysoup.jpg')

insert into Product (Name, ProductDescription, Price, Stock, SortOrder, [Image])
values ('soup stain remover', 'You ate the soup while you were getting jiggy, didn''t you? Well pay up sucker.',100000.00, 6, 5, 'stain.jpg')

GO


CREATE PROCEDURE AddStock
(
	@ProductID int,
	@Count int
)
AS
BEGIN
	Update Product
	Set Stock = Stock + @Count
	Where ProductID = @ProductID
END
GO

CREATE PROCEDURE RemoveStock
(
	@ProductID int,
	@Count int
)
AS
BEGIN
	Update Product
	Set Stock = Stock - @Count
	Where ProductID = @ProductID
END
GO

CREATE PROCEDURE InsertCustomer
(
	@UserID nvarchar(200),
	@Firstname nvarchar(200),
	@Middlename nvarchar(200),
	@Lastname nvarchar(200),
    @Address nvarchar(200),
	@Address2 nvarchar(200),
	@City nvarchar(100),
	@State nvarchar(50),
	@Zip nvarchar(50)
)
AS
BEGIN
	insert into Customer
	select @UserID,
	@Firstname,
	@Middlename,
	@Lastname,
    @Address,
	@Address2,
	@City,
	@State,
	@Zip
END
GO

CREATE PROCEDURE UpdateCustomer
(
	@UserID nvarchar(200),
	@Firstname nvarchar(200),
	@Middlename nvarchar(200),
	@Lastname nvarchar(200),
    @Address nvarchar(200),
	@Address2 nvarchar(200),
	@City nvarchar(100),
	@State nvarchar(50),
	@Zip nvarchar(50)
)
AS
BEGIN
	Update Customer
	SET Firstname = @Firstname,
	Middlename = @Middlename,
	Lastname = @Lastname,
    Address = @Address,
	Address2 = @Address2,
	City = @City,
	State = @State,
	Zip = @Zip
	Where UserID = @UserID
END

GO

CREATE PROCEDURE AddOrder
@CustomerID int,
@ProductID int,
@Count int
AS
BEGIN
	insert into Orders
	select @CustomerID,
	@ProductID,
	@Count
END

GO

CREATE PROCEDURE GetProduct
	@ProductID int
AS
BEGIN
	IF @ProductID = 0
	BEGIN
		SELECT * FROM Product
	END
	ELSE
	BEGIN
		SELECT * FROM Product WHERE ProductID = @ProductID
	END
END
GO

CREATE PROCEDURE GetCustomer
	@UserID nvarchar(200)
AS
BEGIN
	SELECT * FROM Customer WHERE UserID=@UserID
END