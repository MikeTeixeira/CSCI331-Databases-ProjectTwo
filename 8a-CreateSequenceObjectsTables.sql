USE BIClass 
GO

-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[usp_CountTableRows]
-- Create date: November 6th, 2019
-- Description: Drops exiting sequences and re-creates new ones
-- =============================================



DROP PROCEDURE IF EXISTS [Project2].[CreateSequenceKeysForTables];
GO

CREATE PROCEDURE [Project2].[CreateSequenceKeysForTables]

    @UserAuthorizationKey INT

AS
BEGIN

DROP SEQUENCE IF EXISTS [Project2].[DimCustomerSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DimOccupationSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DimProductSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DimTerritorySequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[SalesManagersSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DataSequenceKeys]

CREATE SEQUENCE [Project2].[DimCustomerSequenceKeys]
    AS INT
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    MINVALUE -2147483648

CREATE SEQUENCE [Project2].[DimOccupationSequenceKeys]
    AS INT
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    MINVALUE -2147483648

CREATE SEQUENCE [Project2].[DimTerritorySequenceKeys]
    AS INT
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    MINVALUE -2147483648

CREATE SEQUENCE [Project2].[SalesManagersSequenceKeys]
    AS INT
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    MINVALUE -2147483648

CREATE SEQUENCE [Project2].[DataSequenceKeys]
    AS INT
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    MINVALUE -2147483648


    EXEC [Process].[usp_TrackWorkFlow] @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Created Sequence Objects for particular tables in the BIClass Database.';
END