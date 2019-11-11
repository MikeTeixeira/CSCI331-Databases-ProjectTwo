
USE BIClass
GO


DROP PROCEDURE IF EXISTS [Project2].[LoadDimTerritory]
GO

CREATE PROCEDURE [Project2].[LoadDimTerritory]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[LoadDimTerritory] (TerritoryKey, TerritoryGroup, TerritoryCoutry, TerritoryRegion, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT
        NEXT VALUE FOR [Project2].[DimTerritorySequenceKeys],
        TerritoryGroup,
        TerritoryCoutry,
        TerritoryRegion,
        @UserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM [FileUpload].OriginallyLoadedData

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimTerritory Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END