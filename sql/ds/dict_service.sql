USE [ds]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dict_service](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[config] [varchar](126) NULL
) ON [PRIMARY]
GO


