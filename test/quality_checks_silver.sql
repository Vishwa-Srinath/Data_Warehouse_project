/*
===============================================================================
Quality Checks - Silver Layer
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces in Customer Key
-- Expectation: No Results
SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Check for Unwanted Spaces in Customer Names
-- Expectation: No Results
SELECT
    cst_firstname,
    cst_lastname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency: Marital Status
-- Expectation: Only 'Single', 'Married', 'n/a'
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;

-- Data Standardization & Consistency: Gender
-- Expectation: Only 'Male', 'Female', 'n/a'
SELECT DISTINCT
    cst_gndr
FROM silver.crm_cust_info;
