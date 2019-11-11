USE BIClass
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [Project2].[DropAllForeignKeys];
GO

CREATE PROCEDURE [Project2].[DropAllForeignKeys]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimCustomer;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimGender;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimMaritalStatus;  

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimOccupation;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimOrderDate;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimProduct;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimTerritory;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_SalesManagers;

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = 1, @WorkFlowStepDescription = 'Dropped all Foreign Keys from Fact.Data table.'

END
