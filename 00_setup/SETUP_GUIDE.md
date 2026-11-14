# Guía de Configuración — DatawarehouseDB (PostgreSQL)

## 1. Parámetros de Conexión en pgAdmin 4

- **Host:** `127.0.0.1`
- **Puerto:** `5000`
- **Usuario:** `postgres`
- **Base de datos:** `DatawarehouseDB`
- **Esquemas:** `bronze`, `silver`, `gold`

## 2. Orden de Ejecución

1. `03_scripts/init_database.sql`: Crea la base de datos `DatawarehouseDB` y los esquemas `bronze`, `silver` y `gold`.
2. `03_scripts/bronze/ddl_bronze.sql`: Crea las 6 tablas de la capa Bronze.
3. `03_scripts/bronze/proc_load_bronze.sql`: Crea el procedimiento `bronze.load_bronze()` y ejecuta `CALL bronze.load_bronze();`.
4. `03_scripts/silver/ddl_silver.sql`: Crea las 6 tablas de la capa Silver.
5. `03_scripts/silver/proc_load_silver.sql`: Crea el procedimiento `silver.load_silver()` y ejecuta `CALL silver.load_silver();`.
6. `03_scripts/gold/ddl_gold.sql`: Crea las vistas analíticas `gold.dim_customers`, `gold.dim_products` y `gold.fact_sales`.
7. `04_tests/quality_checks_silver.sql` y `04_tests/quality_checks_gold.sql`: Verifica la calidad de datos en las capas Silver y Gold.
