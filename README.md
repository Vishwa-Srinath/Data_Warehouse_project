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

---

### 🥈 Silver Layer (Cleaned & Structured Data)
- Stores **cleaned and structured data**
- Object type: **Tables**
- Load type:
  - Full load (Truncate & Insert)
- Transformations applied:
  - Data cleaning
  - Data standardization
  - Data normalization
  - Data enrichment
- Purpose: Prepare high-quality data for business modeling

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
