USE [ Beauty_Salon]
GO
/****** Object:  Trigger [dbo].[TotalSummInsUpd]    Script Date: 07.12.2018 12:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[TotalSummInsUpd]
   ON  [dbo].[UslugaKlientu]
   AFTER INSERT,UPDATE
AS 
declare @id int
declare @summTovar int
declare @summUsluga int
declare @summ int
declare @skidka int
declare @totalSumm int
BEGIN
set @id = (select [id] from inserted)
set @summTovar = (select [SummTovar] from inserted)
set @summUsluga = (select [SummUsluga] from inserted)
set @summ = @summTovar + @summUsluga
if (select [Skidka] from[dbo].[UslugaKlientu] where [id]=@id) = null
set @skidka = 0
else 
set @skidka = (select [Skidka] from inserted)
set @totalSumm = @summ - (@summ*(@skidka*0.01))
update [dbo].[UslugaKlientu]
set [Summ] = @summ where id = @id
update [dbo].[UslugaKlientu]
set [TotalSumm] = @totalSumm where id = @id
END
