USE [FinDev3]
GO
/****** Object:  UserDefinedFunction [dbo].[DateToString]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-05-22
-- Description:	Converts Sql data to string,
--	 removing any insignificant trailing 0's.
-- Note: Return value is not quoted.
-- =============================================
CREATE FUNCTION [dbo].[DateToString](@d datetime)
RETURNS nvarchar(48)
AS
BEGIN
	DECLARE @r nvarchar(48)

	if @d is null
	begin
		return null
	end

	set @r = dbo.NumToString(Year(@d))
	set @r += '-' + Right('0' + dbo.NumToString(Month(@d)), 2)
	set @r += '-' + Right('0' + dbo.NumToString(Day(@d)), 2)
	
	if @d <> DateAdd(month,Month(@d)-1+12*(Year(@d)-1900),Day(@d)-1)
	begin
		declare @ss smallint; set @ss = DatePart(Second, @d)
		declare @ms smallint; set @ms = DatePart(MilliSecond, @d)
		set @r += ' ' + Right('0' + dbo.NumToString(DatePart(Hour, @d)), 2)
		set @r += ':' + Right('0' + dbo.NumToString(DatePart(Minute, @d)), 2)
		if @ss > 0 or @ms > 0
		begin
			set @r += ':' + Right('0' + dbo.NumToString(DatePart(Second, @d)), 2)
			if DatePart(Millisecond, @d) > 0
			begin
				declare @m varchar(30)
				set @m = dbo.NumToString(Convert(decimal(8,4), DatePart(Millisecond, @d))/1000)
				-- now @m resembles '0.23' for 230 milliseconds
				set @m = right(@m, Len(@m) - 1) -- trim off first '0' before '.'
				-- now @m resembles '.23' for 230 milliseconds
				set @r += @m
			end
		end
	end

	return @r
END



GO
/****** Object:  UserDefinedFunction [dbo].[DateToStringQ]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-07-26
-- Description:	Converts Sql data to string,
--	 removing any insignificant trailing 0's.
-- Note: Return value includes single quote before and after string value.
-- =============================================
CREATE FUNCTION [dbo].[DateToStringQ](@d datetime)
RETURNS nvarchar(48)
AS
BEGIN
	DECLARE @r nvarchar(48)

	set @r = dbo.DateToString(@d);
	if (@r != 'NULL')
	begin;
		set @r = '''' + @r + '''';
	end;
	return @r
END



GO
/****** Object:  UserDefinedFunction [dbo].[GetAccountBalanceByAccountIdAndTime]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-07-12
-- Description:	Calculates the balance of any Account by Account.Id and at a given DateTime.
-- =============================================
CREATE FUNCTION [dbo].[GetAccountBalanceByAccountIdAndTime](@accountId int, @untilWhen DateTime)
RETURNS Decimal(28,12)
AS
BEGIN
	if not exists (select Id from Account where Id = @accountId)
		return null

	DECLARE	@d Decimal(28,12) -- total sum of deposits
		,	@w Decimal(28,12) -- total sum of withdrawals

	if (@untilWhen is null)
	begin -- this will include all transactions, including pending transations
		select @d = sum(  ToAmount) from [Tran] where   ToAccountId = @accountId
		select @w = sum(FromAmount) from [Tran] where FromAccountId = @accountId
	end
	else
	begin -- this excludes pending transactions and dates after given DateTime
		select @d = sum(  ToAmount) from [Tran] where   ToAccountId = @accountId and PostDate <= @untilWhen
		select @w = sum(FromAmount) from [Tran] where FromAccountId = @accountId and PostDate <= @untilWhen
	end

--	if @d is null and @w is null		return null

	return IsNull(@d, 0) - IsNull(@w, 0)

END



GO
/****** Object:  UserDefinedFunction [dbo].[GetLuhnDigit]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION	[dbo].[GetLuhnDigit](@Luhn VARCHAR(8000))
RETURNS VARCHAR(1)
AS
BEGIN
	DECLARE @L VarChar(8000)
	SET @L = Replace(@Luhn, '-', '') -- allow hyphens in @Luhn parameter

	IF @L LIKE '%[^0-9]%'
		RETURN ''

	DECLARE	@Index SMALLINT,
		@Multiplier TINYINT,
		@Sum INT,
		@Plus TINYINT

	SELECT	@Index = LEN(@L),
			@Multiplier = 2,
			@Sum = 0

	WHILE @Index >= 1
		SELECT	@Plus = @Multiplier * CAST(SUBSTRING(@L, @Index, 1) AS TINYINT),
			@Multiplier = 3 - @Multiplier,
			@Sum = @Sum + @Plus / 10 + @Plus % 10,
			@Index = @Index - 1

	RETURN CASE WHEN @Sum % 10 = 0 THEN '0' ELSE CAST(10 - @Sum % 10 AS CHAR) END
END



GO
/****** Object:  UserDefinedFunction [dbo].[GetLuhnNumber]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-05-15
-- Description:	Appends Luhn digit to string number
-- =============================================
CREATE FUNCTION [dbo].[GetLuhnNumber]
(
	@Luhn VarChar(7999)
)
RETURNS VarChar(8000)
AS
BEGIN
	RETURN @Luhn + dbo.GetLuhnDigit(@Luhn)
END



GO
/****** Object:  UserDefinedFunction [dbo].[Hex32toInt4]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-04-04
-- Description:	Converts 32 hex digits to INT.
--				(INT = Int32 = 4 byte integer).
--              Result may be Positive, Negative, or 0.
-- Note: Function removes all hyphens from parameter,
-- so SQL's 'NewID()' may be passed directly to
-- this function.
-- =============================================
create FUNCTION [dbo].[Hex32toInt4](@hx varchar(50))
RETURNS INT
AS
BEGIN
	declare @r int; -- return value
	set @hx = REPLACE(@hx, '-', ''); -- now hx = 32 random hex characters
	set @hx = REPLACE(@hx, ' ', '');
	set @hx = RTRIM(@hx)
	set @r = 0;
	if (LEN(@hx) = 0) or (LEN(@hx) % 8) <> 0
	begin;
		return 0;
	end;
	-- now we take @hx, 8 hex digits at a time, convert them to INT and XOR r with that value.
	while (LEN(@hx) > 0)
	begin;
		set @r = @r ^ CONVERT(INT, CONVERT(VARBINARY, LEFT(@hx, 8), 2))
		set @hx = SUBSTRING(@hx, 9, Len(@hx))
	end;
	return @r
END



GO
/****** Object:  UserDefinedFunction [dbo].[HexToInt4]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2015-09-01
-- Description:	Converts hex digits to INT. Hex Char count must be <= 8.
--				(INT = Int32 = 4 byte integer).
--              Result may be Positive, Negative, or 0.
-- =============================================
CREATE FUNCTION [dbo].[HexToInt4](@hx NVarChar(max), @ignoredChars NVarChar(max))
RETURNS INT
AS
BEGIN
	if (@hx is null) begin; return null; end;

	set @hx =  dbo.ModifyTextWithCharsToRemove(@hx, @ignoredChars); -- Removes characters to be ignored.
	if (@hx <> dbo.ModifyTextWithCharsToKeep  (@hx, '0123456789ABCDEFabcdef'))
	begin; -- @hx has invalid chars (chars that are not Hex chars) and not in the 'ignoreChars' parameter.
		return null;
	end;
	-- now @hx only contains Hex chars
	if (LEN(@hx) > 8) begin; return null; end; -- too many hex chars. only up to 8 allowed.

	if (Len(@hx) % 2 > 0) begin; set @hx = '0' + @hx; end;
	declare @r int; -- return value
	set @r = CONVERT(INT, CONVERT(VARBINARY, @hx, 2));
	return @r;
END
GO




/****** Object:  UserDefinedFunction [dbo].[IsLuhnValid]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsLuhnValid](@Luhn VARCHAR(8000))
RETURNS BIT
AS
BEGIN
	DECLARE @L VarChar(8000)
	SET @L = Replace(@Luhn, '-', '') -- allow hyphens in @Luhn parameter

	IF @L LIKE '%[^0-9]%'
		RETURN 0 -- contains char that is not a digit from 0 thru 9.

	DECLARE	@Index SMALLINT,
		@Multiplier TINYINT,
		@Sum INT,
		@Plus TINYINT

	SELECT	@Index = LEN(@L),
		@Multiplier = 1,
		@Sum = 0

	WHILE @Index >= 1
		SELECT	@Plus = @Multiplier * CAST(SUBSTRING(@L, @Index, 1) AS TINYINT),
			@Multiplier = 3 - @Multiplier,
			@Sum = @Sum + @Plus / 10 + @Plus % 10,
			@Index = @Index - 1

	RETURN CASE WHEN @Sum % 10 = 0 THEN 1 ELSE 0 END
END



GO
/****** Object:  UserDefinedFunction [dbo].[ModifyTextWithCharsToKeep]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2015-11-05
-- Description:	Removes all characters except specified 'charsToKeep'.
--	This is NOT case-sensitive.
--	ModifyTextWithCharsToKeep('abcd654321', 'AbC23') returns 'AbC32'.
--	All chars NOT in @charsToKeep are removed.
-- =============================================
CREATE FUNCTION [dbo].[ModifyTextWithCharsToKeep]
(	@txt NVarChar(max), @charsToKeep NVarChar(max)
)
RETURNS NVarChar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r NVarChar(max), @ch NChar;
	declare @x int;
	if (@txt is null) return null;

	set @r = ''; set @x = Len(@txt + '.') - 1;

	while (@x > 0)
	begin;
		set @ch = SUBSTRING(@txt, @x, 1);
		if (CharIndex(@ch, @charsToKeep) > 0)
		begin;
			set @r = @ch + @r;
		end;
		set @x -= 1;
	end;
	return @r;
END



GO
/****** Object:  UserDefinedFunction [dbo].[ModifyTextWithCharsToRemove]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2015-11-05
-- Description:	Removes characters from @txt that are found in 'charsToRemove'.
--	This is NOT case-sensitive so any letter(s) in @charsToRemove will remove
--	both the Upper *and* Lower-Case equivalents from @txt.
--	ModifyTextWithCharsToRemove('abcd654321', 'AbC23') returns 'd6541'.
-- =============================================
CREATE FUNCTION [dbo].[ModifyTextWithCharsToRemove]
(	@txt NVarChar(max), @charsToRemove NVarChar(max)
)
RETURNS NVarChar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r NVarChar(max), @ch NChar(1);
	declare @x int;
	if (@txt is null) return null;
	if (@charsToRemove is null) return @txt;

	set @r = ''; set @x = Len(@txt + '.') - 1;

	while (@x > 0)
	begin;
		set @ch = SUBSTRING(@txt, @x, 1);
		if (CharIndex(@ch, @charsToRemove) <= 0)
		begin;
			set @r = @ch + @r;
		end;
		set @x -= 1;
	end;
	return @r;
END



GO
/****** Object:  UserDefinedFunction [dbo].[NumToString]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-05-22
-- Description:	Converts Sql data to string,
--	 removing any insignificant trailing 0's.
-- =============================================
CREATE FUNCTION [dbo].[NumToString](@num sql_variant)
RETURNS nvarchar(48)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r nvarchar(48)

	if @num is null
	begin
		return 'null'
	end

	set @r = LTrim(RTrim(convert(nvarchar(48), @num)))
	while CHARINDEX('.', @r) > 0 and Right(@r, 1) = '0'
	begin
		set @r = Left(@r, Len(@r + '.') - 2)
	end
	if Len(@r) > 1 and right(@r, 1) = '.'
	begin
		set @r = Left(@r, Len(@r + '.') - 2)
	end

	return @r
END



GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2013-07-31
-- Modify date: 2014-10-14
-- Description:	Separates a list of strings,
--              split by @separatorString.
-- Note: If @separatorString is null, then
-- the split character is the 1st char in @txt.
-- Returned table has 2 fields: 'itemIndex1' and 'item'.
-- [itemIndex1] field indexes each return record and begins counting at 1.
-- [item] field is the string item.
-- =============================================
CREATE FUNCTION [dbo].[SplitString]
(
	@txt nvarchar(max),
	@separatorString nvarchar(999),
	@trimItems bit,
	@removeEmptyItems bit
)
RETURNS @items TABLE
(
	itemIndex1 int,
	item nvarchar(max)
)
AS
BEGIN
	declare @charX int;
	declare @itemX int; set @itemX = 0;
	if @separatorString is null
	begin
		set @separatorString = SUBSTRING(@txt, 1, 1)
		set @txt = SUBSTRING(@txt, 2, len(@txt + '-'))
	end
	declare @sepLen1 int; set @sepLen1 = LEN(@separatorString + '*') - 2;
	-- @sepLen1 = true Len(@separatorString) - 1    -- SQL's Len('a ') = 1, not 2.
	declare @txtLen int;
	declare @item nvarchar(max);

	if (@trimItems <> 0) set @txt = LTrim(RTrim(@txt));
	set @txt = @txt + @separatorString
	set @txtLen = LEN(@txt + '*') - 1;
	while LEN(@txt) > 0
	begin
		set @itemX += 1;
		set @charX = CHARINDEX(@separatorString, @txt)
		if @charX > 1
		begin
		    set @item = Left(@txt, @charX - 1)
		    if (@trimItems <> 0) set @item = RTRIM(@item)
			insert into @items (itemIndex1, item) values (@itemX, @item)
			set @txt = Right(@txt, @txtLen - @charX - @sepLen1)
			if (@trimItems <> 0) set @txt = LTRIM(@txt)
		end
		else if @charX = 1 -- empty item
		begin
		    if @removeEmptyItems = 0
				insert into @items (itemIndex1, item) values (@itemX, '')
			else
				set @itemX -= 1;
			set @txt = Right(@txt, @txtLen - @charX - @sepLen1)
			if (@trimItems <> 0) set @txt = LTRIM(@txt)
		end
		else
		begin
			insert into @items (itemIndex1, item) values (@itemX, @txt)
			set @txt = ''
		end
		set @txtLen = LEN(@txt + '*') - 1;
	end
	RETURN
END



GO
/****** Object:  UserDefinedFunction [dbo].[GetSumBySubAcctIdBeforeDate]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-04-24
-- Description:	Retrieves the sum of one person's SubAccount before a given date.
-- =============================================
CREATE FUNCTION [dbo].[GetSumBySubAcctIdBeforeDate]
(	@SubAccountId int
,	@endDate datetime
)
RETURNS money
AS
BEGIN
	DECLARE @r money

	select @r = Sum(TraAmt) from Xaction
	 where TraSubActId = @SubAccountId
	  and TraDate < @endDate

	RETURN @r
END



GO
/****** Object:  UserDefinedFunction [dbo].[GetSumBySubAcctIdBeforePostingDate]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-04-24
-- Description:	Retrieves the sum of one person's SubAccount before a given posting date.
-- =============================================
create FUNCTION [dbo].[GetSumBySubAcctIdBeforePostingDate]
(	@SubAccountId int
,	@endPostingDate datetime
)
RETURNS money
AS
BEGIN
	DECLARE @r money

	select @r = Sum(TraAmt) from Xaction
	 where TraSubActId = @SubAccountId
	  and TraPostDate < @endPostingDate

	RETURN @r
END



GO
/****** Object:  Table [dbo].[Account]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileId] [int] NOT NULL,
--	[Number]  AS (CONVERT([bigint],[dbo].[ModifyTextWithCharsToKeep]([NumStr],'0123456789'),(0))),
	AccountName varchar(36) not null,
	[Title] [nvarchar](50) NOT NULL,
	[TitlePart1] [nvarchar](12) NOT NULL,
	[TitlePart2] [nvarchar](12) NOT NULL,
	[Precision] [smallint] NOT NULL,
	[DeactivationDateUTC] [smalldatetime] NULL,
	[APY] [decimal](9, 8) NULL,
	[NextAccrualDate] [date] NULL,
	[AccrualPeriodInMonths] [tinyint] NULL,
	[NextRentChargeAmount] [decimal](38, 19) NULL,
	[NextRentDate] [date] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Currency]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Currency](
	[Id] [varchar](12) NOT NULL,
	[NameEN] [nvarchar](50) NOT NULL,
	[MassTroyOz] [decimal](8, 4) NULL,
	[AgPerUnit] [decimal](8, 4) NULL,
	[AuPerUnit] [decimal](8, 4) NULL,
	[UsdPerUnit] [decimal](18, 0) NULL,
	[DescripEN] [varchar](144) NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogBackup]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogBackup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WhenUTC] [smalldatetime] NOT NULL,
	[WhenLocal] [smalldatetime] NOT NULL,
	[FileName] [nvarchar](144) NOT NULL,
 CONSTRAINT [PK_LogBackup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Market]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Market](
	[MarketCode] [varchar](12) NOT NULL,
	[MarketURL] [nvarchar](144) NULL,
	[ShortNameEN] [varchar](72) NULL,
	[LongNameEN] [varchar](144) NULL,
 CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED 
(
	[MarketCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MarketPrice]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MarketPrice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MetalCode] [varchar](2) NOT NULL,
	[MarketCode] [varchar](12) NOT NULL,
	[WhenUTC] [datetime] NOT NULL,
	[PriceUSD] [smallmoney] NOT NULL,
	[PriceEUR] [smallmoney] NULL,
	[PriceGBP] [smallmoney] NULL,
 CONSTRAINT [PK_MarketPrice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 2017-04-30 09:50:42 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AspNetUserId] [nvarchar](128) NOT NULL,
	[FirstName] [nvarchar](144) NULL,
	[LastName] [nvarchar](144) NULL,
	[NickName] [nvarchar](144) NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SettingString]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingString](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](max) NOT NULL,
	[SettingDescr] [nvarchar](max) NULL,
 CONSTRAINT [PK_SettingString] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FinCard]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinCard](
	[FinKey] [nvarchar](12) NOT NULL,
	[FinNameEN] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_FinCard] PRIMARY KEY CLUSTERED 
(
	[FinKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FinCardPrefix]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinCardPrefix](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FinKey] [nvarchar](12) NOT NULL,
	[MinPrefix] [nvarchar](50) NULL,
	[MaxPrefix] [nvarchar](50) NULL,
	[MinDigitLen] [tinyint] NULL,
	[MaxDigitLen] [tinyint] NULL,
	[WhenStart] [date] NULL,
	[WhenEnd] [date] NULL,
	[ValidationAlgorithm] [nvarchar](12) NULL,
 CONSTRAINT [PK_FinCardPrefix] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tran]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tran](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TranTypeId] [tinyint] NOT NULL,
	[ToAccountId] [int] NULL,
	[ToAmount] [decimal](38, 19) NULL,
	[FromAccountId] [int] NULL,
	[FromAmount] [decimal](38, 19) NULL,
	[TranDate] [datetime] NULL,
	[PostDate] [datetime] NULL,
	[Note] [nvarchar](144) NULL,
 CONSTRAINT [PK_Tran] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TranType]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TranType](
	[Id] [tinyint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TranType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[AccountView]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AccountView]
AS
SELECT	p.[Id] as ProfileId
	,	p.[UserName]
	,	p.[AccountNumRoot]
	,	p.[AccountTitle] as ShortAccountTitle
	,	p.[DeactivationDateUTC] as WhenAccountExpiresUTC
	,	a.Id as AccountId
	,	a.AccountName as AccountName
--	,	a.Number as AccountNumber	--	deprecated by AccountName field
--	,	a.NumStr as AccountNumberStr--	deprecated by AccountName field
	,	a.Title as AccountTitle
	,	a.DeactivationDateUTC as WhenProfileExpiresUTC
	,	a.APY
	,	a.NextAccrualDate
	,	a.AccrualPeriodInMonths
 FROM dbo.Profile p JOIN dbo.Account a ON p.Id = a.ProfileId
GO
/****** Object:  View [dbo].[FinCardPrefixView]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FinCardPrefixView]
AS
SELECT	p.[Id]			as pId
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
 FROM [dbo].[FinCardPrefix] p join FinCard f on p.FinKey = f.FinKey

GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_Precision]  DEFAULT ((2)) FOR [Precision]
GO
ALTER TABLE [dbo].[LogBackup] ADD  CONSTRAINT [DF_LogBackup_WhenUTC]  DEFAULT (getutcdate()) FOR [WhenUTC]
GO
ALTER TABLE [dbo].[LogBackup] ADD  CONSTRAINT [DF_LogBackup_WhenLocal]  DEFAULT (getdate()) FOR [WhenLocal]
GO
ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_AspNetUsers] FOREIGN KEY([AspNetUserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Profile] FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profile] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Profile]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[FinCardPrefix]  WITH CHECK ADD  CONSTRAINT [FK_FinCardPrefix_FinCard] FOREIGN KEY([FinKey])
REFERENCES [dbo].[FinCard] ([FinKey])
GO
ALTER TABLE [dbo].[FinCardPrefix] CHECK CONSTRAINT [FK_FinCardPrefix_FinCard]
GO
ALTER TABLE [dbo].[Tran]  WITH CHECK ADD  CONSTRAINT [FK_Tran_FromAccount] FOREIGN KEY([FromAccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Tran] CHECK CONSTRAINT [FK_Tran_FromAccount]
GO
ALTER TABLE [dbo].[Tran]  WITH CHECK ADD  CONSTRAINT [FK_Tran_ToAccount] FOREIGN KEY([ToAccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Tran] CHECK CONSTRAINT [FK_Tran_ToAccount]
GO
ALTER TABLE [dbo].[Tran]  WITH CHECK ADD  CONSTRAINT [FK_Tran_TranType] FOREIGN KEY([TranTypeId])
REFERENCES [dbo].[TranType] ([Id])
GO
ALTER TABLE [dbo].[Tran] CHECK CONSTRAINT [FK_Tran_TranType]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [CK_Account_Title] CHECK  (([Title]=(([TitlePart1]+' - ')+[TitlePart2])))
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [CK_Account_Title]
GO
ALTER TABLE [dbo].[FinCardPrefix]  WITH CHECK ADD  CONSTRAINT [CK_FinCardPrefix_SamePrefixLengths] CHECK  ((isnull(len([MinPrefix]),(-1))=isnull(len([MaxPrefix]),(-2))))
GO
ALTER TABLE [dbo].[FinCardPrefix] CHECK CONSTRAINT [CK_FinCardPrefix_SamePrefixLengths]
GO
/****** Object:  StoredProcedure [dbo].[AddExchangeTran]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-07-17
-- Description:	Creates Exchange transaction to buy or sell silver
-- =============================================
CREATE PROCEDURE [dbo].[AddExchangeTran] 
	-- Add the parameters for the stored procedure here
	@toAccountId int,
	@toAmount Decimal(28,12),
	@fromAccountId int,
	@fromAmount Decimal(28,12),
	@tranDate datetime,
	@postDate datetime,
	@spotPrice decimal(38, 19)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
	@toAccountId as ToAccountId,
	@toAmount as ToAmount,
	@fromAccountId as FromAccountId,
	@fromAmount as FromAmount,
	@tranDate as TranDate,
	@postDate as PostDate,
	@spotPrice as SpotPrice

END



GO
/****** Object:  StoredProcedure [dbo].[ApplyInterest]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-07-12
-- Description:	Adds applicable interest to
-- interest bearing accounts if CurrentDate >= NextAccrualDate and
-- APY is not null and NextAccrualDate is not null and AccrualPeriodInMonths is not null
-- =============================================
CREATE PROCEDURE [dbo].[ApplyInterest](@show bit = 0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @txt nvarchar(max)
	declare @noteText nvarchar(144)
	-- Now set text pattern for Transaction Note text (that will end up in [Tran].Note field).
	set @noteText = '{APY%} APY interest for {yyyy-MM} (${AverageBalance} * {InterestRate%})'

	declare @dayX tinyint
	declare @table table
	(Id int, APY decimal(9,8),
	 InterestRate decimal(20,18), -- this seems to only benefit with up to 16 precision: decimal(17,16)
	 NextAccrualDate date, AccrualPeriodInMonths tinyint,
	 amt Decimal(28,12), [Precision] smallint, dy tinyint, dii tinyint, NoteText nvarchar(144) )

	insert into @table (Id, APY, NextAccrualDate, AccrualPeriodInMonths, Amt, [Precision], NoteText)
	 select Id, APY, NextAccrualDate, AccrualPeriodInMonths, 0, [Precision], @noteText from Account
	  where NextAccrualDate is not null and APY is not null and AccrualPeriodInMonths is not null
	   and  NextAccrualDate <= GetDate()

	update @table set dii = 0, dy = DateDiff(day, DateAdd(month, -1, NextAccrualDate), NextAccrualDate)
		,	InterestRate = power(convert(decimal(20,18), 1 + APY), convert(decimal(20,18), 1) / (12.0/AccrualPeriodInMonths)) - 1
		-- Power() seems to only keep 16 digits of precision in [InterestRate]
	update @table set InterestRate = Round(InterestRate, 8)

	update @table set NoteText = replace(NoteText, '{yyyy-MM}', '{yyyy}-{MM}') where CharIndex('{yyyy-MM}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{yyyy}', dbo.NumToString(Year(DateAdd(day, -dy, NextAccrualDate))))
		where CharIndex('{yyyy}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{MM}' , Right('0' + dbo.NumToString(Month(DateAdd(day, -dy, NextAccrualDate))), 2))
		where CharIndex('{MM}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{APY%}', dbo.NumToString(APY*100) + '%')
		where CharIndex('{APY%}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{InterestRate%}', dbo.NumToString(InterestRate*100) + '%')
		where CharIndex('{InterestRate%}', NoteText) > 0

	select @dayX = max(dy) from @table

	if @show <> 0
		select *, DateAdd(day, -dy, NextAccrualDate) as [First Balance Date]
				, DateAdd(day, -1 , NextAccrualDate) as  [Last Balance Date]
		 from	@table
		-- Totals for each Account will begin for the balance of that account on [First Balance Date]

	while @dayX > 0
	begin
		if @dayX > 27 or @dayX < 3
		begin
			set @txt = isnull(@txt + ' - ', '') + 'dayX=' + left(@dayX, 2)
			select @txt = @txt + ' [' + left(Id, 9) + '] ' + convert(nvarchar,DateAdd(day, -dy, NextAccrualDate))
			 from @table where dy > 0
		end

		update @table set
				amt += dbo.GetAccountBalanceByAccountIdAndTime(Id, DateAdd(day, -dy, NextAccrualDate))
			--	adds the balance for date that is dy days before NextAccrualDate for that account.
			,	dy  -= 1 -- track days. dy  is how many days are left to include calculation of balance that day.
			,	dii += 1 -- track days. dii is how many days have already been counted.
			where dy > 0
		set @dayX -= 1
	end

	if @show <> 0
	begin
		select @dayX as [@dayX], @txt as [@txt]
				, 'In the following table SELECTion, the amt field now holds total sum of balances for each day in the date range:' as msg
		select *, DateAdd(day, -dii, NextAccrualDate) as [First Balance Date]
				, DateAdd(day, -1  , NextAccrualDate) as  [Last Balance Date]
		 from	@table
	end

	update @table set amt = Round(amt / dii, [Precision])
	update @table set NoteText = replace(NoteText, '{AverageBalance}' , dbo.NumToString(amt))
	 where CharIndex('{AverageBalance}', NoteText) > 0

	if @show <> 0
	begin
	select *, 'This amt field is now the average balance thru-out the date span, which is its previous value / dii' as msg from @table
	end

	update @table set amt = amt * InterestRate

	if @show <> 0
	begin
		select *, (power(convert(decimal(9,8), 1 + APY), convert(decimal(9,8), 1) / (12.0/AccrualPeriodInMonths)) - 1 ) * 100 as InterestRate
				, 'This amt field is now the interest to be deposited given.'
		 from @table
	end

	update @table set amt = Round(amt, [Precision])

	if @show <> 0
	begin
		select *, 'amt is now rounded deposit amount.' from @table
	end

	delete from @table where amt = 0

	insert into [Tran] (TranTypeId, ToAccountId, ToAmount, FromAccountId, FromAmount,
		TranDate, PostDate, Note)
	 select	1 as TranTypeId -- 1 = Deposit
			,	Id as ToAccountId, amt as ToAmount, null as FromAccountId, null as FromAmount
			,	NextAccrualDate as TranDate, NextAccrualDate as PostDate, NoteText as Note
		 from @table

	update Account set NextAccrualDate = DateAdd(month, a.AccrualPeriodInMonths, a.NextAccrualDate)
	 from Account a join @table t on a.Id = t.Id

END



GO
/****** Object:  StoredProcedure [dbo].[ApplyRent]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-08-06
-- Description:	Adds applicable rent charge to rental accounts
-- where CurrentDate >= NextRentDate and NextRentChargeAmount <> 0
-- =============================================
CREATE PROCEDURE [dbo].[ApplyRent](@show bit = 0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @txt nvarchar(max)
	declare @noteText nvarchar(144)
	-- Now set text pattern for Transaction Note text (that will end up in [Tran].Note field).
	set @noteText = 'Rent for {yyyy-MM} {MonthName}'

	declare @dayX tinyint
	declare @table table (Id int, NextRentChargeAmount Decimal(28,12), NextRentDate datetime, NoteText nvarchar(144) )

	insert into @table (Id, NextRentChargeAmount, NextRentDate, NoteText)
	 select Id, NextRentChargeAmount, NextRentDate, @noteText from Account
	  where NextRentDate <= GetDate() and NextRentChargeAmount <> 0

	update @table set NextRentDate = DateAdd(second, -1, DATEADD(day, 1, NextRentDate))
	update @table set NoteText = replace(NoteText, '{yyyy-MM}', '{yyyy}-{MM}') where CharIndex('{yyyy-MM}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{yyyy}', dbo.NumToString(Year(NextRentDate)))
		where CharIndex('{yyyy}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{MM}' , Right('0' + dbo.NumToString(Month(NextRentDate)), 2))
		where CharIndex('{MM}', NoteText) > 0
	update @table set NoteText = replace(NoteText, '{MonthName}', DateName(month, NextRentDate))
		where CharIndex('{MonthName}', NoteText) > 0

	if @show <> 0
	begin; select * from @table; end

	insert into [Tran] (TranTypeId, FromAccountId, FromAmount, ToAccountId, ToAmount,
		TranDate, PostDate, Note)
	 select	2 as TranTypeId -- 2 = Withdrawal
			,	Id as FromAccountId, NextRentChargeAmount as FromAmount, null as ToAccountId, null as ToAmount
			,	NextRentDate as TranDate, NextRentDate as PostDate, NoteText as Note
		 from @table

	update Account set NextRentDate = DateAdd(month, 1, a.NextRentDate)
	 from Account a join @table t on a.Id = t.Id

END



GO
/****** Object:  StoredProcedure [dbo].[BackupDB]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-07-26
-- Description:	Creates database backup
-- =============================================
CREATE PROCEDURE [dbo].[BackupDB] @showInfo bit, @unconditionalBackup bit = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare	@f nvarchar(max) -- file name Folder
		,	@p nvarchar(max) -- file name pattern
		,	@t nvarchar(50) -- Temp string

	select @f = LTrim(RTrim(SettingValue)) from SettingString where SettingName = 'BackupFileNameFolder'
	select @p = LTrim(RTrim(SettingValue)) from SettingString where SettingName = 'BackupFileNamePattern'

	if IsNull(Len(@f),0) = 0 or IsNull(Len(@p),0) = 0
	begin
		if @showInfo <> 0 begin
			declare @msg nvarchar(max); set @msg = 'SQL Setting '
			if @f is null set @msg = @msg + '''BackupFileNameFolder'' is null'
			if Len(@f)=0 set @msg = @msg + '''BackupFileNameFolder'' is empty'
			if IsNull(Len(@f),0) = 0 and IsNull(Len(@p),0) = 0 set @msg = @msg + ' and '
			if @p is null set @msg = @msg + '''BackupFileNamePattern'' is null'
			if Len(@p)=0 set @msg = @msg + '''BackupFileNamePattern'' is empty'
			set @p += '. So BackupDB has nothing to do and will now terminate.'
			print @p
			select @p as Msg
			return -103
		end
	end

	if CharIndex('{UtcDate}', @p) > 0
	begin
		select @p = Replace(@p, '{UtcDate}', Left(dbo.DateToString(GetUtcDate()),10))
	end
	if CharIndex('{UtcTime}', @p) > 0
	begin
		select @p = Replace(@p, '{UtcTime}', Replace(SUBSTRING(dbo.DateToString(GetUtcDate()),12,8), ':', '-'))
	end
	if CharIndex('{LocalDate}', @p) > 0
	begin
		select @p = Replace(@p, '{LocalDate}', Left(dbo.DateToString(GetDate()),10))
	end
	if CharIndex('{LocalTime}', @p) > 0
	begin
		select @p = Replace(@p, '{LocalTime}', Replace(SUBSTRING(dbo.DateToString(GetDate()),12,8), ':', '-'))
	end
	set @p = replace(replace(@p, '/', ''), '\', '') -- remove any dir separater chars in @p
	set @f = replace(@f, '/', '\')
	if Right(@f, 1) <> '\' set @f = @f + '\'
	set @f = @f + @p -- now @f is filename of DB backup

	if @showInfo <> 0
	begin
		set @p = 'BACKUP DATABASE FinDev TO DISK = ''' + @f + ''''
		print @p
	end

	BACKUP DATABASE FinDev TO DISK = @f

	INSERT INTO LogBackup (WhenUTC, WhenLocal, [FileName]) VALUES (GetUtcDate(), GetDate(), @f)
END



GO
/****** Object:  StoredProcedure [dbo].[GetDevScriptForTranTableData]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-05-22
-- Description:	Generates SQL to insert developer
--				data into [Tran] table.
-- =============================================
CREATE PROCEDURE [dbo].[GetDevScriptForTranTableData]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 'INSERT INTO [Tran] (Id, TranTypeId, ToAccountId, ToAmount, FromAccountId, FromAmount, TranDate, PostDate, Note) VALUES ' +
'(' + dbo.NumToString(Id) + ', ' + dbo.NumToString(TranTypeId) + ', ' + dbo.NumToString(ToAccountId) + ', '
	+ dbo.NumToString(ToAmount) + ', ' + dbo.NumToString(FromAccountId) + ', ' + dbo.NumToString(FromAmount) + ', '
	+ dbo.DateToStringQ(TranDate) + ', ' + dbo.DateToStringQ(PostDate) + ', '
	+ IsNull('''' + replace(Note, '''', '''''') + '''', 'null') + ')' SQL
--, Id, TranTypeId, ToAccountId, ToAmount, FromAccountId, FromAmount, TranDate, PostDate, Note
 FROM [Tran]
/*
 where (ToAccountId is null or
        ToAccountId IN (select Id from [Account] where ProfileId in (select Id from [Profile] where Dev_UseInDev <> 0)))
 and (FromAccountId is null or
      FromAccountId IN (select Id from [Account] where ProfileId in (select Id from [Profile] where Dev_UseInDev <> 0)))
*/
 ORDER BY Id
END
GO


/****** Object:  StoredProcedure [dbo].[SetUniqueRandForProfile]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2016-06-24
-- Description:	Creates and sets a new UniqueRand value that does not have a match in the [Profile] table.
-- =============================================
CREATE PROCEDURE [dbo].[SetUniqueRandForProfile](@profileId int)
AS
BEGIN
	declare @r int -- Return value (Unique, positive, Random int)
		,	@t nvarchar(50); -- Text string
	set @r = 0;
	while (@r <= 0)
	begin;
		set @t = Convert(VarChar(64), HashBytes('SHA2_256', Convert(nvarchar(50), NewID())), 2);
		if (@t is null) begin;
			set @t = Convert(VarChar(64), HashBytes('MD5', Convert(nvarchar(50), NewID())), 2);
		end;
		while (CharIndex(Left(@t, 1), '89ABCDEF') > 0)
		begin; set @t = Substring(@t, 2, 64); end;
		if (Len(@t) < 8) begin; set @t = '00'; end;
		set @r = dbo.HexToInt4(Left(@t, 8), null);

		-- when @r already exists in Profile, then set @r = 0, so loop will repeat
		select @r = 0 from [Profile] where UniqueRand = @r;
	end;
	update [Profile] set UniqueRand = @r where id = @profileId;
END
GO


/****** Object:  StoredProcedure [dbo].[ViewAccountTransactionsFor3AccountsById]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2013-07-20
-- Description:	Creates and returns table variable
--              of 3 subaccounts in a single table
--              view format.
-- =============================================
CREATE PROCEDURE [dbo].[ViewAccountTransactionsFor3AccountsById]
	@profileId int,
	@accTitle1 nvarchar(50),
	@accTitle2 nvarchar(50) = null,
	@accTitle3 nvarchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @id1 int, @show1 bit,
			@id2 int, @show2 bit,
			@id3 int, @show3 bit;

	select @id1 = Id from Account where ProfileId = @profileId and TitlePart2 = @accTitle1
	select @id2 = Id from Account where ProfileId = @profileId and TitlePart2 = @accTitle2
	select @id3 = Id from Account where ProfileId = @profileId and TitlePart2 = @accTitle3

	if @id1 = @id3 set @id3 = null
	if @id1 = @id2 set @id2 = null
	if @id2 = @id3 set @id3 = null

	set @show1 = 0; if @id1 > 0 and Len(@accTitle1) > 0 set @show1 = 1
	set @show2 = 0; if @id2 > 0 and Len(@accTitle2) > 0 set @show2 = 1
	set @show3 = 0; if @id3 > 0 and Len(@accTitle3) > 0 set @show3 = 1

	declare @t table
	(	o int null, -- used to order the rows
		tId int null, -- transaction Id used for order by after descending date
		tDate datetime not null,	-- transaction date
		pDate datetime     null,	-- posted date
		inc1 smallmoney null, -- amount increase for #1 (USD balance)
		inc2 smallmoney null, -- amount increase for #2 (FV balance)
		inc3 smallmoney null, -- amount increase for #3 (SAE (Silver American Eagle) coin count)
		cs1 smallmoney null, -- cumulative sum for inc1 (USD)
		cs2 smallmoney null, -- cumulative sum for inc2 (Face Value)
		cs3 smallmoney null, -- cumulative sum for inc3 (SAE (Silver American Eagle) coin count)
		noteText nvarchar(144)) -- human note text for transaction

	insert into @t (tId, tDate, pDate, noteText, inc1, inc2, inc3)
		select t.Id, t.TranDate, t.PostDate, [Note],
		 case when    ToAccountId = @id1 then    ToAmount
		      when  FromAccountId = @id1 then -FromAmount
		      else 0 end as inc1,
		 case when    ToAccountId = @id2 then    ToAmount
		      when  FromAccountId = @id2 then -FromAmount
		      else 0 end as inc2,
		 case when    ToAccountId = @id3 then    ToAmount
		      when  FromAccountId = @id3 then -FromAmount
		      else 0 end as inc3
		 from [Tran] t where (ToAccountId in (@id1, @id2, @id3)
						or	FromAccountId in (@id1, @id2, @id3))
						and (ToAmount <> 0 or FromAmount <> 0)

	-- update pk column, setting it to the row_number of @t, when ordered by tDate, pDate
	update x set x.o = x.newO
	 from (select o, row_number() over (order by tDate, tId, pDate) as newO
			 from @t
		) as x

	-- now set all cumulative sums of inc1, inc2, and inc3 into b1, b2, b3 columns.
	-- internet search result claimed "Getting running totals in T-SQL is not hard, "
	-- "there are many correct answers, most of them pretty easy. What is not easy "
	-- "(or even possible at this time) is to write a true query in T-SQL for running "
	-- "totals that is efficient. They are all O(n^2), though they could easily "
	-- "be O(n), except that T-SQL does not optimize for this case. "
	-- "You can get O(n) using Cursors and/or While loops" [End of quote.]
	-- So i coded it with a while loop, in case this is true.
	declare @s1 smallmoney, @x int,
			@s2 smallmoney, @maxX int,
			@s3 smallmoney
	set @x = 1
	select @maxX = max(o) from @t
	while @x <= @maxX
	begin
		select @s1 = sum(inc1), @s2 = sum(inc2), @s3 = sum(inc3) from @t where o <= @x
		update @t set cs1 = @s1, cs2 = @s2, cs3 = @s3 where o = @x
		set @x = @x + 1
	end

--	if each @SubTitle# parameter was found in the SubAct table, then
--	update all null values to 0 in the money columns associated with that SubTitle.
	update @t set cs1 = isnull(cs1, 0), inc1 = isnull(inc1, 0) where @id1 is not null
	update @t set cs2 = isnull(cs2, 0), inc2 = isnull(inc2, 0) where @id2 is not null
	update @t set cs3 = isnull(cs3, 0), inc3 = isnull(inc3, 0) where @id3 is not null

	select * into #t from @t order by o
	declare @sq nvarchar(987)
	set @sq = 'select o'
	if @show1 != 0 set @sq += ', cs1 [' + @accTitle1 + ']'
	if @show2 != 0 set @sq += ', cs2 [' + @accTitle2 + ']'
	if @show3 != 0 set @sq += ', cs3 [' + @accTitle3 + ']'
	set @sq += ', tDate, pDate'
	if @show1 != 0 set @sq += ', inc1 [+ ' + @accTitle1 + ']'
	if @show2 != 0 set @sq += ', inc2 [+ ' + @accTitle2 + ']'
	if @show3 != 0 set @sq += ', inc3 [+ ' + @accTitle3 + ']'
	set @sq += ', noteText from #t order by o'
	exec sp_executeSQL @sq
	drop table #t
END



GO
/****** Object:  StoredProcedure [dbo].[ViewAccountTransactionsFor3AccountsByTitle]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-05-23 from original created 2013-07-20.
-- Description:	Creates and returns table variable of single account ledger.
-- =============================================
CREATE PROCEDURE [dbo].[ViewAccountTransactionsFor3AccountsByTitle]
	@profileAccountTitle nvarchar(50),
	@accountTitle1 nvarchar(50),
	@accountTitle2 nvarchar(50) = null,
	@accountTitle3 nvarchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @pId int; select @pId = Id from [Profile] where AccountTitle = @profileAccountTitle
	exec ViewAccountTransactionsFor3AccountsById @pId, @accountTitle1, @accountTitle2, @accountTitle3
END



GO
/****** Object:  StoredProcedure [dbo].[ViewTransactionsByProfileId_AccountTitles]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Original creation date for old sproc: 2013-07-20
-- Create date:	2014-10-14 thru 10-16
-- Description:	Creates and returns ('SELECT's) a table variable
--				of 1 or more subaccounts as a single table result
--				for the profile. when @accTitles = '*' then all
--				accounts linked to the profile are returned, otherwise
--				@accTitles should be a character separated list of the
--				Account.TitlePart2 field values for the desired accounts.
--				The separation character of the string is determined by
--				the first character, so any character can be dynamically
--				used. 2 examples are:
--				',USD,SAE' gives 2 fields: 'USD' and 'SAE'.
--				';USD;90%;SAE' gives 3 fields: 'USD', '90%', and 'SAE'.
-- =============================================
CREATE PROCEDURE [dbo].[ViewTransactionsByProfileId_AccountTitles]
	@profileId int,
	@accTitles nvarchar(987) -- if null, empty, or 'ALL' or 'omni' or 'omna' or 'tota' then all accounts for the profile.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @x int, @cx int, @xMax int, @cxMax int, @q1 nvarchar(max), @q2 nvarchar(max), @sq nvarchar(max)
	declare @meta table
	(	cx int not null, -- key for this table. index #. starts at 1 & increments.
		aId int null, -- account Id for this record
		aTitle nvarchar(987) not null -- account title for result table header
	); set @accTitles = RTrim(@accTitles)
	if @accTitles is null
	or @accTitles = ''
	or @accTitles = '*'
	or (Len(@accTitles) = 2 and Left(@accTitles, 1)<>'*' and Right(@accTitles, 1)='*')
	begin
		insert into @meta (aId, cx, aTitle)
			select a.Id, 0, TitlePart2
				 from Account a
				where ProfileId = @profileId
			select top 1 @x = aId, @cx = 0 from @meta where cx = 0 order by aTitle
			while @x > 0
			begin; set @cx = @cx + 1
				update @meta set cx = @cx where aId = @x
				set @x = 0
				select top 1 @x = aId from @meta where cx = 0 order by aTitle
			end
	end
	else
	begin
		insert into @meta (aId, cx, aTitle) select null, * from dbo.SplitString(@accTitles,null,1,1)
		update m set aId = a.Id, aTitle=a.TitlePart2
			  from @meta m join Account a on a.TitlePart2 = m.aTitle
			 where a.ProfileId = @profileId
		delete m1 from @meta m1 join @meta m2 on m1.aTitle = m2.aTitle and m1.cx > m2.cx
		delete from @meta where aTitle is null or Len(aTitle) = 0 or aId is null or aId <= 0
		set @cx = 0
		select top 1 @cx = m1.cx from @meta m1 left join @meta m2 on m1.cx = m2.cx + 1 where m1.cx > 1 and m2.cx is null
		while @cx > 1
		begin
			update @meta set cx = cx - 1 where cx >= @cx
			set @cx = 0
			select top 1 @cx = m1.cx from @meta m1 left join @meta m2 on m1.cx = m2.cx + 1 where m1.cx > 1 and m2.cx is null
		end
	end
--	select * from @meta order by cx
	select @cxMax = max(cx) from @meta

	create table #t
	(	o int null, -- used to order the rows
		tId int null, -- transaction Id used for order by after descending date
		tDate datetime not null,	-- transaction date
		pDate datetime     null,	-- posted date
		noteText nvarchar(144)) -- human note text for transaction
--	now need to add columns that resemble [inc1], [cs1], [inc2], [cs2], etc.
	set @cx = 1
	while (@cx <= @cxMax)
	begin
		set @sq = 'alter table #t add inc' + Left(@cx, 9) + ' Decimal(28,12) null'
		-- previous SQL adds column [inc1] to table #t when @cx = 1
		set @sq += ', cs' + Left(@cx, 9) + ' Decimal(28,12) null; '
		-- previous SQL adds column [cs1] to table #t when @cx = 1
		exec sp_executeSQL @sq; set @cx += 1
	end
	-- now table #t is built where column [inc1] and [cs1] will hold the increment value and the cumulative sum
	-- and columns [inc2] and [cs2] etc are included, thru as many extra columns are needed, thru # @cxMax

	-- now begin populating table #t here
	-- first build SQL statement that inserts all the data records
	select @q1 = '', @q2 = null, @sq = ''
	select
		@q1 += ',inc' + Left(m.cx, 9),
		@q2 = isnull(@q2 + ',', '(') + Left(m.aId, 9),
		@sq += ',
			case when    ToAccountId = ' + Left(m.aId, 9) + ' then    ToAmount
				when  FromAccountId = ' + Left(m.aId, 9) + ' then -FromAmount
				else 0 end as inc' + Left(m.cx, 9)
			from @meta m order by m.cx
	set @q2 += ')'
	-- now @q1 resembles ',inc1,inc2,inc3,inc4,inc5,inc6'
	-- now @q2 resembles '(5,15,8,6,7,25)' where each # is each account Id in aId field in table #t
	set @q1 = 'insert into #t (tId, tDate, pDate, noteText' + @q1 + ')
		select t.Id, t.TranDate, t.PostDate, [Note]'
	set @q2 = ' from [Tran] t where (ToAccountId in ' + @q2 + '
						or	FromAccountId in ' + @q2 + ')
						and (ToAmount <> 0 or FromAmount <> 0)'
	set @sq = @q1 + @sq + @q2 + '{EndSQL}'
	if CharIndex('{EndSQL}', @sq) > 0
	begin
		set @sq = Replace(@sq, '{EndSQL}', '');
		print 'dynamic SQL:'; print @sq
		exec sp_executeSQL @sq
	end
	else
	begin	-- @sq is too long, so don't try to execute it.
		print 'dynamic SQL:'; print @sq
		return -987
	end

	-- update pk column, setting it to the row_number of @t, when ordered by tDate, pDate
	update x set x.o = x.newO
	 from (select o, row_number() over (order by tDate, tId, pDate) as newO
			 from #t
		) as x

	--	now calculate all the cumulative sum values
	set @x = 1; select @xMax = max(o) from #t -- max column index in temp table #t
	while @x <= @xMax
	begin
		set @q1 = null -- will resemble '@s1=sum(inc1),@s2=sum(inc2)'
		set @q2 = null -- will resemble 'cs1=@s1,cs2=@s2'
		set @sq = null -- will resemble 'declare @s1 Decimal(28,12), @s2 Decimal(28,12)'
		select
			@sq = isnull(@sq + ',', '') + '@s' + Left(m.cx, 9) + ' Decimal(28,12)',
			@q1 = isnull(@q1 + ',', '') + '@s' + Left(m.cx, 9) + '=sum(inc' + Left(m.cx, 9) + ')',
			@q2 = isnull(@q2 + ',', '') + 'cs' + Left(m.cx, 9) + '=@s' + Left(m.cx, 9)
				from @meta m order by m.cx
		set @sq = 'declare ' + @sq + char(10)
		set @q1 = 'select ' + @q1 + ' from #t where o <= @x' + char(10)
		set @q2 = 'update #t set ' + @q2 + ' where o = @x'
	--	declare @s1 Decimal(28,12),@s2 Decimal(28,12)
	--	; select @s1=sum(inc1),@s2=sum(inc2) from #t where o <= @x
	--	; update #t set @s1=sum(inc1),@s2=sum(inc2) where o = @x
		set @sq = @sq + @q1 + @q2
		print 'dynamic SQL:'; print @sq
		exec sp_executeSQL @sq, N'@x int', @x
		set @x += 1
	end

	--	now view the data
	set @cx = 1; set @q1 = ''; set @q2 = ''
	while (@cx <= @cxMax)
	begin
		select	@q1 += ', dbo.NumToString(cs'  + Left(@cx, 9) + ') as ['   + m.aTitle + ']',
				@q2 += ', dbo.NumToString(inc' + Left(@cx, 9) + ') as [+ ' + m.aTitle + ']'
			from @meta m where cx = @cx
		set @cx += 1
	end
	set @sq = 'select o' + @q1 + ', tDate, pDate' + @q2 + ', noteText from #t order by o'
	exec sp_executeSQL @sq
	drop table #t
END



GO
/****** Object:  StoredProcedure [dbo].[ViewTransactionsByProfileTitle_AccountTitles]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-10-16 from original created 2013-07-20.
-- Description:	Creates and returns table variable of single account ledger.
-- =============================================
create PROCEDURE [dbo].[ViewTransactionsByProfileTitle_AccountTitles]
	@profileAccountTitle nvarchar(50),
	@accTitles nvarchar(987) = null -- if null, empty, or 'ALL' or 'omni' or 'omna' or 'tota',
	-- then all accounts for the profile are displayed.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @pId int; select @pId = Id from [Profile] where AccountTitle = @profileAccountTitle
	exec ViewTransactionsByProfileId_AccountTitles @pId, @accTitles
END
GO

/** This sproc is moved to end of SQL script so it SQL Server Management Studio does not yield ..
	an error message:
		The module 'PayRentByName' depends on the missing object
		'ViewAccountTransactionsFor3AccountsById'. The module will still be created;
		however, it cannot run successfully until the object exists.
**/
/****** Object:  StoredProcedure [dbo].[PayRentByName]    Script Date: 2017-04-30 09:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Edward Kovac
-- Create date: 2014-07-31
-- Description:	Adds rent payment on account
-- =============================================
CREATE PROCEDURE [dbo].[PayRentByName]
	@who nvarchar(144),
	@dollarsPaid money,
	@noteText nvarchar(144),
	@tranDate datetime,
	@postDate datetime,
	@show bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @accountId int, @count int, @pId int
	select @count = count(Id) from [Account] where TitlePart1 = @who
	if @count = 1
		select @accountId = Id from [Account] where TitlePart1 = @who

	if @accountId is null
	begin	-- try full name
		set @pId = null
		select @pId = Id from [Profile] p where @who = FirstName + ' ' + LastName
		if @pId is null
		select @pId = Id from [Profile] p where @who = FirstNickName + ' ' + LastName
		if @pId is not null
		select @accountId = Id from Account where ProfileId = @pId
	end

	if @accountId is null and Len(@who) > 10 and (Left(@who, 10) = 'AccountId:' or Left(@who, 10) = 'AccountId=')
	begin
		set @who = RTrim(LTrim(SUBSTRING(@who, 11, Len(@who))))
		select @accountId = Id from Account where @who = convert(varchar(30), Id)
	end

	if @accountId is null
	begin
		print 'PayRentByName cannot find any matching Account.'
		return -100
	end

	if @dollarsPaid = 0
	begin
		print 'PayRentByName cannot proceed with a zero dollars paid amount.'
		return -110
	end
	if @dollarsPaid is null
	begin
		print 'PayRentByName cannot proceed with a NULL dollars paid amount.'
		return -111
	end

	if @tranDate is null or @postDate is null
	begin
		declare @now date -- note this does have time information included
		set @now = GetDate()
		if @tranDate is null set @tranDate = @now
		if @postDate is null set @postDate = @now
	end

	insert into [Tran] (TranTypeId,ToAccountId,ToAmount,FromAccountId,FromAmount,TranDate,PostDate,Note)
	 select 1 as TranTypeId,@accountId as ToAccountId, @dollarsPaid as ToAmount,
			null as FromAccountId, null as FromAmount, @tranDate, @postDate, @noteText
	if @show <> 0
	begin
		select @pId = ProfileId from [Account] where Id = @accountId
		select * from [Tran] where ToAccountId = @accountId or FromAccountId = @accountId

		exec ViewAccountTransactionsFor3AccountsById @pId, 'USD'
	end
	else
	begin
		print 'Rent payment recorded.'
	end
	return 1
END
GO


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'all transactions are to be rounded to this precision before posting to account. 2 means hundredths or cents for a dollar account. 0 means whole units of the account. -2 means hudreds.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Account', @level2type=N'COLUMN',@level2name=N'Precision'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'this ID is a short code for each currency' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(English) currency name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'COLUMN',@level2name=N'NameEN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(English) description of this currency' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'COLUMN',@level2name=N'DescripEN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OS filename of backup file' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LogBackup', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MetalCode = Symbol on Periodic Table: Au = Gold(79), Ag = Silver(47), Pt = Platinum(78), Pd = Palladium(46). (numbers in parentheses are atomic #''s.)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MarketPrice', @level2type=N'COLUMN',@level2name=N'MetalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'=' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MarketPrice', @level2type=N'COLUMN',@level2name=N'MarketCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Gold has 2 dates per day: 10'' & 15''. Silver has one per day: 12''.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MarketPrice', @level2type=N'COLUMN',@level2name=N'WhenUTC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Profile ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Profile', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account Title (for internal purposes)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Profile', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account Deactivation Date (UTC time)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Profile', @level2type=N'COLUMN',@level2name=N'DeactivationDateUTC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Keep DeactivationDate and IsActive in sync' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Profile', @level2type=N'CONSTRAINT',@level2name=N'CK_Profile_IsActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transaction ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tran', @level2type=N'COLUMN',@level2name=N'Id'
GO
