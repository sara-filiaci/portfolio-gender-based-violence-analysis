# Gender-Based Violence in Italy – Data Cleaning, SQL Analysis and Visualization

This repository documents the full analytical workflow of a project focused on **gender-based violence in Italy**, structured into three main phases:

- **data cleaning and standardization**
- **SQL analysis**
- **data visualization**

The datasets were sourced from **ISTAT**.

---

# Project Objective

The goal of the project is to build a dataset that is:

- clean  
- consistent  
- query-ready  
- comparable across regions  

to enable a structured analysis of gender-based violence.

The work focused on:

- cleaning and standardizing datasets  
- aligning structures across files  
- removing irrelevant elements  
- preparing data for SQL querying  
- building comparable territorial indicators  
- integrating multiple data sources  
- visually presenting the results  

---

# Scope of the Work

The repository includes the cleaning of:

- **18 CSV files**
- **1 XLSX file**, initially processed in **Google Sheets**

From the XLSX file, **3 separate CSV files** were extracted, related to **shelter houses**.

The cleaned datasets were then imported into a **SQLite** database for SQL analysis.

---

# Cleaned Datasets

The `Violenza di genere/data_clean` folder contains all datasets used for the analysis.

## 1522 Hotline
- `1522_modalità_conoscenza.csv`
- `1522_modalità_intervento.csv`
- `1522_motivo_chiamata.csv`
- `1522_tipologia_utenti.csv`

## Social Attitudes
- `Opinioni_ruoli_tradizionali_età.csv`
- `Opinioni_ruoli_tradizionali_reg.csv`
- `Opinioni_ruoli_tradizionali_titolo_studio.csv`
- `Opinioni_violenza_sessuale_età.csv`
- `Opinioni_violenza_sessuale_reg.csv`
- `Opinioni_violenza_sessuale_titolo_studio.csv`

## Shelter Houses
- `case_rifugio_2023_motivo_uscita_clean.csv`
- `case_rifugio_2023_posti_letto_clean.csv`
- `case_rifugio_2023_quantita_donne_accolte_clean.csv`

## Other Datasets
- `popolazione_regione.csv`

## Victims
- `vittime.disabilità.csv`
- `vittime.età.csv`
- `vittime.motivo_chiamata.csv`
- `vittime.stato_civile.csv`
- `vittime.stato_denuncia.csv`
- `vittime.tipo_violenza.csv`
- `Orientamento_sessuale.csv`

---

# Tools Used

- **Python**
- **pandas**
- **Jupyter Notebook**
- **Visual Studio Code**
- **Google Sheets**
- **SQLite**
- **Tableau Public**

---

# Data Cleaning Workflow

Data cleaning was performed using dedicated Python notebooks, applying a consistent methodology across datasets.

## 1. Initial Inspection
- file structure analysis  
- column inspection  
- unique values analysis  
- identification of missing or redundant fields  

## 2. Column Cleaning
- removal of irrelevant or empty columns  
- elimination of unnecessary technical fields  
- standardization of column names  

## 3. Row Cleaning
- removal of empty rows  
- exclusion of non-relevant categories  
- handling of aggregated categories when needed  

## 4. Value Standardization
- normalization of strings  
- trimming unnecessary spaces  
- standardization of territorial labels  
- harmonization of categories  

## 5. Type Normalization
- conversion of numeric fields  
- validation of consistency between counts and categories  

## 6. Final Validation
- missing values check  
- duplicate check  
- dataset structure validation  
- final export to CSV  

---

# Data Cleaning Output

The result is a set of datasets that are:

- consistent  
- easier to query  
- suitable for SQL analysis  
- reproducible through notebooks  

---

# SQL Analysis Phase

The datasets were imported into a **SQLite** database and analyzed through SQL queries organized into **5 main scripts**.

---

## 1. Victims Profile  
`Violenza di genere/sql/01_victims_profile_analysis.sql`

- total number of victims by region  
- regional percentage distribution  
- gender distribution  
- types of violence  
- age distribution  
- marital status distribution  

---

## 2. 1522 Hotline Analysis  
`Violenza di genere/sql/02_hotline_1522_analysis.sql`

- reasons for contacting the service  
- user types  
- how users became aware of 1522  
- total contacts by region and year  
- contacts per **100,000 inhabitants**  

---

## 3. Shelter Houses Analysis  
`Violenza di genere/sql/03_shelter_houses_analysis.sql`

- authorized beds by region  
- usage level of facilities  
- number of women hosted  
- indicators per **100,000 women**  
- outcomes of shelter programs  

---

## 4. Social Attitudes Analysis  
`Violenza di genere/sql/04_social_attitudes_analysis.sql`

- comparison by gender  
- comparison by age group  
- comparison by education level  
- territorial comparison  
- analysis of stereotypes on:
  - traditional gender roles  
  - sexual violence  

---

## 5. Integrated Regional Comparison  
`Violenza di genere/sql/05_gender_based_violence_italy.sql`

Final integrated table combining:

- victims per **100,000 women**  
- 1522 contacts per **100,000 women**  
- shelter beds per **100,000 women**  
- women hosted per **100,000 women**  
- regional stereotype indices  

### Methodological Note
- normalization based on female population  
- exclusion of non-comparable territorial aggregates  
- integration limited to regions consistently present across datasets  

---

# Key Findings

- significant territorial differences in violence distribution  
- strong regional variability in 1522 usage  
- uneven availability of services  
- higher prevalence of gender stereotypes in specific areas  
- non-linear relationship between violence, services, and cultural context  

---

# Data Visualization

The main SQL outputs were transformed into an interactive dashboard.

The dashboard highlights:

- territorial distribution of violence  
- use of the 1522 service  
- availability of services  
- distribution of gender stereotypes  
- relationships between key variables  

---

Final output used for visualization:

`Violenza di genere/sql/05_results.csv`

👉 **Tableau Public Dashboard:**  
https://public.tableau.com/app/profile/sara.filiaci4225/viz/portfolio-gender-based-violence-analysis/Dashboard1

---

# Conclusion

This project covers the full data analysis pipeline:

- data cleaning  
- data structuring  
- SQL analysis  
- indicator creation  
- data visualization  

and represents a complete example of a **data analysis workflow applied to a complex social phenomenon**.