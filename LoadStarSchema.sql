USE BIClass
GO



DROP PROCEDURE IF EXISTS [Project2].[LoadStarSchema]
GO

CREATE SCHEMA [Process];
GO
CREATE SCHEMA [Project2];
GO
CREATE SCHEMA [DbSecurity];
GO


CREATE PROCEDURE [Project2].[LoadStarSchema]

-- Loads the appropriate key into the procedures done by a particular group member
    @GroupMemberUserAuthorizationKeyOne INT,
    @GroupMemberUserAuthorizationKeyTwo INT,
    @GroupMemberUserAuthorizationKeyThree INT
AS
BEGIN

    -- Create Sequence Object for the Process.WorkFlow Table
    EXEC [Project2].[usp_WorkFlowStepCounter]

    -- Creates the Work Flow Table to track the Project Tasks
    EXEC [Project2].[CreateWorkFlowStepsTable] @GroupMemberUserAuthorizationKey = 1;

    SELECT * FROM [Process].[WorkFlowSteps];

    -- Creates the TrackWorkFLow procedure to help insert into the WorkFlowSteps table
    EXEC [Process].[usp_TrackWorkFlow] @GroupMemberUserAuthorizationKey = 1, @WorkFlowStepDescription = 'Created the Process.usp_TrackWorkFlow Procedure'

    -- Creates the UserAuthTable to store the group members in Project2
    EXEC [Project2].[CreateUserAuthtable] @GroupMemberUserAuthorization = 1;

    -- SELECT * FROM DbSecurity.[UserAuthorization];

    -- Add the necessary columns to all tables
    EXEC [Project2].[Add_UserAuth_DateAdded_DateOfLastUpdated_ToAllTables] @GroupMemberUserAuthorizationKey = 1;

    SELECT * FROM Process.WorkFlowSteps;

    -- Drops all foreign keys in Fact.Data table
    EXEC [Project2].[DropAllForeignKeys] @UserAuthorizationKey = 1;

    -- Counts all rows in every table
    EXEC [Project2].[usp_CountTableRows] @UserAuthorizationKey = 1;

    -- Truncate all tables
    EXEC [Project2].[TruncateAllTables] @UserAuthorizationKey = 1;

    -- Creates sequence objects for DimCustomer, DimOccupation, DimProduct, DimTerritory, SalesManagers, Data tables
    EXEC [Project2].[CreateSequenceKeysForTables] @UserAuthorizationKey = 1;

    -- Alter the DimCustomer, DimOccupation, DimProduct, DimTerritory, SalesManagers, Data tables to allow sequence objects
    EXEC [Project2].[AlterTableIdentityKeystoSequenceObjects] @UserAuthorizationKey = 1;

    -- Load each tables data into the appropriate table
    EXEC [Project2].[LoadDimCustomer] @UserAuthorizationKey = 1;

    SELECT * FROM [CH01-01-Dimension].[DimCustomer];


