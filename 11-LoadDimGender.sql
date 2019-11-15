USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimGender]
-- Create date: November 8th, 2019 
-- Description: Loads the DimGender data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimGender]
GO

CREATE PROCEDURE [Project2].[LoadDimGender]

    @UserAuthorizationKey INT
AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimGender](Gender, GenderDescription, UserAuthorizationKey)
    SELECT DISTINCT old.Gender,
        CASE
            WHEN old.Gender = 'M' THEN 'Male'
            WHEN old.Gender = 'F' THEN 'Female'
        END AS GenderDescription,
        @UserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData as old;

    EXEC Process._uspTrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Loading Gender data into Gender Table';

END
GO

