/*
============================================================
BANKING CUSTOMER INTELLIGENCE & RISK ANALYTICS
SQL BUSINESS ANALYSIS
============================================================

Database: PostgreSQL
Main table: public.banking_customers
Records: 3,000 customers
Purpose: Business analysis for a Data Analyst portfolio project

Workflow:
Python/Pandas → PostgreSQL → SQL → Power BI
============================================================
*/


/* =========================================================
01. DATA VALIDATION
========================================================= */

-- Total records and unique customers
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM public.banking_customers;


-- Check the table structure
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'banking_customers'
ORDER BY ordinal_position;


/* =========================================================
02. DATA QUALITY CHECKS
========================================================= */

-- Check NULL values in important analytical columns
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE age IS NULL) AS null_age,
    COUNT(*) FILTER (WHERE estimated_income IS NULL) AS null_income,
    COUNT(*) FILTER (WHERE bank_deposits IS NULL) AS null_deposits,
    COUNT(*) FILTER (WHERE bank_loans IS NULL) AS null_loans,
    COUNT(*) FILTER (WHERE credit_card_balance IS NULL) AS null_credit_card_balance
FROM public.banking_customers;


-- Check duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM public.banking_customers
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;


/* =========================================================
03. EXECUTIVE KPIs
Business question:
What is the overall financial and demographic position
of the customer base?
========================================================= */

SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(estimated_income), 2) AS average_income,
    ROUND(SUM(bank_loans), 2) AS total_bank_loans,
    ROUND(SUM(bank_deposits), 2) AS total_bank_deposits,
    ROUND(AVG(credit_card_balance), 2) AS average_credit_card_balance
FROM public.banking_customers;


/* =========================================================
04. CUSTOMER ANALYSIS
========================================================= */

-- Customers by age group
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        WHEN age >= 66 THEN '66+'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS customer_count
FROM public.banking_customers
GROUP BY age_group
ORDER BY
    CASE age_group
        WHEN '18-25' THEN 1
        WHEN '26-35' THEN 2
        WHEN '36-45' THEN 3
        WHEN '46-55' THEN 4
        WHEN '56-65' THEN 5
        WHEN '66+' THEN 6
        ELSE 7
    END;


-- Customers by gender
SELECT
    gender,
    COUNT(*) AS customer_count
FROM public.banking_customers
GROUP BY gender
ORDER BY customer_count DESC;


-- Customers by fee structure
SELECT
    fee_structure,
    COUNT(*) AS customer_count,
    ROUND(AVG(estimated_income), 2) AS average_income
FROM public.banking_customers
GROUP BY fee_structure
ORDER BY customer_count DESC;


-- Customers by number of credit cards
SELECT
    amount_of_credit_cards,
    COUNT(*) AS customer_count
FROM public.banking_customers
GROUP BY amount_of_credit_cards
ORDER BY amount_of_credit_cards;


/* =========================================================
05. LOYALTY ANALYSIS
Business question:
How does financial behavior differ across loyalty segments?
========================================================= */

SELECT
    loyalty_classification,
    COUNT(*) AS customer_count,
    ROUND(AVG(estimated_income), 2) AS average_income,
    ROUND(AVG(bank_deposits), 2) AS average_deposit,
    ROUND(AVG(bank_loans), 2) AS average_loan,
    ROUND(AVG(credit_card_balance), 2) AS average_credit_card_balance
FROM public.banking_customers
GROUP BY loyalty_classification
ORDER BY customer_count DESC;


-- Total deposits and loans by loyalty classification
SELECT
    loyalty_classification,
    COUNT(*) AS customers,
    ROUND(SUM(bank_deposits), 2) AS total_deposits,
    ROUND(SUM(bank_loans), 2) AS total_loans
FROM public.banking_customers
GROUP BY loyalty_classification
ORDER BY total_deposits DESC;


-- Average loan by loyalty classification
SELECT
    loyalty_classification,
    ROUND(AVG(bank_loans), 2) AS average_loan
FROM public.banking_customers
GROUP BY loyalty_classification
ORDER BY average_loan DESC;


/* =========================================================
06. FINANCIAL ANALYSIS
========================================================= */

-- Overall financial summary
SELECT
    ROUND(AVG(estimated_income), 2) AS average_income,
    ROUND(AVG(bank_deposits), 2) AS average_deposit,
    ROUND(AVG(bank_loans), 2) AS average_loan,
    ROUND(AVG(credit_card_balance), 2) AS average_credit_card_balance,
    ROUND(AVG(checking_accounts), 2) AS average_checking_balance,
    ROUND(AVG(saving_accounts), 2) AS average_saving_balance,
    ROUND(AVG(foreign_currency_account), 2) AS average_foreign_currency_balance,
    ROUND(AVG(business_lending), 2) AS average_business_lending
FROM public.banking_customers;


-- Total financial exposure
SELECT
    ROUND(SUM(bank_deposits), 2) AS total_deposits,
    ROUND(SUM(bank_loans), 2) AS total_loans,
    ROUND(SUM(credit_card_balance), 2) AS total_credit_card_balance,
    ROUND(SUM(business_lending), 2) AS total_business_lending
FROM public.banking_customers;


/* =========================================================
07. LOAN & DEPOSIT ANALYSIS
========================================================= */

-- Customers with zero deposits
SELECT
    COUNT(*) AS zero_deposit_customers
FROM public.banking_customers
WHERE bank_deposits = 0;


-- Customer-level loan-to-deposit ratio
-- NULLIF prevents division by zero.
SELECT
    customer_id,
    bank_loans,
    bank_deposits,
    ROUND(
        bank_loans / NULLIF(bank_deposits, 0),
        2
    ) AS loan_deposit_ratio
FROM public.banking_customers
WHERE bank_deposits > 0
ORDER BY loan_deposit_ratio DESC;


-- Average loan-to-deposit ratio
SELECT
    ROUND(
        AVG(
            bank_loans / NULLIF(bank_deposits, 0)
        ),
        2
    ) AS average_loan_deposit_ratio
FROM public.banking_customers
WHERE bank_deposits > 0;


-- Loan-to-deposit ratio bands
SELECT
    CASE
        WHEN bank_deposits = 0 THEN 'Zero Deposit'
        WHEN bank_loans / NULLIF(bank_deposits, 0) < 0.5
            THEN 'Below 0.5'
        WHEN bank_loans / NULLIF(bank_deposits, 0) < 1
            THEN '0.5 - 1.0'
        WHEN bank_loans / NULLIF(bank_deposits, 0) < 1.5
            THEN '1.0 - 1.5'
        WHEN bank_loans / NULLIF(bank_deposits, 0) < 2
            THEN '1.5 - 2.0'
        ELSE '2.0+'
    END AS loan_deposit_band,
    COUNT(*) AS customer_count
FROM public.banking_customers
GROUP BY loan_deposit_band
ORDER BY customer_count DESC;


/* =========================================================
08. CUSTOMER SEGMENTATION
Business question:
Who are the high-value customers?
========================================================= */

-- Financial percentiles used to create data-driven thresholds
SELECT
    PERCENTILE_CONT(0.25)
        WITHIN GROUP (ORDER BY estimated_income) AS income_q1,
    PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY estimated_income) AS income_median,
    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY estimated_income) AS income_q3,

    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY bank_deposits) AS deposit_q3,

    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY bank_loans) AS loan_q3
FROM public.banking_customers;


-- Customer financial segment using income and deposits
WITH thresholds AS (
    SELECT
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY estimated_income) AS income_threshold,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY bank_deposits) AS deposit_threshold
    FROM public.banking_customers
)
SELECT
    CASE
        WHEN estimated_income >= income_threshold
         AND bank_deposits >= deposit_threshold
            THEN 'High Value'
        WHEN estimated_income >= income_threshold
         OR bank_deposits >= deposit_threshold
            THEN 'Potential High Value'
        ELSE 'Standard'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(estimated_income), 2) AS average_income,
    ROUND(AVG(bank_deposits), 2) AS average_deposit,
    ROUND(AVG(bank_loans), 2) AS average_loan
FROM public.banking_customers
CROSS JOIN thresholds
GROUP BY customer_segment
ORDER BY customer_count DESC;


/* =========================================================
09. HIGH-VALUE CUSTOMERS
========================================================= */

WITH thresholds AS (
    SELECT
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY estimated_income) AS income_threshold,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY bank_deposits) AS deposit_threshold
    FROM public.banking_customers
)
SELECT
    customer_id,
    age,
    estimated_income,
    bank_deposits,
    bank_loans,
    credit_card_balance,
    loyalty_classification,
    risk_weighting
FROM public.banking_customers
CROSS JOIN thresholds
WHERE estimated_income >= income_threshold
  AND bank_deposits >= deposit_threshold
ORDER BY bank_deposits DESC;


/* =========================================================
10. HIGH LOAN EXPOSURE
========================================================= */

-- Customers with the highest loan amounts
SELECT
    customer_id,
    estimated_income,
    bank_loans,
    bank_deposits,
    loyalty_classification,
    risk_weighting
FROM public.banking_customers
ORDER BY bank_loans DESC
LIMIT 20;


-- Customers with high loan-to-deposit exposure
SELECT
    customer_id,
    estimated_income,
    bank_loans,
    bank_deposits,
    ROUND(
        bank_loans / NULLIF(bank_deposits, 0),
        2
    ) AS loan_deposit_ratio,
    risk_weighting
FROM public.banking_customers
WHERE bank_deposits > 0
ORDER BY loan_deposit_ratio DESC
LIMIT 20;


/* =========================================================
11. BUSINESS LENDING ANALYSIS
========================================================= */

-- Business lending distribution
SELECT
    CASE
        WHEN business_lending < 500000 THEN '0-500K'
        WHEN business_lending < 1000000 THEN '500K-1M'
        WHEN business_lending < 1500000 THEN '1M-1.5M'
        WHEN business_lending < 2000000 THEN '1.5M-2M'
        WHEN business_lending < 2500000 THEN '2M-2.5M'
        WHEN business_lending < 3000000 THEN '2.5M-3M'
        WHEN business_lending < 3500000 THEN '3M-3.5M'
        WHEN business_lending < 4000000 THEN '3.5M-4M'
        ELSE '4M+'
    END AS business_lending_range,
    COUNT(*) AS customer_count,
    ROUND(AVG(business_lending), 2) AS average_business_lending
FROM public.banking_customers
GROUP BY business_lending_range
ORDER BY
    MIN(business_lending);


/* =========================================================
12. CREDIT CARD ANALYSIS
========================================================= */

-- Credit card balance summary
SELECT
    ROUND(AVG(credit_card_balance), 2) AS average_balance,
    ROUND(MIN(credit_card_balance), 2) AS minimum_balance,
    ROUND(MAX(credit_card_balance), 2) AS maximum_balance
FROM public.banking_customers;


-- Credit card balance distribution
SELECT
    CASE
        WHEN credit_card_balance < 1000 THEN '0-1K'
        WHEN credit_card_balance < 2500 THEN '1K-2.5K'
        WHEN credit_card_balance < 5000 THEN '2.5K-5K'
        WHEN credit_card_balance < 10000 THEN '5K-10K'
        ELSE '10K+'
    END AS credit_card_balance_band,
    COUNT(*) AS customer_count
FROM public.banking_customers
GROUP BY credit_card_balance_band
ORDER BY
    MIN(credit_card_balance);


/* =========================================================
13. ACCOUNT BALANCE ANALYSIS
========================================================= */

SELECT
    ROUND(AVG(checking_accounts), 2) AS average_checking_balance,
    ROUND(AVG(saving_accounts), 2) AS average_saving_balance,
    ROUND(AVG(foreign_currency_account), 2) AS average_foreign_currency_balance
FROM public.banking_customers;


/* =========================================================
14. RISK ANALYSIS
========================================================= */

-- Risk weighting distribution
SELECT
    risk_weighting,
    COUNT(*) AS customer_count,
    ROUND(AVG(bank_loans), 2) AS average_loan,
    ROUND(AVG(bank_deposits), 2) AS average_deposit,
    ROUND(AVG(estimated_income), 2) AS average_income
FROM public.banking_customers
GROUP BY risk_weighting
ORDER BY customer_count DESC;


-- Financial profile by risk weighting
SELECT
    risk_weighting,
    COUNT(*) AS customers,
    ROUND(SUM(bank_loans), 2) AS total_loans,
    ROUND(SUM(bank_deposits), 2) AS total_deposits,
    ROUND(AVG(credit_card_balance), 2) AS average_credit_card_balance,
    ROUND(AVG(business_lending), 2) AS average_business_lending
FROM public.banking_customers
GROUP BY risk_weighting
ORDER BY risk_weighting;


/* =========================================================
15. RISK + LOAN EXPOSURE
========================================================= */

SELECT
    risk_weighting,
    COUNT(*) AS customers,
    ROUND(AVG(bank_loans), 2) AS average_loan,
    ROUND(AVG(bank_deposits), 2) AS average_deposit,
    ROUND(
        AVG(bank_loans / NULLIF(bank_deposits, 0)),
        2
    ) AS average_loan_deposit_ratio
FROM public.banking_customers
WHERE bank_deposits > 0
GROUP BY risk_weighting
ORDER BY average_loan_deposit_ratio DESC;


/* =========================================================
16. RISK + LOYALTY ANALYSIS
Business question:
Does financial behavior vary across both loyalty and risk?
========================================================= */

SELECT
    loyalty_classification,
    risk_weighting,
    COUNT(*) AS customer_count,
    ROUND(AVG(estimated_income), 2) AS average_income,
    ROUND(AVG(bank_deposits), 2) AS average_deposit,
    ROUND(AVG(bank_loans), 2) AS average_loan
FROM public.banking_customers
GROUP BY
    loyalty_classification,
    risk_weighting
ORDER BY
    loyalty_classification,
    customer_count DESC;


/* =========================================================
17. POTENTIAL CROSS-SELLING OPPORTUNITIES
========================================================= */

-- Customers with relatively high income but lower deposits
WITH income_threshold AS (
    SELECT
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY estimated_income) AS high_income
    FROM public.banking_customers
),
deposit_threshold AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY bank_deposits) AS low_deposit
    FROM public.banking_customers
)
SELECT
    customer_id,
    estimated_income,
    bank_deposits,
    bank_loans,
    loyalty_classification,
    risk_weighting
FROM public.banking_customers
CROSS JOIN income_threshold
CROSS JOIN deposit_threshold
WHERE estimated_income >= high_income
  AND bank_deposits <= low_deposit
ORDER BY estimated_income DESC;


/* =========================================================
18. FINAL BUSINESS SUMMARY
========================================================= */

SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(age), 2) AS avg_age,
    ROUND(AVG(estimated_income), 2) AS avg_income,
    ROUND(AVG(bank_deposits), 2) AS avg_deposit,
    ROUND(AVG(bank_loans), 2) AS avg_loan,
    ROUND(AVG(credit_card_balance), 2) AS avg_credit_card_balance,
    ROUND(
        AVG(bank_loans / NULLIF(bank_deposits, 0)),
        2
    ) AS avg_loan_deposit_ratio,
    COUNT(*) FILTER (WHERE bank_deposits = 0) AS zero_deposit_customers
FROM public.banking_customers;


/*
============================================================
END OF BANKING CUSTOMER INTELLIGENCE & RISK ANALYTICS
============================================================
*/
