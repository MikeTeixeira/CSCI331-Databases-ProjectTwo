USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[LoadDimCustomer]
-- Create date: November 8th, 2019 
-- Description: Loads the DimCustomer data from the FileUpload.OriginallyLoadedData 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[LoadDimCustomer]
GO

CREATE PROCEDURE [Project2].[LoadDimCustomer]

    @UserAuthorizationKey INT

AS
BEGIN


    -- Insert into the customer table including the user auth key
    INSERT INTO [CH01-01-Dimension].[DimCustomer] 
        (CustomerKey, CustomerName, UserAuthorizationKey)
    SELECT 
        NEXT VALUE FOR [Project2].[DimCustomerSequenceKeys] AS CustomerKey, 
        C.CustomerName, 
        @UserAuthorizationKey
    FROM (SELECT DISTINCT CustomerName FROM FileUpload.OriginallyLoadedData) AS C 


    --  Insert the user into the Process.WorkFlowTable
    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Loading data into DimCustomer table';

END
GO

