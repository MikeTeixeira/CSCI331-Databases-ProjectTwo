USE BIClass;
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimTerritory]
-- Create date: November 8th, 2019 
-- Description: Loads the SalesManagers data from the FileUpload.OriginallyLoadedData 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[LoadSalesManagers]
GO

CREATE PROCEDURE [Project2].[LoadSalesManagers]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[LoadDiSalesManagers] (SalesManagerKey, Category, SalesManager, Office, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[SalesManagersSequenceKeys] AS SalesManagerKey,
        ProductCategory AS Category,
        SalesManager,
        Office = 
                CASE
                    WHEN SalesManager LIKE N'Maurizio%' OR SalesManager LIKE N'Marco%' THEN 'Redmond'
                    WHEN SalesManager LIKE N'Alberto%' OR SalesManager LIKE N'Luis%' THEN 'Seattle'
                END,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT ProductCategory, SalesManager FROM  FileUpload.OriginallyLoadedData) AS S;

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimTerritory Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO

