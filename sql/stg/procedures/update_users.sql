USE stg
GO

CREATE PROCEDURE dbo.update_users AS
BEGIN
SET NOCOUNT ON;

MERGE ds.dbo.dict_user AS du
USING (
    SELECT
        distinct user_id,
        user_name,
        user_surname
    FROM
        [stg].[dbo].[cf_test_dataset]
) AS src
	ON (du.src_user_id = src.user_id)
WHEN MATCHED THEN
UPDATE SET
    name = src.user_name,
    surname = src.user_surname
    WHEN NOT MATCHED THEN
INSERT (src_user_id, name, surname)
VALUES (src.user_id, src.user_name, user_surname);

END
GO