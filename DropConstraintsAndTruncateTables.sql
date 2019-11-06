USE BIClass
GO

/* --------------------------------------------- CREATE TABLE DbSecurity.UserAuthorizationKey ------------------------------------------------ */

-- CREATE the DbSecurity.UserAuthorization table to help track the work flow of the project
-- Before creating, first make the schema since it is not created in the database


CREATE SCHEMA DbSecurity;
GO

ALTER TABLE Process.WorkFlowSteps
DROP CONSTRAINT FK_UserAuthorizationKey

DROP TABLE IF EXISTS DbSecurity.UserAuthorization;


CREATE TABLE DbSecurity.UserAuthorization(
    UserAuthorizationKey INT NOT NULL PRIMARY KEY, 
    ClassTime nchar(5) NULL DEFAULT('9:15'),
    IndividualProject nvarchar (60) null default('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),
    GroupMemberLastName nvarchar(35) NOT NULL,
    GroupMemberFirstName nvarchar(25) NOT NULL,
    GroupName nvarchar(20) NOT NULL,
    DateAdded datetime2 null default sysdatetime()
)
GO

-- Insert group member into DB

EXEC [Project2].[InsertGroupMembersIntoUserAuthorization];

SELECT * FROM DbSecurity.UserAuthorization;


/* --------------------------------------------- CREATE TABLE Process.WorkflowSteps  ------------------------------------------------ */

-- Create the Process.WorkFlowSteps table to help track the work flow of the project
-- Before creating, first make the schema since it is not created in the database

-- CREATE SCHEMA [Process];

DROP TABLE IF EXISTS [Process].[WorkFlowSteps]

GO
CREATE TABLE Process.WorkFlowSteps(
    WorkFlowStepKey INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- PK that auto increments
    WorkFlowStepDescription NVARCHAR(100) NOT NULL, -- Desceribes the work that was done
    WorkFlowStepTableRowCount INT NULL DEFAULT (0), -- Index in the table
    StartingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) , -- Time that the workflow process started
    EndingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,-- Time that the workflow process ended
    ClassTime CHAR(5) NULL DEFAULT('09:15'), 
    UserAuthorizationKey INT NOT NULL,
    CONSTRAINT FK_UserAuthorizationKey FOREIGN KEY(UserAuthorizationKey)
    REFERENCES DbSecurity.UserAuthorization(UserAuthorizationKey)
)


/* --------------------------------------------- CREATE PROCEDURE Process.usp_TrackWorkFlow  ------------------------------------------------ */

-- This Procedure is used to help track the work flow of the entire project by providing in the userid, a small description of what was done,
-- the time it was started and done, and the row count

GO
CREATE PROCEDURE [Process].[usp_TrackWorkFlow]
    @WorkFlowDescription NVARCHAR(100), 
    @WorkFlowStepTableRowCount int, 
    @UserAuthorizationKey int
AS
BEGIN
    INSERT INTO [Process].[WorkFlowSteps](WorkFlowStepDescription, WorkFlowStepTableRowCount, UserAuthorizationKey)
    VALUES(@WorkFlowDescription, @WorkFlowStepTableRowCount, @UserAuthorizationKey)

END



-- REMOVE ALL THE CONSTRAINTS TO TRUNCATE ALL THE TABLES

/* Must first drop the constraints in the Fact.Data table since it's using all of the keys from the other tables */

ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimCustomer


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimGender


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimMaritalStatus


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimOccupation


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimOrderDate


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimTerritory


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_DimProduct


ALTER TABLE [CH01-01-Fact].[Data] 
DROP CONSTRAINT FK_Data_SalesManagers



/* DROP THE CONSTRAINTS IN THE INDIVIDUAL TABLES */


ALTER TABLE [CH01-01-Dimension].[DimCustomer] 
DROP CONSTRAINT PK__DimCusto__95011E6452BCF41C


ALTER TABLE [CH01-01-Dimension].[DimGender] 
DROP CONSTRAINT PK_DimGender


ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] 
DROP CONSTRAINT PK_DimMaritalStatus


ALTER TABLE [CH01-01-Dimension].[DimOccupation] 
DROP CONSTRAINT PK_DimOccupation


ALTER TABLE [CH01-01-Dimension].[DimOrderDate] 
DROP CONSTRAINT PK_DimOrderDate_1


ALTER TABLE [CH01-01-Dimension].[DimProduct] 
DROP CONSTRAINT PK__DimProdu__A15E99B3E27177EF


ALTER TABLE [CH01-01-Dimension].[DimTerritory] 
DROP CONSTRAINT PK__DimTerri__C54B735D813BBCA6



/* TRUNCATE all of the tables */

TRUNCATE TABLE [CH01-01-Dimension].[DimCustomer];
TRUNCATE TABLE [CH01-01-Dimension].[DimGender];
TRUNCATE TABLE [CH01-01-Dimension].[DimMaritalStatus];
TRUNCATE TABLE [CH01-01-Dimension].[DimOccupation];
TRUNCATE TABLE [CH01-01-Dimension].[DimOrderDate];
TRUNCATE TABLE [CH01-01-Dimension].[DimProduct];
TRUNCATE TABLE [CH01-01-Dimension].[DimTerritory];
TRUNCATE TABLE [CH01-01-Dimension].[SalesManagers];
TRUNCATE TABLE [CH01-01-Fact].[Data];


/* check to see if any data is currently in the old tables */
SELECT * FROM [CH01-01-Dimension].[DimCustomer];
SELECT * FROM [CH01-01-Dimension].[DimGender];
SELECT * FROM [CH01-01-Dimension].[DimMaritalStatus];
SELECT * FROM [CH01-01-Dimension].[DimOccupation];
SELECT * FROM [CH01-01-Dimension].[DimOrderDate];
SELECT * FROM [CH01-01-Dimension].[DimProduct];
SELECT * FROM [CH01-01-Dimension].[DimTerritory];
SELECT * FROM [CH01-01-Fact].[Data];


