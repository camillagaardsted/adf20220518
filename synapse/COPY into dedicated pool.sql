IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'RaspDataViaCopy' AND O.TYPE = 'U' AND S.NAME = 'dbo')



CREATE TABLE dbo.RaspDataViaCopy
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
	DISTRIBUTION = ROUND_ROBIN, --default 
	 HEAP
	 -- CLUSTERED COLUMNSTORE INDEX
	)
GO

select * from dbo.RaspDataViaCopy


--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_RaspDataViaCopy
--AS
--BEGIN
COPY INTO dbo.RaspDataViaCopy
(sensorid 1,
timestamp 2, 
temperature_from_humidity 3,
 temperature_from_pressure 4,
  humidity 5,
   pressure 6)
FROM 'https://datalakesu20220516.dfs.core.windows.net/raspdata/sensor=1984/year=2022/month=05/*.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 400
	,FIRSTROW = 11
	,ERRORFILE = 'https://datalakesu20220516.dfs.core.windows.net/raspdata/'
)
--END
GO

SELECT TOP 100 * FROM dbo.RaspDataViaCopy
GO