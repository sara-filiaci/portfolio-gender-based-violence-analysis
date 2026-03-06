# Data Cleaning Portfolio – Gender-Based Violence

This repository documents the **data cleaning and standardization phase** of a data analysis project focused on **gender-based violence** in Italy.

The datasets were downloaded from **ISTAT** and prepared for the subsequent stages of the project, particularly **SQL analysis**, exploratory analysis, and portfolio development.

## Project Objective

The objective of this phase was to build a **clean, consistent, and reproducible dataset** for analysis.

The cleaning process focused on:

- structural consistency across datasets  
- standardization of columns, categories, and formats  
- removal of elements not useful for analysis  
- final validation of cleaned outputs  

## Scope of the Work

The repository currently includes the cleaning of:

- **18 CSV files**
- **1 XLSX file**, handled separately in **Google Sheets** due to its small size

From the XLSX file, **3 separate CSV files** were then extracted and prepared, corresponding to three different tables related to **shelter houses**.

This phase represents the foundation of the project. The analytical phase will be developed in the next stage.

## Cleaned Datasets

The `data_clean` folder contains the cleaned datasets used for analysis and visualization.  
At this stage, the project includes the following files:

### 1522
- `1522_modalità_conoscenza.csv`
- `1522_modalità_intervento.csv`
- `1522_motivo_chiamata.csv`
- `1522_tipologia_utenti.csv`

### Opinions
- `opinioni_ruoli_tradizionali_clean.csv`

### Shelter houses
- `case_rifugio_2023_motivo_uscita_clean.csv`
- `case_rifugio_2023_posti_letto_clean.csv`
- `case_rifugio_2023_quantita_donne_accolte_clean.csv`

### Other datasets
- `orientamento_sessuale.xlsx`
- `popolazione_regione.csv`

### Victims
- `vittime_reato_regione_eta_clean.csv`
- `vittime_reato_regione_titolo_studio_clean.csv`
- `vittime_reato_regione_stato_civile_clean.csv`
- `vittime_reato_regione_cittadinanza_clean.csv`
- `vittime_tipo_autore_reato_clean.csv`
- `vittime_tipo_violenza_clean.csv`
- `vittime_rivolte_istituzioni.csv`
- `vittime_rivolte_centri.csv`
- `vittime_denunce.csv`
- `vittime_notte_luogo_pubblico_clean.csv`
- `vittime_notte_mezzo_pubblico_clean.csv`
- `vittime_contesto_familiare_clean.csv`
- `vittime_partner_ex_partner_clean.csv`
- `vittime_partner_ex_partner_motivo_non_denuncia_clean.csv`
- `vittime_preoccupazione_violenza_clean.csv`
- `vittime_preoccupazione_reati.csv`

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
   - conversion of numeric fields to the correct type
   - consistency checks on counts, percentages, and categorical variables

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

The cleaned CSV files were obtained by re-running the notebooks from scratch and exporting the final outputs after the validation checks.

In the case of the XLSX file, the initial preparation was carried out in **Google Sheets**, from which the three CSV files were extracted and then cleaned in the notebooks.

This makes the cleaning process:

- transparent  
- traceable  
- reproducible  

## Next Phase

This repository covers the **data cleaning phase**.  
The next stage of the project will focus on **SQL analysis** and the exploration of patterns related to gender-based violence.