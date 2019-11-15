USE BIClass
GO


-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[AddForeignKeysToNewlyModifiedTables]
-- Create date: November 8th, 2019 
-- Description: Loads the adds FKs to the Fact.Data table and then loads data from the tables 
-- =============================================



DROP PROCEDURE IF EXISTS [Project2].[AddForeignKeysToNewlyModifiedTables]
GO

CREATE PROCEDURE[Project2].[AddForeignKeysToNewlyModifiedTables]

    @UserAuthorizationKey INT


AS
BEGIN


    ALTER TABLE [CH01-01-Fact].[Data]
    ADD 
        CONSTRAINT FK_DimCustomer_Data FOREIGN KEY(CustomerKey)
        REFERENCES [CH01-01-Dimension].[DimCustomer] (CustomerKey),

        CONSTRAINT FK_DimGender_Data FOREIGN KEY (Gender)
        REFERENCES [CH01-01-Dimension].[DimGender] (Gender),

        CONSTRAINT FK_DimMaritalStatus_Data FOREIGN KEY (MaritalStatus)
        REFERENCES [CH01-01-Dimension].[DimMaritalStatus] (MaritalStatus),

        CONSTRAINT FK_DimOccupation_Data FOREIGN KEY (OccupationKey)
        REFERENCES [CH01-01-Dimension].[DimOccupation] (OccupationKey),

        CONSTRAINT FK_DimOrderDate_Data FOREIGN KEY (OrderDate)
        REFERENCES [CH01-01-Dimension].[DimGender] (OrderDate),

        CONSTRAINT FK_DimProduct_Data FOREIGN KEY (ProductKey)
        REFERENCES [CH01-01-Dimension].[DimProduct] (ProductKey),

        CONSTRAINT FK_DimTerritory_Data FOREIGN KEY (TerritoryKey)
        REFERENCES [CH01-01-Dimension].[DimTerritory] (TerritoryKey),

        CONSTRAINT FK_SalesManager_Data FOREIGN KEY (SalesManagerKey)
        REFERENCES [CH01-01-Dimension].[SalesManager] (SalesManagerKey)


    
    EXEC [Project2].[usp_TrackWorkFlow] @WorkFlowStepDescription = 'Added Foreign Key relationships to the Fact.Data table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;




END
GO