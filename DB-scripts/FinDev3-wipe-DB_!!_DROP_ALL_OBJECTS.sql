USE [FinDev3]
GO
/****** Object:  StoredProcedure [dbo].[ViewTransactionsByProfileTitle_AccountTitles]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[ViewTransactionsByProfileTitle_AccountTitles]
GO
/****** Object:  StoredProcedure [dbo].[ViewTransactionsByProfileID_AccountTitles]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[ViewTransactionsByProfileID_AccountTitles]
GO
/****** Object:  StoredProcedure [dbo].[ViewAccountTransactionsFor3AccountsByTitle]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[ViewAccountTransactionsFor3AccountsByTitle]
GO
/****** Object:  StoredProcedure [dbo].[ViewAccountTransactionsFor3AccountsByID]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[ViewAccountTransactionsFor3AccountsByID]
GO
/****** Object:  StoredProcedure [dbo].[SetUniqueRandForProfile]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[SetUniqueRandForProfile]
GO
/****** Object:  StoredProcedure [dbo].[PayRentByName]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[PayRentByName]
GO
/****** Object:  StoredProcedure [dbo].[GetDevScriptForTranTableData]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[GetDevScriptForTranTableData]
GO
/****** Object:  StoredProcedure [dbo].[BackupDB]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[BackupDB]
GO
/****** Object:  StoredProcedure [dbo].[ApplyRent]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[ApplyRent]
GO
/****** Object:  StoredProcedure [dbo].[ApplyInterest]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[ApplyInterest]
GO
/****** Object:  StoredProcedure [dbo].[AddExchangeTran]    Script Date: 2017-04-30 09:53:44 ******/
DROP PROCEDURE [dbo].[AddExchangeTran]
GO
ALTER TABLE [dbo].[Tran] DROP CONSTRAINT [FK_Tran_TranType]
GO
ALTER TABLE [dbo].[Tran] DROP CONSTRAINT [FK_Tran_ToAccount]
GO
ALTER TABLE [dbo].[Tran] DROP CONSTRAINT [FK_Tran_FromAccount]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FinCardPrefix_FinCard]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbFinCardPrefix]'))
ALTER TABLE [dbo].[tbFinCardPrefix] DROP CONSTRAINT [FK_FinCardPrefix_FinCard]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Account] DROP CONSTRAINT [FK_Account_Profile]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FinCardPrefixView]'))
DROP VIEW [dbo].[FinCardPrefixView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwFinCardPrefix]'))
DROP VIEW [dbo].[vwFinCardPrefix]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwFinCard]'))
DROP VIEW [dbo].[vwFinCard]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[AccountView]'))
DROP VIEW [dbo].[AccountView]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwAct]'))
DROP VIEW [dbo].[vwAct]
GO

DROP TABLE [dbo].[TranType]
GO

DROP TABLE [dbo].[Tran]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbFinCard]') AND type in (N'U'))
DROP TABLE [dbo].[tbFinCard]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbFinCardPrefix]') AND type in (N'U'))
DROP TABLE [dbo].[tbFinCardPrefix]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FinCardPrefix]') AND type in (N'U'))
DROP TABLE [dbo].[FinCardPrefix]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FinCard]') AND type in (N'U'))
DROP TABLE [dbo].[FinCard]
GO

DROP TABLE [dbo].[SettingString]
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[Profile]
GO
/****** Object:  Table [dbo].[MarketPrice]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[MarketPrice]
GO
/****** Object:  Table [dbo].[Market]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[Market]
GO
/****** Object:  Table [dbo].[LogBackup]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[LogBackup]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[Currency]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[Account]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2017-04-30 09:53:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__MigrationHistory]') AND type in (N'U'))
DROP TABLE [dbo].[__MigrationHistory]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSumBySubAcctIDBeforePostingDate]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetSumBySubAcctIDBeforePostingDate]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSumBySubAcctIDBeforeDate]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetSumBySubAcctIDBeforeDate]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[SplitString]
GO
/****** Object:  UserDefinedFunction [dbo].[fnNumToString]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[NumToString]
GO
/****** Object:  UserDefinedFunction [dbo].[fnModifyTextWithCharsToRemove]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[ModifyTextWithCharsToRemove]
GO
/****** Object:  UserDefinedFunction [dbo].[fnModifyTextWithCharsToKeep]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[ModifyTextWithCharsToKeep]
GO
/****** Object:  UserDefinedFunction [dbo].[fnIsLuhnValid]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[IsLuhnValid]
GO

/****** Object:  UserDefinedFunction [dbo].[HexToInt4]    Script Date: 2017-04-30 09:53:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HexToInt4]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[HexToInt4]
GO

/****** Object:  UserDefinedFunction [dbo].[fnHex32toInt4]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[Hex32toInt4]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetLuhnNumber]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetLuhnNumber]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetLuhnDigit]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetLuhnDigit]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAccountBalanceByAccountIDAndTime]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetAccountBalanceByAccountIDAndTime]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDateToStringQ]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[DateToStringQ]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDateToString]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[DateToString]
GO
