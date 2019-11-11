USE BIClass
GO

DROP PROCEDURE IF EXISTS [Project2].[AlterTableIdentityKeystoSequenceObjects]
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[AlterTableIdentityKeystoSequenceObjects] 
-- Create date: November 7th, 2019 
-- Description: Drops the PK constraints, then drops the column, and finally re-creates the column to a sequence object
-- =============================================


CREATE PROCEDURE [Project2].[AlterTableIdentityKeystoSequenceObjects]

    @UserAuthorizationKey INT

AS
BEGIN

    -- DROPS THE PK CONSTRAINTS AND THE PK COLUMN

    ALTER TABLE [CH01-01-Dimension].[DimCustomer]  
    DROP 
        CONSTRAINT PK__DimCusto__95011E6452BCF41C,
        COLUMN [CustomerKey];


    ALTER TABLE [CH01-01-Dimension].[DimCustomer]  
    ADD 
        CustomerKey INT NOT NULL PRIMARY KEY






    ALTER TABLE [CH01-01-Dimension].[DimOccupation]
    DROP 
        CONSTRAINT PK_DimOccupation,
        COLUMN [OccupationKey];


    ALTER TABLE [CH01-01-Dimension].[DimOccupation]
        ADD OccupationKey INT NOT NULL PRIMARY KEY







    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    DROP 
        CONSTRAINT PK__DimProdu__A15E99B3E27177EF,
        COLUMN ProductKey;  


    ALTER TABLE [CH01-01-Dimension].[DimProduct]
        ADD ProductKey INT NOT NULL PRIMARY KEY









    ALTER TABLE [CH01-01-Dimension].[DimTerritory]
    DROP 
        CONSTRAINT PK__DimTerri__C54B735D813BBCA6,
        COLUMN [TerritoryKey];

    ALTER TABLE [CH01-01-Dimension].[DimTerritory]
        ADD TerritoryKey INT NOT NULL PRIMARY KEY








    ALTER TABLE [CH01-01-Dimension].[SalesManagers]
    DROP 
        CONSTRAINT PK_SalesManagers,
        COLUMN [SalesManagerKey]

    ALTER TABLE [CH01-01-Dimension].[SalesManagers]
    ADD SalesManagerKey INT NOT NULL PRIMARY KEY






    ALTER TABLE [CH01-01-Fact].[Data]
    DROP
        CONSTRAINT PK_Data, 
        COLUMN [SalesKey]


    ALTER TABLE [CH01-01-Fact].[Data]
    ADD SalesKey INT NOT NULL;



    EXEC [Process].[usp_TrackWorkFlow] @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Altered the PKs of various tables to Sequence Objects';




END
go


-- SELECT name FROM sys.key_constraints WHERE type = 'PK';