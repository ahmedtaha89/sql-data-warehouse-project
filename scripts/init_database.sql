/*

====================================================================
						CREATE DATABASE AND SCHEMA 
====================================================================

Script Purpose:
This script creates DATABASE called DataWareHouseProject AND checking if it EXISTS OR NOT 
AND SCHEMAS => bronze,silver,gold

Warning:
If DATABASE EXISTS these script will DELETE AND ReCreate it AND remove ALL data be careful AND make backups before run script 

*/

use master;
Go

-- Checking the DATABASE Exists OR NOT 
if EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWareHouseProject')
begin 
    ALTER DATABASE DataWareHouseProject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWareHouseProject;
END;
GO



-- Create the 'DataWareHouseProject' database
CREATE DATABASE DataWareHouseProject;
GO
use DataWareHouseProject;
GO

CREATE SCHEMA bronze;
Go
CREATE SCHEMA silver;
Go
CREATE SCHEMA glod;

