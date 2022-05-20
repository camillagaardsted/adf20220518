-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://asadatalake2prbthc.dfs.core.windows.net/wwi-02/sale-small/Year=2016/Quarter=Q3/Month=9/Day=20160930/sale-small-20160930-snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
