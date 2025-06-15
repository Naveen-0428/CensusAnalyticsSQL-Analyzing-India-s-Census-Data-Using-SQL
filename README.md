# 🧠 Census Analytics SQL – Insights from India’s District-Level Census Data

This project explores India’s census data at the district level using **SQL** to uncover key demographic and social insights. It demonstrates how raw datasets can be transformed into actionable knowledge using advanced SQL queries.

---

## 📌 Project Highlights

### 🔍 Key Analyses Performed:
- Estimated **previous population** using census growth rates  
- Calculated **literacy and illiteracy counts** by district and state  
- Derived **male and female populations** using sex ratios  
- Ranked districts with **window functions** (`RANK() OVER`)  
- Computed **population density** (people per square km)  
- Identified **top 3 literate districts per state**

---

## 🧠 SQL Concepts Used
- Table joins and subqueries  
- Aggregate functions (`SUM`, `ROUND`)  
- Window functions (`RANK() OVER`)  
- Derived fields and analytical calculations  
- Grouping, filtering, and ordering logic  

---

## 🗃️ Database Schema

Two tables were used and joined on the `District` field:

### 🔹 `Data1` (Demographic Metrics)
| Column       | Description                        |
|--------------|------------------------------------|
| `State`      | Name of the state                  |
| `District`   | Name of the district               |
| `Sex_Ratio`  | Female-to-male ratio               |
| `Literacy`   | Literacy rate (%)                  |
| `Growth`     | Population growth rate (%)         |

### 🔹 `Sheet1` (Population & Area)
| Column        | Description                      |
|---------------|----------------------------------|
| `District`    | District name                    |
| `State`       | State name                       |
| `Population`  | Total population                 |
| `Area_Km2`    | Area in square kilometers        |

---

## 📊 Sample Calculation: Gender Breakdown

Using sex ratio to estimate gender distribution:
```sql
-- Female-to-male ratio is given
Males = Population / (1 + Sex_Ratio)
Females = Population - Males
