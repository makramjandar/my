SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Create grades Table to insert data
CREATE TABLE [dbo].[grades](
	[Last_name] [text] NULL,
	[First_name] [text] NULL,
	[SSN] [text] NULL,
	[Test1] [int] NULL,
	[Test2] [int] NULL,
	[Test3] [int] NULL,
	[Test4] [int] NULL,
	[Final] [int] NULL,
	[Grade] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Import CSV File Into SQL Server Using Bulk Insert
BULK
INSERT grades
FROM 'c:\grades.csv'
WITH
(
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)
GO
