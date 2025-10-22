# SQL Data Warehouse Project  

A complete data warehousing project built using **SQL** and organized in a **multi-layered architecture (Bronze → Silver → Gold)** following the **Star Schema** modeling approach.  
This project simulates a realistic data warehouse design for analytics and reporting purposes.

---

## 🧩 Project Overview  

This project demonstrates how to build and manage a small-scale data warehouse using SQL.  
It walks through the full lifecycle — from **raw data ingestion** to **transformation**, **data modeling**, and **final reporting queries**.

The main objective is to show how raw, unstructured data is cleaned, standardized, and modeled into an efficient analytical schema that supports fast insights and business intelligence use cases.

---

## 🏗️ Architecture  

The project is divided into three layers, each serving a specific purpose:

### 1. **Bronze Layer – Raw Data**
- Stores the raw, unprocessed data loaded from source systems.
- Acts as the staging area.
- Minimal or no transformation is applied here.

### 2. **Silver Layer – Cleaned and Transformed Data**
- Handles data cleaning, normalization, and type conversions.
- Intermediate tables are created to ensure consistent data formats.
- Prepares the data for modeling in the gold layer.

### 3. **Gold Layer – Star Schema (Analytics Layer)**
- Implements the **Star Schema**, with:
  - **Fact Tables** (containing measurable business events)
  - **Dimension Tables** (containing descriptive attributes)
- Designed for efficient analytical queries and reporting.
```
Example structure:
Fact_Sales
├── sale_id
├── customer_id
├── product_id
├── store_id
├── date_id
├── total_amount
└── quantity

Dim_Customer
├── customer_id
├── customer_name
├── region
└── gender

Dim_Product
├── product_id
├── product_name
├── category
└── price
```
---

## 🧠 Key Concepts Demonstrated  

- **Data Modeling:** Star Schema and dimensional modeling principles  
- **ETL Logic:** Stepwise data transformation across layers  
- **SQL Best Practices:** Use of joins, aggregations, subqueries, and constraints  
- **Analytical Querying:** Aggregating facts across multiple dimensions  
- **Reproducible Scripts:** Each SQL script can be run independently to recreate layers  

---

## ⚙️ Folder Structure  
```
sql-data-warehouse-project/
│
├── scripts/
│ ├── bronze/ → Raw data ingestion scripts
│ ├── silver/ → Data cleaning and transformation scripts
│ └── gold/ → Final data modeling (Star Schema)
│
├── docs/ → (optional) documentation or ERD diagrams
│
└── README.md → Project overview and usage guide
```


## 🚀 How to Run  

```bash
# 1. Clone the repository
git clone https://github.com/devendra-coder/sql-data-warehouse-project.git
cd sql-data-warehouse-project

# 2. Open your SQL environment (SQL Server / MySQL / PostgreSQL, etc.)

# 3. Execute scripts layer by layer
#    Run scripts from /bronze to create staging tables
#    Run scripts from /silver for data cleaning and transformation
#    Run scripts from /gold to build the star schema

# 4. (Optional) Run analytical queries from /gold to validate data
```
---

## 👨‍💻 Author  

**Devendra Singh**  
SQL & Data Analytics Enthusiast  
[GitHub Profile](https://github.com/devendra-coder)
