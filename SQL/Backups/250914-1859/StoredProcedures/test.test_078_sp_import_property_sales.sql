SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================================
-- Author:           Terry Watts
-- Create date:      12-Sep-2025
-- Rtn:              test.test_078_sp_import_property_sales
-- Description: main test routine for the dbo.sp_import_property_sales routine 
--
-- Tested rtn description:
--
-- Design:      EA:
-- Tests:
--
-- Preconditions:
-- Postconditions: POST01: following tabnle are populated:
--    PropertySalesStaging
--    PropertySales
--    Agency         merge
--    Contacts       merge
--    Delegate       merge
--    Status         merge ??
--==============================================================================
CREATE PROCEDURE [test].[test_078_sp_import_property_sales]
AS
BEGIN
DECLARE
   @fn VARCHAR(35) = 'test_078_sp_import_property_sales'
   EXEC test.sp_tst_mn_st @fn;
   -- 1 off setup  ??
   EXEC test.hlpr_078_sp_import_property_sales
       @tst_num               = '001'
      ,@display_tables        = 1
      ,@inp_file              = 'D:\Dev\CRM\SQL\Tests\078_sp_import_property_sales\Property Sales.xlsx'
      ,@inp_worksheet         = 'Resort Sale'
      ,@inp_range             = 'A1:AA93'
      ,@exp_row_cnt           = 92
      ,@exp_rc                = 0
      ,@exp_agency_cnt        = 92
      ,@exp_contact_cnt       = 3
      ,@exp_contactAgency_cnt = 1
      ,@exp_ex_num            = NULL
      ,@exp_ex_msg            = NULL
   ;
   EXEC sp_log 2, @fn, '99: All subtests PASSED'
   EXEC test.sp_tst_mn_cls;
END
/*
EXEC tSQLt.Run 'test.test_078_sp_import_property_sales';
EXEC test.test_078_sp_import_property_sales;
EXEC tSQLt.RunAll;
*/
GO

