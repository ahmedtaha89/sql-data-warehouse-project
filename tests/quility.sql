
--------------------------------------------------------------------
/* Testing For CRM Customer information TABLE */
-- CHECK NULL OR dublicate VALUES
-- Expectation: No Result
SELECT cst_id , COUNT(*) AS c
FROM silver.crm_cust_info 
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS null


-- CHECK for unknown space for first AND last name
-- Expectation: No Result
SELECT cst_lastname FROM silver.crm_cust_info
WHERE cst_lastname != trim(cst_lastname)

-- CHECK marital status for customer 
-- Expectation IN (sigle,married,n/a)
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info


-- CHECK Gender for customer 
-- Expectation IN (Male,Female,n/a)
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info

-- CHECK creating date 
-- Expectation No Date Greater Than Today
SELECT cst_create_date FROM bronze.crm_cust_info
WHERE cst_create_date >= GETDATE()
ORDER BY cst_create_date desc

--------------------------------------------------------------------------------------------------
SELECT * FROM bronze.crm_prd_info

SELECT prd_id,COUNT(*) FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING prd_id IS null

--CHECK prd_cost IS inter AND don't NULL OR negative value
SELECT prd_cost FROM bronze.crm_prd_info
WHERE prd_cost IS NULL

---------------------------------------------------------
/*Test CRM Sales*/
