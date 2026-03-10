# Violenza di genere in Italia – Pulizia dei dati e analisi SQL

Questo repository documenta la fase di **pulizia, standardizzazione e prima analisi SQL** di un progetto dedicato alla **violenza di genere** in Italia.

I dataset sono stati scaricati da **ISTAT** e preparati per le successive fasi del progetto, in particolare per **analisi SQL**, analisi esplorativa e sviluppo del portfolio.

## Obiettivo del progetto

L’obiettivo di questa fase è stato costruire un insieme di dati **pulito, coerente e riproducibile** per l’analisi.

Il processo di pulizia si è concentrato su:

- coerenza strutturale tra dataset  
- standardizzazione di colonne, categorie e formati  
- rimozione di elementi non utili all’analisi  
- validazione finale degli output puliti  

## Ambito del lavoro

Il repository attualmente include la pulizia di:

- **18 file CSV**
- **1 file XLSX**, gestito separatamente in **Google Sheets** per le sue dimensioni ridotte

Dal file XLSX sono stati poi estratti e preparati **3 file CSV distinti**, corrispondenti a tre tavole diverse relative alle **case rifugio**.

Questa fase rappresenta la base del progetto e include anche una prima esplorazione analitica in SQL.

## Dataset puliti

La cartella `data_clean` contiene i dataset puliti utilizzati per l’analisi e la visualizzazione.  
Attualmente il progetto include i seguenti file:

### 1522
- `1522_modalità_conoscenza.csv`
- `1522_modalità_intervento.csv`
- `1522_motivo_chiamata.csv`
- `1522_tipologia_utenti.csv`

### Opinioni
- `opinioni_ruoli_tradizionali_clean.csv`

### Case rifugio
- `case_rifugio_2023_motivo_uscita_clean.csv`
- `case_rifugio_2023_posti_letto_clean.csv`
- `case_rifugio_2023_quantita_donne_accolte_clean.csv`

### Altri dataset
- `orientamento_sessuale.xlsx`
- `popolazione_regione.csv`

### Vittime
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

## Strumenti utilizzati

- **Python**
- **pandas**
- **Jupyter Notebook**
- **Visual Studio Code**
- **Google Sheets** per il file XLSX di piccole dimensioni
- **SQLite** per la prima fase di analisi SQL

## Workflow di pulizia

Il processo di pulizia è stato implementato attraverso notebook Python dedicati, applicando una metodologia coerente ai diversi dataset.

Le principali operazioni hanno incluso:

1. **Ispezione iniziale dei dati**
   - controllo delle colonne
   - analisi dei valori distinti
   - individuazione di campi vuoti, ridondanti o tecnici

2. **Pulizia delle colonne**
   - rimozione di colonne irrilevanti o completamente vuote
   - rimozione di campi tecnici non necessari all’analisi
   - standardizzazione dei nomi delle colonne

3. **Pulizia delle righe**
   - rimozione di righe completamente vuote
   - esclusione di categorie non analitiche dove necessario
   - gestione di categorie aggregate quando non utili all’analisi

4. **Standardizzazione dei valori**
   - normalizzazione delle stringhe
   - rimozione di spazi inutili
   - uniformazione del testo
   - standardizzazione delle etichette territoriali dove necessario

5. **Normalizzazione dei tipi**
   - conversione dei campi numerici nel tipo corretto
   - controlli di coerenza su conteggi, percentuali e variabili categoriali

6. **Validazione finale**
   - controllo dei valori mancanti
   - controllo dei duplicati
   - verifica della coerenza strutturale
   - esportazione finale in formato CSV

## Output finale

Il risultato di questa fase è un insieme di dataset puliti progettati per essere:

- più facili da interrogare  
- più coerenti tra file  
- adatti ad analisi successive  
- riproducibili a partire dai notebook  

## Riproducibilità

I file CSV puliti sono stati ottenuti rieseguendo i notebook da zero ed esportando gli output finali dopo i controlli di validazione.

Nel caso del file XLSX, la preparazione iniziale è stata svolta in **Google Sheets**, da cui sono stati ricavati i tre CSV poi puliti nei notebook.

Questo rende il processo di pulizia:

- trasparente  
- tracciabile  
- riproducibile  

## Analisi SQL

Dopo la fase di pulizia, i dataset puliti sono stati importati in un database SQLite ed esplorati tramite query SQL.

Il primo passaggio analitico si concentra sulla costruzione di un **profilo demografico delle vittime** a livello regionale.

L’analisi SQL include:

- numero totale di vittime per regione  
- distribuzione delle vittime per sesso  
- distribuzione delle tipologie di violenza  
- distribuzione delle vittime per fascia d’età  
- distribuzione delle vittime per stato civile  

Le query sono disponibili in:

`sql/victims_profile_analysis.sql`

Questo script rappresenta una prima esplorazione del dataset e prepara la base per analisi successive, come confronti territoriali, pattern di violenza e analisi dei servizi di supporto.

## Fase successiva

Dopo la prima esplorazione SQL del profilo delle vittime, la fase successiva del progetto sarà dedicata a domande analitiche più approfondite, tra cui:

- confronto dei pattern di violenza tra regioni  
- relazione tra numero di vittime e servizi di supporto disponibili  
- analisi delle chiamate al 1522  
- costruzione di indicatori regionali basati sulla popolazione