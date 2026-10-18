# SQL Data Warehouse Project

## 📌 Project Overview
This project focuses on designing and implementing a **SQL-based Data Warehouse** to support analytical reporting and business intelligence.  
It demonstrates core data warehousing concepts such as **ETL processes, dimensional modeling, fact and dimension tables, and analytical queries**.
## 🏗️ High-Level Data Warehouse Architecture

![High Level Data Warehouse Architecture](docs/Dara_Warehose.drawio.svg)

This diagram represents the **end-to-end architecture of the SQL Data Warehouse**, following a **Bronze–Silver–Gold** layered approach to data processing and analytics.

---

### 🔹 Source Systems
- CRM and ERP systems
- Data extracted as **CSV files**
- Files stored in object storage / folders
- Acts as the raw input layer

---

### 🥉 Bronze Layer (Raw Data)
- Stores **raw, unprocessed data**
- Object type: **Tables**
- Load type:
  - Batch processing
  - Full load (Truncate & Insert)
- No transformations applied
- Purpose: Data archival and traceability

![Bronze layer Architecture](docs/Bronze_later.png)
---

### 🥈 Silver Layer (Cleaned & Structured Data)
- Stores **cleaned and structured data**
- Object type: **Tables**
- Load type:
  - Full load (Truncate & Insert)
- Transformations applied:
  - **Data Cleansing**: Trim whitespace, handle NULLs, filter corrupt records
  - **Data Standardization**: Consistent gender (`Male`/`Female`/`n/a`), marital status (`Single`/`Married`/`n/a`), and country names (`Germany`, `United States`)
  - **Data Normalization & Formatting**: Date parsing (e.g., integer to `DATE`), business rule enforcement (`Sales = Quantity * Price`)
  - **Data Enrichment**: Metadata columns (`dwh_create_date`), deriving end dates using `LEAD()`, extracting composite category IDs
- Purpose: Prepare high-quality, validated data for business modeling

![Silver Layer Data Flow](docs/data_flow.png)

#### 🛠️ Silver Layer Implementation
* **DDL Scripts**: [`scripts/silver/ddl_silver.sql`](scripts/silver/ddl_silver.sql) creates the 6 cleaned tables with metadata tracking.
* **Automated ETL**: [`scripts/silver/proc_load_silver.sql`](scripts/silver/proc_load_silver.sql) executes the complete Truncate & Load pipeline with duration tracking and error handling:
  ```sql
  EXEC silver.load_silver;
  ```
* **Data Quality Suite**: [`test/quality_checks_silver.sql`](test/quality_checks_silver.sql) runs comprehensive validation queries (uniqueness, primary key integrity, invalid dates, business rules, whitespace checks).


---

### 🥇 Gold Layer (Business-Ready Data)
- Stores **business-ready datasets**
- Object type: **Views**
- No physical data load
- Transformations:
  - Data integration
  - Aggregations
  - Business logic
- Data models:
  - Star schema
  - Fact tables
  - Aggregated tables
- Purpose: Optimized for analytics and reporting

---

### 📊 Data Consumption
- BI dashboards and reports
- Ad-hoc SQL queries
- Machine Learning use cases
- Supports decision-making and analytics

---

### 🎯 Architecture Benefits
- Clear separation of concerns
- Scalable and maintainable design
- Supports analytics, reporting, and ML
- Easy debugging and data lineage tracking
