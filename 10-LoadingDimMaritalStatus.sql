USE BIClass
GO


GO
DROP PROCEDURE IF EXISTS [Project2].[LoadDimMaritalStatus]

GO
CREATE PROCEDURE [Project2].[LoadDimMaritalStatus]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimMaritalStatus](MaritalStatus,MaritalStatusDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT old.MaritalStatus,
        CASE
            WHEN old.MaritalStatus = 'M' THEN 'Married'
            WHEN old.MaritalStatus = 'S' THEN 'Single'
        END AS MaritalStatusDescription,
    @UserAuthorizationKey,
    SYSDATETIME(),
    SYSDATETIME()
    FROM FileUpload.OriginallyLoadedData AS old

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Loading Data into the DimMaritalStatus Table';

END