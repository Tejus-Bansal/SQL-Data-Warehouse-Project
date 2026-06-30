/*
  PURPOSE OF SCRIPT: This script creates the Bronze layer tables of the data warehouse following the Medallion Architecture.
           These tables act as the landing zone for raw data imported from the organization's CRM and ERP source systems.

            The script performs the following tasks:

                # Checks whether each Bronze table already exists.
                # Drops the existing table if found to ensure a clean recreation.
                # Creates six raw data tables in the bronze schema:
                    - crm_cust_info – Customer information from the CRM system.
                    - crm_prd_info – Product master data from the CRM system.
                    - crm_sales_details – Sales transaction data from the CRM system.
                    - erp_cust_az12 – Customer demographic data from the ERP system.
                    - erp_loc_a101 – Customer location data from the ERP system.
                    - erp_px_cat_g1v2 – Product category and maintenance data from the ERP system.

  WARNING: Before creating each table, the script checks if it already exists and, if so, permanently drops it using DROP TABLE.

            Running this script will:

                # Delete all existing data stored in the Bronze tables.
                # Remove any indexes, constraints, or triggers associated with those tables.
                # Recreate the tables with the schema defined in this script.

            Run this script only when:
            
                # Setting up the project for the first time.
                # Resetting the Bronze layer during development or testing.
                # Intentionally recreating the table structures.
*/
USE DataWarehouse;
GO

IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info
CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info
CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost NVARCHAR(50),
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
);

IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12
CREATE TABLE bronze.erp_cust_az12(
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101
CREATE TABLE bronze.erp_loc_a101(
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2
CREATE TABLE bronze.erp_px_cat_g1v2(
	ID NVARCHAR(50),
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(50)
);
