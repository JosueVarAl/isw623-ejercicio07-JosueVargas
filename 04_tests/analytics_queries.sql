SELECT 'bronze.crm_cust_info'     AS objeto, COUNT(*) AS filas FROM bronze.crm_cust_info
UNION ALL SELECT 'bronze.crm_prd_info',      COUNT(*) FROM bronze.crm_prd_info
UNION ALL SELECT 'bronze.crm_sales_details', COUNT(*) FROM bronze.crm_sales_details
UNION ALL SELECT 'bronze.erp_cust_az12',     COUNT(*) FROM bronze.erp_cust_az12
UNION ALL SELECT 'bronze.erp_loc_a101',      COUNT(*) FROM bronze.erp_loc_a101
UNION ALL SELECT 'bronze.erp_px_cat_g1v2',   COUNT(*) FROM bronze.erp_px_cat_g1v2
UNION ALL SELECT 'silver.crm_cust_info',     COUNT(*) FROM silver.crm_cust_info
UNION ALL SELECT 'silver.crm_prd_info',      COUNT(*) FROM silver.crm_prd_info
UNION ALL SELECT 'silver.crm_sales_details', COUNT(*) FROM silver.crm_sales_details
UNION ALL SELECT 'silver.erp_cust_az12',     COUNT(*) FROM silver.erp_cust_az12
UNION ALL SELECT 'silver.erp_loc_a101',      COUNT(*) FROM silver.erp_loc_a101
UNION ALL SELECT 'silver.erp_px_cat_g1v2',   COUNT(*) FROM silver.erp_px_cat_g1v2
UNION ALL SELECT 'gold.dim_customers',       COUNT(*) FROM gold.dim_customers
UNION ALL SELECT 'gold.dim_products',        COUNT(*) FROM gold.dim_products
UNION ALL SELECT 'gold.fact_sales',          COUNT(*) FROM gold.fact_sales;

SELECT
    COUNT(DISTINCT order_number) AS total_ordenes,
    COUNT(*)                     AS total_lineas_venta,
    SUM(quantity)                AS total_unidades_vendidas,
    SUM(sales_amount)            AS ingresos_totales,
    ROUND(AVG(sales_amount), 2)  AS ticket_promedio_linea,
    COUNT(DISTINCT customer_key) AS clientes_con_compras,
    COUNT(DISTINCT product_key)  AS productos_vendidos
FROM gold.fact_sales;

SELECT
    c.country                                                    AS pais,
    COUNT(DISTINCT c.customer_key)                               AS total_clientes,
    COUNT(DISTINCT f.order_number)                               AS total_ordenes,
    SUM(f.quantity)                                              AS unidades_vendidas,
    SUM(f.sales_amount)                                          AS ventas_totales,
    ROUND(SUM(f.sales_amount) * 100.0 / SUM(SUM(f.sales_amount)) OVER (), 2) AS porcentaje_ventas
FROM gold.fact_sales f
JOIN gold.dim_customers c ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY ventas_totales DESC;

SELECT
    p.category          AS categoria,
    p.subcategory       AS subcategoria,
    COUNT(DISTINCT p.product_key) AS productos_activos,
    SUM(f.quantity)     AS unidades_vendidas,
    SUM(f.sales_amount) AS ventas_totales,
    ROUND(AVG(f.price), 2) AS precio_promedio
FROM gold.fact_sales f
JOIN gold.dim_products p ON f.product_key = p.product_key
GROUP BY p.category, p.subcategory
ORDER BY ventas_totales DESC;

SELECT
    c.customer_key,
    c.customer_number,
    c.first_name || ' ' || c.last_name AS nombre_completo,
    c.country                          AS pais,
    COUNT(DISTINCT f.order_number)     AS ordenes_realizadas,
    SUM(f.quantity)                    AS articulos_comprados,
    SUM(f.sales_amount)                AS total_gastado
FROM gold.fact_sales f
JOIN gold.dim_customers c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.customer_number, c.first_name, c.last_name, c.country
ORDER BY total_gastado DESC
LIMIT 10;

SELECT
    EXTRACT(YEAR FROM order_date)::INT  AS anio,
    COUNT(DISTINCT order_number)        AS total_ordenes,
    COUNT(DISTINCT customer_key)        AS clientes_unicos,
    SUM(quantity)                       AS unidades_vendidas,
    SUM(sales_amount)                   AS ventas_totales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY anio;
