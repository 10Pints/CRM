SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================
-- Author:      Terry Watts
-- Create date: 7-SEP-2025
-- Description: Migrates the Resort Sales staging data to ResortSales
--
-- Preconditions:
-- PRE01: ResortSalesStaging table is populated
-- Postconditions:
-- POST01: ResortSales is populated
-- POST 01 
-- ===================================================================
CREATE PROCEDURE [dbo].[sp_migrate_property_sales_data] @display_tables BIT = 1
AS
BEGIN
   DECLARE
    @fn           VARCHAR(35)   = N'SP_MIGRATE_PROPERTY_SALES_DATA'
   ,@cmd          VARCHAR(MAX)
   ,@msg          VARCHAR(1000)
   ;
   EXEC sp_log 1, @fn,'000: starting';
   BEGIN TRY
      -- Validating Preconditions:
      -- PRE01: PropertySalesStaging table is populated
      EXEC sp_log 1, @fn,'010: Validating preconditions';
      EXEC sp_log 1, @fn,'020: Validating  PRE01:  PropertySalesStaging table is populated';
      EXEC sp_assert_tbl_pop 'PropertySalesStaging';
      EXEC sp_log 1, @fn,'030: Processing';
      EXEC sp_log 1, @fn,'040: clearing ContactAgency, Agency, Contact,PropertySales';
      DELETE FROM ContactAgency;
      DELETE FROM Agency;
      DELETE FROM Contact;
      DELETE FROM PropertySales;
      EXEC sp_log 1, @fn,'050: Pop PropertySales';
      INSERT INTO PropertySales
      (
 agency,[type_id],[area_id],[delegate_id],status_id
,[sept_2],[notes],[quality],[phone],[preferred_contact_method]
,[email],[whatsapp],[viber],[facebook],[messenger],[website]
,[address],[notes_2],[old_notes]
,[date_1]
,[actions_08_oct],[jan_16_2025]
,[action_by_dt]
,[replied],[history]
      )
      SELECT
 agency,t.[type_id],a.area_id,d.delegate_id,s.status_id
,[sept_2],[notes],[quality],[phone],[preferred_contact_method]
,[email],[whatsapp],[viber],[facebook],[messenger],[website]
,[address],[notes_2],[old_notes]
,TRY_CAST([date_1] AS DATE)
,[Actions_08_OCT],[Jan_16_2025]
,TRY_CAST(action_by_dt AS DATE)
,[replied],[history]
FROM PropertySalesStaging pss
LEFT JOIN [Type]   t ON pss.[Type]   = t.type_nm
LEFT JOIN Area     a ON pss.Area     = a.area_nm
LEFT JOIN Delegate d ON pss.delegate = d.alias
LEFT JOIN [Status] s ON pss.[status] = s.status_nm
;
      EXEC sp_log 1, @fn,'060: Pop Contact table';
      INSERT INTO Contact(contact_nm)
      SELECT distinct s1.value as contact
      FROM PropertySalesStaging ps
      CROSS APPLY string_split(Contact_nm, ',') as s1
      ORDER BY s1.value;
      IF @display_tables = 1
         SELECT * FROM PropertySales_vw;
      EXEC sp_log 1, @fn,'070: Merge Agency table';
      -- Populate Agency Table
      MERGE INTO Agency AS target
      USING (
         SELECT DISTINCT agency 
         FROM PropertySales 
         WHERE agency IS NOT NULL
      ) AS source
      ON target.agency_nm = source.agency
      WHEN NOT MATCHED BY TARGET THEN
         INSERT (agency_nm)
         VALUES (source.agency)
      WHEN NOT MATCHED BY SOURCE THEN
         DELETE;
      -- Update Agency set the default phone number to be the phone number from 
      -- PropertySalesStaging where no contacts specified
      EXEC sp_log 1, @fn,'080: update Agency default phone number where no contacts specified';
      UPDATE Agency
      SET phone = ps.phone
      FROM PropertySalesStaging ps JOIN Agency a ON ps.Agency = a.agency_nm
      WHERE ps.Contact_nm IS  NULL
      ;
      EXEC sp_log 1, @fn,'090: update Agency default phone number with the first contact phone';
      UPDATE Agency
      SET phone = X.default_phone
      FROM Agency
      INNER JOIN
      (
         SELECT agency, MIN(dbo.fnTrim(s1.value)) AS default_phone
         FROM PropertySalesStaging ps
         CROSS APPLY string_split(phone, ',') AS s1
         WHERE s1.value <> ''
         GROUP BY agency
      ) X
      ON Agency.agency_nm = X.agency;
      IF @display_tables = 1
         SELECT * FROM Agency;
      -- Validating Postconditions:
      -- POST01: PropertySales table is populated
      EXEC sp_log 1, @fn,'200: Validating postconditions';
      EXEC sp_log 1, @fn,'210: Validating  POST01: PropertySales table is populated'
      EXEC sp_assert_tbl_pop 'PropertySales';
      EXEC sp_assert_tbl_pop 'Agency';
      EXEC sp_assert_tbl_pop 'Contact';
      EXEC sp_log 1, @fn,'300: postconditions validated';
   END TRY
   BEGIN CATCH
      EXEC sp_log_exception @fn;
      THROW;
   END CATCH
   EXEC sp_log 1, @fn,'999: leaving';
END
/*
EXEC sp_migrate_property_sales_data;
SELECT * FROM PropertySalesStaging;
SELECT * FROM Agency;
SELECT * FROM PropertySales_vw;
*/
GO

