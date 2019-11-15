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


    ALTER TABLE [CH01-01-Dimension].[DimCustomer]
    DROP CONSTRAINT 
        DF__DimCustom__DateO__245D67DE   

    ALTER TABLE [CH01-01-Dimension].[DimCustomer]
    DROP COLUMN UserAuthorizationKey, 
        DateAdded,
        DateOfLastUpdate

    SET NOCOUNT ON;

    ALTER TABLE [CH01-01-Dimension].[DimCustomer]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimGender]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())


    ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimOccupation]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimOrderDate]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1-99,
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())


    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Dimension].[DimTerritory]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())


    ALTER TABLE [CH01-01-Dimension].[SalesManagers]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(-99),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    ALTER TABLE [CH01-01-Fact].[Data]
    ADD UserAuthorizationKey INT NOT NULL DEFAULT(1),
        DateAdded datetime2 null DEFAULT(sysdatetime()),
        DateOfLastUpdate datetime2 null DEFAULT(sysdatetime())

    
    EXEC [Process].[usp_TrackWorkFlow] @GroupMemberUserAuthorizationKey = 1, @WorkFlowStepDescription = 'Added the UserAuthKey, DateAdded, DateOfLastupdate to all tables';


END
GO