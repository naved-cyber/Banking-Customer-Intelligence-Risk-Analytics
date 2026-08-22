# 🏦 Banking Customer Intelligence & Risk Analytics

An end-to-end **Data Analyst portfolio project** analyzing customer demographics, financial behavior, banking products, customer segmentation, and financial risk using **Python, Pandas, PostgreSQL, SQL, and Power BI**.

---

## 🔄 Project Workflow

```text
📂 Data Upload
      ↓
🧹 Data Cleaning
      ↓
📊 EDA
      ↓
🗄️ PostgreSQL
      ↓
🔎 SQL Business Analysis
      ↓
📈 Power BI
      ↓
📊 3 Interactive Dashboards
```

---

## 📂 1. Data Upload

- Imported a banking customer dataset containing **3,000 customer records and 25 original columns**.
- Loaded the dataset into Python/Pandas for preparation and exploratory analysis.
- Loaded the cleaned dataset into PostgreSQL.
- Connected Power BI directly to the PostgreSQL database.

---

## 🧹 2. Data Cleaning

The dataset was prepared using **Python and Pandas**.

Key cleaning steps:

- ✅ Checked missing values.
- ✅ Checked duplicate records.
- 🔍 Investigated repeated `client_id` values.
- ✅ Preserved repeated IDs when they represented different customers instead of incorrectly deleting valid records.
- 🆔 Created a unique `customer_id` for analysis.
- ✅ Verified the final dataset before loading it into PostgreSQL.

---

## 📊 3. Exploratory Data Analysis (EDA)

Key areas analyzed:

- 👥 Customer age distribution.
- 💰 Estimated income distribution.
- 🏦 Bank deposits and loan distributions.
- 💳 Credit card balance distribution.
- 🏦 Banking product characteristics.
- ⭐ Customer loyalty classification.
- 🔗 Relationships between income, deposits, and loans.
- ⚠️ Customers with zero bank deposits.

### 🔎 Key EDA Findings

- 📈 Income, deposits, loans, and credit-card balances show right-skewed distributions.
- 💰 Income vs. bank deposits correlation: **0.2603**.
- 💳 Income vs. bank loans correlation: **0.3299**.
- 🏦 Bank deposits vs. bank loans correlation: **0.3732**.
- ⚠️ **34 customers** have zero bank deposits.

---

## 🗄️ 4. PostgreSQL & SQL Analysis

The cleaned dataset was stored in **PostgreSQL** and analyzed using SQL.

SQL analysis focuses on:

- 👤 Customer-level analysis.
- 📌 Business KPIs.
- 🎯 Customer segmentation.
- 💰 Income and deposit analysis.
- 💳 Loan exposure.
- 📊 Loan-to-deposit analysis.
- ⭐ Loyalty-based financial analysis.
- ⚠️ Risk analysis.
- 💎 Identification of high-value and high-exposure customer segments.

**Main PostgreSQL table:**

```text
public.banking_customers
```

---

## 📈 5. Power BI Dashboards

The project contains **3 interactive Power BI dashboards**.

### 🏠 Dashboard 1 — Executive Overview

**Business question:**  
> What is happening across the bank overall?

Key metrics and analysis:

- 👥 Total Customers
- 🎂 Average Age
- 💰 Average Income
- 💳 Total Bank Loans
- 🏦 Total Bank Deposits
- 💼 Customers by Occupation
- ⭐ Customers by Loyalty Classification
- 🌍 Customers by Nationality
- 📅 Customers by Joined Year

---

### 👥 Dashboard 2 — Customer Analysis

**Business question:**  
> Who are our customers?

Key analysis:

- 🎂 Customers by Age Group
- ⚧️ Customers by Gender
- 💵 Customers by Fee Structure
- 💰 Income Distribution
- 💳 Customers by Number of Credit Cards
- 🏠 Customers by Properties Owned
- 🏦 Average Account Balance by Account Type

This dashboard focuses on **customer characteristics, preferences, and segmentation** without duplicating the main visuals from the Executive Overview.

---

### ⚠️ Dashboard 3 — Financial & Risk Analysis

**Business question:**  
> How financially healthy and exposed is the customer base?

Key metrics and analysis:

- 💳 Average Loan
- 🏦 Average Deposit
- 💰 Average Credit Card Balance
- 📊 Average Loan-to-Deposit Ratio
- 👥 Total Customers
- ⚖️ Average Loan vs. Average Deposit
- 💳 Credit Card Balance Distribution
- 📊 Loan-to-Deposit Ratio Distribution
- ⚠️ Customer Risk Distribution
- 💼 Business Lending Range
- ⭐ Average Loan by Loyalty Classification

---

## 🎯 6. Business Objective

The analysis is designed to answer questions such as:

- 💎 Who are the bank's most valuable customer segments?
- 🏦 Which customers hold significant deposits?
- 💳 Which customers have high loan exposure?
- ⭐ How does financial behavior differ across loyalty segments?
- 💰 How are credit-card balances distributed?
- 📊 What does the loan-to-deposit relationship look like?
- 🎯 Which customer groups may represent potential cross-selling opportunities?
- ⚠️ Where is financial exposure concentrated?

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

## 👨‍💻 Author

**Naved**

🎯 Data Analyst Portfolio Project

**Python | SQL | PostgreSQL | Power BI**
