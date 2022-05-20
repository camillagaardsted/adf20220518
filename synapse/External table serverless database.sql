IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE,
			 FIRST_ROW = 2
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'raspdata_datalakesu20220516_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [raspdata_datalakesu20220516_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://raspdata@datalakesu20220516.dfs.core.windows.net' 
	)
GO

CREATE SCHEMA EXT

CREATE EXTERNAL TABLE EXT.RaspData (
	[sensorid] bigint,
	[timestamp] datetime2(0),
	[temperature_from_humidity] float,
	[temperature_from_pressure] float,
	[humidity] float,
	[pressure] float
	)
	WITH (
	LOCATION = 'sensor=1984/year=2022/month=05/*',
	DATA_SOURCE = [raspdata_datalakesu20220516_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM ext.RaspData
GO








