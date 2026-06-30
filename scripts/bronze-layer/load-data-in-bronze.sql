/*
  PURPOSE: This script creates the bronze.load_bronze stored procedure, which automates loading raw CRM and ERP data into the Bronze layer of the data warehouse. 
  It truncates existing data, performs high-performance bulk inserts from CSV files, logs the execution time for each table and the overall load, 
  and handles errors using a TRY...CATCH block.

  WARNING: This procedure performs a full reload of the Bronze layer.

            # All existing data in the Bronze tables is permanently removed using TRUNCATE TABLE before loading new data.
            # The BULK INSERT file paths are hardcoded and must be updated to match your local environment.
            # SQL Server must have permission to access the source CSV files.
            # TABLOCK is used to improve bulk load performance by locking the target table during data import.
*/

-- creating a stored procedure to load the data as it is from the source in BRONZE LAYER
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY

		DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
		SET @batch_start_time = GETDATE();

		PRINT '======================================================';
		PRINT 'Loading the crm files:';
		PRINT '======================================================';

		SET @start_time = GETDATE();
		PRINT 'Truncating table: bronze.crm_cust_info';
		PRINT '------------------------------------------------------';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserting data in table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Tejus Bansal\Desktop\sql datawarehouse project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT 'Time taken to load the table: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @start_time = GETDATE();
		PRINT 'Truncating table: bronze.crm_prd_info';
		PRINT '------------------------------------------------------';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT 'Inserting data in table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Tejus Bansal\Desktop\sql datawarehouse project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT 'Time taken to load the table: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @start_time = GETDATE();
		PRINT 'Truncating table: bronze.crm_sales_details';
		PRINT '------------------------------------------------------';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT 'Inserting in table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Tejus Bansal\Desktop\sql datawarehouse project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT 'Time taken to load the table: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @start_time = GETDATE();
		PRINT 'Truncating table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '------------------------------------------------------';

		PRINT 'Inserting in table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Tejus Bansal\Desktop\sql datawarehouse project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT 'Time taken to load the table: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @start_time = GETDATE();
		PRINT 'Truncating table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '------------------------------------------------------';

		PRINT 'Inserting in table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Tejus Bansal\Desktop\sql datawarehouse project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT 'Time taken to load the table: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @start_time = GETDATE();
		PRINT 'Truncating table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '------------------------------------------------------';

		PRINT 'Inserting in table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Tejus Bansal\Desktop\sql datawarehouse project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT 'Time taken to load the table: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @batch_end_time = GETDATE();
		PRINT 'Time elapsed in loading all the tables in bronze layer: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+ 'seconds'; 
	END TRY
	BEGIN CATCH
		PRINT '======================================================';
		PRINT 'AN ERROE OCCURED WHILE LOADING THE BRONZE LAYER!!!!!!';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '======================================================';
	END CATCH
END;
