# 📊 SQL Project: Data Job Market Analysis

---

## Introduction

This project focuses on analyzing the **Data Analyst job market** using SQL to uncover insights related to **salary trends, skill demand, and optimal skill combinations**.  
The analysis answers practical, career-focused questions using real-world job posting data.

All insights are derived from SQL queries executed on a PostgreSQL database, with results visualized for clearer interpretation.

---

## Background

With the rapid rise of data-driven decision-making, Data Analyst roles have become highly competitive. Job seekers often struggle to understand:

- Which roles offer the highest salaries
- Which skills are truly in demand
- How skill demand correlates with compensation

This project addresses these questions by analyzing job postings, salary information, company data, and required skills using SQL.

---

## Tools I Used

- **PostgreSQL (SQL)**
  - Joins, aggregations, filtering
  - CTEs and subqueries
  - Window functions (`RANK`)
  - Date & time zone conversions

- **Python**
  - `pandas` for handling query outputs
  - `matplotlib` for generating visualizations

- **Git & GitHub**
  - Version control
  - Project documentation

> 📌 Large datasets, generated results, and visualizations are excluded from the repository for cleanliness and efficiency.

---

## The Analysis

---

### 1️⃣ Top Paying Remote Data Analyst Jobs  
**SQL File:** `1_top_paying_jobs.sql`

**Problem Explanation:**  
This query identifies the **top 10 highest-paying Data Analyst jobs** that are available remotely and have non-null salary information.  
The objective is to evaluate whether high compensation is limited to on-site roles or achievable in remote positions.

**Result Analysis:**  
The results show that several remote Data Analyst roles offer salaries exceeding **$150K–$200K annually**.  
This confirms that location independence does not restrict earning potential and that high-paying opportunities exist across a range of companies.

![Top Paying Remote Data Analyst Jobs](PASTE_IMAGE_URL_HERE)

---

### 2️⃣ Skills Required for Top Paying Jobs  
**SQL File:** `2_top_paying_job's_skills.sql`

**Problem Explanation:**  
This analysis determines which skills are most commonly required in the **highest-paying Data Analyst roles**.

**Result Analysis:**  
SQL appears in nearly all top-paying jobs, reinforcing its role as a foundational skill.  
Python and Tableau are also highly prevalent, highlighting the importance of programming and data visualization in high-compensation roles.

![Skills Required for Top Paying Jobs](PASTE_IMAGE_URL_HERE)

---

### 3️⃣ Most In-Demand Data Analyst Skills  
**SQL File:** `3_top_demanded_skills.sql`

**Problem Explanation:**  
This query ranks skills by the number of Data Analyst job postings that require them, revealing overall market demand.

**Result Analysis:**  
SQL and Excel dominate demand, confirming they are baseline requirements for most roles.  
Python, Tableau, and Power BI follow closely, emphasizing the importance of analytical and visualization skills.

![Most In-Demand Data Analyst Skills](PASTE_IMAGE_URL_HERE)

---

### 4️⃣ Top Paying Skills by Average Salary  
**SQL File:** `4_top_skills_by_salary.sql`

**Problem Explanation:**  
This analysis identifies skills associated with the **highest average salaries**, regardless of how frequently they appear in job postings.

**Result Analysis:**  
Highly specialized and infrastructure-related skills command premium pay.  
These skills are less common but significantly increase earning potential, often reflecting scarcity and advanced expertise.

![Top Paying Data Analyst Skills](PASTE_IMAGE_URL_HERE)

---

### 5️⃣ Most Optimal Skills (Demand vs Salary)  
**SQL File:** `5_top_optimal_skills.sql`

**Problem Explanation:**  
This query combines job demand and average salary to identify the **most optimal skills** to learn.

**Result Analysis:**  
SQL offers the strongest balance between demand and compensation.  
Python and Tableau provide strong salary upside, while Excel—though highly demanded—offers less differentiation in pay.

![Most Optimal Data Analyst Skills](PASTE_IMAGE_URL_HERE)

---

### 6️⃣ Latest Data Analyst Job Postings  
**SQL File:** `6_latest_jobs.sql`

**Problem Explanation:**  
This query retrieves the most recent Data Analyst job postings after February 2023 and converts posting times from UTC to U.S. Eastern Time.

**Result Analysis:**  
The latest postings show continued hiring activity across regions and remote roles.  
Salary ranges vary widely, reflecting differences in role scope, seniority, and company expectations.

![Latest Data Analyst Job Postings](PASTE_IMAGE_URL_HERE)

---

## What I Learned

- How to write real-world analytical SQL queries
- Practical use of CTEs, subqueries, and window functions
- How to translate raw SQL results into actionable insights
- How demand and salary do not always correlate directly
- How to document a complete data analysis project professionally

---

## Conclusions

This project demonstrates that:

- **SQL is the most critical skill** for Data Analysts
- Combining SQL with Python/R and visualization tools maximizes career potential
- Specialized skills unlock higher salary tiers
- Remote roles can offer compensation comparable to on-site positions

Overall, this project shows how **SQL-driven analysis** can provide meaningful insights into the data job market and support informed, data-driven career decisions.
