/*
  PURPOSE OF SCRIPT:
    This script initializes the DataWarehouse database by creating a clean database environment for the data warehouse project. 
    It performs the following tasks:

        # Checks whether a database named DataWarehouse already exists.
        # If it exists, forces all active connections to close and deletes the database.
        # Creates a new DataWarehouse database.
        # Creates the three schemas used in the Medallion Architecture:
        # bronze – Stores raw data ingested from source systems.
        # silver – Stores cleaned, validated, and transformed data.
        # gold – Stores business-ready, analytics-friendly data for reporting and dashboards.

    Run this script only when setting up the project for the first time or when a complete reset of the database is required.

  WARNING:
    Executing this script will:

        # Permanently delete the existing DataWarehouse database (if it exists).
        # Remove all tables, data, stored procedures, views, indexes, and other database objects within that database.
        # Forcefully disconnect all users connected to the database using SINGLE_USER WITH ROLLBACK IMMEDIATE, rolling back any uncommitted transactions.

    Do not run this script on a production or any database containing important data unless you have a verified backup and intentionally want to recreate the database from scratch.
*/

USE master;
GO

-- drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
		ALTER DATABASE DataWarehouse
		SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		Drop DATABASE DataWarehouse
END;
GO

-- create the database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
USE DataWarehouse;

-- create the schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
