USE dm
GO

CREATE VIEW dbo.cnt_sum_first_orders AS
WITH first_order AS (
        SELECT
            *,
            ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY start_date) rn
        FROM ds.dbo.orders
    )
SELECT
    DATEPART(YEAR, start_date) year,
    DATEPART(MONTH, start_date) month,
    COUNT(user_id) as cfo,
    SUM(price) as sfo
FROM first_order
WHERE rn = 1
GROUP BY
    DATEPART(YEAR, start_date),
    DATEPART(MONTH, start_date)
GO