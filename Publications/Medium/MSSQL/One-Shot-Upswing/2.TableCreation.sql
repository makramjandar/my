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
BEGIN                                                                   -- Create traditional on-disk
EXEC (@OnDiskTable)
END
ELSE
BEGIN                                                                -- Create memory-optimized table
EXEC (@InMemTable)	                                        
END;
GO
