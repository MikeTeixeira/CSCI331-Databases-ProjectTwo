USE BIClass;
GO


DROP PROCEDURE IF EXISTS [Project2].[LoadSalesManagers]
GO

CREATE PROCEDURE [Project2].[LoadSalesManagers]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[LoadDimTerritory] (SalesManagerKey, Category, SalesManager, Office, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT
        NEXT VALUE FOR [Project2].[SalesManagersSequenceKeys],
        Category,
        SalesManager,
        Office,
        @UserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM [FileUpload].OriginallyLoadedData

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimTerritory Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END


-- SELECT * FROM FileUpload.OriginallyLoadedData WHERE Office
-- SELECT * FROM [CH01-01-Dimension].[SalesManagers];