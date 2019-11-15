USE BIClass
Go

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimOccupation]
-- Create date: November 8th, 2019 
-- Description: Loads the DimOccupation data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimOccupation]
GO

CREATE PROCEDURE [Project2].[LoadDimOccupation]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimOccupation] (OccupationKey, Occupation, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[DimOccupationSequenceKeys],
        O.Occupation,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT Occupation FROM FileUpload.OriginallyLoadedData) AS O

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimOccupation Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO