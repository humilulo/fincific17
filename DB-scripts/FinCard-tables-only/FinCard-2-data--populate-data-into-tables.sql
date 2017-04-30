USE [FinDev3]
--	Enter the desired DataBase name between brackets in the previous line.
--	Or if the desired database is already the default DataBase for this connection,
--	then you can simple delete these first 5 lines in this SQL script file.
GO

-- Now the 4 major credit cards are added to ('INSERT'ed) into the tbFinCard table ...
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'AmEx', N'American Express')
GO
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'Discover', N'Discover')
GO
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'MasterCard', N'MasterCard')
GO
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'Visa', N'Visa')
GO





-- Now we populate the tbFinCardPrefix table...
SET IDENTITY_INSERT [dbo].[tbFinCardPrefix] ON 
-- 'IDENTITY INSERT' is the 1st SQL statement to add data to this table.
-- It turns on a 'switch' that SQL remembers for each table, in this case, the tbFinCardPrefix table.
--	A few points to understand about IDENTITY columns and this IDENTITY_INSERT switch is:
--	1: An IDENTITY column is one that SQL normally creates the value in the row, ensuring that its value is unique for each row in the table.
--	2: Under normal operation, trying to specify a value for an IDENTITY field throws an error. But when it is truly desired that the value
--		for the IDENTITY field is specified for the new row, then this switch can be turned ON before row(s) are INSERTed.
--	3: When this 'switch' is turned on with the 'SET IDENTITY_INSERT' for the table, then it shud be turned OFF when done.
--		Note that the last statement before the last GO in this file, turns off this IDENTITY_INSERT for this table.
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (1, N'Visa', N'4', N'4', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (2, N'MasterCard', N'51', N'55', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (3, N'Discover', N'6011', N'6011', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (4, N'Discover', N'65', N'65', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (5, N'Discover', N'622126', N'622925', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (6, N'Discover', N'644', N'649', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (7, N'AmEx', N'34', N'37', 15, 15, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm]) VALUES (9, N'MasterCard', N'2221', N'2720', 16, 16, CAST(N'2016-10-13' AS Date), NULL, N'Luhn')
GO
SET IDENTITY_INSERT [dbo].[tbFinCardPrefix] OFF
GO
