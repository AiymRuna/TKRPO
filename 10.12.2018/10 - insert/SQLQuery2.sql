
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 alter PROCEDURE totalSummMonth
@month int,
@year int

AS

BEGIN
select sum(summ) from [dbo].[Zakupka] where month(data) = @month and year(data) = @year
END
GO
