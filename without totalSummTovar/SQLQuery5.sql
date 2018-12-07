
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER SummTovarInsUpd
   ON  [dbo].[SummTovarKlienta]
   AFTER INSERT,UPDATE
AS 
declare @id int
set @id = (select [idUslugaKlientu] from inserted)
declare @summTovar int
BEGIN
set @summTovar = (select  SUM([Summ]) from [dbo].[SummTovarKlienta] where [idUslugaKlientu] = @id)
update [dbo].[UslugaKlientu]
set [SummTovar] = @summTovar
where [id]=@id

END
GO
