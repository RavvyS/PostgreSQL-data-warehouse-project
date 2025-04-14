/*
Create database and schemas-

script purpose-
frist we check weather the our database name is alredy exists or not , if exists we will drop that database and creta our database.
additionaly we create a three schemas 'bronze','silver' and 'gold'.

warning-
BE CAUTON!!
runnig this script will delete permanetely the existing database. so make sure that you already got a backup of the database..

*/

IF EXISTS (SELECT 1 FROM sys.database WHERE name='datawarehouse')
BEGIN
	ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE datawarehouse;
END;


CREATE DATABASE datawarehouse;
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
