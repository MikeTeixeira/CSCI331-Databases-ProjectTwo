USE BIClass
GO

-- ============================================= 
-- Author: Michael Teixeira 
-- Procedure:  [Project2].[TruncateAllTables]
-- Create date: November 6th, 2019
-- Description: truncates all of the tables in the BIClass database besides the FileUpload.OriginallyLoadedData table 
-- =============================================

CREATE PROCEDURE [Project2].[TruncateAllTables]
    @GroupMemberUserAuthorizationKey INT,
    @ClassTime NCHAR(5),
    @IndividualProject NVARCHAR(60),
    @GroupMemberLastName NVARCHAR(35),
    @GroupMemberFirstName NVARCHAR(25)
AS
BEGIN
 SET NOCOUNT ON;

    INSERT INTO DbSecurity.UserAuthorization(UserAuthorizationKey, ClassTime, IndividualProject, GroupMemberLastName, GroupMemberFirstName, GroupName, DateAdded)
    VALUES(@GroupMemberUserAuthorizationKey, '9:15', @IndividualProject, @GroupMemberLastName, @GroupMemberFirstName, 'G_Kenley', GETDATE())

    TRUNCATE TABLE [CH01-01-Dimension].[DimCustomer]
    TRUNCATE TABLE [CH01-01-Dimension].[DimGender]
    TRUNCATE TABLE [CH01-01-Dimension].[DimMaritalStatus]
    TRUNCATE TABLE [CH01-01-Dimension].[DimOccupation]
    TRUNCATE TABLE [CH01-01-Dimension].[DimOrderDate]
    TRUNCATE TABLE [CH01-01-Dimension].[DimProduct]
    TRUNCATE TABLE [CH01-01-Dimension].[DimTerritory]
    TRUNCATE TABLE [CH01-01-Dimension].[SalesManagers]
    TRUNCATE TABLE [CH01-01-Fact].[Data]
END










ALTER TABLE Process.WorkFlowSteps
DROP COLUMN UserAuthorizationKey;

ALTER TABLE Process.WorkFlowSteps
ADD UserAuthorizationKey INT NOT NULL;

ALTER TABLE Process.WorkFlowSteps
ADD CONSTRAINT FK_UserAuthorizationKey FOREIGN KEY(UserAuthorizationKey) REFERENCES DbSecurity.UserAuthorization(UserAuthorizationKey)





GO
CREATE PROCEDURE [Process].[usp_TrackWorkFLow]
    @UserAuthorizationKey INT,
    @StartTime DATETIME2, @WorkFlowDescription NVARCHAR(100), @WorkFlowStepTableRowCount int, @ UserAuthorization int
AS
BEGIN
    SET NOCOUNT ON;



