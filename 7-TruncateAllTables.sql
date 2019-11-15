USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[usp_CountTableRows]
-- Create date: November 6th, 2019
-- Description: Truncates all the tables in BiClass besides the FileUpad.LoadOriginalData Table
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[TruncateAllTables]
GO


CREATE PROCEDURE [Project2].[TruncateAllTables]

    @UserAuthorizationKey INT

AS
BEGIN

    TRUNCATE TABLE [CH01-01-Dimension].[DimCustomer];
    TRUNCATE TABLE [CH01-01-Dimension].[DimGender];
    TRUNCATE TABLE [CH01-01-Dimension].[DimMaritalStatus];
    TRUNCATE TABLE [CH01-01-Dimension].[DimOccupation];
    TRUNCATE TABLE [CH01-01-Dimension].[DimOrderDate];
    TRUNCATE TABLE [CH01-01-Dimension].[DimProduct];
    TRUNCATE TABLE [CH01-01-Dimension].[DimTerritory];
    TRUNCATE TABLE [CH01-01-Dimension].[SalesManagers];
    TRUNCATE TABLE [CH01-01-Fact].[Data];

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Truncated all old tables';

END
GO
