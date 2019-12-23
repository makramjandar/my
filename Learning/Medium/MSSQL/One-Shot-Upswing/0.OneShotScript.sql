SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-------------------------------------------------------------------------------------- Initialization
IF OBJECT_ID('GradesDetail') IS NOT NULL 
BEGIN 
	DROP TABLE GradesDetail
END
GO

IF OBJECT_ID('grades') IS NOT NULL 
BEGIN 
	DROP TABLE grades
END
GO

---------------------------------------------------------------- grades Table creation to insert data
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

--------------------------------------------------- Import CSV File Into SQL Server Using Bulk Insert
BULK
INSERT grades
FROM 'c:\grades.csv'
WITH
(
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)
GO

-------------------------------------------------------------------------------------- Table creation
DECLARE @OnDiskTable VARCHAR(MAX), @InMemTable VARCHAR(MAX)

SET @OnDiskTable = ' CREATE TABLE GradesDetail                                           
		(
		Id INT IDENTITY(1, 1)
		, SSN VARCHAR(11) NOT NULL
		, FullName VARCHAR(50) NOT NULL
		, Test VARCHAR(25) NOT NULL
		, Score NUMERIC(5, 2)
		,
		-- Creates a primary key
		CONSTRAINT PK_GRADES PRIMARY KEY CLUSTERED (Id)
		,
		-- Creates a unique nonclustered index on columns SSN
		INDEX IX_SSN NONCLUSTERED (SSN)
		,
		-- This creates a non-clustered index on (FullName)
		INDEX IX_FullName NONCLUSTERED (FullName)
		,
		-- This creates a non-clustered index on (Test)
		INDEX IX_Test NONCLUSTERED (Test)
		) '
		
SET @InMemTable = 'CREATE TABLE GradesDetail		
		(
		Id INT IDENTITY(1, 1)
		, SSN VARCHAR(11) NOT NULL
		, FullName VARCHAR(50) NOT NULL
		, Test VARCHAR(25) NOT NULL
		, Score NUMERIC(5, 2)
		,
		-- Creates a primary key
		CONSTRAINT PK_GRADES PRIMARY KEY NONCLUSTERED HASH (Id) WITH (BUCKET_COUNT = 1000000)
		,
		-- Creates a unique nonclustered index on columns SSN
		INDEX IX_SSN NONCLUSTERED (SSN)
		,
		-- This creates a non-clustered index on (FullName)
		INDEX IX_FullName NONCLUSTERED (FullName)
		,
		-- This creates a non-clustered index on (Test)
		INDEX IX_Test NONCLUSTERED (Test)
		)
		WITH (
			  MEMORY_OPTIMIZED = ON
			  , DURABILITY = SCHEMA_AND_DATA
			 )'

IF (SELECT SERVERPROPERTY('EngineEdition')) = 5
	BEGIN							   -- Create traditional on-disk Table
		EXEC (@OnDiskTable)
	END
ELSE
	BEGIN							      -- Create memory-optimized table
		EXEC (@InMemTable)	                                        
	END;
GO

--------------------------------------------------------------------------------------- Normalization
;
WITH T1 AS
  (SELECT Rtrim(Cast(SSN AS NVARCHAR(MAX))) AS SSN ,
          Rtrim(Cast(First_name AS NVARCHAR(MAX)) + ' ' + Cast(Last_name AS NVARCHAR(MAX))) AS FullName ,
          Test1 AS A ,
          Test2 AS B ,
          Abs(Test3) AS C ,
          Abs(Test4) AS D ,
          Final
   FROM DBO.grades),

T2 AS 
  (SELECT SSN , FullName , 'A' AS Test , A AS Score
FROM T1
UNION
SELECT SSN , FullName , 'B' AS Test , B AS Score FROM T1
UNION
SELECT SSN ,FullName ,'C' AS Test ,C AS Score FROM T1
UNION
SELECT SSN , FullName , 'D' AS Test , D AS Score FROM T1
UNION
SELECT SSN , FullName , 'Final' AS Test , Final AS Score FROM T1
)
INSERT INTO GradesDetail (SSN, FullName, Test, Score)
SELECT * FROM T2
ORDER BY Test, SSN;
GO

----------------------------------------------------------------------------------------------- Pivot
SELECT *, CAST((([A] + [B] + [C] + [D]) / 6) + (Final / 3) AS DECIMAL(5, 2)) AS [Moy.]
FROM (
	SELECT SSN, FullName, Test, Score
	FROM GradesDetail
	) p
PIVOT(SUM(Score) FOR Test IN ([A], [B], [C], [D], [Final])) AS pvt;
GO

------------------------------------------------------------------------------ With Analytic Function
SELECT *
	, LEAD(Score) OVER (ORDER BY Id) Lead
FROM GradesDetail
WHERE Test = 'D';
GO

------------------------------------------------------------------------------ No joins and CTE usage
;
WITH T1
AS (
	SELECT *
	FROM dbo.GradesDetail T2
	WHERE T2.Test = 'D'
	)
SELECT *
	, CASE 
		WHEN Id % 2 = 1
			THEN MAX(CASE 
						WHEN Id % 2 = 0
							THEN Score
						END) OVER (PARTITION BY (Id + 1) / 2)
		ELSE MAX(CASE 
					WHEN Id % 2 = 1
						THEN Score
					END) OVER (PARTITION BY Id / 2)
		END [Lead]
FROM T1 Score
GO

---------------------------------------------------------------------------- With joins and CTE usage
;
WITH T1
AS (
	SELECT *
		, NULL AS Def
	FROM GradesDetail
	WHERE Test = 'D'
	)
SELECT T1.Id
	, T1.SSN
	, T1.FullName
	, T1.Test
	, T1.Score
	, ISNULL(T2.Score, T1.Def) AS [Lead]
FROM T1
LEFT JOIN T1 AS T2
	ON T1.Id = T2.Id - 1;
GO

------------------------------------------------------------------------ Another CTE usage with joins
;
WITH T1
AS (
	SELECT *
	FROM GradesDetail
	WHERE Test = 'D'
	)
SELECT T2.*
	, T3.Score AS [Lead]
FROM T1 AS T2
LEFT JOIN T1 AS T3
	ON T3.Id = T2.Id + 1;
GO

------------------------------------------------- And the Winner is !!! the Co-Related Subquery usage
SELECT *
	, (
		SELECT Score
		FROM GradesDetail
		WHERE Test = 'D'
			AND Id = T1.Id + 1
		) AS Lead
FROM GradesDetail AS T1
WHERE T1.Test = 'D';
GO
