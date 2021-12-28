USE dm
GO

CREATE PROCEDURE dbo.prc_cfo_by_user_per_month AS
BEGIN
SET NOCOUNT ON;

DECLARE @dates AS TABLE(dt date)
DROP TABLE IF EXISTS ##calc
CREATE TABLE ##calc( dt date, user_id bigint,cnt bigint)
DECLARE @case varchar(max)
DECLARE @sql varchar(max)

INSERT INTO @dates (dt)
SELECT DISTINCT
	CAST(CONCAT(DATEPART(YEAR, start_date),'.',datepart(month, start_date),'.','1') AS date)
FROM ds.dbo.orders

SELECT @case = CONCAT_WS(',',@case,CONCAT('SUM(CASE WHEN dt = ''',dt,''' THEN cnt ELSE NULL END)AS ''',dt,''' '))
FROM @dates 


WITH calc AS (
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY user_id,
            service_id,
            DATEPART(YEAR, start_date),
            DATEPART(MONTH, start_date)
            ORDER BY
                start_date
        ) rn
    FROM ds.dbo.orders
)
INSERT INTO ##calc
SELECT
    CAST( CONCAT(DATEPART(YEAR, start_date),'.',DATEPART(MONTH, start_date),'.','1') AS date) AS dt,
    user_id,
    COUNT(service_id) AS cnt
FROM calc
WHERE rn = 1
GROUP BY
    user_id,
    DATEPART(YEAR, start_date),
    DATEPART(MONTH, start_date)
ORDER BY 1,2;

SET @sql = CONCAT(' SELECT user_id, ',@case,' FROM ##calc GROUP BY user_id')
EXEC(@sql)
DROP TABLE ##calc
END
GO