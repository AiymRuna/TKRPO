USE [ Beauty_Salon]
GO
/****** Object:  Trigger [dbo].[InsUpdSummTovar]    Script Date: 04.12.2018 18:31:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[InsUpdSummTovar]
   ON  [dbo].[SummTovarKlienta]
   AFTER INSERT,UPDATE
AS 
BEGIN
	declare @id int
	declare @idUslugaKlientu int
	declare @idTovar int
	declare @amount int
	
set @id = (select id from inserted)
set @idUslugaKlientu = (select [idUslugaKlientu] from inserted)
set @idTovar = (select [idTovar] from inserted)
set @amount = (select [amount] from inserted)

declare @summTovar int
set @summTovar = (select [summOneEnd] from [dbo].[Tovar] where id = @idTovar)

declare @TotalSummTovar int
set @TotalSummTovar = @summTovar * @amount

update [dbo].[SummTovarKlienta]
set [Summ] = @TotalSummTovar
from [dbo].[SummTovarKlienta]
where [id] = @id

update [dbo].[Budget]
set [budget] = [budget] + @TotalSummTovar

update [dbo].[Tovar]
set [summ] = [summ] - @amount*[summOneBegin]
from [dbo].[Tovar]
where [id] = @idTovar

update [dbo].[Tovar]
set [amount] = [amount] - @amount
from [dbo].[Tovar]
where [id] = @idTovar

declare @tovarIdData int
set @tovarIdData = (select top 1 [id] from [dbo].[TovarDateUse] where [name_tovar] = @idTovar order by [dataEndUse] ASC)

update [dbo].[TovarDateUse]
set [amount] = [amount] - @amount
from [dbo].[TovarDateUse]
where [id] = @tovarIdData

END

