SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================
-- Author:      Terry watts
-- Create date: 9-Sep-2025
-- Description: Clean populates the Property sales tables
-- EXEC tSQLt.Run 'test.test_<nnn>_<proc_nm>';
-- Design:      
-- Tests:       
-- ===========================================================
CREATE PROCEDURE [dbo].[sp_crt_pop_property_sales]
    @file_path       VARCHAR(500) -- the import data file tsv
   ,@display_tables  BIT         = 0
AS
BEGIN
 SET NOCOUNT ON;
   DECLARE
    @fn              VARCHAR(35) = N'sp_crt_pop_property_sales'
   ,@rc              INT         = 1
   ,@sep             VARCHAR(6)  = NULL
   ,@format_file     VARCHAR(500)= 'D:\Dev\Property\Data\Property_Sales.Resort_Sale.xml'
   ;
   EXEC sp_log 1, @fn ,'000: starting
    @file_path       :[',@file_path     ,']
   ,@display_tables  :[',@display_tables,']
';
   BEGIN TRY
      EXEC sp_log 1, @fn ,'010: importing the main marketing info table';
      EXEC @rc = dbo.sp_crt_pop_table
                @file_path       = @file_path
               ,@sep             = NULL
               ,@format_file     = @format_file
               ,@display_tables  = @display_tables
               ;
      EXEC sp_log 1, @fn ,'020: importing the reference data';
      EXEC sp_Pop_ResortSalesRefData @display_tables;
      EXEC sp_log 1, @fn ,'490: completed processing';
   END TRY
   BEGIN CATCH
      EXEC sp_log_exception @fn;
      THROW;
   END CATCH
   EXEC sp_log 1, @fn ,'999: leaving';
END
/*
EXEC sp_crt_pop_property_sales 'D:\Dev\Property\Data\Property Sales - Resort Sale.tsv'
EXEC tSQLt.Run 'test.test_<proc_nm>';
*/
GO

