SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertySales](
	[agency] [varchar](57) NULL,
	[type_nm] [varchar](10) NULL,
	[type_id] [int] NULL,
	[area] [varchar](6) NULL,
	[area_id] [int] NULL,
	[delegate_id] [int] NULL,
	[status_id] [int] NULL,
	[status] [varchar](40) NULL,
	[sept_2] [varchar](38) NULL,
	[notes] [varchar](509) NULL,
	[quality] [varchar](4) NULL,
	[contact_nm] [varchar](318) NULL,
	[phone] [varchar](255) NULL,
	[preferred_contact_method] [varchar](8) NULL,
	[email] [varchar](216) NULL,
	[whatsapp] [varchar](45) NULL,
	[viber] [varchar](14) NULL,
	[facebook] [varchar](92) NULL,
	[messenger] [varchar](85) NULL,
	[website] [varchar](319) NULL,
	[address] [varchar](62) NULL,
	[notes_2] [varchar](82) NULL,
	[old_notes] [varchar](156) NULL,
	[date_1] [varchar](11) NULL,
	[actions_08_oct] [varchar](51) NULL,
	[jan_16_2025] [varchar](43) NULL,
	[action_by_dt] [varchar](7) NULL,
	[replied] [varchar](1) NULL,
	[history] [varchar](66) NULL
) ON [PRIMARY]
GO

