/*
DDL Script: create Bronze tables

scripts purpose:
    this script creates tables in the 'bronze' schema and drop all the tabels if they already exits.


*/






CALL bronze.load_bronze();


CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP := clock_timestamp();
    batch_end_time TIMESTAMP;
BEGIN
    RAISE NOTICE 'LOADING Bronze layer';
    RAISE NOTICE 'Loading CRM tables';

    -- CRM Table 1
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_cust_info;
    COPY bronze.crm_cust_info
    FROM '/Users/ravindusandun/Documents/Ds/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
    WITH (FORMAT csv, HEADER, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- CRM Table 2
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_prd_info;
    COPY bronze.crm_prd_info
    FROM '/Users/ravindusandun/Documents/Ds/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
    WITH (FORMAT csv, HEADER, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- CRM Table 3
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_sales_details;
    COPY bronze.crm_sales_details
    FROM '/Users/ravindusandun/Documents/Ds/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
    WITH (FORMAT csv, HEADER, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    RAISE NOTICE 'Loading ERP tables';

    -- ERP Table 1
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_cust_az12;
    COPY bronze.erp_cust_az12
    FROM '/Users/ravindusandun/Documents/Ds/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
    WITH (FORMAT csv, HEADER, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- ERP Table 2
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_loc_a101;
    COPY bronze.erp_loc_a101
    FROM '/Users/ravindusandun/Documents/Ds/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
    WITH (FORMAT csv, HEADER, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- ERP Table 3
    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    COPY bronze.erp_px_cat_g1v2
    FROM '/Users/ravindusandun/Documents/Ds/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (FORMAT csv, HEADER, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE 'Duration: % seconds', EXTRACT(EPOCH FROM end_time - start_time);

    -- Final Summary
    batch_end_time := clock_timestamp();
    RAISE NOTICE 'Bronze layer completed successfully.';
    RAISE NOTICE 'Total load duration: % seconds', EXTRACT(EPOCH FROM batch_end_time - batch_start_time);

EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING 'Something went wrong: %', SQLERRM;
        RAISE WARNING 'ERROR occurred during loading Bronze layer.';
END;
$$;

