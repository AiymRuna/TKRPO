USE [ Beauty_Salon]
GO
/****** Object:  StoredProcedure [dbo].[RemoveTovarData]    Script Date: 04.12.2018 19:01:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RemoveTovarData]
@dataToday date

AS

BEGIN

declare @id int
declare @nameTovar int
declare @amount int
declare @dataEndUse date
declare @summ int

set @id = (select top 1 id from [dbo].[TovarDateUse] where [dataEndUse] <= @dataToday order by [dataEndUse] asc)

set @amount = (select [amount] from [dbo].[TovarDateUse] where id = @id)
set @nameTovar = (select [name_tovar] from [dbo].[TovarDateUse] where id = @id)
set @summ = (select [summOneBegin] from [dbo].[Tovar] where [id] = @nameTovar)

insert into [dbo].[Remove] ([data],[name_tovar],[amount], [summ] )
values (getdate(), @nameTovar, @amount, @amount*@summ);

update [dbo].[Tovar]
set [amount] =  [amount] - @amount where id=@nameTovar
update [dbo].[Tovar]
set [summ] = [summ] - @amount*@summ

update [dbo].[Budget]
set [budget] = [budget] - @amount*@summ 

delete from [dbo].[TovarDateUse]
where [id] = @id

END
