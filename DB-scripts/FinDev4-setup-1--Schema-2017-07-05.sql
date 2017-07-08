USE [FinDev4]
GO
/****** Object:  Table [dbo].[GlAccount]    Script Date: 2017-07-05 17:24:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GlAccount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GlAccount](
	[Id] [int] NOT NULL,
	[Number] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL,
	[AccountTypeId] [int] NULL,
	[BalanceTypeId] [int] NULL,
	[ConsolidateToAccountId] [int] NULL,
 CONSTRAINT [PK_GlAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlAccountDetail]    Script Date: 2017-07-05 17:24:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GlAccountDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GlAccountDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GlAccountId] [int] NULL,
	[FiscalYear] [int] NULL,
	[FiscalPeriod] [int] NULL,
	[Actual] [decimal](38, 19) NULL,
	[Budget] [decimal](38, 19) NULL,
 CONSTRAINT [PK_GlAccountDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 2017-07-05 17:24:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Profile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Profile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AspNetUserId] [nvarchar](128) NULL,
	[FirstName] [nvarchar](144) NULL,
	[LastName] [nvarchar](144) NULL,
	[NickName] [nvarchar](144) NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SmPeriodConversion]    Script Date: 2017-07-05 17:24:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SmPeriodConversion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SmPeriodConversion](
	[Id] [int] NOT NULL,
	[FiscalYear] [int] NULL,
	[FiscalPeriod] [int] NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[GlClosed] [bit] NULL,
	[ApClosed] [bit] NULL,
	[ArClosed] [bit] NULL,
 CONSTRAINT [PK_SmPeriodConversion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_GlAccount_Number_Unique]    Script Date: 2017-07-05 17:24:17 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GlAccount]') AND name = N'IX_GlAccount_Number_Unique')
CREATE UNIQUE NONCLUSTERED INDEX [IX_GlAccount_Number_Unique] ON [dbo].[GlAccount]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SmPeriodConversion]    Script Date: 2017-07-05 17:24:17 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SmPeriodConversion]') AND name = N'IX_SmPeriodConversion')
CREATE UNIQUE NONCLUSTERED INDEX [IX_SmPeriodConversion] ON [dbo].[SmPeriodConversion]
(
	[FiscalYear] ASC,
	[FiscalPeriod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GlAccount_ConsolidateToAccountId]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlAccount]'))
ALTER TABLE [dbo].[GlAccount]  WITH CHECK ADD  CONSTRAINT [FK_GlAccount_ConsolidateToAccountId] FOREIGN KEY([ConsolidateToAccountId])
REFERENCES [dbo].[GlAccount] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GlAccount_ConsolidateToAccountId]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlAccount]'))
ALTER TABLE [dbo].[GlAccount] CHECK CONSTRAINT [FK_GlAccount_ConsolidateToAccountId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GlAccountDetail_GlAccount]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlAccountDetail]'))
ALTER TABLE [dbo].[GlAccountDetail]  WITH CHECK ADD  CONSTRAINT [FK_GlAccountDetail_GlAccount] FOREIGN KEY([GlAccountId])
REFERENCES [dbo].[GlAccount] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GlAccountDetail_GlAccount]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlAccountDetail]'))
ALTER TABLE [dbo].[GlAccountDetail] CHECK CONSTRAINT [FK_GlAccountDetail_GlAccount]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GlAccountDetail_SmPeriodConversion]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlAccountDetail]'))
ALTER TABLE [dbo].[GlAccountDetail]  WITH CHECK ADD  CONSTRAINT [FK_GlAccountDetail_SmPeriodConversion] FOREIGN KEY([FiscalYear], [FiscalPeriod])
REFERENCES [dbo].[SmPeriodConversion] ([FiscalYear], [FiscalPeriod])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GlAccountDetail_SmPeriodConversion]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlAccountDetail]'))
ALTER TABLE [dbo].[GlAccountDetail] CHECK CONSTRAINT [FK_GlAccountDetail_SmPeriodConversion]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Profile_AspNetUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[Profile]'))
ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_AspNetUsers] FOREIGN KEY([AspNetUserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Profile_AspNetUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[Profile]'))
ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_AspNetUsers]
GO
