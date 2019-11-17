USE BIClass
GO

CREATE SCHEMA [Process];
GO
CREATE SCHEMA [Project2];
GO
CREATE SCHEMA [DbSecurity];
GO


-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[usp_WorkFlowStepCounter] 
-- Create date: November 3rd, 2019
-- Description: Creates the WorkFlowStepCounter to track the number of tasks submitted 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[usp_WorkFlowStepCounter]
GO

CREATE PROCEDURE [Project2].[usp_WorkFlowStepCounter]

AS
BEGIN

    SET NOCOUNT ON;

    DROP SEQUENCE IF EXISTS [Process].WorkFlowStepTableRowCountBy1

    CREATE SEQUENCE [Process].WorkFlowStepTableRowCountBy1
        START WITH 1
        INCREMENT BY 1

END
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

    SET NOCOUNT ON;


    DROP TABLE IF EXISTS Process.WorkFlowSteps;

    CREATE TABLE Process.WorkFlowSteps
    (
        WorkFlowStepKey INT NOT NULL IDENTITY(1,1),
        -- PK
        WorkFlowStepDescription NVARCHAR(100) NOT NULL,
        WorkFlowStepTableRowCount INT NULL DEFAULT(0),
        StartingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,
        EndingDateTime DATETIME2(7) NULL DEFAULT (SYSDATETIME()) ,
        ClassTime CHAR(5) NULL DEFAULT ('09:15'),
        UserAuthorizationKey INT NOT NULL
    )

    INSERT INTO Process.WorkFlowSteps
        (UserAuthorizationKey, WorkFlowStepDescription, WorkFlowStepTableRowCount)
    VALUES(@GroupMemberUserAuthorizationKey, 'Created the Process.WorkFLowSteps table', NEXT VALUE FOR Process.WorkFlowStepTableRowCountBy1)

END
GO




-- ============================================= 
-- Author: Michael Teixeira  
-- Procedure: [Process].[usp_TrackWorkFlow]
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

    SET NOCOUNT ON;

    INSERT INTO Process.WorkFlowSteps
        (WorkFlowStepDescription, UserAuthorizationKey, WorkFlowStepTableRowCount)
    VALUES(@WorkFlowStepDescription, @GroupMemberUserAuthorizationKey, NEXT VALUE FOR Process.WorkFlowStepTableRowCountBy1);


END
GO





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[CreateUserAuthtable]
-- Create date: November 3rd, 2019
-- Description: Creates the DbSecurity.UserAuthTable
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[CreateUserAuthtable]
GO

CREATE PROCEDURE [Project2].[CreateUserAuthtable]

    @GroupMemberUserAuthorization INT

AS
BEGIN

    SET NOCOUNT ON;

    DROP TABLE IF EXISTS [DbSecurity].[UserAuthorization];

    CREATE TABLE [DbSecurity].[UserAuthorization]
    (
        UserAuthorizationKey INT NOT NULL, -- Primary Key
        ClassTime nchar(5) Null DEFAULT('9:15'),
        IndividualProject nvarchar (60) null default('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),
        GroupMemberLastName nvarchar(35) NOT NULL,
        GroupMemberFirstName nvarchar(25) NOT NULL,
        GroupName nvarchar(20) NOT NULL DEFAULT('G_Kenley'),
        DateAdded datetime2 null default sysdatetime(),
        CONSTRAINT PK_UserAuthKey PRIMARY KEY(UserAuthorizationKey)

    )

    INSERT INTO [DbSecurity].[UserAuthorization]
        (UserAuthorizationKey, GroupMemberLastName,GroupMemberFirstName)
    VALUES
        (@GroupMemberUserAuthorization, 'Teixeira', 'Michael'),
        (2, 'Nicolas', 'Kenley'),
        (3, 'Yin', 'Eric')

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @GroupMemberUserAuthorization, @WorkFlowStepDescription = 'Created the DBSecurity.UserAuthTable';

END
GO





-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[DropAllForeignKeys]
-- Create date: November 3rd, 2019
-- Description: Drops all of the Foreign keys from the Fact.Data table
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[DropAllForeignKeys];
GO

CREATE PROCEDURE [Project2].[DropAllForeignKeys]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimCustomer;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimGender;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimMaritalStatus;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimOccupation;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimOrderDate;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimProduct;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimTerritory;

    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_SalesManagers;

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Dropped all Foreign Keys from Fact.Data table.'

END
GO




-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[usp_CountTableRows]
-- Create date: November 3rd, 2019
-- Description: Counts all the rows in every table besides the file upload table
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[usp_CountTableRows]
GO

CREATE PROCEDURE [Project2].[usp_CountTableRows]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

        (
    SELECT 'DimCustomer' AS [Table Name], COUNT(*) AS TotalNumberOfRows
        FROM [CH01-01-Dimension].[DimCustomer]
    UNION ALL
        SELECT 'DimGender', COUNT(*)
        FROM [CH01-01-Dimension].[DimGender]
    UNION ALL
        SELECT 'DimMaritalStatus', COUNT(*)
        FROM [CH01-01-Dimension].[DimMaritalStatus]
    UNION ALL
        SELECT 'DimOccupation', COUNT(*)
        FROM [CH01-01-Dimension].[DimOccupation]
    UNION ALL
        SELECT 'DimOrderDate', COUNT(*)
        FROM [CH01-01-Dimension].[DimOrderDate]
    UNION ALL
        SELECT 'DimProduct', COUNT(*)
        FROM [CH01-01-Dimension].[DimProduct]
    UNION ALL
        SELECT 'DimTerritory', COUNT(*)
        FROM [CH01-01-Dimension].[DimTerritory]
    UNION ALL
        SELECT 'SalesManagers', COUNT(*)
        FROM [CH01-01-Dimension].[SalesManagers]
    UNION ALL
        SELECT 'FactData', COUNT(*)
        FROM [CH01-01-Fact].[Data]);


    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Displaying all the row counts of all the old tables.'


END
GO



-- ============================================= 
-- Author: Michael Teixeira
-- Procedure: [Project2].[TruncateAllTables]
-- Create date: November 3rd, 2019
-- Description: Truncates all the tables in BiClass besides the FileUpad.LoadOriginalData Table
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[TruncateAllTables]
GO


CREATE PROCEDURE [Project2].[TruncateAllTables]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    TRUNCATE TABLE [CH01-01-Dimension].[DimCustomer];
    TRUNCATE TABLE [CH01-01-Dimension].[DimGender];
    TRUNCATE TABLE [CH01-01-Dimension].[DimMaritalStatus];
    TRUNCATE TABLE [CH01-01-Dimension].[DimOccupation];
    TRUNCATE TABLE [CH01-01-Dimension].[DimOrderDate];
    TRUNCATE TABLE [CH01-01-Dimension].[DimProduct];
    TRUNCATE TABLE [CH01-01-Dimension].[DimTerritory];
    TRUNCATE TABLE [CH01-01-Dimension].[SalesManagers];
    TRUNCATE TABLE [CH01-01-Fact].[Data];

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Truncated all old tables';

END
GO




-- ============================================= 
-- Author: Kenley Nicolas
-- Procedure: [Project2].[CreateSequenceKeysForTables]
-- Create date: November 5th, 2019
-- Description: Drops exiting sequences and re-creates new ones
-- =============================================



DROP PROCEDURE IF EXISTS [Project2].[CreateSequenceKeysForTables];
GO

CREATE PROCEDURE [Project2].[CreateSequenceKeysForTables]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

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
GO





DROP PROCEDURE IF EXISTS [Project2].[AlterTableIdentityKeystoSequenceObjects]
GO

-- ============================================= 
-- Author: Kenley Nicolas
-- Procedure: [Project2].[AlterTableIdentityKeystoSequenceObjects] 
-- Create date: November 5th, 2019 
-- Description: Drops the PK constraints, then drops the column, and finally re-creates the column to a sequence object
-- =============================================


CREATE PROCEDURE [Project2].[AlterTableIdentityKeystoSequenceObjects]

    @UserAuthorizationKey INT

AS
BEGIN

        SET NOCOUNT ON;

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
GO




-- ============================================= 
-- Author: Kenley Nicolas
-- Procedure: [Project2].[LoadDimCustomer]
-- Create date: November 5th, 2019 
-- Description: Loads the DimCustomer data from the FileUpload.OriginallyLoadedData 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[LoadDimCustomer]
GO

CREATE PROCEDURE [Project2].[LoadDimCustomer]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;


    -- Insert into the customer table including the user auth key
    INSERT INTO [CH01-01-Dimension].[DimCustomer]
        (CustomerKey, CustomerName, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[DimCustomerSequenceKeys] AS CustomerKey,
        C.CustomerName,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT CustomerName
        FROM FileUpload.OriginallyLoadedData) AS C


    --  Insert the user into the Process.WorkFlowTable
    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Loading data into DimCustomer table';

END
GO




-- ============================================= 
-- Author: Kenley Nicolas 
-- Procedure: [Project2].[LoadDimMaritalStatus]
-- Create date: November 5th, 2019 
-- Description: Loads the DimMaritalStatus data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimMaritalStatus]
GO


CREATE PROCEDURE [Project2].[LoadDimMaritalStatus]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [CH01-01-Dimension].[DimMaritalStatus]
        (MaritalStatus, MaritalStatusDescription, UserAuthorizationKey)
    SELECT DISTINCT old.MaritalStatus,
        CASE
            WHEN old.MaritalStatus = 'M' THEN 'Married'
            WHEN old.MaritalStatus = 'S' THEN 'Single'
        END AS MaritalStatusDescription,
        @UserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData AS old

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription =  'Loading Data into the DimMaritalStatus Table';

END
GO




-- ============================================= 
-- Author: Kenley Nicolas 
-- Procedure: [Project2].[LoadDimGender]
-- Create date: November 5th, 2019 
-- Description: Loads the DimGender data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimGender]
GO

CREATE PROCEDURE [Project2].[LoadDimGender]

    @UserAuthorizationKey INT
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [CH01-01-Dimension].[DimGender]
        (Gender, GenderDescription, UserAuthorizationKey)
    SELECT DISTINCT old.Gender,
        CASE
            WHEN old.Gender = 'M' THEN 'Male'
            WHEN old.Gender = 'F' THEN 'Female'
        END AS GenderDescription,
        @UserAuthorizationKey
    FROM FileUpload.OriginallyLoadedData as old;

    EXEC Process.usp_TrackWorkFlow @GroupMemberUserAuthorizationKey = @UserAuthorizationKey, @WorkFlowStepDescription = 'Loading Gender data into Gender Table';

END
GO




-- ============================================= 
-- Author: Eric 
-- Procedure: [Project2].[LoadDimOccupation]
-- Create date: November 5th, 2019 
-- Description: Loads the DimOccupation data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimOccupation]
GO

CREATE PROCEDURE [Project2].[LoadDimOccupation]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [CH01-01-Dimension].[DimOccupation]
        (OccupationKey, Occupation, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[DimOccupationSequenceKeys],
        O.Occupation,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT Occupation
        FROM FileUpload.OriginallyLoadedData) AS O

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimOccupation Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO




-- ============================================= 
-- Author: Eric Yin 
-- Procedure: [Project2].[LoadDimOrderDate]
-- Create date: November 5th, 2019 
-- Description: Loads the DimOrderDate data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimOrderDate]
GO

CREATE PROCEDURE [Project2].[LoadDimOrderDate]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [CH01-01-Dimension].[DimOrderDate]
        (OrderDate, MonthName, MonthNumber, [Year], UserAuthorizationKey)
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




-- ============================================= 
-- Author: Eric Yin 
-- Procedure: [Project2].[LoadDimTerritory]
-- Create date: November 5th, 2019 
-- Description: Loads the DimTerritory data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[LoadDimTerritory]
GO

CREATE PROCEDURE [Project2].[LoadDimTerritory]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [CH01-01-Dimension].[DimTerritory]
        (TerritoryKey, TerritoryGroup, TerritoryCountry, TerritoryRegion, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[DimTerritorySequenceKeys],
        TerritoryGroup,
        TerritoryCountry,
        TerritoryRegion,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT TerritoryGroup, TerritoryCountry, TerritoryRegion
        FROM [FileUpload].OriginallyLoadedData) AS T

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimTerritory Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO




-- ============================================= 
-- Author: Eric Yin 
-- Procedure: [Project2].[LoadSalesManagers]
-- Create date: November 5th, 2019 
-- Description: Loads the SalesManagers data from the FileUpload.OriginallyLoadedData 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[LoadSalesManagers]
GO

CREATE PROCEDURE [Project2].[LoadSalesManagers]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO [CH01-01-Dimension].[SalesManagers]
        (SalesManagerKey, Category, SalesManager, Office, UserAuthorizationKey)
    SELECT
        NEXT VALUE FOR [Project2].[SalesManagersSequenceKeys] AS SalesManagerKey,
        ProductCategory AS Category,
        SalesManager,
        Office = 
                CASE
                    WHEN SalesManager LIKE N'Maurizio%' OR SalesManager LIKE N'Marco%' THEN 'Redmond'
                    WHEN SalesManager LIKE N'Alberto%' OR SalesManager LIKE N'Luis%' THEN 'Seattle'
                END,
        @UserAuthorizationKey
    FROM (SELECT DISTINCT ProductCategory, SalesManager
        FROM FileUpload.OriginallyLoadedData) AS S;

    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loading data into the DimTerritory Table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO





-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData]
-- Create date: November 6th, 2019 
-- Description: Loads the creates the DimProduct, DimProductCategory, DimProductSubcategory table and loads the data data from the FileUpload.OriginallyLoadedData 
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData]
GO





CREATE PROCEDURE [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData]
    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    ---------------------------------------- GRANDPARENT TABLE - DimProductSubCategory ----------------------------------------



    -- Used to create the Primary Key value
    CREATE SEQUENCE [Project2].[ProductSubcategorySequenceKey]
        START WITH 1
        INCREMENT BY 1



    -- GRANDPARENT TABLE
    CREATE TABLE [CH01-01-Dimension].[DimProductSubcategory]
    (
        ProductSubcategoryKey INT NOT NULL PRIMARY KEY,
        ProductSubcategory VARCHAR(20) NULL
    );




    -- Insert the data from the FileUpload
    INSERT INTO [CH01-01-Dimension].[DimProductSubcategory]
        (ProductSubcategoryKey, ProductSubcategory)
    SELECT
        NEXT VALUE FOR [Project2].[ProductSubcategorySequenceKey],
        OLD.ProductSubcategory
    FROM
        (SELECT
            DISTINCT ProductSubcategory
        FROM FileUpload.OriginallyLoadedData
        ) AS OLD



    ---------------------------------------- PARENT TABLE - DimProductCategory ----------------------------------------

    CREATE SEQUENCE [Project2].[ProductCategorySequenceKey]
        START WITH 1
        INCREMENT BY 1



    -- PARENT TABLE
    CREATE TABLE [CH01-01-Dimension].[DimProductCategory]
    (
        ProductCategoryKey INT NOT NULL PRIMARY KEY,
        ProductSubcategoryKey INT NOT NULL
            CONSTRAINT FK_DimProductSubcategory 
            FOREIGN KEY (ProductSubcategoryKey) 
            REFERENCES [CH01-01-Dimension].[DimProductSubcategory](ProductSubcategoryKey),
        ProductCategory VARCHAR(20) NULL
    );


    INSERT INTO [CH01-01-Dimension].[DimProductCategory]
        (ProductCategoryKey, ProductSubcategoryKey, ProductCategory)
    SELECT
        NEXT VALUE FOR [Project2].[ProductCategorySequenceKey],
        new.ProductSubcategoryKey,
        new.ProductCategory
    FROM (SELECT
            DISTINCT
            old.ProductCategory,
            old.ProductSubcategory,
            dps.ProductSubcategoryKey
        FROM FileUpload.OriginallyLoadedData AS old
            INNER JOIN [CH01-01-Dimension].[DimProductSubcategory] AS dps
            ON old.ProductSubcategory = dps.ProductSubcategory) AS new









    ---------------------------------------- CHILD TABLE - DimProductCategory ----------------------------------------


    CREATE SEQUENCE [Project2].[DimProductSequenceKey]
        START WITH 1
        INCREMENT BY 1



    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    DROP COLUMN ProductCategory, ProductSubcategory;



    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    ADD 
        ProductCategoryKey INT NOT NULL DEFAULT (-1)
        CONSTRAINT FK_DimProductCategoryKey
        FOREIGN KEY (ProductCategoryKey)
        REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey)




    INSERT INTO [CH01-01-Dimension].[DimProduct]
        (ProductKey,ProductCategoryKey, ProductCode, ProductName, Color, ModelName)
    SELECT
        NEXT VALUE FOR [Project2].[DimProductSequenceKey],
        new.ProductCategoryKey,
        new.ProductCode,
        new.ProductName,
        new.Color,
        new.ModelName
    FROM
        (SELECT
            DISTINCT
            ProductCategoryKey,
            ProductCode,
            ProductName,
            Color,
            ModelName
        FROM FileUpload.OriginallyLoadedData AS old
            INNER JOIN [CH01-01-Dimension].[DimProductCategory] AS dpc
            ON old.ProductCategory = dpc.ProductCategory) AS new


END
GO




-- ============================================= 
-- Author: Ken Nicolas 
-- Procedure: [Project2].[LoadData]
-- Create date: November 7th, 2019 
-- Description: Alters the columns in the Fact.Data table with their proper FK constraints
-- =============================================



DROP PROCEDURE IF EXISTS [Project2].[LoadData]
GO

CREATE PROCEDURE[Project2].[LoadData]

    @UserAuthorizationKey INT

AS
BEGIN

    SET NOCOUNT ON;

    CREATE SEQUENCE [Project2].[DataSequenceKey]
    START WITH 1
    INCREMENT BY 1

    INSERT INTO [CH01-01-Fact].[Data]
        (
        SalesKey,SalesManagerKey,OccupationKey,TerritoryKey,ProductKey,
        CustomerKey,ProductCategory,SalesManager,ProductSubcategory,
        ProductCode,ProductName,Color,ModelName,OrderQuantity,UnitPrice,
        ProductStandardCost,SalesAmount,OrderDate,MonthName,[Year],CustomerName,
        MaritalStatus,Gender,Education,Occupation,TerritoryRegion,TerritoryCountry,
        TerritoryGroup)
    SELECT
        NEXT VALUE FOR [Project2].[DataSequenceKey], old.SalesManagerKey, old.OccupationKey, DT.TerritoryKey, DP.ProductKey,
        DC.CustomerKey, old.ProductCategory, old.SalesManager, old.ProductSubcategory,
        old.ProductCode, old.ProductName, old.Color, old.ModelName, old.OrderQuantity, old.UnitPrice,
        old.ProductStandardCost, old.SalesAmount, old.OrderDate, old.MonthName, [Year], old.CustomerName,
        old.MaritalStatus, old.Gender, old.Education, old.Occupation, old.TerritoryRegion, old.TerritoryCountry,
        old.TerritoryGroup
    FROM
        FileUpload.OriginallyLoadedData AS old
        INNER JOIN [CH01-01-Dimension].[SalesManagers] AS SM
        ON SM.SalesManagerKey = old.SalesManagerKey
        INNER JOIN [CH01-01-Dimension].[DimOccupation] AS DO
        ON DO.OccupationKey = old.OccupationKey
        INNER JOIN [CH01-01-Dimension].[DimTerritory] as DT ON 
        DT.TerritoryGroup = old.TerritoryGroup AND
            DT.TerritoryCountry = old.TerritoryCountry AND
            DT.TerritoryRegion = old.TerritoryRegion
        INNER JOIN [CH01-01-Dimension].[DimProduct] AS DP ON 
        DP.ProductName = old.ProductName
        INNER JOIN [CH01-01-Dimension].[DimCustomer] AS DC ON
        DC.CustomerName = old.CustomerName


    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Loaded the Fact.Data table with data', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;

END
GO





-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[AddForeignKeysToNewlyModifiedTables]
-- Create date: November 5th, 2019 
-- Description: Loads alters the columns in the Fact.Data table with their proper FK constraints
-- =============================================

DROP PROCEDURE IF EXISTS [Project2].[AddForeignKeysToNewlyModifiedTables]
GO

CREATE PROCEDURE[Project2].[AddForeignKeysToNewlyModifiedTables]

    @UserAuthorizationKey INT


AS
BEGIN

    SET NOCOUNT ON;


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
        REFERENCES [CH01-01-Dimension].[DimOrderDate] (OrderDate),

        CONSTRAINT FK_DimProduct_Data FOREIGN KEY (ProductKey)
        REFERENCES [CH01-01-Dimension].[DimProduct] (ProductKey),

        CONSTRAINT FK_DimTerritory_Data FOREIGN KEY (TerritoryKey)
        REFERENCES [CH01-01-Dimension].[DimTerritory] (TerritoryKey),

        CONSTRAINT FK_SalesManager_Data FOREIGN KEY (SalesManagerKey)
        REFERENCES [CH01-01-Dimension].[SalesManagers] (SalesManagerKey)



    EXEC Process.usp_TrackWorkFlow @WorkFlowStepDescription = 'Added Foreign Key relationships to the Fact.Data table', @GroupMemberUserAuthorizationKey = @UserAuthorizationKey;




END
GO