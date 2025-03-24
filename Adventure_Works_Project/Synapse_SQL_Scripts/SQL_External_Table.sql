-- What to do before recreating external table?

-- 1) Create a master key in SQL pool:
	-- syntax : CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'AmbarCoco@123';

	--for Alter the master key: ALTER MASTER KEY REGENERATE WITH ENCRYPTION BY PASSWORD = 'AmbarCoco@123';
	
	
--2) Create database scope credential to get access by managed identity

	CREATE DATABASE SCOPED CREDENTIAL cred_ambar
	WITH
		IDENTITY = 'Managed Identity';
		
--3) Create Extrernal Data Source

	CREATE EXTERNAL DATA SOURCE source_silver
	WITH
	(
		LOCATION = 'https://datalakeambars.dfs.core.windows.net/silver',
		CREDENTIAL = cred_ambar
	);


	CREATE EXTERNAL DATA SOURCE source_gold
	WITH
	(
		LOCATION = 'https://datalakeambars.blob.core.windows.net/gold',
		CREDENTIAL = cred_ambar
	);
	
	
--4) Create External File Format

	CREATE EXTERNAL FILE FORMAT format_parquet
	WITH
	(
		FORMAT_TYPE = PARQUET,
		DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
	);


--# Creating External Table EXTSALES

	CREATE EXTERNAL TABLE gold.extsales
	WITH
	(
		LOCATION = 'extsales',
		DATA_SOURCE = source_gold,
		FILE_FORMAT = format_parquet
	)
	AS
	SELECT * FROM gold.sales;