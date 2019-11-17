USE BIClass
GO



DROP PROCEDURE IF EXISTS [Project2].[LoadStarSchema]
GO



CREATE PROCEDURE [Project2].[LoadStarSchema]

AS
BEGIN

    -- Create Sequence Object for the Process.WorkFlow Table
    EXEC [Project2].[usp_WorkFlowStepCounter]

    -- Creates the Work Flow Table to track the Project Tasks
    EXEC [Project2].[CreateWorkFlowStepsTable] @GroupMemberUserAuthorizationKey = 1;

    -- Creates the TrackWorkFLow procedure to help insert into the WorkFlowSteps table
    EXEC [Process].[usp_TrackWorkFlow] @GroupMemberUserAuthorizationKey = 1, @WorkFlowStepDescription = 'Created the Process.usp_TrackWorkFlow Procedure'

    -- Creates the UserAuthTable to store the group members in Project2
    EXEC [Project2].[CreateUserAuthtable] @GroupMemberUserAuthorization = 1;


    -- Drops all foreign keys in Fact.Data table
    EXEC [Project2].[DropAllForeignKeys] @UserAuthorizationKey = 1;

    -- Counts all rows in every table
    EXEC [Project2].[usp_CountTableRows] @UserAuthorizationKey = 1;

    -- Truncate all tables
    EXEC [Project2].[TruncateAllTables] @UserAuthorizationKey = 1;

    -- Creates sequence objects for DimCustomer, DimOccupation, DimProduct, DimTerritory, SalesManagers, Data tables
    EXEC [Project2].[CreateSequenceKeysForTables] @UserAuthorizationKey = 2;

    -- Alter the DimCustomer, DimOccupation, DimProduct, DimTerritory, SalesManagers, Data tables to allow sequence objects
    EXEC [Project2].[AlterTableIdentityKeystoSequenceObjects] @UserAuthorizationKey = 2;

    -- Load each tables data into the appropriate table
    EXEC [Project2].[LoadDimCustomer] @UserAuthorizationKey = 2;
    EXEC [Project2].[LoadDimMaritalStatus] @UserAuthorizationKey = 2;
    EXEC [Project2].[LoadDimGender] @UserAuthorizationKey = 2;
    EXEC [Project2].[LoadDimOccupation] @UserAuthorizationKey = 3;
    EXEC [Project2].[LoadDimOrderDate] @UserAuthorizationKey = 3;
    EXEC [Project2].[LoadDimTerritory] @UserAuthorizationKey = 3;
    EXEC [Project2].[LoadSalesManagers] @UserAuthorizationKey = 3;  

    -- Create the relationship for the DimProduct, DimProductSubcategory, DimProductCategory and load data
    EXEC [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData] @UserAuthorizationKey = 1;


    EXEC [Project2].[LoadData] @UserAuthorizationKey = 2;

    -- Count the number of rows after adding the data to each table
    EXEC [Project2].[usp_CountTableRows] @UserAuthorizationKey = 1;



    --  Setup all of the Foreign Key relationships
    EXEC [Project2].[AddForeignKeysToNewlyModifiedTables] @UserAuthorizationKey = 3;

END
GO


exec [Project2].[LoadStarSchema]
-- GO


SELECT * FROM [Process].[WorkFlowSteps];







        


