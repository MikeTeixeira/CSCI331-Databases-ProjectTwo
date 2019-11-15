USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure: [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData]
-- Create date: November 8th, 2019 
-- Description: Loads the creates the DimProduct, DimProductCategory, DimProductSubcategory table and loads the data data from the FileUpload.OriginallyLoadedData 
-- =============================================


DROP PROCEDURE IF EXISTS [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData]
GO

CREATE PROCEDURE [Project2].[CreateDimProduct_DimProductCategory_DimProductSubCategoryAndLoadData]
@UserAuthorizationKey INT

AS
BEGIN

    ---------------------------------------- GRANDPARENT TABLE - DimProductCategory ----------------------------------------



    -- Used to create the Primary Key value
    CREATE SEQUENCE [Project2].[ProductCategorySubcategorySequenceKey]
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
        NEXT VALUE FOR [Project2].[DimProductSubCategorySequenceKey],
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


    CREATE SEQUENCE [CH01-01-Dimension].[DimProductSequenceKey]
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


    SELECT
        ProductKey,
        ProductCode,
        ProductName,
        ProductCategory,
        Color,
        ModelName,
        DPC.ProductCategoryKey
    FROM [CH01-01-Dimension].[DimProduct] AS DP
        INNER JOIN [CH01-01-Dimension].[DimProductCategory] AS DPC
        ON DP.ProductCategoryKey = DPC.ProductCategoryKey

END
GO