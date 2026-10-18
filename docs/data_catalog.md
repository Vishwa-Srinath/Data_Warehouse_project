# Data Catalog for Gold Layer

## Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** organized into a Star Schema.

![Star Schema Data Model](data_model.png)

---

### 1. **gold.dim_customers**
- **Purpose:** Stores customer details enriched with demographic and geographic data.
- **Columns:**

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `customer_key` | INT | Surrogate key uniquely identifying each customer record in the dimension table. |
| `customer_id` | INT | Unique numerical identifier assigned to each customer from the CRM system. |
| `customer_number` | NVARCHAR(50) | Alphanumeric business identifier representing the customer (e.g., `AW00011000`). |
| `first_name` | NVARCHAR(50) | The customer's first name, cleansed of leading and trailing whitespace. |
| `last_name` | NVARCHAR(50) | The customer's last name or family name, cleansed of leading and trailing whitespace. |
| `country` | NVARCHAR(50) | The standardized country of residence for the customer (e.g., `'Germany'`, `'United States'`). |
| `marital_status` | NVARCHAR(50) | The normalized marital status of the customer (`'Single'`, `'Married'`, or `'n/a'`). |
| `gender` | NVARCHAR(50) | The standardized gender (`'Male'`, `'Female'`, or `'n/a'`), prioritizing CRM with fallback to ERP. |
| `birthdate` | DATE | The verified birthdate of the customer, formatted as YYYY-MM-DD. |
| `create_date` | DATE | The date when the customer record was created in the source system. |

---

### 2. **gold.dim_products**
- **Purpose:** Provides information about current active products and their hierarchical category attributes.
- **Columns:**

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `product_key` | INT | Surrogate key uniquely identifying each active product in the product dimension table. |
| `product_id` | INT | Unique numeric identifier assigned to the product for operational tracking. |
| `product_number` | NVARCHAR(50) | Alphanumeric product SKU code extracted from the composite source key. |
| `product_name` | NVARCHAR(50) | Descriptive name of the product. |
| `category_id` | NVARCHAR(50) | Identifier for the product's category linking to ERP classification. |
| `category` | NVARCHAR(50) | The broader category classification (e.g., `Bikes`, `Components`, `Clothing`). |
| `subcategory` | NVARCHAR(50) | Detailed sub-classification of the product within the category. |
| `maintenance` | NVARCHAR(50) | Indicates whether the product requires scheduled maintenance (`'Yes'`, `'No'`). |
| `cost` | INT | The base cost of the product, with missing values imputed to 0. |
| `product_line` | NVARCHAR(50) | Descriptive product line (`'Mountain'`, `'Road'`, `'Other Sales'`, `'Touring'`). |
| `start_date` | DATE | The date when this product revision became active. |

---

### 3. **gold.fact_sales**
- **Purpose:** Stores transactional sales line items for revenue, quantity, and price analysis.
- **Columns:**

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `order_number` | NVARCHAR(50) | Alphanumeric identifier for the sales order line. |
| `product_key` | INT | Warehouse surrogate foreign key linking to `gold.dim_products`. |
| `customer_key` | INT | Warehouse surrogate foreign key linking to `gold.dim_customers`. |
| `order_date` | DATE | Standardized date when the customer order was placed. |
| `shipping_date` | DATE | Standardized date when the order was shipped to the customer. |
| `due_date` | DATE | Standardized date when the order payment was due. |
| `sales_amount` | INT | Total monetary value of the line item, validated against `Quantity * Price`. |
| `quantity` | INT | Number of product units ordered for the line item. |
| `price` | INT | Price per unit of the product for the line item. |
