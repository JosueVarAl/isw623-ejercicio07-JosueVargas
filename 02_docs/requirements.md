# Requisitos del Proyecto

## Construcción del Almacén de Datos (Ingeniería de Datos)

### Objetivo
Desarrollar un almacén de datos moderno en PostgreSQL (`DatawarehouseDB`) bajo la Arquitectura Medallion para consolidar la información de ventas, permitiendo generar reportes analíticos y facilitar la toma de decisiones informadas.

### Especificaciones
- **Fuentes de datos (Data Sources):** Importar información de dos sistemas de origen (ERP y CRM), proporcionados mediante archivos CSV.
- **Calidad de los datos (Data Quality):** Limpiar y resolver los problemas relacionados con la calidad de los datos antes de realizar los análisis.
- **Integración (Integration):** Combinar ambas fuentes de información en un único modelo de datos en estrella (Star Schema), fácil de utilizar y diseñado para consultas analíticas.
- **Alcance (Scope):** Trabajar únicamente con el conjunto de datos más reciente; no se requiere mantener un historial de los datos.
- **Documentación (Documentation):** Proporcionar documentación clara del modelo de datos para los interesados del negocio y equipos de análisis.
