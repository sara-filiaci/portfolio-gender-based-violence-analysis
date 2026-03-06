# Data Cleaning Portfolio – Gender-Based Violence

This repository documents the **data cleaning and standardization phase** of a data analysis project focused on **gender-based violence** in Italy.

The datasets were downloaded from **ISTAT** and prepared for the subsequent stages of the project, particularly **SQL analysis**, exploratory analysis, and portfolio development.

## Project Objective

The objective of this phase was not only to make the files usable, but to build a **clean, consistent, and reproducible dataset** for analysis.

The cleaning process focused on:

- structural consistency across different datasets  
- standardization of columns, categories, and formats  
- removal of elements not useful for analysis  
- final validation of cleaned outputs  

## Scope of the Work

The repository currently includes the cleaning of:

- **18 CSV files**
- **1 additional XLSX file**, handled separately in **Google Sheets** due to its small size and then prepared for export as CSV

This phase represents the foundation of the project; the actual analysis will be developed in the next stage.

## Cleaned Datasets

### 1522
- `1522_modalità_conoscenza.csv`
- `1522_modalità_intervento.csv`
- `1522_motivo_chiamata.csv`
- `1522_tipologia_utenti.csv`

### Opinions
- `Opinioni_ruoli_tradizionali_età.csv`
- `Opinioni_ruoli_tradizionali_reg.csv`
- `Opinioni_ruoli_tradizionali_titolo_studio.csv`
- `Opinioni_violenza_sessuale_età.csv`
- `Opinioni_violenza_sessuale_reg.csv`
- `Opinioni_violenza_sessuale_titolo_studio.csv`

### Other datasets
- `Orientamento_sessuale.csv`
- `popolazione_regione.csv`

### Victims
- `vittime.disabilità.csv`
- `vittime.età.csv`
- `vittime.motivo_chiamata.csv`
- `vittime.stato_civile.csv`
- `vittime.stato_denuncia.csv`
- `vittime.tipo_violenza.csv`

## Tools Used

- **Python**
- **pandas**
- **Jupyter Notebook**
- **Visual Studio Code**
- **Google Sheets** for the small XLSX file

## Cleaning Workflow

The cleaning process was implemented through dedicated Python notebooks, applying a consistent methodology across the different datasets.

The main operations included:

1. **Initial data inspection**
   - column review
   - analysis of distinct values
   - identification of empty, redundant, or technical fields

2. **Column cleaning**
   - removal of irrelevant or completely empty columns
   - removal of technical fields not necessary for analysis
   - standardization of column names

3. **Row cleaning**
   - removal of completely empty rows
   - exclusion of non-analytical categories where necessary
   - handling of aggregated categories when not useful for analysis

4. **Value standardization**
   - string normalization
   - removal of unnecessary whitespace
   - text normalization
   - territorial label standardization where necessary

5. **Type normalization**
   - conversion of numeric fields to appropriate types
   - consistency checks on year, counts, and percentages

6. **Final validation**
   - missing value checks
   - duplicate checks
   - structural consistency verification
   - final export to CSV format

## Final Output

The result of this phase is a set of cleaned datasets designed to be:

- easier to query  
- more consistent across files  
- suitable for further analysis  
- reproducible from the notebooks  

## Reproducibility

The cleaned CSV files were obtained by re-running the notebooks from scratch and exporting the final outputs after the final validation checks.

This makes the cleaning process:

- transparent  
- traceable  
- reproducible  

## Next Phase

This repository covers the **data cleaning phase**.  
The next stage of the project will focus on **SQL analysis** and the exploration of patterns related to gender-based violence.