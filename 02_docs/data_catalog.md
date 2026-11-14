# Catálogo de Datos — Capa Gold (`DatawarehouseDB`)

## 1. `gold.dim_customers`
Almacena la información consolidada de clientes enriquecida con datos demográficos y geográficos.

| Columna | Tipo de Dato | Descripción |
|---|---|---|
| `customer_key` | `BIGINT` | Clave subrogada única de la dimensión de clientes. |
| `customer_id` | `INT` | Identificador numérico único del cliente en el CRM. |
| `customer_number` | `VARCHAR(50)` | Código alfanumérico del cliente (`cst_key`). |
| `first_name` | `VARCHAR(50)` | Nombre del cliente. |
| `last_name` | `VARCHAR(50)` | Apellido del cliente. |
| `country` | `VARCHAR(50)` | País de residencia del cliente. |
| `marital_status` | `VARCHAR(50)` | Estado civil (`Married`, `Single`, `n/a`). |
| `gender` | `VARCHAR(50)` | Género del cliente (`Male`, `Female`, `n/a`). |
| `birthdate` | `DATE` | Fecha de nacimiento del cliente. |
| `create_date` | `DATE` | Fecha de registro del cliente. |

---

## 2. `gold.dim_products`
Almacena el catálogo vigente de productos enriquecido con sus categorías y subcategorías.

| Columna | Tipo de Dato | Descripción |
|---|---|---|
| `product_key` | `BIGINT` | Clave subrogada única de la dimensión de productos. |
| `product_id` | `INT` | Identificador interno del producto. |
| `product_number` | `VARCHAR(50)` | Código alfanumérico del producto (`prd_key`). |
| `product_name` | `VARCHAR(50)` | Nombre descriptivo del producto. |
| `category_id` | `VARCHAR(50)` | Identificador de la categoría del producto. |
| `category` | `VARCHAR(50)` | Categoría principal (`Bikes`, `Components`, `Clothing`, `Accessories`). |
| `subcategory` | `VARCHAR(50)` | Subcategoría del producto. |
| `maintenance` | `VARCHAR(50)` | Indica si requiere mantenimiento (`Yes`, `No`). |
| `cost` | `INT` | Costo base del producto. |
| `product_line` | `VARCHAR(50)` | Línea de producto (`Mountain`, `Road`, `Touring`, `Other Sales`, `n/a`). |
| `start_date` | `DATE` | Fecha de inicio de disponibilidad del producto. |

---

## 3. `gold.fact_sales`
Almacena las transacciones de ventas vinculadas a las dimensiones mediante claves subrogadas.

| Columna | Tipo de Dato | Descripción |
|---|---|---|
| `order_number` | `VARCHAR(50)` | Identificador de la orden de venta (ej. `SO43697`). |
| `product_key` | `BIGINT` | Clave foránea subrogada hacia `gold.dim_products`. |
| `customer_key` | `BIGINT` | Clave foránea subrogada hacia `gold.dim_customers`. |
| `order_date` | `DATE` | Fecha de realización del pedido. |
| `shipping_date` | `DATE` | Fecha de envío del pedido. |
| `due_date` | `DATE` | Fecha de vencimiento del pedido. |
| `sales_amount` | `INT` | Monto total de la línea de venta (`quantity * price`). |
| `quantity` | `INT` | Cantidad de unidades vendidas. |
| `price` | `INT` | Precio unitario del producto. |
