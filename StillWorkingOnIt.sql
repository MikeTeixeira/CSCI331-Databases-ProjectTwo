USE master
GO

USE BIClass
GO

EXEC [Project2].[LoadStarSchema]

DROP PROCEDURE IF EXISTS [Process].[usp_ShowWorkFlowSteps]
GO

CREATE PROCEDURE [Process].[usp_ShowWorkFlowSteps]

AS
BEGIN

    SELECT * FROM [Process].[WorkFlowSteps];

END
GO



DROP PROCEDURE IF EXISTS [Project2].[TotalExecutionTime]
GO

CREATE PROCEDURE [Project2].[TotalExecutionTime]

AS
BEGIN

    SELECT 
        UserAuthorizationKey,
        MAX(EndingTime) - MIN(StartingTime)
    FROM [Process].[WorkFLowSteps]
    GROUP BY UserAuthorizationKey;

END


