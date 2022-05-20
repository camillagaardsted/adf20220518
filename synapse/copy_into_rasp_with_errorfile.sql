IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'raspdatafirst' AND O.TYPE = 'U' AND S.NAME = 'dbo')

CREATE TABLE dbo.raspdatafirst
	(
	 [sensorid] bigint,
	 [timestamp] datetime2(0),
	 [temperature_from_humidity] float,
	 [temperature_from_pressure] float,
	 [humidity] float,
	 [pressure] float
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 HEAP
	 -- CLUSTERED COLUMNSTORE INDEX
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_raspdatafirst
--AS
--BEGIN

COPY INTO dbo.raspdatafirst
(sensorid 1, timestamp 2, temperature_from_humidity 3, temperature_from_pressure 4, humidity 5, pressure 6)
FROM 'https://datalakesu20220516.dfs.core.windows.net/raspdata/sensor=1984/year=2022/month=05/data2022_05_16_10_59_33.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 200
	,FIRSTROW = 01
	,ERRORFILE = 'https://datalakesu20220516.dfs.core.windows.net/raspdata/'
)
--END
GO

SELECT * FROM dbo.raspdatafirst
GO


CREATE TABLE dbo.raspdataAll
	(
	 [sensorid] bigint,
	 [timestamp] datetime2(0),
	 [temperature_from_humidity] float,
	 [temperature_from_pressure] float,
	 [humidity] float,
	 [pressure] float
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 HEAP
	 -- CLUSTERED COLUMNSTORE INDEX
	)
GO


COPY INTO dbo.raspdataAll
(sensorid 1, timestamp 2, temperature_from_humidity 3, temperature_from_pressure 4, humidity 5, pressure 6)
FROM 'https://datalakesu20220516.dfs.core.windows.net/raspdata/sensor=1984/year=2022/month=05/*.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 400
	,FIRSTROW = 01
	,ERRORFILE = 'https://datalakesu20220516.dfs.core.windows.net/raspdata/'
)
