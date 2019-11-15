USE BIClass
GO


-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[usp_CountTableRows]
-- Create date: November 6th, 2019
-- Description: Counts all the rows in every table besides the file upload table
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[usp_CountTableRows]
GO

CREATE PROCEDURE [Project2].[usp_CountTableRows]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    (SELECT 'DimCustomer' AS [Table Name], COUNT(*) AS TotalNumberOfRows FROM [CH01-01-Dimension].[DimCustomer]
    UNION ALL
    SELECT 'DimGender', COUNT(*) FROM [CH01-01-Dimension].[DimGender]
    UNION ALL
    SELECT 'DimMaritalStatus', COUNT(*) FROM [CH01-01-Dimension].[DimMaritalStatus]
    UNION ALL
    SELECT 'DimOccupation', COUNT(*) FROM [CH01-01-Dimension].[DimOccupation]
    UNION ALL
    SELECT 'DimOrderDate', COUNT(*) FROM [CH01-01-Dimension].[DimOrderDate]
    UNION ALL
    SELECT 'DimProduct', COUNT(*) FROM [CH01-01-Dimension].[DimProduct]
    UNION ALL
    SELECT 'DimTerritory', COUNT(*) FROM [CH01-01-Dimension].[DimTerritory]
    UNION ALL
    SELECT 'SalesManagers', COUNT(*) FROM [CH01-01-Dimension].[SalesManagers]
    UNION ALL
    SELECT 'FactData', COUNT(*) FROM [CH01-01-Fact].[Data]);

   
   EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Displaying all the row counts of all the old tables.'


END
GO