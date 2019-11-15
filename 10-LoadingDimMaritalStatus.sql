USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimMaritalStatus]
-- Create date: November 8th, 2019 
-- Description: Loads the DimMaritalStatus data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimMaritalStatus]
GO


CREATE PROCEDURE [Project2].[LoadDimMaritalStatus]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimMaritalStatus](MaritalStatus, MaritalStatusDescription, UserAuthorizationKey)
    SELECT DISTINCT old.MaritalStatus,
        CASE
            WHEN old.MaritalStatus = 'M' THEN 'Married'
            WHEN old.MaritalStatus = 'S' THEN 'Single'
        END AS MaritalStatusDescription,
    @UserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData AS old

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Loading Data into the DimMaritalStatus Table';

END
GO