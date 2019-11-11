USE BIClass
Go


DROP PROCEDURE IF EXISTS [Project2].[LoadDimOccupation]
GO

CREATE PROCEDURE [Project2].[LoadDimOccupation]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimOccupation] (OccupationKey, Occupation, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT
        NEXT VALUE FOR [Project2].[DimOccupationSequenceKeys],
        Occupation,
        @UserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM [FileUpload].OriginallyLoadedData

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimOccupation Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END