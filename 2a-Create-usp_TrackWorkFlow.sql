USE BIClass

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[CreateWorkFlowStepsTable]
-- Create date: November 3rd, 2019
-- Description: Creates the Work Flow Steps procedure to help track the project tasks
-- =============================================

DROP PROCEDURE IF EXISTS [Process].[usp_TrackWorkFlow]
GO

CREATE PROCEDURE [Process].[usp_TrackWorkFlow]

    @GroupMemberUserAuthorizationKey INT,
    @WorkFlowStepDescription NVARCHAR(100)

AS
BEGIN

    INSERT INTO Process.WorkFlowSteps(WorkFlowStepDescription, UserAuthorizationKey, WorkFlowStepTableRowCount)
    VALUES(@WorkFlowStepDescription, @GroupMemberUserAuthorizationKey, NEXT VALUE FOR Process.WorkFlowStepTableRowCountBy1);


END