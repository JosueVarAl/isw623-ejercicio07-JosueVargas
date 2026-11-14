# Ejercicio 7: Arquitectura Medallion en PostgreSQL (`DatawarehouseDB`)

**Estudiante:** Josué Vargas  
**Curso:** ISW623 — Bases de Datos Avanzadas  
**Base de Datos:** `DatawarehouseDB` (PostgreSQL `127.0.0.1:5000`, visible en **pgAdmin 4**)

---

## Estructura del Proyecto

```text
isw623-ejercicio07-JosueVargas/
├── 00_setup/
│   └── SETUP_GUIDE.md
├── 01_datasets/
│   ├── source_crm/
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   └── source_erp/
│       ├── CUST_AZ12.csv
│       ├── LOC_A101.csv
│       └── PX_CAT_G1V2.csv
├── 02_docs/
│   ├── data_architecture.png
│   ├── data_catalog.md
│   ├── data_flow.png
│   ├── data_integration.png
│   ├── data_model.png
│   ├── ETL.png
│   ├── naming_conventions.md
│   └── requirements.md
├── 03_scripts/
│   ├── init_database.sql
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   └── gold/
│       └── ddl_gold.sql
└── 04_tests/
    ├── analytics_queries.sql
    ├── quality_checks_gold.sql
    └── quality_checks_silver.sql
```

---

## Resumen de Objetos y Registros en `DatawarehouseDB`

| Esquema | Objeto | Tipo | Registros |
|---|---|---|---:|
| `bronze` | `bronze.crm_cust_info` | Tabla | 18,494 |
| `bronze` | `bronze.crm_prd_info` | Tabla | 397 |
| `bronze` | `bronze.crm_sales_details` | Tabla | 60,398 |
| `bronze` | `bronze.erp_cust_az12` | Tabla | 18,484 |
| `bronze` | `bronze.erp_loc_a101` | Tabla | 18,484 |
| `bronze` | `bronze.erp_px_cat_g1v2` | Tabla | 37 |
| `silver` | `silver.crm_cust_info` | Tabla | 18,484 |
| `silver` | `silver.crm_prd_info` | Tabla | 397 |
| `silver` | `silver.crm_sales_details` | Tabla | 60,398 |
| `silver` | `silver.erp_cust_az12` | Tabla | 18,484 |
| `silver` | `silver.erp_loc_a101` | Tabla | 18,484 |
| `silver` | `silver.erp_px_cat_g1v2` | Tabla | 37 |
| `gold` | `gold.dim_customers` | Vista | 18,484 |
| `gold` | `gold.dim_products` | Vista | 295 |
| `gold` | `gold.fact_sales` | Vista | 60,398 |

---

## Ejecución en pgAdmin 4

1. Conectar al servidor **`DatawarehouseDB (Medallion)`** o **`PostgreSQL (Local)`** (`127.0.0.1:5000`) $\rightarrow$ **Databases** $\rightarrow$ **`DatawarehouseDB`**.
2. Abrir el **Query Tool** sobre `DatawarehouseDB` y ejecutar:
   ```sql
   CALL bronze.load_bronze();
   CALL silver.load_silver();
   SELECT * FROM gold.fact_sales LIMIT 100;
   ```
