USE stg
GO
CREATE PROCEDURE dbo.update_services AS
BEGIN
SET NOCOUNT ON;
SET IDENTITY_INSERT ds.dbo.dict_service ON;
MERGE ds.dbo.dict_service AS du
USING (
        SELECT
            DISTINCT service_id,
            server_configuration
        FROM
            [stg].[dbo].[cf_test_dataset]
    ) AS src
	ON (du.id = src.service_id)
WHEN MATCHED THEN
UPDATE SET
    config = src.server_configuration
WHEN NOT MATCHED THEN
INSERT (id, config)
VALUES (src.service_id, src.server_configuration);

END
GO