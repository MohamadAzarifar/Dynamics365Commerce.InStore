/**
 * SAMPLE CODE NOTICE
 * 
 * THIS SAMPLE CODE IS MADE AVAILABLE AS IS.  MICROSOFT MAKES NO WARRANTIES, WHETHER EXPRESS OR IMPLIED,
 * OF FITNESS FOR A PARTICULAR PURPOSE, OF ACCURACY OR COMPLETENESS OF RESPONSES, OF RESULTS, OR CONDITIONS OF MERCHANTABILITY.
 * THE ENTIRE RISK OF THE USE OR THE RESULTS FROM THE USE OF THIS SAMPLE CODE REMAINS WITH THE USER.
 * NO TECHNICAL SUPPORT IS PROVIDED.  YOU MAY NOT DISTRIBUTE THIS CODE UNLESS YOU HAVE A LICENSE AGREEMENT WITH MICROSOFT THAT ALLOWS YOU TO DO SO.
 */

 -- Create the extension table to store the custom fields.

IF (SELECT OBJECT_ID('[ext].[Golrang_STORECOMMERCE_EXAMPLETABLE]')) IS NULL 
BEGIN
    CREATE TABLE
        [ext].[Golrang_STORECOMMERCE_EXAMPLETABLE]
    (
        [EXAMPLEID]     BIGINT IDENTITY(1,1) NOT NULL,
        [EXAMPLEINT]    INT NOT NULL DEFAULT ((0)),
        [EXAMPLESTRING] NVARCHAR(64) NOT NULL DEFAULT (('')),
        CONSTRAINT [I_EXAMPLETABLE_EXAMPLEID] PRIMARY KEY CLUSTERED
        (
            [EXAMPLEID] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]

    ALTER TABLE [ext].[Golrang_STORECOMMERCE_EXAMPLETABLE] WITH CHECK ADD CHECK (([EXAMPLEID]<>(0)))
END
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::[ext].[Golrang_STORECOMMERCE_EXAMPLETABLE] TO [DataSyncUsersRole]
GO

-- Create a stored procedure CRT can use to add entries to the custom table.

IF OBJECT_ID(N'[ext].[Golrang_STORECOMMERCE_INSERTEXAMPLE]', N'P') IS NOT NULL
    DROP PROCEDURE [ext].[Golrang_STORECOMMERCE_INSERTEXAMPLE]
GO

CREATE PROCEDURE [ext].[Golrang_STORECOMMERCE_INSERTEXAMPLE]
    @i_ExampleInt    INT,
    @s_ExampleString NVARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO
         ext.Golrang_STORECOMMERCE_EXAMPLETABLE
        (EXAMPLEINT, EXAMPLESTRING)
    OUTPUT
        INSERTED.EXAMPLEID
    VALUES
        (@i_ExampleInt, @s_ExampleString)
END;
GO

GRANT EXECUTE ON [ext].[Golrang_STORECOMMERCE_INSERTEXAMPLE] TO [UsersRole];
GO

GRANT EXECUTE ON [ext].[Golrang_STORECOMMERCE_INSERTEXAMPLE] TO [DeployExtensibilityRole];
GO

-- Create the custom view that can query a complete Example Entity.

IF (SELECT OBJECT_ID('[ext].[Golrang_STORECOMMERCE_EXAMPLEVIEW]')) IS NOT NULL
    DROP VIEW [ext].[Golrang_STORECOMMERCE_EXAMPLEVIEW]
GO

CREATE VIEW [ext].[Golrang_STORECOMMERCE_EXAMPLEVIEW] AS
(
    SELECT
        et.EXAMPLEINT,
        et.EXAMPLESTRING,
        et.EXAMPLEID
    FROM
        [ext].[Golrang_STORECOMMERCE_EXAMPLETABLE] et
)
GO

GRANT SELECT ON OBJECT::[ext].[Golrang_STORECOMMERCE_EXAMPLEVIEW] TO [UsersRole];
GO

GRANT SELECT ON OBJECT::[ext].[Golrang_STORECOMMERCE_EXAMPLEVIEW] TO [DeployExtensibilityRole];
GO

-- Create a stored procedure CRT can use to perform updates.

IF OBJECT_ID(N'[ext].[Golrang_STORECOMMERCE_UPDATEEXAMPLE]', N'P') IS NOT NULL
    DROP PROCEDURE [ext].[Golrang_STORECOMMERCE_UPDATEEXAMPLE]
GO

CREATE PROCEDURE [ext].[Golrang_STORECOMMERCE_UPDATEEXAMPLE]
    @bi_Id           BIGINT,
    @i_ExampleInt    INT,
    @s_ExampleString NVARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON

    UPDATE
        ext.Golrang_STORECOMMERCE_EXAMPLETABLE
    SET
        EXAMPLEINT = @i_ExampleInt,
        EXAMPLESTRING = @s_ExampleString
    WHERE
        EXAMPLEID = @bi_Id
END;
GO

GRANT EXECUTE ON [ext].[Golrang_STORECOMMERCE_UPDATEEXAMPLE] TO [UsersRole];
GO

GRANT EXECUTE ON [ext].[Golrang_STORECOMMERCE_UPDATEEXAMPLE] TO [DeployExtensibilityRole];
GO

-- Create a stored procedure CRT can use to delete Example Entities.

IF OBJECT_ID(N'[ext].[Golrang_STORECOMMERCE_DELETEEXAMPLE]', N'P') IS NOT NULL
    DROP PROCEDURE [ext].Golrang_STORECOMMERCE_DELETEEXAMPLE
GO

CREATE PROCEDURE [ext].Golrang_STORECOMMERCE_DELETEEXAMPLE
    @bi_Id           BIGINT
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM
        ext.Golrang_STORECOMMERCE_EXAMPLETABLE
    WHERE
        EXAMPLEID = @bi_Id
END;
GO

GRANT EXECUTE ON [ext].Golrang_STORECOMMERCE_DELETEEXAMPLE TO [UsersRole];
GO

GRANT EXECUTE ON [ext].Golrang_STORECOMMERCE_DELETEEXAMPLE TO [DeployExtensibilityRole];
GO
