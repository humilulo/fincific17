USE FinDev3
GO
--	insert into tbFinPrefix (FinKey, MinPrefix, MaxPrefix, MinDigitLen, MaxDigitLen, ValidationAlgorithm, WhenStart) values ('MasterCard', '2221', '2720', 16, 16, 'Luhn', '2016-10-13')
declare @n nvarchar(50); set @n = '34';
select * from vwFinPrefix
 where pMinPrefix <= Left(dbo.ModifyTextWithCharsToKeep(@n, '0123456789'), Len(pMinPrefix))
  and  pMaxPrefix >= Left(dbo.ModifyTextWithCharsToKeep(@n, '0123456789'), Len(pMaxPrefix))
 order by pID;

select * from vwFinPrefix order by pMinPrefix;
GO
