USE [FinDev3]
GO





INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'AmEx', N'American Express')
GO
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'Discover', N'Discover')
GO
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'MasterCard', N'MasterCard')
GO
INSERT [dbo].[tbFinCard] ([FinKey], [FinNameEN]) VALUES (N'Visa', N'Visa')
GO





SET IDENTITY_INSERT [dbo].[tbFinCardPrefix] ON
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (1, N'Visa', N'4', N'4', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (2, N'MasterCard', N'2221', N'2720', 16, 16, CAST(N'2016-10-13' AS Date), NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (3, N'MasterCard', N'51', N'55', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (4, N'Discover', N'6011', N'6011', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (5, N'Discover', N'622126', N'622925', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (6, N'Discover', N'644', N'649', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (7, N'Discover', N'65', N'65', 16, 16, NULL, NULL, N'Luhn')
GO
INSERT [dbo].[tbFinCardPrefix] ([id], [FinKey], [MinPrefix], [MaxPrefix], [MinDigitLen], [MaxDigitLen], [WhenStart], [WhenEnd], [ValidationAlgorithm])
						VALUES (8, N'AmEx', N'34', N'37', 15, 15, NULL, NULL, N'Luhn')
GO
SET IDENTITY_INSERT [dbo].[tbFinCardPrefix] OFF
GO
