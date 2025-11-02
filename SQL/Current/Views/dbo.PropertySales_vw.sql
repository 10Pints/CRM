SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PropertySales_vw]
AS
SELECT
       ps.[agency]
      ,t.[type_nm]
      ,ps.[type_id]
      ,a.area_nm
      ,d.[delegate_nm]
      ,s.[status_nm]
      ,ps.[sept_2]
      ,ps.[notes]
      ,ps.[quality]
      ,ps.[contact_nm]
--      ,ps.[agnt_comm_split]
      ,ps.[phone]
 --     ,ps.[alt_phone]
      ,ps.[preferred_contact_method]
      ,ps.[email]
      ,ps.[whatsapp]
      ,ps.[viber]
      ,ps.[facebook]
      ,ps.[messenger]
      ,ps.[website]
      ,ps.[address]
      ,ps.[notes_2]
      ,ps.[old_notes]
      ,ps.[date_1]
      ,ps.[actions_08_oct]
      ,ps.[jan_16_2025]
      ,ps.[action_by_dt]
      ,ps.[replied]
      ,ps.[history]
FROM PropertySales ps 
LEFT JOIN [Type]   t ON ps.[type_id] = t.[type_id]
LEFT JOIN Area     a ON ps.area_id   = a.area_id
LEFT JOIN Delegate d ON ps.delegate_id = d.delegate_id
LEFT JOIN [Status] s ON ps.status_id = s.status_id
;
/*
SELECT * FROM PropertySales_vw;
*/
GO

