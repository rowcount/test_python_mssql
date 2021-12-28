USE [stg]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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
GO

