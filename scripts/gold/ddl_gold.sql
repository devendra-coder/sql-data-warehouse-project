/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

if OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
    DROP VIEW gold.dim_customer;
GO
create VIEW gold.dim_customer AS
SELECT
    ROW_NUMBER() over(order by ci.cst_id) as customer_key,
    ci.cst_id as customer_id,
    ci.cst_key as customer_number,
    ci.cst_firstname as first_name,
    ci.cst_lastname as last_name,
    la.cntry as country,
    ci.cst_marital_status as marital_status,
    case when ci.cst_gndr != 'n/a' then ci.cst_gndr 
         else coalesce(ca.gen,'n/a') 
    end as gender,
    ca.bdate as birthdate,
    ci.cst_create_date as create_date   
from silver.crm_cust_info ci
left JOIN silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 as la
on ci.cst_key = la.cid
GO


-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

if OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() over(order by pn.prd_start_dt, pn.prd_key) as product_key,
    pn.prd_id as product_id,
    pn.prd_key as product_number,
    pn.prd_nm as product_name,
    pn.cat_id as category_id,
    pc.cat as category,
    pc.subcat as subcategory,
    pc.maintenance as maintenance,
    pn.prd_cost as cost,
    pn.prd_line as product_line,
    pn.prd_start_dt as start_date
from silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
on pn.prd_key = pc.id
WHERE prd_end_dt is NULL   -- filter out all historical data
GO


-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu
    ON sd.sls_cust_id = cu.customer_id;
GO



 




