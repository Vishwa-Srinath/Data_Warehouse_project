/*
create Database and schemas
script purpose::
this script creates a new databse named 'DataWareHouse' and also check weather it ailready exist.
if there is database in  same name it dropped and recreated. Also here create 3 schemas bronze,silver and gold.

WARNING:
With this script you current 'DataWareHouse' databse drops and all data in that is permanently deleted.

*/

use master;

--Drop and recreate 'DataWareHouse' database
if exists (select 1 from sys.databases where name="DataWareHouse")
begin
  alter DATABASE DataWareHouse set SINGLE_USER with rollback immediate;
end;
go
  
--create the 'DataWareHouse' databse
create database DataWareHouse;

use DataWareHouse;
--create schemas
create schema bronze;
go 
create schema silver;
go
create schema gold;
go
