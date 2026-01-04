/*
=================================================================================
    BRONZE LAYER - RAW DATA TABLES CREATION SCRIPT
=================================================================================
Purpose:
    This script creates raw data tables in the Bronze schema layer for the 
    Sales Data Warehouse. Bronze layer stores unprocessed data from source systems.

Source Systems:
    - CRM System: Customer, Product, and Sales data
    - ERP System: Location, Customer demographic, and Product category data

WARNING: 
    ⚠️ This script will DROP existing tables if they already exist!
    ⚠️ All data in existing tables will be LOST!
    ⚠️ Ensure you have a backup before running this script.

Tables Created:
    1. bronze.crm_cust_info      - CRM Customer Information
    2. bronze.crm_prd_info       - CRM Product Information  
    3. bronze.crm_sales_details  - CRM Sales Transaction Details
    4. bronze.erp_loc_a101       - ERP Location/Country Data
    5. bronze.erp_cust_az12      - ERP Customer Demographics
    6. bronze.erp_px_cat_g1v2    - ERP Product Category/Maintenance Info
=================================================================================
*/

USE SalesDataWareHouse;
GO

PRINT '=================================================================================';
PRINT 'Starting Bronze Layer Tables Creation...';
PRINT '=================================================================================';
GO

/*
---------------------------------------------------------------------------------
    TABLE 1: bronze.crm_cust_info
---------------------------------------------------------------------------------
Description: Customer master data from CRM system
Source: CRM Database
Contains: Customer personal information including demographics and marital status
*/

-- Drop table if exists
DROP TABLE IF EXISTS bronze.crm_cust_info;
GO

-- Create CRM Customer Information table
CREATE TABLE bronze.crm_cust_info (
    cst_id INT                          -- Customer ID (Primary identifier)
    ,cst_key NVARCHAR(50)               -- Customer Business Key (Alternate key)
    ,cst_firstname NVARCHAR(50)         -- Customer First Name
    ,cst_lastname NVARCHAR(50)          -- Customer Last Name
    ,cst_marital_status NVARCHAR(10)    -- Marital Status (Single/Married/Divorced)
    ,cst_gndr NVARCHAR(10)              -- Gender (Male/Female)
    ,cst_create_date DATE               -- Date customer record was created
);
GO

PRINT '✓ Table bronze.crm_cust_info created successfully';
GO

/*
---------------------------------------------------------------------------------
    TABLE 2: bronze.crm_prd_info
---------------------------------------------------------------------------------
Description: Product master data from CRM system
Source: CRM Database
Contains: Product details including pricing, product line, and lifecycle dates
*/

-- Drop table if exists
DROP TABLE IF EXISTS bronze.crm_prd_info;
GO

-- Create CRM Product Information table
CREATE TABLE bronze.crm_prd_info (
    prd_id INT                          -- Product ID (Primary identifier)
    ,prd_key NVARCHAR(50)               -- Product Business Key (Alternate key)
    ,prd_nm NVARCHAR(50)                -- Product Name
    ,prd_cost INT                       -- Product Cost (Manufacturing/Purchase cost)
    ,prd_line NVARCHAR(50)              -- Product Line/Category
    ,prd_start_dt DATETIME              -- Product Launch Date
    ,prd_end_dt DATETIME                -- Product Discontinuation Date (NULL if active)
);
GO

PRINT '✓ Table bronze.crm_prd_info created successfully';
GO

/*
---------------------------------------------------------------------------------
    TABLE 3: bronze.crm_sales_details
---------------------------------------------------------------------------------
Description: Sales transaction details from CRM system
Source: CRM Database - Sales Orders
Contains: Detailed sales transactions including quantities, pricing, and dates
Note: Date columns stored as INT (likely in YYYYMMDD format) - needs transformation
*/

-- Drop table if exists
DROP TABLE IF EXISTS bronze.crm_sales_details;
GO

-- Create CRM Sales Details table
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50)            -- Sales Order Number (Transaction ID)
    ,sls_prd_key NVARCHAR(50)           -- Product Key (Foreign key to products)
    ,sls_cust_id INT                    -- Customer ID (Foreign key to customers)
    ,sls_order_dt INT                   -- Order Date (Format: YYYYMMDD as integer)
    ,sls_ship_dt INT                    -- Ship Date (Format: YYYYMMDD as integer)
    ,sls_due_dt INT                     -- Due Date (Format: YYYYMMDD as integer)
    ,sls_sales INT                      -- Total Sales Amount
    ,sls_quantity INT                   -- Quantity Sold
    ,sls_price INT                      -- Unit Price
);
GO

PRINT '✓ Table bronze.crm_sales_details created successfully';
GO

/*
---------------------------------------------------------------------------------
    TABLE 4: bronze.erp_loc_a101
---------------------------------------------------------------------------------
Description: Location/Country mapping from ERP system
Source: ERP System
Contains: Customer location and country information
*/

-- Drop table if exists
DROP TABLE IF EXISTS bronze.erp_loc_a101;
GO

-- Create ERP Location table
CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50)                    -- Customer ID (Links to customer data)
    ,cntry NVARCHAR(50)                 -- Country Name/Code
);
GO

PRINT '✓ Table bronze.erp_loc_a101 created successfully';
GO

/*
---------------------------------------------------------------------------------
    TABLE 5: bronze.erp_cust_az12
---------------------------------------------------------------------------------
Description: Customer demographic data from ERP system
Source: ERP System
Contains: Additional customer attributes like birth date and gender
*/

-- Drop table if exists
DROP TABLE IF EXISTS bronze.erp_cust_az12;
GO

-- Create ERP Customer Demographics table
CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50)                    -- Customer ID (Links to customer data)
    ,bdate DATE                         -- Birth Date (Date of Birth)
    ,gen NVARCHAR(50)                   -- Gender
);
GO

PRINT '✓ Table bronze.erp_cust_az12 created successfully';
GO

/*
---------------------------------------------------------------------------------
    TABLE 6: bronze.erp_px_cat_g1v2
---------------------------------------------------------------------------------
Description: Product category and maintenance information from ERP system
Source: ERP System
Contains: Product categorization and maintenance requirements
*/

-- Drop table if exists
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
GO

-- Create ERP Product Category table
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50)                     -- Product ID (Links to product data)
    ,cat NVARCHAR(50)                   -- Main Category
    ,subcat NVARCHAR(50)                -- Sub-Category
    ,maintenance NVARCHAR(50)           -- Maintenance Requirements/Schedule
);
GO

