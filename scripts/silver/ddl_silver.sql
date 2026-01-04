USE SalesDataWareHouse;
GO

PRINT '=================================================================================';
PRINT 'Starting silver Layer Tables Creation...';
PRINT '=================================================================================';
GO


-- Drop table if exists
DROP TABLE IF EXISTS silver.crm_cust_info;
GO

-- Create CRM Customer Information table
CREATE TABLE silver.crm_cust_info (
    cst_id INT                          -- Customer ID (Primary identifier)
    ,cst_key NVARCHAR(50)               -- Customer Business Key (Alternate key)
    ,cst_firstname NVARCHAR(50)         -- Customer First Name
    ,cst_lastname NVARCHAR(50)          -- Customer Last Name
    ,cst_marital_status NVARCHAR(10)    -- Marital Status (Single/Married/Divorced)
    ,cst_gndr NVARCHAR(10)              -- Gender (Male/Female)
    ,cst_create_date DATE               -- Date customer record was created
    ,dwh_create_date datetime DEFAULT getdate()
);
GO

PRINT '✓ Table silver.crm_cust_info created successfully';
GO


-- Drop table if exists
DROP TABLE IF EXISTS silver.crm_prd_info;
GO

-- Create CRM Product Information table
CREATE TABLE silver.crm_prd_info (
    prd_id INT                          -- Product ID (Primary identifier)
    ,prd_key NVARCHAR(50)               -- Product Business Key (Alternate key)
    ,prd_nm NVARCHAR(50)                -- Product Name
    ,prd_cost INT                       -- Product Cost (Manufacturing/Purchase cost)
    ,prd_line NVARCHAR(50)              -- Product Line/Category
    ,prd_start_dt date              -- Product Launch Date
    ,prd_end_dt date                -- Product Discontinuation Date (NULL if active)
    ,dwh_create_date datetime DEFAULT getdate()

);
GO

PRINT '✓ Table silver.crm_prd_info created successfully';
GO

-- Drop table if exists
DROP TABLE IF EXISTS silver.crm_sales_details;
GO

-- Create CRM Sales Details table
CREATE TABLE silver.crm_sales_details (
    sls_ord_num NVARCHAR(50)            -- Sales Order Number (Transaction ID)
    ,sls_prd_key NVARCHAR(50)           -- Product Key (Foreign key to products)
    ,sls_cust_id INT                    -- Customer ID (Foreign key to customers)
    ,sls_order_dt INT                   -- Order Date (Format: YYYYMMDD as integer)
    ,sls_ship_dt INT                    -- Ship Date (Format: YYYYMMDD as integer)
    ,sls_due_dt INT                     -- Due Date (Format: YYYYMMDD as integer)
    ,sls_sales INT                      -- Total Sales Amount
    ,sls_quantity INT                   -- Quantity Sold
    ,sls_price INT                      -- Unit Price
    ,dwh_create_date datetime DEFAULT getdate()

);
GO

PRINT '✓ Table silver.crm_sales_details created successfully';
GO

-- Drop table if exists
DROP TABLE IF EXISTS silver.erp_loc_a101;
GO

-- Create ERP Location table
CREATE TABLE silver.erp_loc_a101 (
    cid NVARCHAR(50)                    -- Customer ID (Links to customer data)
    ,cntry NVARCHAR(50)                 -- Country Name/Code
    ,dwh_create_date datetime DEFAULT getdate()

);
GO

PRINT '✓ Table silver.erp_loc_a101 created successfully';
GO

-- Drop table if exists
DROP TABLE IF EXISTS silver.erp_cust_az12;
GO

-- Create ERP Customer Demographics table
CREATE TABLE silver.erp_cust_az12 (
    cid NVARCHAR(50)                    -- Customer ID (Links to customer data)
    ,bdate DATE                         -- Birth Date (Date of Birth)
    ,gen NVARCHAR(50)                   -- Gender
    ,dwh_create_date datetime DEFAULT getdate()

);
GO

PRINT '✓ Table silver.erp_cust_az12 created successfully';
GO


-- Drop table if exists
DROP TABLE IF EXISTS silver.erp_px_cat_g1v2;
GO

-- Create ERP Product Category table
CREATE TABLE silver.erp_px_cat_g1v2 (
    id NVARCHAR(50)                     -- Product ID (Links to product data)
    ,cat NVARCHAR(50)                   -- Main Category
    ,subcat NVARCHAR(50)                -- Sub-Category
    ,maintenance NVARCHAR(50)           -- Maintenance Requirements/Schedule
    ,dwh_create_date datetime DEFAULT getdate()

);
GO

