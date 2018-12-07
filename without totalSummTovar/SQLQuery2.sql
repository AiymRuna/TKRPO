
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter TRIGGER SumUslugaInsUpd
   ON  [dbo].[SummUslugiKlienta]
   AFTER INSERT,UPDATE
AS 
declare @id int
set @id = (select [id] from inserted)
declare @summUsluga int
BEGIN
set @summUsluga = (select SUM([Summ]) from [dbo].[SummUslugiKlienta] where [idUsugaKlientu] = @id)
update [dbo].[UslugaKlientu]
set [SummUsluga] = @summUsluga where id = @id
END
GO
