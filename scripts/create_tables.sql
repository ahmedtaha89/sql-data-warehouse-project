/*
==================================================================
		CREATE Tables According ERP AND CRM Sources
==================================================================

This IS sript creates Sturcture of tables Using DDL queries.
the following Tables:
1-crm_product_info
2-crm_customer_info
3-crm_sales_details
4-erp_customer_info
5-erp_location_details
6-erp_product_details
*/

use DataWareHouseProject;
Go


-- Creating customers informations table from crm system 
CREATE TABLE bronze.crm_customer_info (
cst_id	int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(10),
cst_gndr nvarchar(10),
cst_create_date datetime);
go


-- Creating Products informations table from crm system
CREATE TABLE bronze.crm_product_info (
prd_id	int,
prd_key	nvarchar(50),
prd_nm	nvarchar(100),
prd_cost	int,
prd_line	nvarchar(10),
prd_start_dt datetime,
prd_end_dt datetime);

go
-- Creating Sales details table from crm system
CREATE TABLE bronze.crm_sales_details (
sls_ord_num	nvarchar(50),
sls_prd_key	nvarchar(50),
sls_cust_id	int,
sls_order_dt int,	
sls_ship_dt	int,
sls_due_dt	int,
sls_sales	int,
sls_quantity int,	
sls_price int);

go


-- Creating Sales details table from erp system
CREATE TABLE bronze.erp_customer_info (
CID	nvarchar(100),
BDATE datetime,
GEN nvarchar(10));
go

6-erp_product_details

-- Creating location details table from erp system
CREATE TABLE bronze.erp_location_details (
CID	nvarchar(50),
CNTRY nvarchar(10));
go



-- Creating location details table from erp system
--CREATE TABLE bronze.erp_product_details (
--ID	CAT	SUBCAT	MAINTENANCE

--CID	nvarchar(50),
--CNTRY nvarchar(10));

go

	

