USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[uso_WorkFlowStepCounter] 
-- Create date: November 3rd, 2019
-- Description: Define the actions of the stored procedure 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[uso_WorkFlowStepCounter]
GO

CREATE PROCEDURE [Project2].[usp_WorkFlowStepCounter]

AS 
BEGIN

    CREATE SEQUENCE Process.WorkFlowStepTableRowCountBy1
        AS INT
        START WITH 1
        INCREMENT BY 1

END


-- Code to execute the next value
-- NEXT VALUE FOR Process.WorkFlowStepTableRowCountBy1