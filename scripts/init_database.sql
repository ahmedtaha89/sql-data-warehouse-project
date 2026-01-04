/*
=========================================================================
    Create SalesDataWareHouse DATABASE with Medallion Architecture
=========================================================================
Creates Bronze, Silver, and Gold schemas for data warehouse layers
WARNING: This will DROP the existing database if it exists!
=========================================================================
*/

USE master;
GO

-- Close all connections and drop database if exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SalesDataWareHouse')
BEGIN
    PRINT 'Dropping existing SalesDataWareHouse database...';
    ALTER DATABASE SalesDataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SalesDataWareHouse;
    PRINT 'Database dropped successfully.';
END
GO

-- Create new database
PRINT 'Creating SalesDataWareHouse database...';
CREATE DATABASE SalesDataWareHouse;
GO

USE SalesDataWareHouse;
GO

-- Create Bronze Schema (Raw Data Layer)
PRINT 'Creating Bronze schema...';
GO
CREATE SCHEMA bronze;
GO

-- Create Silver Schema (Cleansed Data Layer)
PRINT 'Creating Silver schema...';
GO
CREATE SCHEMA silver;
GO

-- Create Gold Schema (Business Layer)
PRINT 'Creating Gold schema...';
GO
CREATE SCHEMA gold;
GO

PRINT 'SalesDataWareHouse setup completed successfully!';
GO