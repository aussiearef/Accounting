USE [master]
GO

/****** Object:  Database [PersonalPhotos]    Script Date: 26/04/2018 10:07:29 PM ******/
CREATE DATABASE [PersonalPhotos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PersonalPhotos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PersonalPhotos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PersonalPhotos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PersonalPhotos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [PersonalPhotos] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PersonalPhotos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PersonalPhotos] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PersonalPhotos] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PersonalPhotos] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PersonalPhotos] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PersonalPhotos] SET ARITHABORT OFF 
GO

ALTER DATABASE [PersonalPhotos] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PersonalPhotos] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PersonalPhotos] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PersonalPhotos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PersonalPhotos] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PersonalPhotos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PersonalPhotos] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PersonalPhotos] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PersonalPhotos] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PersonalPhotos] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PersonalPhotos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PersonalPhotos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PersonalPhotos] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PersonalPhotos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PersonalPhotos] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PersonalPhotos] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PersonalPhotos] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PersonalPhotos] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [PersonalPhotos] SET  MULTI_USER 
GO

ALTER DATABASE [PersonalPhotos] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PersonalPhotos] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PersonalPhotos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PersonalPhotos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [PersonalPhotos] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PersonalPhotos] SET QUERY_STORE = OFF
GO

USE [PersonalPhotos]
GO

ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [PersonalPhotos] SET  READ_WRITE 
GO

USE [PersonalPhotos]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 26/04/2018 10:09:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [PersonalPhotos]
GO

/****** Object:  Table [dbo].[Photos]    Script Date: 26/04/2018 10:09:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Photos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Description] [varchar](max) NULL,
	[FileName] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Photos]  WITH CHECK ADD  CONSTRAINT [FK_Photos_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Photos] CHECK CONSTRAINT [FK_Photos_Users]
GO

USE [PersonalPhotos]
GO

/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 26/04/2018 10:09:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[CreateUser]
@Email varchar(100),
@Password varchar(100)
AS
	Insert Into Users (Email, [Password])
	values (@Email, @Password)
GO


USE [PersonalPhotos]
GO

/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 26/04/2018 10:09:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[GetUser]
@Email varchar(100)
AS
	Select * from Users
	Where Email = @Email;
GO

USE [PersonalPhotos]
GO

/****** Object:  StoredProcedure [dbo].[GetUserPhotos]    Script Date: 26/04/2018 10:09:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[GetUserPhotos]
	@UserName varchar(100)
As
	Declare @UserId int
	Select @UserId = Id
	From Users
	Where lower(Email) = lower(@UserName);

	if (@UserId is not null)
	Begin
		Select * 
		From Photos	
		Where UserId = @UserId;
	End;
GO


USE [PersonalPhotos]
GO

/****** Object:  StoredProcedure [dbo].[GetUserPhotos]    Script Date: 26/04/2018 10:10:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[GetUserPhotos]
	@UserName varchar(100)
As
	Declare @UserId int
	Select @UserId = Id
	From Users
	Where lower(Email) = lower(@UserName);

	if (@UserId is not null)
	Begin
		Select * 
		From Photos	
		Where UserId = @UserId;
	End;
GO
USE [PersonalPhotos]
GO

/****** Object:  StoredProcedure [dbo].[SaveMetaData]    Script Date: 26/04/2018 10:10:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[SaveMetaData]
	@UserName varchar(100),
	@Description varchar(max),
	@FileName varchar(100)
As

declare @userId int

select @userId = Id 
from Users
where LTRIM(rtrim(lower(email))) = ltrim(rtrim(lower(@UserName)))

if @userId is not null
begin
	insert into Photos
	(UserId, [Description], [FileName])
	values (@userId, @Description, @FileName)
end
GO





