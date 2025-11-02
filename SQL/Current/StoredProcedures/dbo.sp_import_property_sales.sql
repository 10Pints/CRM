SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Terry Watts
-- Create date: 12-SEP-2025
-- Description: 
-- Design:      EA:
-- Tests:       
--
-- Preconditions:
-- Postconditions: POST01: following tables are populated:
--    PropertySalesStaging
--    PropertySales
--    Agency         merge
--    Contacts       merge
--    Delegate       merge
--    Status         merge ??
-- =============================================
CREATE PROCEDURE [dbo].[sp_import_property_sales]
    @file            VARCHAR(100)
   ,@worksheet       VARCHAR(64)  --= 'Resort Sale'
   ,@range           VARCHAR(255) --= 'A1:Z93'
   ,@display_tables  BIT         = 1
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE
       @fn           VARCHAR(35)   = N'sp_import_property_sales'
      ,@sql          NVARCHAR(4000)
      ,@schema       VARCHAR(40)
      ,@table_nm     VARCHAR(60)
      ,@fld_ty       VARCHAR(25)
      ,@fld_id       INT
      ,@fld_nm       VARCHAR(50)
      ,@len          INT
  ;
   BEGIN TRY
      EXEC sp_log 1, @fn, '000: starting:
   @file:[',@file,']
   ';
      -- Preconditions: PRE01: table must exist or exception 60001 'Table '<@q_table_nm> does not exist
   DELETE FROM PropertySalesStaging;
   SET @sql = CONCAT('
INSERT INTO PropertySalesStaging
(
[agency],[Type],[Area],[Delegate],[Status]
,[Sept_2],[Notes],[Quality],[Contact_nm],[role],[phone]
,[preferred_contact_method],[email],[WhatsApp]
,[viber],[facebook],[messenger],[website],[Address]
,[Notes_2],[Old_Notes],[date_1],[Actions_08_OCT],[Jan_16_2025]
,[Action_By_dt],[Replied],[History])
      SELECT 
[agency],[Type],[Area],[Delegate],[Status]
,[Sept 2],[Notes],[Quality],[Contact nm],[role],[phone]
,[preferred contact method],[email],[WhatsApp]
,[viber],[facebook],[messenger],[website],[Address]
,[Notes_2],[Old Notes],[date 1],[Actions 08-OCT],[Jan 16 2025]
,[Action By dt],[Replied],[History]
FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
         ''Excel 12.0;Database=', @file, ';HDR=YES'',
         ''SELECT * FROM [', @worksheet, '$', @range, ']'')
   ');
      EXEC sp_log 1, @fn, '010: import sql:
', @sql;
      EXEC(@sql);
      IF @display_tables = 1
         SELECT * FROM PropertySalesStaging;
      EXEC sp_migrate_property_sales_data @display_tables;
      EXEC sp_log 1, @fn, '900: completed processing loop';
   END TRY
   BEGIN CATCH
      EXEC sp_log 4, @fn, '500: caught exception';
      EXEC sp_log_exception @fn;
      THROW;
   END CATCH
   EXEC sp_log 1, @fn, '999: leaving ok';
END
/*
EXEC test.test_078_sp_import_property_sales;
EXEC tSQLt.Run 'test.test_078_sp_import_property_sales';
*/
GO

