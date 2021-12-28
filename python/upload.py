
import pymssql
import dotenv
import pandas as pd
import os
dotenv.load_dotenv()

server = os.environ.get("server")
user = os.environ.get("user")
password = os.environ.get("password")
filepath = os.environ.get("filepath")
cnxn = pymssql.connect(server, user, password, 'stg')
cnxn.autocommit(True)
data = pd.read_csv (filepath,sep='\t')   
df = pd.DataFrame(data)
cursor = cnxn.cursor()

cursor.execute("""
IF OBJECT_ID('dbo.cf_test_dataset', 'U') IS NOT NULL
    DROP TABLE dbo.cf_test_dataset
CREATE TABLE [dbo].[cf_test_dataset](
	[user_id] [varchar](126) NULL,
	[server_order_id] [bigint] NULL,
	[service_id] [bigint] NULL,
	[server_configuration] [varchar](126) NULL,
	[service_start_date] [datetime] NULL,
	[service_end_date] [datetime] NULL,
	[user_id_1] [varchar](126) NULL,
	[user_name] [varchar](126) NULL,
	[user_surname] [varchar](126) NULL,
	[price] [varchar](126) NULL
) ON [PRIMARY]
""")
cnxn.commit

cnxn.bulk_copy(table_name='dbo.cf_test_dataset',
               elements=df.itertuples(index=False, name=None))
cnxn.commit
cnxn.close


