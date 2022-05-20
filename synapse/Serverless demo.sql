-- vi er på serverless pool her

CREATE DATABASE ServerlessDB

-- vi kan bruge USE

USE ServerlessDB

DROP VIEW dbo.vRaspData

CREATE VIEW dbo.vRaspData AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakesu20220516.dfs.core.windows.net/raspdata/sensor=1984/year=2022/month=*/*.csv',
            FORMAT = 'CSV',
            PARSER_VERSION = '2.0',
            HEADER_ROW = TRUE
        ) AS [result]



SELECT      count(*) AS Antal
            , MIN(pressure)     AS minpressure
            , MAX(pressure)     AS maxpressure
FROM        dbo.vRaspData


 SELECT
        top 100 *, T.filename(),T.filepath(1)       As partfromfilename
    FROM
        OPENROWSET(
            BULK 'https://datalakesu20220516.dfs.core.windows.net/raspdata/sensor=1984/year=2022/month=*/*.csv',
            FORMAT = 'CSV',
            PARSER_VERSION = '2.0',
            HEADER_ROW = TRUE
        ) AS T



select TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://datalakesu20220516.dfs.core.windows.net/raspdata/sensor=1984/year=2022/month=05/data*.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) 
    WITH
    (
        SensorId    INT 1,
        DatoTid     DATETIME2(0) 2,
        Temperatur  DECIMAL(19,6) 4,
        Humidity    DECIMAL(19,6) 5,    
        Pressure    DECIMAL(19,6) 6
    ) AS [result]     
    



SELECT      *
FROM        dbo.vRaspData



















