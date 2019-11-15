USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimOrderDate]
-- Create date: November 8th, 2019 
-- Description: Loads the DimOrderDate data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimOrderDate]
GO

CREATE PROCEDURE [Project2].[LoadDimOrderDate]

    @UserAuthorizationKey INT

AS
BEGIN

    INSERT INTO [CH01-01-Dimension].[DimOrderDate] (OrderDate, MonthName, MonthNumber, [Year], UserAuthorizationKey)
    SELECT 
        DISTINCT
        OrderDate,
        MonthName,
        MonthNumber,
        [Year],
        @UserAuthorizationKey
    FROM [FileUpload].OriginallyLoadedData

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimOrderDate Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO
