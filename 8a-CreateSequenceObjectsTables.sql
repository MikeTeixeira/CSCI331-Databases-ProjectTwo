USE BIClass 
GO

-- -- FOLLOWING TABLES NEED SEQUENCE OBJECTS
-- SELECT * FROM [CH01-01-Dimension].[DimCustomer];
-- SELECT * FROM [CH01-01-Dimension].[DimOccupation];
-- SELECT * FROM [CH01-01-Dimension].[DimProduct];
-- SELECT * FROM [CH01-01-Dimension].[DimTerritory];
-- SELECT * FROM [CH01-01-Dimension].[SalesManagers];
-- SELECT * FROM [CH01-01-Fact].[Data];

-- -- FOLLOWING TABLES DON'T NEED SEQUENCE OBJECT KEYS
-- SELECT * FROM [CH01-01-Dimension].[DimGender];
-- SELECT * FROM [CH01-01-Dimension].[DimMaritalStatus];
-- SELECT * FROM [CH01-01-Dimension].[DimOrderDate];



DROP SEQUENCE IF EXISTS [Project2].[DimCustomerSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DimOccupationSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DimProductSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DimTerritorySequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[SalesManagersSequenceKeys]
DROP SEQUENCE IF EXISTS [Project2].[DataSequenceKeys]


DROP PROCEDURE IF EXISTS [Project2].[CreateSequenceKeysForTables];
GO

CREATE PROCEDURE [Project2].[CreateSequenceKeysForTables]

    @UserAuthorizationKey INT

AS
BEGIN

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

CREATE SEQUENCE [Project2].[DimProductSequenceKeys]
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