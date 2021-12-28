USE [ds]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dict_user](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[src_user_id] [varchar](126) NULL,
	[name] [varchar](126) NULL,
	[surname] [varchar](126) NULL
) ON [PRIMARY]
GO


