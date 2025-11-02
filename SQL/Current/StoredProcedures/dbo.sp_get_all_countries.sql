SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Terry Watts
-- Create date: 10-SEP-2025
-- Description: Returns a list of the countries 
--              from the country table.
-- Design:      
-- Tests:       
-- =============================================
CREATE PROCEDURE [dbo].[sp_get_all_countries]
AS
BEGIN
 SET NOCOUNT ON;
 SELECT TOP (1000) [ID]
      ,[name]
  FROM [Property_Dev].[dbo].[Country];
END
/*
EXEC dbo.sp_get_all_countries;
EXEC tSQLt.Run 'test.test_<proc_nm>';
*/
GO

