USE [FinDev3]
--	Enter the desired DataBase name between brackets in the previous line.
--	Or if the desired database is already the default DataBase for this connection,
--	then you can simple delete these first 5 lines in this SQL script file.
GO


-- The below 'CREATE TABLE' statement does just that, it creates a table named 'tbFinCard'.
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbFinCard](
	[FinKey] [nvarchar](12) NOT NULL, -- this line defines the first field of this table
	[FinNameEN] [nvarchar](50) NOT NULL, -- this line defines the 2nd field of this table
 CONSTRAINT [PK_tbFinCard] PRIMARY KEY CLUSTERED ( [FinKey] ASC )
-- The previous line specifies which field is the primary key for this table. A primary key is optional,
-- but I cannot think of a gud reason to *ever* create a table without a primary key.
) ON [PRIMARY]
GO


--	The tbFinCard table will have a row for each credit or debit card type,
--	such as MasterCard, Visa, Discover, and American Express.


-- The below 'CREATE TABLE' statement creates a table named 'tbFinCardPrefix'.
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbFinCardPrefix](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FinKey] [nvarchar](12) NOT NULL, -- This 'FinKey' field will be used to 'point to' ...
	-- the FinKey field of the tbFinCard table.
	[MinPrefix] [nvarchar](50) NULL,
	[MaxPrefix] [nvarchar](50) NULL,
	[MinDigitLen] [tinyint] NULL, -- Note: this line uses brackets ...
	 MaxDigitLen   tinyint  NULL, -- while this line omits the optional brackets.
	[WhenStart] [date] NULL,
	[WhenEnd] [date] NULL,
	[ValidationAlgorithm] [nvarchar](12) NULL,
 CONSTRAINT [PK_tbFinPrefix] PRIMARY KEY CLUSTERED ( [id] ASC )
) ON [PRIMARY]
GO
--	This tbFinCardPrefix table holds what prefixes are used for which credit/debit card types,
--	so which card number prefixes are for Visa cards, and which prefixes are for Discover cards,
--	etc. But first we also need to add two SQL 'constraints' ...


--	This next 'foreign key constraint' forces all new rows in the [tbFinCardPrefix] table
--	to have a 'FinKey' value that exists already in the 'tbFinCard' table. These values
--	will be 'Visa' or 'Discover', etc.
--	Foreign Keys are a very common constraint used in SQL databases.
--	This is one way SQL 'forces' 'data integrity' in tables, so the tbFinCard table cannot
--	have a row for any credit or debit card that is not listed in the tbFinCard table.
ALTER TABLE [dbo].[tbFinCardPrefix]
 ADD CONSTRAINT [FK_tbFinPrefix_tbFin]
  FOREIGN KEY([FinKey]) REFERENCES [dbo].[tbFinCard] ([FinKey])
GO


--	This next constraint is a 'check constraint'. It forces the Length of the MinPrefix field value
--	to be the same length as the MaxPrefix field value. This helps SQL force the data to uphold this
--	rule for table data (which SQL calls a 'constraint').
ALTER TABLE [dbo].[tbFinCardPrefix]
 ADD CONSTRAINT [CK_tbFinPrefix_SamePrefixLengths]
  CHECK ((IsNull(Len([MinPrefix]),(-1))=IsNull(Len([MaxPrefix]),(-2))))
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFinCard]
AS
SELECT [FinKey]
      ,[FinNameEN]
  FROM [dbo].[tbFinCard]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFinCardPrefix]
AS
SELECT	p.[id]			as pID
	,	p.[FinKey]		as pFinKey
	,	p.[MinPrefix]	as pMinPrefix
	,	p.[MaxPrefix]	as pMaxPrefix
	,	p.[minDigitLen]	as pMinDigitLen
	,	p.[maxDigitLen]	as pMaxDigitLen
	,	p.[WhenStart]	as pWhenStart
	,	p.[WhenEnd]		as pWhenEnd
	,	p.ValidationAlgorithm as pValidationAlgorithm

  	,	f.[FinKey]		as fFinKey
	,	f.[FinNameEN]	as fFinNameEN
 FROM [dbo].[tbFinCardPrefix] p join tbFinCard f on p.FinKey = f.FinKey
GO

/*	The below SQL commands are what will delete the SQL views and tables from the database.
	I created them because i attempted these script files many times before i got them to work exactly how i wanted,
	so they are really here for my usefulness, but you can also familiarize yourself with them if you want. Or don't
	bother with them if they doesn't interest you yet. But it is very good (and i think 'important') for any SQL
	developer to understand what these kinds of SQL statements wud do.

	DROP VIEW [dbo].[vwFinCardPrefix]
	DROP VIEW [dbo].[vwFinCard]
	ALTER TABLE [dbo].[tbFinCardPrefix] DROP CONSTRAINT [FK_tbFinPrefix_tbFin]
	DROP TABLE [dbo].[tbFinCardPrefix]
	DROP TABLE [dbo].[tbFinCard]

*/