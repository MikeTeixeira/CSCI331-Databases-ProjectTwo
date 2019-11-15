USE BIClass
GO


-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[CreateWorkFlowStepsTable]
-- Create date: November 3rd, 2019
-- Description: Creates the Work Flow Steps table to track the project tasks
-- =============================================

GO
DROP PROCEDURE IF EXISTS [Project2].[CreateWorkFlowStepsTable]

GO
CREATE PROCEDURE [Project2].[CreateWorkFlowStepsTable]

    @GroupMemberUserAuthorizationKey INT

AS
BEGIN


    DROP TABLE IF EXISTS Process.WorkFlowSteps; 

    CREATE TABLE Process.WorkFlowSteps (
        WorkFlowStepKey INT NOT NULL IDENTITY(1,1), -- PK
        WorkFlowStepDescription NVARCHAR(100) NOT NULL,
        WorkFlowStepTableRowCount INT NULL DEFAULT(0),
        StartingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,
        EndingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,
        ClassTime CHAR(5) NULL DEFAULT ('09:15'),
        UserAuthorizationKey INT NOT NULL
    )

    INSERT INTO Process.WorkFlowSteps(UserAuthorizationKey, WorkFlowStepDescription, WorkFlowStepTableRowCount)
    VALUES(@GroupMemberUserAuthorizationKey, 'Created the Process.WorkFLowSteps table', NEXT VALUE FOR Process.WorkFlowStepTableRowCountBy1)

END
GO