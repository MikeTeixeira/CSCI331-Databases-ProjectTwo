USE BIClass


DROP PROCEDURE IF EXISTS [Project2].[LoadDimGender]

GO
CREATE PROCEDURE [Project2].[LoadDimGender]

    @UserAuthorizationKey INT
AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimGender](Gender, GenderDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT old.Gender,
        CASE
            WHEN old.Gender = 'M' THEN 'Male'
            WHEN old.Gender = 'F' THEN 'Female'
        END AS GenderDescription,
        @UserAuthorizationKey, 
        SYSDATETIME(), 
        SYSDATETIME()
    FROM FileUpload.OriginallyLoadedData as old;

    EXEC Process._uspTrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Loading Gender data into Gender Table';

END


EXEC [Project2].[LoadDimGender] @UserAuthorizationKey = 1;

SELECT * FROM [CH01-01-Dimension].[DimGender];

