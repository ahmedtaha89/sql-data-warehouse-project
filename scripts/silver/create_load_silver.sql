CREATE
	OR

ALTER PROC silver.load_silver
AS
PRINT '==============================================================================';
PRINT 'Load Silver Layer'
PRINT '==============================================================================';
PRINT '-------------------------------------------------';
PRINT 'Load crm_cust_info silver layer';
PRINT '-------------------------------------------------';
GO

PRINT 'Truncate Table crm_cust_info';

TRUNCATE TABLE silver.crm_cust_info;

PRINT 'Inserting Data INTO crm_cust_info';

INSERT INTO silver.crm_cust_info (
	cst_id
	,cst_key
	,cst_firstname
	,cst_lastname
	,cst_marital_status
	,cst_gndr
	,cst_create_date
	)
SELECT cst_id
	,cst_key
	,TRIM(cst_firstname) AS cst_firstname
	,TRIM(cst_lastname) AS cst_lastname
	,CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'M'
			THEN 'Married'
		WHEN UPPER(TRIM(cst_marital_status)) = 'S'
			THEN 'Single'
		ELSE 'n/a'
		END AS cst_marital_status
	,CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'M'
			THEN 'Male'
		WHEN UPPER(TRIM(cst_gndr)) = 'F'
			THEN 'Female'
		ELSE 'n/a'
		END AS cst_gndr
	,cst_create_date
FROM (
	SELECT *
		,ROW_NUMBER() OVER (
			PARTITION BY cst_key ORDER BY cst_create_date
			) AS rn
	FROM bronze.crm_cust_info
	WHERE cst_id IS NOT NULL
	) AS CST_TABLE
WHERE RN = 1
GO

PRINT '-------------------------------------------------';
PRINT 'Load crm_prd_info silver layer';
PRINT '-------------------------------------------------';
PRINT 'Truncate Table crm_cust_info';

TRUNCATE TABLE silver.crm_prd_info;

PRINT 'Inserting Data INTO crm_prd_info';

INSERT INTO silver.crm_prd_info (
	prd_id
	,prd_key
	,prd_nm
	,prd_cost
	,prd_line
	,prd_start_dt
	,prd_end_dt
	)
SELECT prd_id
	,UPPER(REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_')) AS prd_key
	,prd_nm
	,ISNULL(prd_cost, 0) AS prd_cost
	,CASE 
		WHEN UPPER(prd_line) = 'S'
			THEN 'Other Sales'
		WHEN UPPER(prd_line) = 'R'
			THEN 'Road'
		WHEN UPPER(prd_line) = 'M'
			THEN 'Mounting'
		WHEN UPPER(prd_line) = 'T'
			THEN 'Touring'
		ELSE 'n/a'
		END AS prd_line
	,cast(prd_start_dt AS DATE) AS prd_start_dt
	,cast(LEAD(prd_start_dt) OVER (
			PARTITION BY prd_key ORDER BY prd_start_dt
			) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info
GO

PRINT '-------------------------------------------------';
PRINT 'Load crm_sales_details silver layer';
PRINT '-------------------------------------------------';
PRINT 'Truncate Table crm_cust_info';

TRUNCATE TABLE silver.crm_sales_details;

PRINT 'Inserting Data INTO crm_sales_details';

INSERT INTO silver.crm_sales_details (
	sls_ord_num
	,sls_prd_key
	,sls_cust_id
	,sls_ship_dt
	,sls_order_dt
	,sls_due_dt
	,sls_sales
	,sls_quantity
	,sls_price
	)
SELECT sls_ord_num
	,sls_prd_key
	,sls_cust_id
	,CASE 
		WHEN sls_ship_dt = 0
			OR len(sls_ship_dt) != 8
			THEN NULL
		ELSE CAST(cast(sls_ship_dt AS NVARCHAR) AS DATE)
		END AS sls_ship_dt
	,CASE 
		WHEN sls_order_dt = 0
			OR len(sls_order_dt) != 8
			THEN NULL
		ELSE CAST(cast(sls_order_dt AS NVARCHAR) AS DATE)
		END AS sls_order_dt
	,CASE 
		WHEN sls_due_dt = 0
			OR len(sls_due_dt) != 8
			THEN NULL
		ELSE CAST(cast(sls_due_dt AS NVARCHAR) AS DATE)
		END AS sls_due_dt
	,CASE 
		WHEN sls_sales IS NULL
			OR sls_sales <= 0
			OR sls_sales != sls_quantity * sls_price
			THEN abs(sls_price) / sls_quantity
		ELSE sls_sales
		END AS sls_sales
	,sls_quantity
	,CASE 
		WHEN sls_price IS NULL
			OR sls_price <= 0
			THEN abs(sls_sales) / sls_quantity
		ELSE sls_price
		END AS sls_price
FROM bronze.crm_sales_details
GO

PRINT '-------------------------------------------------';
PRINT 'Load erp_cust_az12 silver layer';
PRINT '-------------------------------------------------';
PRINT 'Truncate Table erp_cust_az12';

TRUNCATE TABLE silver.erp_cust_az12;

PRINT 'Inserting Data INTO erp_cust_az12';

INSERT INTO silver.erp_cust_az12 (
	cid
	,bdate
	,gen
	)
SELECT CASE 
		WHEN cid LIKE 'NAS%'
			THEN SUBSTRING(cid, 4, LEN(cid))
		ELSE cid
		END AS cid
	,CASE 
		WHEN bdate >= getdate()
			THEN NULL
		ELSE bdate
		END AS bdate
	,CASE 
		WHEN trim(gen) IN (
				'F'
				,'FEMALE'
				)
			THEN 'Female'
		WHEN trim(gen) IN (
				'M'
				,'MALE'
				)
			THEN 'Male'
		ELSE 'n/a'
		END AS gen
FROM bronze.erp_cust_az12
GO

PRINT '-------------------------------------------------';
PRINT 'Load erp_loc_a101 silver layer';
PRINT '-------------------------------------------------';
PRINT 'Truncate Table erp_loc_a101';

TRUNCATE TABLE silver.erp_loc_a101;

PRINT 'Inserting Data INTO erp_loc_a101';

INSERT INTO silver.erp_loc_a101 (
	cid
	,cntry
	)
SELECT REPLACE(cid, '-', '') AS cid
	,CASE 
		WHEN trim(cntry) IN (
				'US'
				,'USA'
				)
			THEN 'United States'
		WHEN trim(cntry) IN ('De')
			THEN 'Germany'
		WHEN trim(cntry) IS NULL
			OR cntry = ''
			THEN 'n/a'
		ELSE trim(cntry)
		END AS cntry
FROM bronze.[erp_loc_a101]
ORDER BY cntry
GO

PRINT '-------------------------------------------------';
PRINT 'Load erp_px_cat_g1v2 silver layer';
PRINT '-------------------------------------------------';
PRINT 'Truncate Table [erp_px_cat_g1v2]';

TRUNCATE TABLE silver.[erp_px_cat_g1v2];

PRINT 'Inserting Data INTO [erp_px_cat_g1v2]';

INSERT INTO silver.[erp_px_cat_g1v2] (
	id
	,cat
	,subcat
	,maintenance
	)
SELECT *
FROM bronze.erp_px_cat_g1v2
GO

exec silver.load_silver
