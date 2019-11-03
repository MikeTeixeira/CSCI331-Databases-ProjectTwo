USE BIClass;
GO



-- ---------------------------------------------------------------------- MICHAEL SECTION ------------------------------------------------------------------------

/*
-- Create a new table DbSecurity.UserAuthorization in this project to add the following columns
• UserAuthorizationKey INT NOT NULL, -- primary key
• ClassTime nchar(5) Null Default either (‘7:45’ or ‘9:15’)
• Individual project nvarchar (60) null default(‘PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA’)
• GroupMemberLastName nvarchar(35) NOT NULL,
• GroupMemberFirstName nvarchar(25) NOT NULL,
• GroupName nvarchar(20) NOT NULL,
• DateAdded datetime2 null default sysdatetime()
*/


-- Drops the existing schema if exists. Followed by a newly created schema
-- ** COMMENT THIS OUT ONCE IT'S CREATED TO AVOID ERRORS
IF EXISTS(SELECT name FROM sys.schemas WHERE name LIKE 'DbSecurity')
    BEGIN 
        PRINT 'Dropping schema if exists'
        DROP SCHEMA [DbSecurity]
    END
GO

PRINT 'Creating Database Schema ---- DbSecurity'

GO
CREATE SCHEMA [DbSecurity]
GO



-- Michael Task One
CREATE TABLE DbSecurity.UserAuthorization(
    UserAuthorizationKey INT NOT NULL PRIMARY KEY,
    ClassTime NCHAR(5) NOT NULL DEFAULT('9:15'),
    IndividualProject NVARCHAR(60) NOT NULL DEFAULT('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),
    GroupMemberLastName NVARCHAR(35) NOT NULL,
    GroupMemberFirstName NVARCHAR(25) NOT NULL,
    GroupName NVARCHAR(20) NOT NULL,
    DateAdded DATETIME2 NOT NULL DEFAULT SYSDATETIME()
)


-- Michael Task Three

/*
Create the table Process.WorkflowSteps table with the following columns
• WorkFlowStepKey INT NOT NULL, -- primary key
• WorkFlowStepDescription NVARCHAR(100) NOT NULL,
• WorkFlowStepTableRowCount INT NULL DEFAULT (0),
• StartingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,
• EndingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,
• ClassTime CHAR(5) NULL DEFAULT ('07:45' OR '09:15' OR '10:45'),
• UserAuthorizationKey INT NOT NULL 
*/

-- Drops the existing schema if exists. Followed by a newly created schema
-- ** COMMENT THIS OUT ONCE IT'S CREATED TO AVOID ERRORS
IF EXISTS(SELECT name FROM sys.schemas WHERE name LIKE 'Process')
    BEGIN 
        PRINT 'Dropping schema if exists'
        DROP SCHEMA [Process]
    END
GO

PRINT 'Creating Database Schema ---- Process'

GO
CREATE SCHEMA [Process]
GO


CREATE TABLE Process.WorkFlowSteps (
    WorkFlowStepKey INT NOT NULL PRIMARY KEY,
    WorkFlowStepDescription NVARCHAR(100) NOT NULL,
    WorkFlowStepTableRowCount INT NULL DEFAULT (0),
    StartingDateTime DATETIME2(7) NULL DEFAULT(SYSDATETIME()),
    EndingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()),
    ClassTime CHAR(5) NULL DEFAULT ('09:15'),
    UserAuthorizationKey INT NOT NULL
)


-- DOCUMENTING YOUR STORED PROCEDURES
/*
-- =============================================
-- Author: Your Name
-- Procedure: Your stored procedure name
-- Create date: The date
-- Description: Define the actions of the stored procedure
-- =============================================
*/





-- ---------------------------------------------------------------------- ERIC SECTION ------------------------------------------------------------------------





-- ---------------------------------------------------------------------- KEN SECTION ------------------------------------------------------------------------

