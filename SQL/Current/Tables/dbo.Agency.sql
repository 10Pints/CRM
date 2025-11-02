SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agency](
	[agency_id] [int] IDENTITY(1,1) NOT NULL,
	[agency_nm] [varchar](250) NOT NULL,
	[phone] [varchar](250) NULL,
	[viber] [varchar](50) NULL,
	[whatsApp] [varchar](50) NULL,
	[facebook] [varchar](50) NULL,
	[messenger] [varchar](50) NULL,
	[website] [varchar](50) NULL,
	[primary_contact_id] [int] NULL,
 CONSTRAINT [PK_Agency] PRIMARY KEY CLUSTERED 
(
	[agency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Agency_nm] UNIQUE NONCLUSTERED 
(
	[agency_nm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

