
USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimTerritory]
-- Create date: November 8th, 2019 
-- Description: Loads the DimTerritory data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimTerritory]
GO

CREATE PROCEDURE [Project2].[LoadDimTerritory]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimTerritory] (TerritoryKey, TerritoryGroup, TerritoryCountry, TerritoryRegion, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[DimTerritorySequenceKeys],
        TerritoryGroup,
        TerritoryCountry,
        TerritoryRegion,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT TerritoryGroup, TerritoryCountry, TerritoryRegion FROM [FileUpload].OriginallyLoadedData) AS T

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimTerritory Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO