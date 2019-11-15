USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[CreateUserAuthtable]
-- Create date: November 7th, 2019
-- Description: Creates the DbSecurity.UserAuthTable
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[CreateUserAuthtable]
GO

CREATE PROCEDURE [Project2].[CreateUserAuthtable]

    @GroupMemberUserAuthorization INT

AS 
BEGIN

    SET NOCOUNT ON;

    DROP TABLE IF EXISTS [DbSecurity].[UserAuthorization];

    CREATE TABLE [DbSecurity].[UserAuthorization](
        UserAuthorizationKey INT NOT NULL, -- Primary Key
        ClassTime nchar(5) Null DEFAULT('9:15'),
        IndividualProject  nvarchar (60) null default('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),
        GroupMemberLastName nvarchar(35) NOT NULL,
        GroupMemberFirstName nvarchar(25) NOT NULL,
        GroupName nvarchar(20) NOT NULL DEFAULT('G_Kenley'),
        DateAdded datetime2 null default sysdatetime(),
        CONSTRAINT PK_UserAuthKey PRIMARY KEY(UserAuthorizationKey)

    )

    INSERT INTO [DbSecurity].[UserAuthorization](UserAuthorizationKey, GroupMemberLastName,GroupMemberFirstName)
    VALUES (@GroupMemberUserAuthorization, 'Teixeira', 'Michael'),
            (2, 'Nicolas', 'Kenley'),
            (3, 'Yin', 'Eric')

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = 1, @WorkFlowStepDescription = 'Created the DBSecurity.UserAuthTable';

END
GO
