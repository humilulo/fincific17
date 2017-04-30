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
/****** Object:  View [dbo].[vwFinCardPrefix]    Script Date: 2017-04-30 09:53:44 ******/
DROP VIEW [dbo].[vwFinCardPrefix]
GO
/****** Object:  View [dbo].[vwFinCard]    Script Date: 2017-04-30 09:53:44 ******/
DROP VIEW [dbo].[vwFinCard]
GO
/****** Object:  View [dbo].[vwAct]    Script Date: 2017-04-30 09:53:44 ******/
DROP VIEW [dbo].[vwAct]
GO
/****** Object:  Table [dbo].[TranType]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[TranType]
GO
/****** Object:  Table [dbo].[Tran]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[Tran]
GO
/****** Object:  Table [dbo].[tbFinCardPrefix]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[tbFinCardPrefix]
GO
/****** Object:  Table [dbo].[tbFinCard]    Script Date: 2017-04-30 09:53:44 ******/
DROP TABLE [dbo].[tbFinCard]
GO
/****** Object:  Table [dbo].[SettingString]    Script Date: 2017-04-30 09:53:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[HexToInt4]    Script Date: 2017-04-30 09:53:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HexToInt4]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[HexToInt4]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSumBySubAcctIDBeforePostingDate]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetSumBySubAcctIDBeforePostingDate]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSumBySubAcctIDBeforeDate]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[GetSumBySubAcctIDBeforeDate]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnSplitString]
GO
/****** Object:  UserDefinedFunction [dbo].[fnNumToString]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnNumToString]
GO
/****** Object:  UserDefinedFunction [dbo].[fnModifyTextWithCharsToRemove]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnModifyTextWithCharsToRemove]
GO
/****** Object:  UserDefinedFunction [dbo].[fnModifyTextWithCharsToKeep]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnModifyTextWithCharsToKeep]
GO
/****** Object:  UserDefinedFunction [dbo].[fnIsLuhnValid]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnIsLuhnValid]
GO
/****** Object:  UserDefinedFunction [dbo].[fnHexToInt4]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnHexToInt4]
GO
/****** Object:  UserDefinedFunction [dbo].[fnHex32toInt4]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnHex32toInt4]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetLuhnNumber]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnGetLuhnNumber]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetLuhnDigit]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnGetLuhnDigit]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAccountBalanceByAccountIDAndTime]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnGetAccountBalanceByAccountIDAndTime]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDateToStringQ]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnDateToStringQ]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDateToString]    Script Date: 2017-04-30 09:53:44 ******/
DROP FUNCTION [dbo].[fnDateToString]
GO
