if  exists(select * From master.dbo.sysdatabases where name='Level3_reduced')
	begin

	USE master 
	ALTER DATABASE [Level3_reduced]  --删除用户连接
	SET SINGLE_USER 
	WITH ROLLBACK IMMEDIATE
	DROP DATABASE [Level3_reduced]; CREATE DATABASE [Level3_reduced]; 
	end 
else
	begin
	 CREATE DATABASE [Level3_reduced]
	end 

GO

USE [Level3_reduced]
GO
/****** Object:  Table [dbo].[s_Exceptions_HttpNotFound]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[s_Exceptions_HttpNotFound](
	[PathAndQuery] [nvarchar](128) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateLastOccurred] [datetime] NOT NULL,
	[MachineName] [nvarchar](64) NOT NULL,
	[Frequency] [int] NOT NULL,
 CONSTRAINT [PK_s_Exceptions_HttpNotFound] PRIMARY KEY CLUSTERED 
(
	[PathAndQuery] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[u_Users]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityIP] [nvarchar](32) NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
	[IsActivated] [bit] NOT NULL,
 CONSTRAINT [PK_u_Users] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[u_Users] ON
INSERT [dbo].[u_Users] ([UserID], [UserName], [LoweredUserName], [IsAnonymous], [LastActivityIP], [LastActivityDate], [IsActivated]) VALUES (1, N'admin', N'admin', 0, N'127.0.0.1', CAST(0x0000A1100167D404 AS DateTime), 1)
INSERT [dbo].[u_Users] ([UserID], [UserName], [LoweredUserName], [IsAnonymous], [LastActivityIP], [LastActivityDate], [IsActivated]) VALUES (16, N'test1', N'test1', 1, N'127.0.0.1', CAST(0x0000A1330106AA30 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[u_Users] OFF
/****** Object:  StoredProcedure [dbo].[u_User_Gets]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[u_User_Gets]
(
	@ids NVARCHAR(512)
)
AS
BEGIN

	IF @ids IS NULL
		RETURN

	declare @sql NVARCHAR(4000)
	set @sql = 'SELECT U.*, M.*, UP.* FROM u_Users U
	JOIN u_Membership M ON U.UserID = M.UserID 
	JOIN u_UserProfile UP ON U.UserID = UP.UserID
	WHERE U.UserID IN ('+@ids+') order by charindex(cast(U.UserID as varchar),'+''''+@ids+''''+')'

	exec (@sql)
END
GO
/****** Object:  Table [dbo].[u_Roles]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](32) NOT NULL,
	[LoweredRoleName] [nvarchar](32) NOT NULL,
	[FriendlyRoleName] [nvarchar](32) NOT NULL,
	[Description] [nvarchar](256) NULL,
	[RoleType] [bigint] NOT NULL,
 CONSTRAINT [PK_u_Roles] PRIMARY KEY NONCLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_u_Roles] UNIQUE CLUSTERED 
(
	[LoweredRoleName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[u_Roles] ON
INSERT [dbo].[u_Roles] ([RoleID], [RoleName], [LoweredRoleName], [FriendlyRoleName], [Description], [RoleType]) VALUES (2, N'Company Admin', N'company admin', N'Company Admin', N'', 7)
INSERT [dbo].[u_Roles] ([RoleID], [RoleName], [LoweredRoleName], [FriendlyRoleName], [Description], [RoleType]) VALUES (1, N'System Administrator', N'system administrator', N'System Administrator', N'', 0)
INSERT [dbo].[u_Roles] ([RoleID], [RoleName], [LoweredRoleName], [FriendlyRoleName], [Description], [RoleType]) VALUES (3, N'User', N'user', N'User', N'', 7)
SET IDENTITY_INSERT [dbo].[u_Roles] OFF
/****** Object:  Table [dbo].[u_RolePermissions]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_RolePermissions](
	[RoleID] [int] NOT NULL,
	[AllowMask] [bigint] NOT NULL,
	[DenyMask] [bigint] NOT NULL,
 CONSTRAINT [PK_u_RolePermissions] PRIMARY KEY NONCLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[u_RolePermissions] ([RoleID], [AllowMask], [DenyMask]) VALUES (3, 1, 254)
INSERT [dbo].[u_RolePermissions] ([RoleID], [AllowMask], [DenyMask]) VALUES (2, 3, 252)
INSERT [dbo].[u_RolePermissions] ([RoleID], [AllowMask], [DenyMask]) VALUES (1, 255, 0)
/****** Object:  Table [dbo].[App_Users]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[App_Users](
	[UserID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[TaxID] [nvarchar](32) NOT NULL,
	[AccountNumber] [nvarchar](32) NOT NULL,
	[DataSourceNumber] [nvarchar](32) NOT NULL,
	[ProcessorNum] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_l_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[App_Users] ([UserID], [CompanyID], [TaxID], [AccountNumber], [DataSourceNumber], [ProcessorNum]) VALUES (1, 1, N'123', N'1222', N'122', N'111')
INSERT [dbo].[App_Users] ([UserID], [CompanyID], [TaxID], [AccountNumber], [DataSourceNumber], [ProcessorNum]) VALUES (16, 1, N'123', N'', N'122', N'')
/****** Object:  StoredProcedure [dbo].[App_Users_Gets]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[App_Users_Gets]
(
	@ids NVARCHAR(4000) 
)
AS
BEGIN
	IF @ids IS NULL OR ISNULL(@ids,'')=''
		RETURN
		
	DECLARE   @str NVARCHAR(4000)  
	set @str = 'SELECT * FROM [App_Users] WHERE UserID IN ('+@ids+')';
	exec (@str)

END
GO
/****** Object:  Table [dbo].[l_Company]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[l_Company](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyLoginName] [nvarchar](32) NOT NULL,
	[CompanyName] [nvarchar](32) NOT NULL,
	[Description] [nvarchar](32) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CardholderCorporationNumber] [nvarchar](64) NOT NULL,
	[ICANumber] [nvarchar](64) NOT NULL,
	[IssuerNumber] [nvarchar](64) NOT NULL,
	[TID] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_l_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[l_Company] ON
INSERT [dbo].[l_Company] ([CompanyID], [CompanyLoginName], [CompanyName], [Description], [CreateDate], [CardholderCorporationNumber], [ICANumber], [IssuerNumber], [TID]) VALUES (1, N'Field CompanyLoginName', N'Microsoft', N'Field Description', CAST(0x0000A0B2014F6E50 AS DateTime), N'16', N'123', N'123', N'7009100001')
SET IDENTITY_INSERT [dbo].[l_Company] OFF
/****** Object:  StoredProcedure [dbo].[l_Company_Gets]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[l_Company_Gets]
(
	@ids NVARCHAR(4000) 
)
AS
BEGIN
	IF @ids IS NULL OR ISNULL(@ids,'')=''
		RETURN
		
	DECLARE   @str NVARCHAR(4000)  
	set @str = 'SELECT * FROM [l_Company] WHERE CompanyID IN ('+@ids+')';
	exec (@str)

END
GO
/****** Object:  Table [dbo].[s_EventLog]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_EventLog](
	[EventLogID] [int] IDENTITY(1,1) NOT NULL,
	[Message] [ntext] NOT NULL,
	[Category] [nvarchar](255) NOT NULL,
	[EventID] [int] NOT NULL,
	[EventType] [int] NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[UserName] [varchar](256) NULL,
 CONSTRAINT [PK_s_EventLog] PRIMARY KEY CLUSTERED 
(
	[EventLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[s_Exceptions]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[s_Exceptions](
	[ExceptionID] [int] IDENTITY(1,1) NOT NULL,
	[ExceptionHash] [varchar](128) NOT NULL,
	[Category] [int] NOT NULL,
	[Exception] [ntext] NOT NULL,
	[ExceptionMessage] [nvarchar](512) NOT NULL,
	[IPAddress] [varchar](64) NOT NULL,
	[UserAgent] [nvarchar](64) NOT NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[HttpReferrer] [nvarchar](256) NOT NULL,
	[HttpVerb] [nvarchar](16) NOT NULL,
	[PathAndQuery] [nvarchar](512) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateLastOccurred] [datetime] NOT NULL,
	[Frequency] [int] NOT NULL,
 CONSTRAINT [PK_s_Exceptions] PRIMARY KEY CLUSTERED 
(
	[ExceptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_s_Exceptions_ExceptionHash] UNIQUE NONCLUSTERED 
(
	[ExceptionHash] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[s_GetRecordsWithNotIn]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[s_GetRecordsWithNotIn]
	@PageIndex int = 0,
	@PageSize int,
	@FromClause varchar(1024),                 --单个Table或者用Join关联的多个Table
	@SelectFields varchar(512),                --查询字段
	@WhereClause nvarchar(4000) = N'',         --条件例如"DirectoryID=4"
	@OrderByClause varchar(256),               --排序字段,
	@UniqueField varchar(256),                 --唯一列
	@ReturnRecordCount bit = 0,                --是否需要返回查询到的记录数
	@MaxRecords int = -1,                      --最多获取多少条记录
	@TotalRecords int = -1 output              --1表示读取数据的时候
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SQLString nvarchar(4000);
	DECLARE @WhereString1 nvarchar(4000);
	DECLARE @WhereString2 nvarchar(4000);

	IF @WhereClause IS NULL OR @WhereClause = N'' BEGIN
		SELECT @WhereString1 = N'';
		SELECT @WhereString2 = N'WHERE ';
	END
	ELSE BEGIN
		SELECT @WhereString1 = N'WHERE ' + @WhereClause;
		SELECT @WhereString2 = N'WHERE ' + @WhereClause + N' AND ';
	END

  --1.处理查询记录数
	IF @ReturnRecordCount=1 
	BEGIN
		DECLARE @SQLCountString nvarchar(4000);
		IF @MaxRecords>0
		  set @SQLCountString = N'select @RecordCount = count(*) from (select top ' + str(@MaxRecords) + N' ' + @UniqueField 
			+ N' from ' + @FromClause +N' ' + @WhereString1+ N') as TempCountTable';
		ELSE
		  set @SQLCountString = N'select @RecordCount = count(*) from ' + @FromClause + N' ' + @WhereString1;
		  
		exec sp_executesql @SQLCountString,N'@RecordCount int out ',@TotalRecords out  
		
	    if(@PageIndex*@PageSize > @TotalRecords)
	      set @PageIndex=0	
	END 
	
    IF (@MaxRecords>0  and @PageIndex*@PageSize>@MaxRecords)
	    set @PageIndex=0	
	
	IF @PageIndex = 0 BEGIN
		SELECT @SQLString = N'SELECT TOP ' + STR(@PageSize)
			+ N' ' + @SelectFields + N' FROM ' + @FromClause + N' ' + @WhereString1 + '	ORDER BY ' + @OrderByClause;
	END
	ELSE BEGIN		
		SET @SQLString = N'SELECT TOP ' + STR(@PageSize) + N' ' + @SelectFields + N' FROM ' + @FromClause + N' ' + @WhereString2 + @UniqueField + N' NOT IN (SELECT TOP ' + STR(@pageSize*@pageIndex) + N' ' + @UniqueField + N' FROM ' + @FromClause + N' ' + @WhereString1 + N'ORDER BY ' + @OrderByClause + N') ORDER BY ' + @OrderByClause;
	END
	
	EXEC sp_executesql @SQLString;

END
GO
/****** Object:  StoredProcedure [dbo].[s_GetRecords]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[s_GetRecords]
	@PageIndex int,
	@PageSize int,
	@FromClause varchar(512),                  --单个Table或者用Join关联的多个Table
	@SelectFields varchar(4000) = '*',         --查询字段，默认为 *
	@WhereClause nvarchar(4000) = N'',         --条件例如"DirectoryID=4"
	@SortField varchar(256),                   --排序字段 
	@SortFieldIsDesc bit = 1,                  --正序(0)还是倒序(1)
    @ReturnRecordCount bit = 1,                --是否需要返回查询到的记录数
    @MaxRecords int = -1,                      --最多获取多少条记录
	@TotalRecords int = -1 output,             --查询到的记录数
	@ReverseOrder bit = 0 output               --1表示读取数据的时候 排序要反过来

AS
BEGIN
	SET NOCOUNT ON;
	
	if (@PageIndex < 0)
	 set @PageIndex = 0;

	DECLARE @SQLString nvarchar(4000);
	DECLARE @WhereString1 nvarchar(4000);
	DECLARE @WhereString2 nvarchar(4000);

	IF @WhereClause IS NULL OR @WhereClause = N'' BEGIN
		SELECT @WhereString1 = N'';
		SELECT @WhereString2 = N'WHERE ';
	END
	ELSE BEGIN
		SELECT @WhereString1 = N'WHERE ' + @WhereClause;
		SELECT @WhereString2 = N'WHERE ' + @WhereClause + N' AND ';
	END

  --1.处理查询记录数
  IF @ReturnRecordCount=1 
    BEGIN
    DECLARE @SQLCountString nvarchar(4000);
    IF @MaxRecords>0
      set @SQLCountString = N'select @TotalRecords = count(*) from (select top ' + str(@MaxRecords)+ N' '+ @SortField 
        + N' from ' + @FromClause +N' ' + @WhereString1+ N') as TempCountTable';
    ELSE
      set @SQLCountString = N'select @TotalRecords = count(*) from ' + @FromClause + N' ' + @WhereString1;
  
    exec sp_executesql @SQLCountString,N'@TotalRecords int out ',@TotalRecords out  
    
	if(@PageIndex*@PageSize > @TotalRecords)
	  set @PageIndex=0	
    END 
  else 
    set @TotalRecords = -1

    IF (@MaxRecords>0  and @PageIndex*@PageSize>@MaxRecords)
	    set @PageIndex=0	

	IF @PageIndex = 0 BEGIN
		SELECT @SQLString = N'SELECT TOP ' + STR(@PageSize)
			+ N' ' + @SelectFields + N' FROM ' + @FromClause + N' ' + @WhereString1 + '	ORDER BY ' + @SortField;
			
		IF @SortFieldIsDesc = 1
			SELECT @SQLString = @SQLString + ' DESC';
						
		SET @ReverseOrder=0	
	END
	ELSE BEGIN
	-----------------------------------------------
	  DECLARE @SortField_NoPrefix varchar(256);
	  IF (CHARINDEX('.',@SortField)>0)
	    SET @SortField_NoPrefix = SUBSTRING(@SortField, CHARINDEX('.',@SortField)+1, LEN(@SortField));
	  ELSE
	    SET @SortField_NoPrefix = @SortField;
	
		SET @SQLString='';
		DECLARE @GetFromLast BIT
		IF @TotalRecords=-1
			SET @GetFromLast=0
		ELSE BEGIN
			DECLARE @TotalPage INT,@ResidualCount INT
			SET @ResidualCount=@TotalRecords%@PageSize
			IF @ResidualCount=0
				SET @TotalPage=@TotalRecords/@PageSize
			ELSE
				SET @TotalPage=@TotalRecords/@PageSize+1
			IF @PageIndex>@TotalPage/2 --页数过半，则从后往前算
				SET @GetFromLast=1
			ELSE
				SET @GetFromLast=0

			IF @GetFromLast=1 BEGIN
				IF @PageIndex=@TotalPage-1 BEGIN
					IF @ResidualCount=0
						SET @ResidualCount=@PageSize;
					SELECT @SQLString = N'SELECT top ' + STR(@ResidualCount)
						+ N' ' + @SelectFields
						+ N' FROM ' + @FromClause + N' ' + @WhereString1 + N' ORDER BY ' + @SortField;
					IF @SortFieldIsDesc = 0--正序
						SELECT @SQLString = @SQLString + ' DESC';
					SET @ReverseOrder=1
				END 
				ELSE IF  @PageIndex>@TotalPage-1 BEGIN --已经超过最大页数
					SELECT @SQLString = N'SELECT ' + @SelectFields
						+ N' FROM ' + @FromClause + ' WHERE 0=1'
					SET @ReverseOrder=0
				END
				ELSE BEGIN
					SET @PageIndex=@TotalPage-(@PageIndex+1)
					IF @SortFieldIsDesc=1
						SET @SortFieldIsDesc=0
					ELSE
						SET @SortFieldIsDesc=1
					SET @ReverseOrder=1
				END  
			END
			ELSE 
				SET @ReverseOrder=0
		END
		
		IF @SQLString='' BEGIN
			DECLARE @TopCount INT
			IF @GetFromLast=1 BEGIN
				SET @TopCount=@PageSize * (@PageIndex-1)+@ResidualCount
				IF @TopCount = 0
					SET @TopCount = @PageSize;
			END
			ELSE
				SET @TopCount=@PageSize * @PageIndex

			IF @SortFieldIsDesc = 1
				SELECT @SQLString = 'SELECT TOP ' + STR(@PageSize)
				+ N' ' + @SelectFields
				+ N' FROM ' + @FromClause+N' ' + @WhereString2 + @SortField + ' <
					(SELECT Min(' + @SortField_NoPrefix + ') FROM 
						(SELECT TOP ' + STR(@TopCount) + ' ' + @SortField + ' FROM ' + @FromClause + N' ' + @WhereString1 + '
								ORDER BY ' + @SortField + ' DESC) AS TempTable)
				ORDER BY ' + @SortField + ' DESC';
			ELSE
				SELECT @SQLString = 'SELECT TOP ' + STR(@PageSize)
				+ N' ' + @SelectFields
				+ N' FROM ' + @FromClause + N' ' + @WhereString2 + @SortField + ' >
					(SELECT Max(' + @SortField_NoPrefix + ') FROM 
						(SELECT TOP ' + STR(@TopCount) + ' ' + @SortField + ' FROM ' + @FromClause+ N' ' + @WhereString1 + '
								ORDER BY ' + @SortField + ' ASC) AS TempTable)
				ORDER BY ' + @SortField;
		END
	END
		
	EXEC sp_executesql @SQLString;

END
GO
/****** Object:  Table [dbo].[s_Settings]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[s_Settings](
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](1024) NOT NULL,
	[Settings] [ntext] NOT NULL,
 CONSTRAINT [PK_s_Settings] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[s_Settings] ([Name], [Description], [Settings]) VALUES (N'basic.core.sitesettings', N'', N'<?xml version="1.0" encoding="utf-16"?>
<SiteSettings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<SiteName>Level3</SiteName> 
<RoleNamesForAdminLogin><string>System Administrator</string><string>Company Admin</string><string>User</string>
</RoleNamesForAdminLogin><DefaultLanguage><string>en-US</string></DefaultLanguage>
</SiteSettings>')
INSERT [dbo].[s_Settings] ([Name], [Description], [Settings]) VALUES (N'basic.core.usersettings', N'', N'<?xml version="1.0" encoding="utf-16"?>
<UserSettings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <RequiresQuestionAndAnswer>false</RequiresQuestionAndAnswer>
  <RequiresUniqueEmail>false</RequiresUniqueEmail>
  <RequiresUniqueNickName>false</RequiresUniqueNickName>
  <PasswordStrengthRegularExpression />
  <MinRequiredPasswordLength>4</MinRequiredPasswordLength>
  <MinRequiredNonAlphanumericCharacters>0</MinRequiredNonAlphanumericCharacters>
  <PasswordFormat>Sha1Hash</PasswordFormat>
  <UserSignatureMaxLength>256</UserSignatureMaxLength>
  <ActivationKeyExpirationSeconds>25200</ActivationKeyExpirationSeconds>
  <BackwardsCompatiblePasswords>false</BackwardsCompatiblePasswords>
  <UserIsOnlineTimeWindow>60</UserIsOnlineTimeWindow>
  <IgnoreDisallowNames>false</IgnoreDisallowNames>
  <AccountActivation>Automatic</AccountActivation>
</UserSettings>')
/****** Object:  StoredProcedure [dbo].[s_Setting_GET]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[s_Setting_GET]
	@Name nvarchar(256)
AS
BEGIN
		
		SELECT
			Name,
			Description,
			Settings			
		FROM
			s_Settings
		WHERE
			Name = @Name

END
GO
/****** Object:  StoredProcedure [dbo].[s_Setting_CreateUpdate]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[s_Setting_CreateUpdate]
(
	@Name nvarchar(256),
	@Description nvarchar(1024),
	@Settings ntext
)
AS
BEGIN

	IF EXISTS(SELECT Name FROM s_Settings WHERE Name = @Name)
		UPDATE
			s_Settings
		SET
			Description = @Description,
			Settings = @Settings
		WHERE
			Name = @Name
	ELSE
		INSERT INTO
			s_Settings
		(
			Name,
			Description,
			Settings
		)
		VALUES
		(
			@Name,
			@Description,
			@Settings
		)
END
GO
/****** Object:  StoredProcedure [dbo].[s_Exceptions_LogHttpNotFound]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[s_Exceptions_LogHttpNotFound]
(
	@PathAndQuery nvarchar(512),
	@MachineName nvarchar(256)
)
AS
BEGIN

SET Transaction Isolation Level Read UNCOMMITTED

SELECT @PathAndQuery = LOWER(@PathAndQuery)

IF EXISTS (SELECT PathAndQuery FROM s_Exceptions_HttpNotFound WHERE PathAndQuery = @PathAndQuery)

	UPDATE
		s_Exceptions_HttpNotFound
	SET
		DateLastOccurred = GetDate(),
		Frequency = Frequency + 1
	WHERE
		PathAndQuery = @PathAndQuery

ELSE
	INSERT INTO 
		s_Exceptions_HttpNotFound
	(
		PathAndQuery,
		DateCreated,
		DateLastOccurred,
		MachineName,
		Frequency
	)
	VALUES
	(
		@PathAndQuery,
		GetDate(),
		GetDate(),
		@MachineName,
		1
	)

END
GO
/****** Object:  StoredProcedure [dbo].[s_Exceptions_Log]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[s_Exceptions_Log]
(
	@ExceptionHash varchar(128),
	@Category int,
	@Exception ntext,
	@ExceptionMessage nvarchar(512),
	@MachineName nvarchar(256),
	@UserAgent nvarchar(64),
	@IPAddress varchar(15),
	@HttpReferrer nvarchar (256),
	@HttpVerb nvarchar(24),
	@PathAndQuery nvarchar(512)
)
AS
BEGIN

SET Transaction Isolation Level Read UNCOMMITTED

IF EXISTS (SELECT ExceptionID FROM s_Exceptions WHERE ExceptionHash = @ExceptionHash)

	UPDATE
		s_Exceptions
	SET
		DateLastOccurred = GetDate(),
		Frequency = Frequency + 1
	WHERE
		ExceptionHash = @ExceptionHash
ELSE
	INSERT INTO 
		s_Exceptions
	(
		ExceptionHash,
		Category,
		Exception,
		ExceptionMessage,
		UserAgent,
		MachineName,
		IPAddress,
		HttpReferrer,
		HttpVerb,
		PathAndQuery,
		DateCreated,
		DateLastOccurred,
		Frequency
	)
	VALUES
	(
		@ExceptionHash,
		@Category,
		@Exception,
		@ExceptionMessage,
		@UserAgent,
		@MachineName,
		@IPAddress,
		@HttpReferrer,
		@HttpVerb,
		@PathAndQuery,
		GetDate(),
		GetDate(),
		1
	)

END
GO
/****** Object:  StoredProcedure [dbo].[s_EventLog_GetEntry]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[s_EventLog_GetEntry]
(
	@EventLogID int
)
AS
	SELECT		EL.EventLogID,
				EL.Message,
				EL.Category,
				EL.EventID,
				EL.EventType,
				EL.EventDate,
				EL.MachineName,
				EL.UserName
	FROM		s_EventLog EL
	WHERE		EL.EventLogID = @EventLogID
GO
/****** Object:  StoredProcedure [dbo].[s_EventLog_GetEntries]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[s_EventLog_GetEntries]
AS
	SELECT TOP 1000
		EL.EventLogID,
		EL.Message,
		EL.Category,
		EL.EventID,
		EL.EventType,
		EL.EventDate,
		EL.MachineName,
		EL.UserName
	FROM		
		s_EventLog EL
	ORDER BY
		EL.EventLogID DESC
GO
/****** Object:  StoredProcedure [dbo].[s_EventLog_Clear]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[s_EventLog_Clear]
(
	@Date datetime
) AS

Delete FROM s_EventLog where EventDate <= @Date

SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  StoredProcedure [dbo].[s_EventLog_Add]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[s_EventLog_Add]
(
	@EventType int,
	@Message ntext,
	@Category nvarchar(256),
	@MachineName nvarchar(256) = null,
	@EventID int,
	@UserName nvarchar(256) = NULL
) 
AS
  INSERT INTO [s_EventLog]([Message], [Category], [EventID], [EventType], [MachineName], [UserName])
    VALUES(  @Message, @Category, @EventID, @EventType, @MachineName, @UserName)
GO
/****** Object:  StoredProcedure [dbo].[l_Company_GetsAll]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[l_Company_GetsAll]
AS
BEGIN
	SELECT * FROM [l_Company]
END
GO
/****** Object:  StoredProcedure [dbo].[l_Company_Get]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[l_Company_Get]
(
	@CompanyID INT
)
AS
BEGIN
	
	SELECT * FROM [l_Company] WHERE CompanyID = @CompanyID

END
GO
/****** Object:  StoredProcedure [dbo].[l_Company_Delete]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[l_Company_Delete]
(
     @CompanyID int    
)
AS
BEGIN

	DELETE FROM l_Company WHERE [CompanyID] = @CompanyID

END
GO
/****** Object:  StoredProcedure [dbo].[l_Company_CreateUpdate]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[l_Company_CreateUpdate]
(
     @CompanyID int out,
     @CompanyLoginName nvarchar(32),    
     @CompanyName nvarchar(32),    
     @Description nvarchar(32),    
     @CreateDate datetime,    
     @CardholderCorporationNumber nvarchar(64),    
     @ICANumber nvarchar(64),    
     @IssuerNumber nvarchar(64),
	 @TID nvarchar(64)   
)
AS
BEGIN
	IF EXISTS(SELECT CompanyID FROM l_Company (NOLOCK) WHERE [CompanyID] = @CompanyID)
	BEGIN
		 UPDATE [l_Company] SET
            [CompanyLoginName] = @CompanyLoginName,
            [CompanyName] = @CompanyName,
            [Description] = @Description,
            [CreateDate] = @CreateDate,
            [CardholderCorporationNumber] = @CardholderCorporationNumber,
            [ICANumber] = @ICANumber,
            [IssuerNumber] = @IssuerNumber,
			[TID]=@TID
         WHERE
	       [CompanyID] = @CompanyID
	END	
	ELSE
	BEGIN
		Insert Into [l_Company] 
        (
            [CompanyLoginName],    
            [CompanyName],    
            [Description],    
            [CreateDate],    
            [CardholderCorporationNumber],    
            [ICANumber],    
            [IssuerNumber],
			[TID]    
        )
        Values
        (
            @CompanyLoginName,
            @CompanyName,
            @Description,
            @CreateDate,
            @CardholderCorporationNumber,
            @ICANumber,
            @IssuerNumber,
			@TID
        )
        SELECT @CompanyID = SCOPE_IDENTITY()
	END
END
GO
/****** Object:  StoredProcedure [dbo].[App_Users_GetsAll]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[App_Users_GetsAll]
AS
BEGIN
	SELECT * FROM [App_Users]
END
GO
/****** Object:  StoredProcedure [dbo].[App_Users_Delete]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[App_Users_Delete]
(
     @UserID int    
)
AS
BEGIN

	DELETE FROM App_Users WHERE [UserID] = @UserID

END
GO
/****** Object:  StoredProcedure [dbo].[App_Users_CreateUpdate]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[App_Users_CreateUpdate]
(
     @UserID int,    
     @CompanyID int,    
     @TaxID nvarchar(32),
     @AccountNumber nvarchar(32),    
     @DataSourceNumber nvarchar(32),    
     @ProcessorNum nvarchar(32)     
)
AS
BEGIN
	IF EXISTS(SELECT UserID FROM App_Users (NOLOCK) WHERE [UserID] = @UserID)
	BEGIN
		 UPDATE [App_Users] SET
            [CompanyID] = @CompanyID,
            [TaxID] = @TaxID,
			[AccountNumber] = @AccountNumber,
            [DataSourceNumber] = @DataSourceNumber,
            [ProcessorNum] = @ProcessorNum
         WHERE
	       [UserID] = @UserID
	END	
	ELSE
	BEGIN
		Insert Into [App_Users] 
        (
		    [UserID],
            [CompanyID],    
            [TaxID],    
            [AccountNumber],    
            [DataSourceNumber],    
            [ProcessorNum]    
        )
        Values
        (
		    @UserID,
            @CompanyID,
            @TaxID,
            @AccountNumber,
            @DataSourceNumber,
            @ProcessorNum
        )
	END
END
GO
/****** Object:  StoredProcedure [dbo].[u_Role_Create]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_Role_Create]
(
	@RoleID	INT out,
	@Name		nvarchar(32) = '',
	@FriendlyRoleName		nvarchar(32) = '',
	@Description	nvarchar(32) = '',
    @RoleType BIGINT
)
AS
	Select @RoleID = RoleID FROM u_Roles where LoweredRoleName = Lower(@Name)
	-- 不允许有同名的
	IF @RoleID > 0
		RETURN

	INSERT INTO 
		u_Roles 
	(
		RoleName, 
		LoweredRoleName,
		FriendlyRoleName,
		Description,
        RoleType
	)
	VALUES 
	(
		@Name,
		Lower(@Name),
		@FriendlyRoleName,
		@Description,
        @RoleType
	)
	
	Select @RoleID = SCOPE_IDENTITY()
GO
/****** Object:  Table [dbo].[u_Membership]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_Membership](
	[UserID] [int] NOT NULL,
	[MemberID] [uniqueidentifier] NOT NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateIP] [nvarchar](32) NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastLoginIP] [nvarchar](32) NULL,
	[AccountStatus] [smallint] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
 CONSTRAINT [PK_u_Membership] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[u_Membership] ([UserID], [MemberID], [Email], [LoweredEmail], [CreateDate], [CreateIP], [LastLoginDate], [LastLoginIP], [AccountStatus], [Password], [PasswordFormat], [PasswordSalt], [LastPasswordChangedDate], [LastLockoutDate], [PasswordQuestion], [PasswordAnswer], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart]) VALUES (1, N'1cada1b3-7ab0-4590-afff-9c51c95671b3', N'admin@admin.com', N'admin@admin.com', CAST(0x0000A1100167D404 AS DateTime), N'127.0.0.1', CAST(0x0000A13F015E2913 AS DateTime), N'127.0.0.1', 1, N'BD-81-F4-3E-8B-D2-84-4F-05-0D-3A-3D-D7-F5-30-39-1F-7E-7B-C4', 2, N'g3aUq7gdhu5RatCW3r0nXg==', CAST(0x0000A1100167D404 AS DateTime), CAST(0x0000A1100167D404 AS DateTime), N'问题', N'答案', 0, CAST(0xFFFF2FB300000000 AS DateTime), 0, CAST(0xFFFF2FB300000000 AS DateTime))
/****** Object:  StoredProcedure [dbo].[u_Role_Update]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_Role_Update]
(
	@RoleID	INT,
	@Name		nvarchar(32) = '',
	@FriendlyRoleName		nvarchar(32) = '',
	@Description	nvarchar(512) = '',
    @RoleType BIGINT
)
AS
	UPDATE 
		u_Roles
	SET
		RoleName = @Name,
		LoweredRoleName = Lower(@Name),
		FriendlyRoleName=@FriendlyRoleName,
		Description = @Description,
        RoleType=@RoleType
	WHERE 
		RoleID = @RoleID
GO
/****** Object:  StoredProcedure [dbo].[u_Role_Get]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[u_Role_Get]
(
	@RoleID INT = null,
	@RoleName nvarchar(32) = null
)
AS
SET Transaction Isolation Level Read UNCOMMITTED
BEGIN

	
	SELECT 
		RoleID, RoleName AS [Name],FriendlyRoleName, r.Description,RoleType
	FROM 
		u_Roles r
	WHERE
		((@RoleID IS NOT NULL AND r.RoleID = @RoleID ) OR @RoleID IS NULL ) AND
		((@RoleName IS NOT NULL AND r.LoweredRoleName = LOWER(@RoleName) ) OR @RoleName IS NULL )

END
GO
/****** Object:  StoredProcedure [dbo].[u_RolePermissions_Update]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_RolePermissions_Update]
    @RoleID int,
    @AllowMask bigint,
    @DenyMask bigint
AS

IF NOT EXISTS (SELECT RoleID FROM [u_RolePermissions] WHERE [RoleID] = @RoleID)
    RETURN 0
ELSE
    UPDATE [u_RolePermissions] SET
        [AllowMask] = @AllowMask,
        [DenyMask] = @DenyMask
    WHERE
        [RoleID] = @RoleID
RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[u_User_UpdateLastActivity]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[u_User_UpdateLastActivity]
(
	@UserID INT,
	@LastActivityDate DateTime,
	@LastActivityIP varchar(64)
)
AS
BEGIN
	UPDATE
		u_Users WITH (ROWLOCK)
	SET 
		LastActivityDate = @LastActivityDate,
		LastActivityIP = @LastActivityIP
	WHERE
		UserID = @UserID
END
GO
/****** Object:  Table [dbo].[u_UsersInRoles]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_UsersInRoles](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_u_UsersInRoles] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[u_UsersInRoles] ([UserID], [RoleID]) VALUES (1, 1)
INSERT [dbo].[u_UsersInRoles] ([UserID], [RoleID]) VALUES (1, 2)
INSERT [dbo].[u_UsersInRoles] ([UserID], [RoleID]) VALUES (1, 3)
INSERT [dbo].[u_UsersInRoles] ([UserID], [RoleID]) VALUES (16, 3)
/****** Object:  StoredProcedure [dbo].[u_RolePermissions_Create]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_RolePermissions_Create]
    @ID int output,
    @RoleID int,
    @AllowMask bigint,
    @DenyMask bigint
AS

IF EXISTS (SELECT RoleID FROM [u_RolePermissions] WHERE [RoleID] = @RoleID)
    RETURN 0
ELSE
    INSERT INTO [u_RolePermissions](
        [RoleID],
        [AllowMask],
        [DenyMask]
    )VALUES(
        @RoleID,
        @AllowMask,
        @DenyMask
    )

SET @ID = SCOPE_IDENTITY()
RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[s_Exceptions_Get]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  procedure [dbo].[s_Exceptions_Get]
(
	@ExceptionType int = 0,
	@MinFrequency int = 10,
	@SortOrder int = 1,
	@IncludeUnknown bit = 0
)
AS
SET Transaction Isolation Level Read UNCOMMITTED
BEGIN

IF @SortOrder = 1
	SELECT TOP 100
		E.*
	FROM
		s_Exceptions E
	WHERE
		((@ExceptionType > 0 and E.Category = @ExceptionType ) or @ExceptionType <= 0 ) AND
		E.Frequency >= @MinFrequency
		AND (@IncludeUnknown = 1 OR (@IncludeUnknown = 0 AND E.Category <> 999))
	ORDER BY
		E.DateLastOccurred DESC, E.Frequency DESC
ELSE
	SELECT TOP 100
		E.*
	FROM
		s_Exceptions E
	WHERE
		((@ExceptionType > 0 and E.Category = @ExceptionType ) or @ExceptionType <= 0 ) AND
		E.Frequency >= @MinFrequency
		AND (@IncludeUnknown = 1 OR (@IncludeUnknown = 0 AND E.Category <> 999))
	ORDER BY
		E.Frequency DESC, E.DateLastOccurred DESC
END
GO
/****** Object:  Table [dbo].[u_UserProfile]    Script Date: 01/07/2013 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_UserProfile](
	[UserID] [int] NOT NULL,
	[RealName] [nvarchar](32) NOT NULL,
	[NickName] [nvarchar](32) NOT NULL,
	[LoweredNickName] [nvarchar](32) NOT NULL,
	[Gender] [smallint] NOT NULL,
	[Age] [smallint] NOT NULL,
	[Birthday] [datetime] NULL,
	[FriendCount] [int] NOT NULL,
	[HitTimes] [int] NOT NULL,
	[MobileNo] [nvarchar](32) NOT NULL,
	[TelNo] [nvarchar](32) NOT NULL,
	[Fax] [nvarchar](32) NOT NULL,
	[Address] [nvarchar](128) NOT NULL,
	[BasicPoints] [int] NOT NULL,
	[Marriage] [smallint] NOT NULL,
	[TimeZone] [float] NOT NULL,
	[BloodGroup] [smallint] NOT NULL,
	[ChineseZodiacAnimals] [smallint] NOT NULL,
	[Horoscope] [smallint] NOT NULL,
	[DatabaseQuota] [int] NOT NULL,
	[DatabaseQuotaUsed] [int] NOT NULL,
	[PropertyNames] [ntext] NULL,
	[PropertyValues] [ntext] NULL,
 CONSTRAINT [PK_u_UserProfile] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[u_UserProfile] ([UserID], [RealName], [NickName], [LoweredNickName], [Gender], [Age], [Birthday], [FriendCount], [HitTimes], [MobileNo], [TelNo], [Fax], [Address], [BasicPoints], [Marriage], [TimeZone], [BloodGroup], [ChineseZodiacAnimals], [Horoscope], [DatabaseQuota], [DatabaseQuotaUsed], [PropertyNames], [PropertyValues]) VALUES (1, N'system admin', N'admin', N'admin', 0, 0, CAST(0xFFFF2FB300000000 AS DateTime), 0, 0, N'13712345678', N'0551-12345678', N'0551-12345678', N'china', 0, 0, 8, 0, 0, 0, 102400, 0, NULL, NULL)
INSERT [dbo].[u_UserProfile] ([UserID], [RealName], [NickName], [LoweredNickName], [Gender], [Age], [Birthday], [FriendCount], [HitTimes], [MobileNo], [TelNo], [Fax], [Address], [BasicPoints], [Marriage], [TimeZone], [BloodGroup], [ChineseZodiacAnimals], [Horoscope], [DatabaseQuota], [DatabaseQuotaUsed], [PropertyNames], [PropertyValues]) VALUES (16, N'TEST1', N'test1 nickname', N'test1 nickname', 0, 0, CAST(0xFFFF2FB300000000 AS DateTime), 0, 0, N'18234567890', N'0551-12345678', N'0551-12345678', N'hefei', 0, 0, 8, 0, 0, 0, 102400, 0, NULL, NULL)
/****** Object:  StoredProcedure [dbo].[u_UsersInRoles_RemoveUserFromRoles]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[u_UsersInRoles_RemoveUserFromRoles]
(
	@UserID INT,
	@RoleID INT
)
AS
BEGIN

	DELETE FROM u_UsersInRoles WHERE UserID = @UserID AND RoleID = @RoleID

END
GO
/****** Object:  StoredProcedure [dbo].[u_UsersInRoles_RemoveUserFromAllRoles]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[u_UsersInRoles_RemoveUserFromAllRoles]
(
	@UserID INT
)
AS
BEGIN

	DELETE FROM u_UsersInRoles WHERE UserID = @UserID

END
GO
/****** Object:  StoredProcedure [dbo].[u_UsersInRoles_FindUsersInRole]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_UsersInRoles_FindUsersInRole]
@RoleID INT,
@PageIndex INT=1,
@PageSize INT=10,
@RecordCount INT OUT
AS
 WITH tempTable AS
		(
	  SELECT u.* 
	  ,m.[Password]
      ,m.[PasswordFormat]
      ,m.[PasswordSalt]
      ,m.[Email]
      ,m.[LoweredEmail]
      ,m.[PasswordQuestion]
      ,m.[PasswordAnswer]
      ,m.[AccountStatus]
      ,m.[CreateDate]
      ,m.[CreateIP]
      ,m.[LastLoginDate]
      ,m.[LastLoginIP]
      ,m.[LastPasswordChangedDate]
      ,m.[LastLockoutDate]
      ,m.[FailedPasswordAttemptCount]
      ,m.[FailedPasswordAttemptWindowStart]
      ,m.[FailedPasswordAnswerAttemptCount]
      ,m.[FailedPasswordAnswerAttemptWindowStart]
	FROM   u_Users u 
	INNER JOIN u_Membership m ON m.UserID = u.UserID
	INNER JOIN u_UsersInRoles ur ON ur.UserID = u.UserID
	WHERE  ur.[RoleID] = @RoleID
		)

SELECT * FROM
(
		select ROW_NUMBER() over(order by CreateDate  desc) as Row ,* from tempTable

) tmp WHERE Row between (@PageIndex - 1) * @PageSize + 1 and @PageIndex*@PageSize 


Select @RecordCount=COUNT(*) FROM   u_Users u 
INNER JOIN u_Membership m ON m.UserID = u.UserID
INNER JOIN u_UsersInRoles ur ON ur.UserID = u.UserID
WHERE  ur.[RoleID] = @RoleID
GO
/****** Object:  StoredProcedure [dbo].[u_UsersInRoles_AddUserToRoles]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[u_UsersInRoles_AddUserToRoles]
(
	@UserID INT,
	@RoleID INT
)
AS
BEGIN

	IF NOT EXISTS (SELECT UserID FROM u_UsersInRoles WHERE UserID = @UserID AND RoleID = @RoleID)
		INSERT INTO
			u_UsersInRoles
		VALUES
			(@UserID, @RoleID)

END
GO
/****** Object:  StoredProcedure [dbo].[u_User_UpdateLastLogin]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[u_User_UpdateLastLogin]
(
	@UserID INT,
	@LastLoginDate DateTime,
	@LastLoginIP varchar(64)
)
AS
BEGIN
	UPDATE
		u_Membership WITH (ROWLOCK)
	SET 
		LastLoginDate = @LastLoginDate,
		LastLoginIP = @LastLoginIP
	WHERE
		UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[u_UserRoles_Get]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE   procedure [dbo].[u_UserRoles_Get]
(
	@UserID INT = null
)
AS
SET Transaction Isolation Level Read UNCOMMITTED
BEGIN

	-- 如果为null返回所有角色
	IF (@UserID IS NULL)
		SELECT
			RoleID, RoleName as [Name],FriendlyRoleName, Description,RoleType
		FROM
			u_Roles
	ELSE -- 返回该用户的所有Role
		SELECT DISTINCT
			R.RoleID, RoleName as [Name],FriendlyRoleName, Description,RoleType
		FROM 
			u_UsersInRoles U,
			u_Roles R
		WHERE
			U.RoleID = R.RoleID AND
			U.UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[u_User_Update]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_Update]
(
	@UserID INT,
	@Email NVARCHAR(256),
    @LastLoginDate        datetime,
	@LastLoginIP NVARCHAR(32),
    @LastActivityDate     datetime,
	@IsActivated BIT,
	@AccountStatus SMALLINT,
	@IsAnonymous BIT,
	@UniqueEmail	BIT = 1,
	@UniqueNickName BIT = 1,
	--profile
    @RealName NVARCHAR(256),
	@NickName NVARCHAR(256),
	@Gender SMALLINT,
	@Age SMALLINT,
	@Birthday DATETIME,
	@FriendCount INT,
	@HitTimes INT,
	@MobileNo VARCHAR(32),
	@TelNo VARCHAR(32),
	@Fax VARCHAR(32),
	@Address VARCHAR(128),
	@BasicPoints INT,
	@Marriage SMALLINT,
	@TimeZone FLOAT,
	@BloodGroup SMALLINT,
	@ChineseZodiacAnimals SMALLINT,
	@Horoscope SMALLINT,
	@DatabaseQuota int = 102400,
    @DatabaseQuotaUsed int =0,
	@PropertyNames NTEXT,
	@PropertyValues NTEXT	
)	
AS
BEGIN
	DECLARE @LastNickName NVARCHAR(256)

    IF NOT EXISTS( SELECT  UserID FROM u_Users WHERE @UserID = UserID )
    BEGIN
		RETURN 14 --用户不存在
    END

    DECLARE @ReturnValue   int
    SET @ReturnValue = 0

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  u_Membership m WITH ( UPDLOCK, HOLDLOCK )
                    WHERE LoweredEmail = LOWER(@Email) AND UserID <> @UserID))
        BEGIN
            SET @ErrorCode = 4 --Email重复
            GOTO Cleanup
        END
    END
	
    IF (@UniqueNickName = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  u_UserProfile P WITH ( UPDLOCK, HOLDLOCK )
                    WHERE  LoweredNickName = LOWER(@NickName) AND UserID <> @UserID))
        BEGIN
            SET @ErrorCode = 3 -- 昵称重复
            GOTO Cleanup
        END
    END

	SELECT
		@LastNickName = NickName
	FROM
		u_UserProfile (NOLOCK)
	WHERE
		UserID = @UserID

    UPDATE u_Users WITH (ROWLOCK)
    SET
         LastActivityDate = @LastActivityDate,
		 IsActivated=@IsActivated
    WHERE
       @UserID = UserID

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

	UPDATE 
		u_Membership WITH (ROWLOCK)
    SET
         Email            = @Email,
         LoweredEmail     = LOWER(@Email),
         AccountStatus    = @AccountStatus,
         LastLoginDate    = @LastLoginDate,
		 LastLoginIP=@LastLoginIP
    WHERE
       @UserID = UserID

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

	UPDATE
		u_UserProfile WITH (ROWLOCK)
	SET
		RealName=@RealName,
		NickName=@NickName,
		LoweredNickName=LOWER(@NickName),
		Gender=@Gender,
		Age=@Age,
		Birthday=@Birthday,
		FriendCount=@FriendCount,
		HitTimes=@HitTimes,
		MobileNo=@MobileNo,
		TelNo=@TelNo,
		Fax=@Fax,
		[Address]=@Address,
		BasicPoints=@BasicPoints,
		Marriage=@Marriage,
		TimeZone=@TimeZone,
		ChineseZodiacAnimals = @ChineseZodiacAnimals,
		Horoscope = @Horoscope,
		DatabaseQuota = @DatabaseQuota,
        DatabaseQuotaUsed=@DatabaseQuotaUsed,
		PropertyNames=@PropertyNames,
		PropertyValues=@PropertyValues
    WHERE
       @UserID = UserID

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 7 -- 更新成功

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[u_User_Search]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_Search]
(
	@UserName NVARCHAR(256),
	@NickName NVARCHAR(256),
	@Email NVARCHAR(256),
	@RoleID INT,
	@SortUsersBy SMALLINT,
	@BeginDate datetime,
	@EndDate datetime
)
AS
BEGIN
	DECLARE @UserCount INT
	SELECT @UserCount = -1

	CREATE TABLE #UserIds (
		UserID int NOT NULL primary key clustered
	)	

	IF @UserName IS NOT NULL AND @UserName <> '' 
	BEGIN
		INSERT INTO #UserIds
		SELECT UserID FROM u_Users (NOLOCK)
		WHERE (LoweredUsername LIKE '%' + LOWER(@UserName) + '%')

		SELECT @UserCount = COUNT(UserID) FROM #UserIds
	END

	IF @UserCount = 0
	BEGIN
		SELECT UserID FROM #UserIds
		RETURN
	END

	IF @NickName IS NOT NULL AND @NickName <> '' 
	BEGIN
		INSERT INTO #UserIds
		SELECT UserID FROM u_UserProfile P (NOLOCK)
		WHERE(LOWER(NickName) LIKE '%' + LOWER(@NickName) + '%')
			AND (@UserCount = -1 OR UserID NOT IN (SELECT UserID FROM #UserIds))

		SELECT @UserCount = COUNT(UserID) FROM #UserIds
	END

	IF @UserCount = 0
	BEGIN		
		SELECT UserID FROM #UserIds
		RETURN
	END

	IF @Email IS NOT NULL AND @Email <> '' 
	BEGIN
		INSERT INTO  #UserIds
		SELECT UserID FROM u_Membership M (NOLOCK)
		WHERE (LoweredEmail LIKE '%' + LOWER(@Email) + '%')
			AND (@UserCount = -1 OR UserID NOT IN (SELECT UserID FROM #UserIds))

		SELECT @UserCount = COUNT(UserID) FROM #UserIds
	END

	IF @UserCount = 0
	BEGIN
		SELECT UserID FROM #UserIds
		RETURN
	END

	IF @RoleID > 0 AND @RoleID!=1 --@RoleID!=1为了搜索“所有人”(所有用户)这个角色
	BEGIN
		--INSERT INTO  #UserIds --直接返回记录
		SELECT UserID FROM u_UsersInRoles (NOLOCK)
		WHERE RoleID = @RoleID
			AND ((@UserCount = -1) OR UserID NOT IN (SELECT UserID FROM #UserIds))
	END

	IF @UserCount = 0
	BEGIN
		SELECT UserID FROM #UserIds
		RETURN
	END

	IF @BeginDate IS NOT NULL AND @EndDate IS NOT NULL 
	BEGIN
		INSERT INTO #UserIds
		SELECT UserID FROM u_Membership M (NOLOCK)
		WHERE (CreateDate between @BeginDate and @EndDate)
			AND (@UserCount = -1 OR UserID NOT IN (SELECT UserID FROM #UserIds))

		SELECT @UserCount = COUNT(UserID) FROM #UserIds
	END

	IF @UserCount = 0
	BEGIN
		SELECT UserID FROM #UserIds
		RETURN
	END

	IF @UserCount = -1
	BEGIN
		INSERT INTO #UserIds
		SELECT UserID FROM u_Users
	END
/*
        UserName = 0,
        NickName = 1,
        Email = 2,
        CreateDate = 3,
        LastActiveDate = 4,
        Posts = 5,
        RecentPosts = 6
*/
	IF @SortUsersBy = 0
		SELECT U.UserID FROM u_Users U
			JOIN #UserIds T ON U.UserID = T.UserID
		ORDER BY LoweredUsername
    ELSE IF @SortUsersBy = 1
		SELECT
			U.UserID FROM u_UserProfile U
			JOIN #UserIds T ON U.UserID = T.UserID
		ORDER BY LoweredNickName
	 ELSE IF @SortUsersBy = 2
		SELECT M.UserID FROM u_Membership M
			JOIN #UserIds T ON M.UserID = T.UserID
		ORDER BY LoweredEmail
     ELSE IF @SortUsersBy = 3
		SELECT M.UserID FROM u_Membership M
			JOIN #UserIds T ON M.UserID = T.UserID
		ORDER BY CreateDate
	 ELSE IF @SortUsersBy = 4
		SELECT U.UserID FROM u_Users U
			JOIN #UserIds T ON U.UserID = T.UserID
		ORDER BY LastActivityDate
END
GO
/****** Object:  StoredProcedure [dbo].[u_User_Password_Change]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_Password_Change]
(
	@UserID int,
	@PasswordFormat int = 1,
	@NewPassword nvarchar(128),
	@Salt nvarchar(128)
)
AS
BEGIN
	UPDATE
		u_Membership WITH (ROWLOCK)
	SET
		[Password] = @NewPassword,
		PasswordFormat = @PasswordFormat,
		PasswordSalt = @Salt
	WHERE
		UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[u_User_GetPassword]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_GetPassword]
(
    @UserName                       NVARCHAR(256),
    @UpdateLastLoginActivityDate    bit,
    @CurrentTimeUtc                 datetime,
    @LastLoginIP				    NVARCHAR(32)
)
AS
BEGIN
    DECLARE @UserID                             int
    DECLARE @Password                           NVARCHAR(128)
    DECLARE @PasswordSalt                       NVARCHAR(128)
    DECLARE @PasswordFormat                     int
    DECLARE @FailedPasswordAttemptCount         int
    DECLARE @FailedPasswordAnswerAttemptCount   int
    DECLARE @AccountStatus                      SMALLINT
    DECLARE @LastActivityDate                   datetime
    DECLARE @LastLoginDate                      datetime

    SELECT  @UserID          = NULL

    SELECT  @UserID = u.UserID, @Password=Password, @PasswordFormat=PasswordFormat,
            @PasswordSalt=PasswordSalt, @FailedPasswordAttemptCount=FailedPasswordAttemptCount,
		    @FailedPasswordAnswerAttemptCount=FailedPasswordAnswerAttemptCount, @AccountStatus = m.AccountStatus,
            @LastActivityDate = LastActivityDate, @LastLoginDate = LastLoginDate
    FROM    u_Users u, u_Membership m
    WHERE u.UserID = m.UserID AND
            LOWER(@UserName) = u.LoweredUserName

    IF (@UserID IS NULL)
        RETURN 1

    IF (@AccountStatus != 1)  --UserAccountStatuses.Approved = 1
        RETURN 99

    SELECT   @Password, @PasswordFormat, @PasswordSalt, @FailedPasswordAttemptCount,
             @FailedPasswordAnswerAttemptCount, @AccountStatus, @LastLoginDate, @LastActivityDate

    --IF (@UpdateLastLoginActivityDate = 1 AND @AccountStatus = 1) --验证后才能更新相关数据
    --BEGIN
    --    UPDATE  u_Membership
    --    SET     LastLoginDate = @CurrentTimeUtc,
				--LastLoginIP=@LastLoginIP
    --    WHERE   UserID = @UserID

    --    UPDATE  u_Users
    --    SET     LastActivityDate = @CurrentTimeUtc
    --    WHERE   @UserID = UserID
    --END

    RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[u_User_Delete]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_Delete]
    @UserID int
AS
DELETE FROM [u_UsersInRoles] WHERE [UserID] = @UserID
DELETE FROM [u_UserProfile] WHERE [UserID] = @UserID
DELETE FROM [u_Membership] WHERE [UserID] = @UserID
DELETE FROM [u_Users] WHERE [UserID] = @UserID
GO
/****** Object:  StoredProcedure [dbo].[u_User_Create]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_Create]
(
	@UserID INT OUT,
	@MemberID uniqueidentifier = NULL,
	@UserName NVARCHAR(256),
	@Password                               NVARCHAR(128),
	@PasswordFormat                         int      = 0,
	@PasswordSalt                           NVARCHAR(128),
	@NickName NVARCHAR(32),
	@Email NVARCHAR(256),
	@CreateDate                             datetime = NULL,
	@CreateIP                              NVARCHAR(32),
	@CurrentTimeUtc                         datetime,
	@PasswordQuestion                       NVARCHAR(256) = NULL,
	@PasswordAnswer                         NVARCHAR(128) = NULL,
	@IsActivated BIT,
	@AccountStatus SMALLINT,
	@IsAnonymous BIT,

	@RealName                              NVARCHAR(32),
	@MobileNo                              NVARCHAR(32),
	@UniqueEmail	BIT = 1,
	@UniqueNickName BIT = 1
)
AS
BEGIN

	DECLARE @DefaultUserID INT
	SELECT @DefaultUserID = @UserID

	DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SET @CreateDate = @CurrentTimeUtc

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  u_Membership m WITH ( UPDLOCK, HOLDLOCK )
                    WHERE LoweredEmail = LOWER(@Email)))
        BEGIN
            SET @ErrorCode = 4 --Email重复
            GOTO Cleanup
        END
    END
	
    IF (@UniqueNickName = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  u_UserProfile P WITH ( UPDLOCK, HOLDLOCK )
                    WHERE  LoweredNickName = LOWER(@NickName)))
        BEGIN
            SET @ErrorCode = 3 -- 昵称重复
            GOTO Cleanup
        END
    END

    SELECT  @UserID = UserID FROM u_Users WHERE LOWER(@UserName) = LoweredUserName
    IF ( @UserID IS NULL )
    BEGIN

		IF @MemberID IS NULL
			SELECT @MemberID = NEWID()

		INSERT u_Users (UserName, LoweredUserName, IsAnonymous, IsActivated, LastActivityIP, LastActivityDate)
		VALUES (@UserName, LOWER(@UserName), @IsAnonymous, @IsActivated, @CreateIP, @CreateDate)
		SELECT @UserID = SCOPE_IDENTITY()

    END
    ELSE
    BEGIN
        SET @ErrorCode = 2 --用户名重复
        GOTO Cleanup
    END

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF ( EXISTS ( SELECT UserID
                  FROM   u_Membership
                  WHERE  UserID = @UserID ) )
    BEGIN
        SET @ErrorCode = 2 --用户名重复
        GOTO Cleanup
    END

	INSERT INTO 
		u_Membership
	(
		UserID, 
		MemberID,
		Email, 
		LoweredEmail, 
		Password, 
		PasswordFormat, 
		PasswordSalt, 
		PasswordQuestion, 
		PasswordAnswer, 
		AccountStatus,
		CreateDate, 
		CreateIP, 
		LastLoginDate, 
		LastPasswordChangedDate, 
		LastLockoutDate, 
		FailedPasswordAttemptCount, 
		FailedPasswordAttemptWindowStart, 
		FailedPasswordAnswerAttemptCount, 
		FailedPasswordAnswerAttemptWindowStart
	)
	VALUES
	(
		@UserID, 
		@MemberID,
		@Email, 
		LOWER(@Email), 
		@Password, 
		@PasswordFormat, 
		@PasswordSalt, 
		@PasswordQuestion, 
		@PasswordAnswer, 
		@AccountStatus, 
		@CreateDate, 
		@CreateIP, 
		@CreateDate, 
		@CreateDate, 
		@CreateDate, 
		0, 
		CONVERT( datetime, '17540101', 112 ), 
		0, 
		CONVERT( datetime, '17540101', 112 )
	)

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

	INSERT INTO
		u_UserProfile
	(
		UserID,
		RealName,
		NickName,
		LoweredNickName,
		Gender,
		Age,
		Birthday,
		FriendCount,
		HitTimes,
		MobileNo,
		TelNo,
		Fax,
		[Address],
		BasicPoints,
		Marriage,
		TimeZone,
		BloodGroup,
		ChineseZodiacAnimals,
		Horoscope,
		PropertyNames,
		PropertyValues
	)
	VALUES
	(
	    @UserID,
		@RealName,
		@NickName,
		LOWER(@NickName),
		0, --Gender,
		0,--Age,
		CONVERT( datetime, '17540101', 112 ), -- Birthday
		0,--FriendCount,
		0,--HitTimes,
		@MobileNo,
		'', -- TelNo
		'', -- Fax
		'', -- Address
		0,--BasicPoints,
		0,--Marriage,
		8, -- TimeZone
		0,--BloodGroup,
		0,--ChineseZodiacAnimals,
		0,--Horoscope,
		'', --PropertyNames
		''--PropertyValues
	)

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 1

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END
GO
/****** Object:  StoredProcedure [dbo].[u_User_ChangePassword]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_User_ChangePassword]
(
	@UserID int,
	@PasswordFormat int = 1,
	@NewPassword NVARCHAR(128),
	@Salt NVARCHAR(128)
)
AS
BEGIN
	UPDATE
		u_Membership WITH (ROWLOCK)
	SET
		[Password] = @NewPassword,
		PasswordFormat = @PasswordFormat,
		PasswordSalt = @Salt
	WHERE
		UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[u_RolePermissions_GetUserPermissions]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_RolePermissions_GetUserPermissions]
	@UserID INT
AS
  SELECT rp.RoleID,
         r.RoleName,
		 r.FriendlyRoleName,
         r.RoleType,
         rp.AllowMask,
         rp.DenyMask
  FROM   u_UsersInRoles ur
         INNER JOIN [u_Roles] r ON ur.RoleID = r.RoleID
         INNER JOIN u_RolePermissions rp ON r.RoleID = rp.RoleID
  WHERE  ur.UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[u_Role_Delete]    Script Date: 01/07/2013 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[u_Role_Delete]
(
	@RoleID INT
)
AS
  --删除该角色相关的所有权限信息
  DELETE FROM u_RolePermissions WHERE  [RoleID] = @RoleID
  --删除用户角色表中的相关记录
  DELETE FROM u_UsersInRoles WHERE [RoleID] = @RoleID
  --最后删除该角色
  DELETE FROM [u_Roles] WHERE [RoleID] = @RoleID
GO
/****** Object:  StoredProcedure [dbo].[App_Users_Get]    Script Date: 01/07/2013 22:11:29 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[App_Users_Get]
(
	@UserID INT
)
AS
BEGIN
	SELECT * FROM u_Users u with (nolock) INNER JOIN u_Membership m ON m.UserID = u.UserID INNER JOIN u_UserProfile up ON up.UserID = u.UserID INNER JOIN App_Users au ON au.UserID = u.UserID WHERE au.UserID = @UserID

END
GO
/****** Object:  Default [DF__l_Company__Creat__59FA5E80]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[l_Company] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
/****** Object:  Default [s_EventLog_EventDate]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_EventLog] ADD  CONSTRAINT [s_EventLog_EventDate]  DEFAULT (getdate()) FOR [EventDate]
GO
/****** Object:  Default [DF_s_EventLog_MachineName]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_EventLog] ADD  CONSTRAINT [DF_s_EventLog_MachineName]  DEFAULT ('') FOR [MachineName]
GO
/****** Object:  Default [DF_s_Exceptions_MachineName]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_Exceptions] ADD  CONSTRAINT [DF_s_Exceptions_MachineName]  DEFAULT ('') FOR [MachineName]
GO
/****** Object:  Default [DF_s_Exceptions_DateCreated]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_Exceptions] ADD  CONSTRAINT [DF_s_Exceptions_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_s_Exceptions_Frequency]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_Exceptions] ADD  CONSTRAINT [DF_s_Exceptions_Frequency]  DEFAULT ((0)) FOR [Frequency]
GO
/****** Object:  Default [DF_s_Exceptions_HttpNotFound_DateCreated]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_Exceptions_HttpNotFound] ADD  CONSTRAINT [DF_s_Exceptions_HttpNotFound_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_s_Exceptions_HttpNotFound_MachineName]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_Exceptions_HttpNotFound] ADD  CONSTRAINT [DF_s_Exceptions_HttpNotFound_MachineName]  DEFAULT ('') FOR [MachineName]
GO
/****** Object:  Default [DF_s_Exceptions_HttpNotFound_Frequency]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[s_Exceptions_HttpNotFound] ADD  CONSTRAINT [DF_s_Exceptions_HttpNotFound_Frequency]  DEFAULT ((0)) FOR [Frequency]
GO
/****** Object:  Default [DF__u_Members__Creat__628FA481]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Membership] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
/****** Object:  Default [DF__u_Members__Creat__6383C8BA]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Membership] ADD  DEFAULT (N'000.000.000.000') FOR [CreateIP]
GO
/****** Object:  Default [DF__u_Members__Accou__6477ECF3]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Membership] ADD  DEFAULT ((1)) FOR [AccountStatus]
GO
/****** Object:  Default [DF__u_Members__Passw__656C112C]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Membership] ADD  DEFAULT ((0)) FOR [PasswordFormat]
GO
/****** Object:  Default [DF__u_UserPro__RealN__66603565]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [RealName]
GO
/****** Object:  Default [DF__u_UserPro__NickN__6754599E]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [NickName]
GO
/****** Object:  Default [DF__u_UserPro__Lower__68487DD7]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [LoweredNickName]
GO
/****** Object:  Default [DF__u_UserPro__Gende__693CA210]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [Gender]
GO
/****** Object:  Default [DF__u_UserProfi__Age__6A30C649]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [Age]
GO
/****** Object:  Default [DF__u_UserPro__Frien__6B24EA82]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [FriendCount]
GO
/****** Object:  Default [DF__u_UserPro__HitTi__6C190EBB]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [HitTimes]
GO
/****** Object:  Default [DF__u_UserPro__Mobil__6D0D32F4]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [MobileNo]
GO
/****** Object:  Default [DF__u_UserPro__TelNo__6E01572D]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [TelNo]
GO
/****** Object:  Default [DF__u_UserProfi__Fax__6EF57B66]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [Fax]
GO
/****** Object:  Default [DF__u_UserPro__Addre__6FE99F9F]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [Address]
GO
/****** Object:  Default [DF__u_UserPro__Basic__70DDC3D8]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [BasicPoints]
GO
/****** Object:  Default [DF__u_UserPro__Marri__71D1E811]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [Marriage]
GO
/****** Object:  Default [DF_u_UserProfile_TimeZone]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  CONSTRAINT [DF_u_UserProfile_TimeZone]  DEFAULT ((8)) FOR [TimeZone]
GO
/****** Object:  Default [DF_u_UserProfile_BloodType]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  CONSTRAINT [DF_u_UserProfile_BloodType]  DEFAULT ((0)) FOR [BloodGroup]
GO
/****** Object:  Default [DF_u_UserProfile_ChineseZodiacAnimals]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  CONSTRAINT [DF_u_UserProfile_ChineseZodiacAnimals]  DEFAULT ((0)) FOR [ChineseZodiacAnimals]
GO
/****** Object:  Default [DF_u_UserProfile_Horoscope]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  CONSTRAINT [DF_u_UserProfile_Horoscope]  DEFAULT ((0)) FOR [Horoscope]
GO
/****** Object:  Default [DF__u_UserPro__Datab__76969D2E]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [DatabaseQuota]
GO
/****** Object:  Default [DF__u_UserPro__Datab__778AC167]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ((0)) FOR [DatabaseQuotaUsed]
GO
/****** Object:  Default [DF__u_UserPro__Prope__787EE5A0]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [PropertyNames]
GO
/****** Object:  Default [DF__u_UserPro__Prope__797309D9]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile] ADD  DEFAULT ('') FOR [PropertyValues]
GO
/****** Object:  Default [DF__u_Users__IsAnony__7A672E12]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Users] ADD  DEFAULT ((0)) FOR [IsAnonymous]
GO
/****** Object:  Default [DF__u_Users__LastAct__7B5B524B]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Users] ADD  DEFAULT (N'000.000.000.000') FOR [LastActivityIP]
GO
/****** Object:  Default [DF__u_Users__LastAct__7C4F7684]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Users] ADD  DEFAULT (getdate()) FOR [LastActivityDate]
GO
/****** Object:  Default [DF_u_Users_IsActivated]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Users] ADD  CONSTRAINT [DF_u_Users_IsActivated]  DEFAULT ((0)) FOR [IsActivated]
GO
/****** Object:  ForeignKey [FK_u_Membership_u_Users]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_Membership]  WITH CHECK ADD  CONSTRAINT [FK_u_Membership_u_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[u_Users] ([UserID])
GO
ALTER TABLE [dbo].[u_Membership] CHECK CONSTRAINT [FK_u_Membership_u_Users]
GO
/****** Object:  ForeignKey [FK_u_UserProfile_u_Users]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_u_UserProfile_u_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[u_Users] ([UserID])
GO
ALTER TABLE [dbo].[u_UserProfile] CHECK CONSTRAINT [FK_u_UserProfile_u_Users]
GO
/****** Object:  ForeignKey [FK_u_UsersInRoles_u_Roles]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [FK_u_UsersInRoles_u_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[u_Roles] ([RoleID])
GO
ALTER TABLE [dbo].[u_UsersInRoles] CHECK CONSTRAINT [FK_u_UsersInRoles_u_Roles]
GO
/****** Object:  ForeignKey [FK_u_UsersInRoles_u_Users]    Script Date: 01/07/2013 22:11:18 ******/
ALTER TABLE [dbo].[u_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [FK_u_UsersInRoles_u_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[u_Users] ([UserID])
GO
ALTER TABLE [dbo].[u_UsersInRoles] CHECK CONSTRAINT [FK_u_UsersInRoles_u_Users]
GO
