# Global Layoff Data Cleaning & Preparation (MySQL)

**Project Overview**  
This repository contains a SQL-based project where I cleaned, transformed, and prepared a global layoff dataset using MySQL. The goal was to take raw layoff data, resolve inconsistencies, remove duplicates, handle missing values, and produce a clean table ready for analysis.

---

## 🗂️ Files & Structure

| Filename                     | Purpose                                                                 |
|------------------------------|-------------------------------------------------------------------------|
| `01_create_tables.sql`       | Creates the base table schema for loading raw layoff data.              |
| `02_data_cleaning.sql`       | Contains SQL statements to clean data: remove duplicates, handle nulls, standardize formats. |
| `03_transformations.sql`     | Additional transformations (e.g. deriving new columns, filtering, staging). |
| `04_final_table.sql`         | Creates the final cleaned version of the table (e.g. `layoffs_cleaned`). |
| `05_analysis_queries.sql`    | Example queries on cleaned data to showcase insights or checks.          |
| `README.md`                   | This documentation.                                                      |

---

## 🛠️ Tools & Technologies

- **MySQL** (version e.g. 8.0)  
- MySQL client (Workbench)  

---

## 📊 Dataset

- **Source:** [https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv]  
- **Description:**  
 - Contains global layoff records with columns such as `company`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, etc.  
 - Raw data may include duplicates, missing values, inconsistent formatting, etc.

---

## 📝 How to Run

1. **Clone this repository**  
   ```bash
   git clone https://github.com/jancarloscamacho/World_Layoffs_Data_Project/blob/main/World_Layoffs_Project_Code.git
   cd World_Layoffs_Data_Project
