-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://asadatalake2prbthc.dfs.core.windows.net/wwi-02/sale-small/Year=2016/Quarter=Q3/Month=9/Day=20160930/sale-small-20160930-snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]


select		top 10 *
from		dbo.vraspdata


-- Vi laver et credential, så synapse anvender sig selv som principal, når den henvender sig til vores datalake
CREATE CREDENTIAL [https://datalakesu20220516.dfs.core.windows.net]
WITH IDENTITY='Managed Identity'

select		*
from		sys.credentials

select top 10 *
from	dbo.vRaspData