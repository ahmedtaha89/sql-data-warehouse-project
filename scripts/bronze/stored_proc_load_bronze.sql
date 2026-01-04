CREATE OR ALTER PROC bronze.load_bronze AS
begin
declare @start_time datetime, @start_batch datetime , @end_time datetime, @end_batch datetime;

begin try

set @start_batch = getdate();

print '***************************************'
print '         Loading Bronzd Layer';
print '***************************************'


print '---------------------------------------';
print 'Loading CRM Tables';
print '---------------------------------------';


SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_cust_info';
truncate table bronze.crm_cust_info
PRINT '>> Inserting Data Into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Courses\Prjects\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK);
SET @end_time = GETDATE();
print 'Loading Duration: ' + cast(datediff(second,@start_time,@end_time) AS varchar)
print '-------------------------------------'


SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_prd_info';
truncate table bronze.crm_prd_info
PRINT '>> Inserting Data Into: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Courses\Prjects\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
firstrow = 2 ,
FIELDTERMINATOR = ',',
TABLOCK);
SET @end_time = GETDATE();
print 'Loading Duration: ' + cast(datediff(second,@start_time,@end_time) AS varchar)
print '-------------------------------------'



SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_sales_details';
truncate table bronze.crm_sales_details
PRINT '>> Inserting Data Into: bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM 'C:\Courses\Prjects\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
firstrow = 2,
FIELDTERMINATOR = ',',
TABLOCK);
SET @end_time = GETDATE();
print 'Loading Duration: ' + cast(datediff(second,@start_time,@end_time) AS varchar)
print '-------------------------------------'


print '---------------------------------------';
print 'Loading ERP Tables';
print '---------------------------------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12
PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Courses\Prjects\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH(
firstrow=2,
fieldterminator = ',',
tablock);
SET @end_time = GETDATE();
print 'Loading Duration: ' + cast(datediff(second,@start_time,@end_time) AS varchar)
print '-------------------------------------'

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101
PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Courses\Prjects\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH(
firstrow=2,
fieldterminator = ',',
tablock);
SET @end_time = GETDATE();
print 'Loading Duration: ' + cast(datediff(second,@start_time,@end_time) AS varchar)
print '-------------------------------------'

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_loc_a101';
truncate table bronze.erp_px_cat_g1v2
PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Courses\Prjects\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
firstrow=2,
fieldterminator = ',',
tablock);
SET @end_time = GETDATE();
print 'Loading Duration: ' + cast(datediff(second,@start_time,@end_time) AS varchar)
print '-------------------------------------'


set @end_batch = getdate();
print 'Bronze Layer IS completed'
print 'Total Loading Duration: ' + cast(datediff(second,@start_batch,@end_batch) AS varchar)
print '-------------------------------------'



END try
begin catch
print '**********************************************************';
print 'Error Message: ' + ERROR_MESSAGE();
print '**********************************************************';
END catch

end 

exec bronze.load_bronze