CREATE OR REPLACE PROCEDURE bronze.load_bronze(
    p_datasets_path TEXT DEFAULT '/home/just/Projects/DB Avanzadas/isw623-ejercicio07-JosueVargas/01_datasets'
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_base_path        TEXT;
    v_start_time       TIMESTAMP;
    v_end_time         TIMESTAMP;
    v_batch_start_time TIMESTAMP;
    v_batch_end_time   TIMESTAMP;
    v_row_count        BIGINT;
    v_err_msg          TEXT;
    v_err_state        TEXT;
BEGIN
    v_batch_start_time := clock_timestamp();

    BEGIN
        PERFORM pg_stat_file(p_datasets_path || '/source_crm/cust_info.csv');
        v_base_path := p_datasets_path;
    EXCEPTION WHEN OTHERS THEN
        v_base_path := '/var/lib/postgres/data/01_datasets';
    END;

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    v_start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_cust_info;
    EXECUTE format(
        'COPY bronze.crm_cust_info FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')',
        v_base_path || '/source_crm/cust_info.csv'
    );
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := clock_timestamp();
    RAISE NOTICE '>> bronze.crm_cust_info: % rows (% s)',
        v_row_count, ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 3);

    v_start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_prd_info;
    EXECUTE format(
        'COPY bronze.crm_prd_info FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')',
        v_base_path || '/source_crm/prd_info.csv'
    );
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := clock_timestamp();
    RAISE NOTICE '>> bronze.crm_prd_info: % rows (% s)',
        v_row_count, ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 3);

    v_start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_sales_details;
    EXECUTE format(
        'COPY bronze.crm_sales_details FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')',
        v_base_path || '/source_crm/sales_details.csv'
    );
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := clock_timestamp();
    RAISE NOTICE '>> bronze.crm_sales_details: % rows (% s)',
        v_row_count, ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 3);

    v_start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_loc_a101;
    EXECUTE format(
        'COPY bronze.erp_loc_a101 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')',
        v_base_path || '/source_erp/LOC_A101.csv'
    );
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := clock_timestamp();
    RAISE NOTICE '>> bronze.erp_loc_a101: % rows (% s)',
        v_row_count, ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 3);

    v_start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_cust_az12;
    EXECUTE format(
        'COPY bronze.erp_cust_az12 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')',
        v_base_path || '/source_erp/CUST_AZ12.csv'
    );
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := clock_timestamp();
    RAISE NOTICE '>> bronze.erp_cust_az12: % rows (% s)',
        v_row_count, ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 3);

    v_start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    EXECUTE format(
        'COPY bronze.erp_px_cat_g1v2 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')',
        v_base_path || '/source_erp/PX_CAT_G1V2.csv'
    );
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := clock_timestamp();
    RAISE NOTICE '>> bronze.erp_px_cat_g1v2: % rows (% s)',
        v_row_count, ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 3);

    v_batch_end_time := clock_timestamp();
    RAISE NOTICE '================================================';
    RAISE NOTICE 'Bronze Layer Loaded in % seconds',
        ROUND(EXTRACT(EPOCH FROM (v_batch_end_time - v_batch_start_time))::NUMERIC, 3);
    RAISE NOTICE '================================================';

EXCEPTION
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS
            v_err_msg   = MESSAGE_TEXT,
            v_err_state = RETURNED_SQLSTATE;
        RAISE NOTICE 'ERROR LOADING BRONZE LAYER [%]: %', v_err_state, v_err_msg;
        RAISE;
END;
$$;
