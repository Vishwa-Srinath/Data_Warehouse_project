# Gold Layer: Star Schema Design & Domain Modeling

## 1. Dimensional Modeling Approach

In the Gold layer, the data warehouse adopts a **Star Schema** dimensional modeling methodology (Kimball approach) rather than a normalized 3NF or Snowflake schema.

### Why Star Schema?
* **Simplicity for BI & Analytics**: Analysts and BI tools (Power BI, Tableau) can easily navigate simple relationships without navigating complex multi-hop normalized joins.
* **Query Performance**: Minimizes the number of table joins when aggregating metrics.
* **Separation of Concerns**: Clearly distinguishes between quantitative business measurements (facts) and contextual attributes (dimensions).

---

## 2. Business Domains & Object Grouping

Source tables from the Silver layer are consolidated into three core business domains:

```
┌──────────────────────────────────────────────┐
│                  GOLD LAYER                  │
│                                              │
│   ┌────────────────────┐                     │
│   │ gold.dim_customers │◄────────┐           │
│   └────────────────────┘         │           │
│                                  │ (1:N)     │
│   ┌────────────────────┐    ┌────┴──────────┐│
│   │ gold.dim_products  │◄───┤gold.fact_sales││
│   └────────────────────┘(1:N)└──────────────┘│
└──────────────────────────────────────────────┘
```

### Business Objects Mapping:

| Domain | Business Entity | Silver Source Tables | Gold Target View | Role |
| :--- | :--- | :--- | :--- | :--- |
| **Customers** | Customer Profiles | `silver.crm_cust_info`<br>`silver.erp_cust_az12`<br>`silver.erp_loc_a101` | `gold.dim_customers` | Dimension (Who) |
| **Products** | Product Catalog | `silver.crm_prd_info`<br>`silver.erp_px_cat_g1v2` | `gold.dim_products` | Dimension (What) |
| **Sales** | Order Transactions | `silver.crm_sales_details` | `gold.fact_sales` | Fact (Measurements) |

---

## 3. Surrogate Key Strategy

* Natural/business keys (`cst_id`, `prd_key`) are retained for operational traceability.
* System-generated warehouse surrogate keys (`customer_key`, `product_key`) are created using `ROW_NUMBER()` to uniquely identify dimension records and insulate the analytical layer from changes in upstream source operational keys.
* Fact tables perform dimension lookups to replace natural keys with the corresponding surrogate keys.
