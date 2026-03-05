# Portfolio Data Cleaning – Violenza di genere

Questa repository documenta la fase di **pulizia e standardizzazione dei dati** di un progetto di analisi sul tema della **violenza di genere** in Italia.

I dataset utilizzati sono stati scaricati da **ISTAT** e preparati per le fasi successive del lavoro, in particolare **analisi SQL**, esplorazione dei dati e costruzione del portfolio.

## Obiettivo del progetto

L’obiettivo di questa fase non è stato solo rendere i file utilizzabili, ma costruire una base dati **pulita, coerente e riproducibile** per l’analisi.

La pulizia è stata svolta con attenzione a:

- coerenza strutturale tra file diversi
- standardizzazione di colonne, categorie e formati
- rimozione di elementi non utili all’analisi
- validazione finale degli output puliti

## Ambito del lavoro

La repository include attualmente la pulizia di:

- **18 file CSV**
- **1 file XLSX aggiuntivo**, gestito separatamente in **Google Fogli** per la sua dimensione ridotta e poi preparato per l’esportazione in CSV

Questa fase rappresenta la base del progetto; l’analisi vera e propria verrà sviluppata successivamente.

## Dataset puliti

### 1522
- `1522_modalità_conoscenza.csv`
- `1522_modalità_intervento.csv`
- `1522_motivo_chiamata.csv`
- `1522_tipologia_utenti.csv`

### Opinioni
- `Opinioni_ruoli_tradizionali_età.csv`
- `Opinioni_ruoli_tradizionali_reg.csv`
- `Opinioni_ruoli_tradizionali_titolo_studio.csv`
- `Opinioni_violenza_sessuale_età.csv`
- `Opinioni_violenza_sessuale_reg.csv`
- `Opinioni_violenza_sessuale_titolo_studio.csv`

### Altri dataset
- `Orientamento_sessuale.csv`
- `popolazione_regione.csv`

### Vittime
- `vittime.disabilità.csv`
- `vittime.età.csv`
- `vittime.motivo_chiamata.csv`
- `vittime.stato_civile.csv`
- `vittime.stato_denuncia.csv`
- `vittime.tipo_violenza.csv`

## Strumenti utilizzati

- **Python**
- **pandas**
- **Jupyter Notebook**
- **Visual Studio Code**
- **Google Fogli** per il file XLSX con poche righe

## Workflow di pulizia

La pulizia è stata realizzata tramite notebook Python dedicati, applicando una metodologia coerente tra i diversi file.

Le principali operazioni svolte sono state:

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
   - esclusione di voci non analitiche, dove necessario
   - gestione di categorie aggregate quando non utili all’analisi

4. **Standardizzazione dei valori**
   - normalizzazione delle stringhe
   - rimozione di spazi superflui
   - uniformazione del testo
   - standardizzazione dei nomi territoriali dove necessario

5. **Normalizzazione dei tipi**
   - conversione dei campi numerici nei tipi corretti
   - controllo di coerenza su anno, conteggi e percentuali

6. **Validazione finale**
   - controllo dei valori mancanti
   - controllo dei duplicati
   - verifica della coerenza strutturale dei file
   - esportazione finale in CSV

## Output finale

Il risultato di questa fase è un insieme di file puliti progettati per essere:

- più facili da interrogare
- più coerenti tra loro
- adatti ad analisi successive
- riproducibili a partire dai notebook

## Riproducibilità

I file CSV puliti sono stati ottenuti rieseguendo i notebook da zero e salvando gli output finali dopo i controlli conclusivi.

Questo rende il processo di pulizia:

- trasparente
- tracciabile
- riproducibile

## Fase successiva

Questa repository copre la fase di **data cleaning**.  
La fase successiva del progetto sarà dedicata all’**analisi SQL** e all’esplorazione dei pattern presenti nei dati sulla violenza di genere.
