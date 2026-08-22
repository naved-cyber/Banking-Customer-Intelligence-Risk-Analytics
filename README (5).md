# 🏦 Banking Customer Intelligence & Risk Analytics

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=flat&logo=databricks&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)

An end-to-end **Data Analyst portfolio project** analyzing customer demographics, financial behavior, banking products, customer segmentation, and financial risk — built with **Python, Pandas, PostgreSQL, SQL, and Power BI**.

---

## 📌 Overview

This project simulates a real-world banking analytics workflow: raw customer data is cleaned and explored in Python, loaded into a PostgreSQL database, queried with SQL to answer business questions, and visualized through three interactive Power BI dashboards covering executive KPIs, customer segmentation, and financial risk exposure.

---

## 🔄 Project Workflow

```
📂 Data Upload
      ↓
🧹 Data Cleaning (Python / Pandas)
      ↓
📊 Exploratory Data Analysis
      ↓
🗄️ PostgreSQL Database
      ↓
🔎 SQL Business Analysis
      ↓
📈 Power BI Dashboards
```

---

## 📂 1. Data Upload

- Imported a banking customer dataset containing **3,000 customer records** and **25 original columns**.
- Loaded the dataset into Python/Pandas for preparation and exploratory analysis.
- Loaded the cleaned dataset into PostgreSQL.
- Connected Power BI directly to the PostgreSQL database.

---

## 🧹 2. Data Cleaning

Prepared using **Python and Pandas**:

- ✅ Checked for missing values and duplicate records
- 🔍 Investigated repeated `client_id` values
- ✅ Preserved repeated IDs that represented distinct customers instead of incorrectly deleting valid records
- 🆔 Created a unique `customer_id` for downstream analysis
- ✅ Verified the final dataset before loading into PostgreSQL

---

## 📊 3. Exploratory Data Analysis (EDA)

**Areas analyzed:**
- Customer age distribution
- Estimated income distribution
- Bank deposit and loan distributions
- Credit card balance distribution
- Banking product characteristics
- Customer loyalty classification
- Relationships between income, deposits, and loans
- Customers with zero bank deposits

**Key findings:**

| Insight | Detail |
|---|---|
| Distribution shape | Income, deposits, loans, and credit card balances are right-skewed |
| Income vs. Deposits | Correlation: **0.2603** |
| Income vs. Loans | Correlation: **0.3299** |
| Deposits vs. Loans | Correlation: **0.3732** |
| Zero-deposit customers | **34 customers** flagged with no bank deposits |

---

## 🗄️ 4. PostgreSQL & SQL Analysis

The cleaned dataset was stored in PostgreSQL (`public.banking_customers`) and analyzed with SQL to cover:

- Customer-level analysis and business KPIs
- Customer segmentation
- Income and deposit analysis
- Loan exposure and loan-to-deposit ratios
- Loyalty-based financial analysis
- Risk analysis, including identification of high-value and high-exposure customer segments

---

## 📈 5. Power BI Dashboards

### 🏠 Dashboard 1 — Executive Overview
**Business question:** *What is happening across the bank overall?*

![Executive Overview Dashboard](<Screenshot 2026-08-23 005617.png>)

- Total Customers, Average Age, Average Income
- Total Bank Loans and Deposits
- Customers by Occupation, Loyalty Classification, Nationality, and Joined Year

---

### 👥 Dashboard 2 — Customer Analysis
**Business question:** *Who are our customers?*

![Customer Analysis Dashboard](<Screenshot 2026-08-23 005636.png>)

- Customers by Age Group, Gender, and Fee Structure
- Income Distribution
- Customers by Number of Credit Cards and Properties Owned
- Average Account Balance by Account Type

---

### ⚠️ Dashboard 3 — Financial & Risk Analysis
**Business question:** *How financially healthy and exposed is the customer base?*

![Financial & Risk Analysis Dashboard](<Screenshot 2026-08-23 005647.png>)

- Average Loan, Deposit, and Credit Card Balance
- Average Loan-to-Deposit Ratio
- Credit Card Balance and Loan-to-Deposit Ratio Distributions
- Customer Risk Distribution
- Business Lending Range
- Average Loan by Loyalty Classification

---

## 🎯 6. Business Objective

This analysis is designed to answer questions such as:

- Who are the bank's most valuable customer segments?
- Which customers hold significant deposits or carry high loan exposure?
- How does financial behavior differ across loyalty segments?
- How are credit card balances distributed across the customer base?
- What does the loan-to-deposit relationship reveal about financial health?
- Which customer groups represent potential cross-selling opportunities?
- Where is financial exposure concentrated?

---

## 🛠️ 7. Technology Stack

| Tool | Purpose |
|---|---|
| 🐍 Python | Data preparation and analysis |
| 🐼 Pandas | Data cleaning and EDA |
| 📓 Jupyter Notebook | Analysis environment |
| 🗄️ PostgreSQL | Database storage |
| 🔎 SQL | Business and financial analysis |
| 📊 Power BI | Interactive dashboards |

---

## 📁 Repository Structure

```
├── banking-clients new.csv       # Raw dataset
├── banking-finance.ipynb         # Python/Pandas cleaning & EDA
├── banking_analysis (1).sql      # SQL business analysis
├── banking_analysis.pbix         # Power BI dashboard file
├── Screenshot ....png            # Dashboard screenshots
└── README.md
```

---

## 👨‍💻 Author

**Naved**
Data Analyst Portfolio Project
`Python` · `SQL` · `PostgreSQL` · `Power BI`
