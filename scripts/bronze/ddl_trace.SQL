/*
****************************************************************************************************
DDL screipt: creates tablse
****************************************************************************************************
purpose:
  This creates tables in the bronze schema, dropping if already existing data
Run this to re-define the ddl structure of 'bronze' table
****************************************************************************************************
*/

if object_id('bronze.crm_cust_info','u') is not null --if there already exist a table remove it and create again after remove mistakes
drop table bronze.crm_cust_info;

--create the table with apprpiate column names
 create table bronze.crm_cust_info(
 cst_id int, 
 cust_key nvarchar(50),
 cust_firstname nvarchar(50),
 cust_lastname nvarchar(50),
 cust_material_status nvarchar(50),
 cust_gender nvarchar(50),
 cst_create_date date
);

if object_id('bronze.crm_prd_info','u') is not null
drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt datetime,
prd_end_dt datetime
);


if object_id('bronze.crm_sales_details','u') is not null
drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);

create table bronze.erp_loc_a101(
cid nvarchar(50),
cntry nvarchar(50)
);

create table bronze.erp_cust_az12(
cid nvarchar(50),
bdate date,
gen nvarchar(50)
);

create table bronze.erp_px_cat_giv2(
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar(50),
maintenance nvarchar(50)
);
