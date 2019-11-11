USE BIClass
GO

-- DIM ORDER DATE


DROP PROCEDURE IF EXISTS [Project2].[LoadDimOrderDate]
GO

CREATE PROCEDURE [Project2].[LoadDimOrderDate]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimOccupation] (OrderDate, MonthName, MonthNumber, [Year], UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT
        OrderDate,
        MonthName,
        MonthNumber,
        [Year],
        @UserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM [FileUpload].OriginallyLoadedData

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimOrderDate Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO
