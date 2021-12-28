USE stg
GO

CREATE PROCEDURE dbo.update_orders AS
BEGIN
SET NOCOUNT ON;
SET IDENTITY_INSERT ds.dbo.orders ON;
MERGE ds.dbo.orders AS ord USING (
        SELECT
            server_order_id,
            service_id,
            du.id as user_id,
            service_start_date,
            service_end_date,
            convert(decimal(17, 2),iif(isnumeric(price) = 1, price, null)) price
        FROM [stg].[dbo].[cf_test_dataset] AS src
        INNER JOIN ds.dbo.dict_user AS du
			ON src.user_id = du.src_user_id
    ) AS src
	ON (ord.id = src.server_order_id)
WHEN MATCHED THEN
UPDATE SET
    service_id = src.service_id,
    user_id = src.user_id,
    start_date = src.service_start_date,
    end_date = src.service_end_date,
    price = src.price
    WHEN NOT MATCHED THEN
INSERT (id, service_id, user_id, start_date, end_date, price)
VALUES (src.server_order_id,src.service_id,src.user_id,src.service_start_date,src.service_end_date,src.price);

END
GO