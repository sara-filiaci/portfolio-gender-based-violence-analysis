# Violenza di genere in Italia – Data cleaning, analisi SQL e visualizzazione

Questo repository documenta l’intero processo di analisi di un progetto dedicato alla **violenza di genere in Italia**, articolato in tre fasi principali:

- **data cleaning e standardizzazione**
- **analisi SQL**
- **visualizzazione dei risultati**

I dataset utilizzati provengono da **ISTAT** e dal servizio nazionale **1522 – Numero antiviolenza e stalking**.

---

# Obiettivo del progetto

L’obiettivo del progetto è costruire un sistema di dati:

- pulito  
- coerente  
- interrogabile  
- comparabile a livello territoriale  

per analizzare il fenomeno della violenza di genere in modo strutturato.

Il lavoro si è concentrato su:

- pulizia e standardizzazione dei dataset  
- uniformazione delle strutture tra file  
- rimozione di elementi non utili all’analisi  
- preparazione dei dati per interrogazioni SQL  
- costruzione di indicatori territoriali comparabili  
- integrazione di più fonti informative  
- rappresentazione visiva dei risultati  

---

# Ambito del lavoro

Il repository include la pulizia di:

- **18 file CSV**
- **1 file XLSX**, gestito separatamente in **Google Sheets** per la preparazione iniziale  

Dal file XLSX sono stati estratti **3 file CSV distinti**, relativi alle **case rifugio**.

I dataset puliti sono stati poi importati in un database **SQLite** per la fase di analisi SQL.

---

# Dataset puliti

La cartella `data_clean` contiene i dataset utilizzati per l’analisi.

## Servizio 1522
- `1522_modalità_conoscenza.csv`
- `1522_modalità_intervento.csv`
- `1522_motivo_chiamata.csv`
- `1522_tipologia_utenti.csv`

## Opinioni sociali
- `opinioni_ruoli_tradizionali_clean.csv`

## Case rifugio
- `case_rifugio_2023_motivo_uscita_clean.csv`
- `case_rifugio_2023_posti_letto_clean.csv`
- `case_rifugio_2023_quantita_donne_accolte_clean.csv`

## Altri dataset
- `orientamento_sessuale.xlsx`
- `popolazione_regione.csv`

## Vittime
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

---

# Strumenti utilizzati

- **Python**
- **pandas**
- **Jupyter Notebook**
- **Visual Studio Code**
- **Google Sheets**
- **SQLite**
- **Tableau Public**

---

# Workflow di pulizia dei dati

La pulizia è stata eseguita tramite notebook Python dedicati, applicando una metodologia coerente ai diversi dataset.

## 1. Ispezione iniziale
- analisi della struttura dei file  
- controllo delle colonne  
- analisi dei valori distinti  
- individuazione di campi vuoti o ridondanti  

## 2. Pulizia delle colonne
- rimozione di colonne irrilevanti o completamente vuote  
- eliminazione di campi tecnici non necessari  
- standardizzazione dei nomi delle colonne  

## 3. Pulizia delle righe
- rimozione di righe vuote  
- eliminazione di categorie non utili all’analisi  
- gestione di categorie aggregate quando necessario  

## 4. Standardizzazione dei valori
- normalizzazione delle stringhe  
- rimozione di spazi inutili  
- uniformazione delle etichette territoriali  
- uniformazione delle categorie  

## 5. Normalizzazione dei tipi
- conversione dei campi numerici  
- verifica della coerenza tra conteggi e categorie  

## 6. Validazione finale
- controllo dei valori mancanti  
- verifica di duplicati  
- controllo della struttura dei dataset  
- esportazione finale in CSV  

---

# Output della fase di data cleaning

Il risultato è un insieme di dataset:

- coerenti tra loro  
- più semplici da interrogare  
- adatti all’analisi SQL  
- riproducibili tramite notebook  

---

# Fase di analisi SQL

I dataset sono stati importati in un database **SQLite** e analizzati tramite query SQL organizzate in **5 script principali**.

---

## 1. Profilo delle vittime  
`sql/01_victims_profile_analysis.sql`

- numero totale di vittime per regione  
- distribuzione percentuale territoriale  
- distribuzione per sesso  
- tipologie di violenza  
- distribuzione per età  
- distribuzione per stato civile  

---

## 2. Analisi del servizio 1522  
`sql/02_hotline_1522_analysis.sql`

- motivi di contatto  
- tipologia utenti  
- modalità di conoscenza del servizio  
- contatti per regione e anno  
- contatti per **100.000 abitanti**  

---

## 3. Analisi delle case rifugio  
`sql/03_shelter_houses_analysis.sql`

- posti letto autorizzati  
- livello di utilizzo  
- donne accolte  
- indicatori per **100.000 donne**  
- esiti dei percorsi  

---

## 4. Analisi delle opinioni sociali  
`sql/04_social_attitudes_analysis.sql`

- confronto per sesso  
- confronto per età  
- confronto per istruzione  
- confronto territoriale  
- analisi stereotipi su:
  - ruoli tradizionali  
  - violenza sessuale  

---

## 5. Confronto integrato regionale  
`sql/05_integrated_regional_comparison.sql`

Tabella finale che integra:

- vittime per **100.000 donne**  
- contatti 1522 per **100.000 donne**  
- posti letto per **100.000 donne**  
- donne accolte per **100.000 donne**  
- indice stereotipi regionali  

### Nota metodologica
- normalizzazione su popolazione femminile  
- esclusione territori non comparabili  
- integrazione solo regioni coerenti tra dataset  

---

# Principali evidenze

- forti differenze territoriali nella violenza  
- variabilità nell’utilizzo del 1522  
- disomogeneità nella disponibilità di servizi  
- presenza di stereotipi più elevati in alcune aree  
- relazione non lineare tra violenza, servizi e contesto culturale  

---

# Visualizzazione dei risultati

Gli output SQL sono stati trasformati in una dashboard interattiva.

La dashboard mostra:

- distribuzione territoriale della violenza  
- utilizzo del servizio 1522  
- disponibilità dei servizi  
- distribuzione degli stereotipi  
- relazioni tra variabili  

---

Output finale utilizzato per la visualizzazione:

`sql/05_results.csv`

👉 **Dashboard Tableau Public:**  
https://public.tableau.com/app/profile/sara.filiaci4225/viz/portfolio-gender-based-violence-analysis/Dashboard1

---

# Conclusione

Il progetto copre l’intero flusso analitico:

- data cleaning  
- strutturazione dati  
- analisi SQL  
- costruzione indicatori  
- data visualization  

e rappresenta un esempio completo di **pipeline di analisi dati applicata a un fenomeno sociale complesso**.