/*
----------------------------------------------------------------------------------------------------
stored procedure: Load bronze layer (source -> bronze)
----------------------------------------------------------------------------------------------------
script purpose:
  This script load data to bronze schema from external csv files
Also
  -This truncate existing table and loading data
  -Use bulk insert to load data from csv

Parameters:
None
this script havent got any parameters

Usage Example:
  EXEC bronze.load_bronze;

****************************************************************************************************

*/


exec bronze.load_bronze

create or alter procedure bronze.load_bronze as
begin

declare @start_time datetime, @end_time datetime , @batch_start_time datetime , @batch_end_time datetime;
set @batch_start_time=getdate();

begin try;
--before update emmpty the existing table if there is something
print '============================================================================';
print 'Load Bronze Layer' ;
print '============================================================================';

print '----------------------------------------------------------------------------';
print 'loading CRM  Tables';
print '----------------------------------------------------------------------------';

set @start_time=getdate();
print '>>Truncate Table'
truncate table bronze.crm_cust_info;
print '>>Inserting Data'

bulk insert bronze.crm_cust_info
from 'E:\projects\Data_WarehouseSQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print '>>Load duration: '+ cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds'


select count(*) from bronze.crm_cust_info;
print '----------------------------------------------------------------------------';
print 'loading CRM  Tables';
print '----------------------------------------------------------------------------';


set @start_time=getdate();
truncate table bronze.crm_prd_info;
print '>>Inserting Data'

bulk insert bronze.crm_prd_info
from 'E:\projects\Data_WarehouseSQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print '>>Load duration: '+ cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds'
select count(*) from bronze.crm_prd_info;



set @start_time=getdate();

truncate table bronze.crm_sales_details;
print '>>Inserting Data'

bulk insert bronze.crm_sales_details
from 'E:\projects\Data_WarehouseSQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print '>>Load duration: '+ cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds'
select count(*) from bronze.erp_loc_a101;



set @start_time=getdate();

truncate table bronze.erp_cust_az12;
print '>>Inserting Data'

bulk insert bronze.erp_cust_az12
from 'E:\projects\Data_WarehouseSQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print '>>Load duration: '+ cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds'
select count(*) from bronze.erp_cust_az12;


set @start_time=getdate();

truncate table bronze.erp_loc_a101;
print '>>Inserting Data'

bulk insert bronze.erp_loc_a101
from 'E:\projects\Data_WarehouseSQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print '>>Load duration: '+ cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds'
select count(*) from bronze.erp_loc_a101;



set @start_time=getdate();

truncate table bronze.erp_px_cat_giv2;

print '>>Inserting Data'

bulk insert bronze.erp_px_cat_giv2
from 'E:\projects\Data_WarehouseSQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (firstrow=2,
fieldterminator=',',
tablock
);

set @end_time=getdate();
print '>>Load duration: '+ cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds'


end try;

begin catch
print '***********************************************************************'
print 'ERROR OCCURED DUSRING LOADING BRONZE LAYER'
print 'Error message '+ ERROR_MESSAGE();
print 'Error Message'+ CAST(ERROR_NUMBER() AS nvarchar);
print 'Error Message' + CASR(ERROR_STATE() AS nvarchar);

end catch

select count(*) from bronze.erp_px_cat_giv2;
end

exec bronze.load_bronze
