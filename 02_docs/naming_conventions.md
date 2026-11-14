# Convenciones de Nomenclatura

## 1. Principios Generales
- **Formato:** `snake_case` (letras minúsculas separadas por guiones bajos `_`).
- **Idioma:** Inglés para nombres de objetos y columnas técnicas.
- **Palabras reservadas:** Evitar el uso de palabras reservadas de SQL como identificadores.

## 2. Convenciones para Nombrar Tablas y Vistas
- **Reglas para Bronze (`bronze`):** `<sourcesystem>_<entity>` respetando el nombre original de la fuente (`crm_cust_info`, `crm_prd_info`, `crm_sales_details`, `erp_cust_az12`, `erp_loc_a101`, `erp_px_cat_g1v2`).
- **Reglas para Silver (`silver`):** `<sourcesystem>_<entity>` manteniendo la trazabilidad con la capa Bronze.
- **Reglas para Gold (`gold`):** `<category>_<entity>` alineado con el negocio (`dim_customers`, `dim_products`, `fact_sales`).

## 3. Convenciones para Nombrar Columnas
- **Claves subrogadas:** `<entity>_key` (ej. `customer_key`, `product_key`).
- **Columnas técnicas:** `dwh_<column_name>` (ej. `dwh_create_date`).

## 4. Procedimientos Almacenados
- **`<schema>.load_<layer>`:** `bronze.load_bronze`, `silver.load_silver`.
