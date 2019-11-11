USE BiClass
GO



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[CreateUserAuthtable]
-- Create date: November 7th, 2019
-- Description: Adds the UserAuthorizationKey, DateAdded, DateOfLastUpdate columns to the tables
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[Add_UserAuth_DateAdded_DateOfLastUpdated_ToAllTables];
GO

CREATE PROCEDURE [Project2].[Add_UserAuth_DateAdded_DateOfLastUpdated_ToAllTables]

    @GroupMemberUserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    ALTER TABLE [CH01-01-Dimension].[DimCustomer]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimGender]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())


    ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimOccupation]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimOrderDate]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())


    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimTerritory]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())


    ALTER TABLE [CH01-01-Dimension].[SalesManagers]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Fact].[Data]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    
    EXEC [Process].[usp_TrackWorkFlow] @GroupMemberUserAuthorizationKey = 1, @WorkFlowStepDescription = 'Added the UserAuthKey, DateAdded, DateOfLastupdate to all tables';


END
-- GO

-- -- Execute the given procedure
-- EXEC [Project2].[Add_UserAuth_DateAdded_DateOfLastUpdated_ToAllTables] @GroupMemberUserAuthorizationKey = 1;
-- GO

-- -- check to see if the columns were added
-- SELECT * FROM [CH01-01-Dimension].[SalesManagers];