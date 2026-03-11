# Violenza di genere in Italia – Data cleaning e analisi SQL

Questo repository documenta la fase di **pulizia dei dati, standardizzazione e analisi SQL** di un progetto dedicato alla **violenza di genere in Italia**.

I dataset utilizzati provengono da **ISTAT** e dal servizio nazionale **1522 – Numero antiviolenza e stalking**.  
I dati sono stati preparati per essere utilizzati in **analisi SQL, analisi esplorativa e successive visualizzazioni**.

---

# Obiettivo del progetto

L’obiettivo di questa fase è costruire un insieme di dati **pulito, coerente e interrogabile** per l’analisi del fenomeno della violenza di genere.

Il lavoro si è concentrato su:

- pulizia e standardizzazione dei dataset  
- uniformazione delle strutture tra file  
- rimozione di elementi non utili all’analisi  
- preparazione dei dati per interrogazioni SQL  
- costruzione di indicatori territoriali comparabili  
- prima esplorazione analitica del fenomeno  

---

# Ambito del lavoro

Il repository include la pulizia di:

- **18 file CSV**
- **1 file XLSX**, gestito separatamente in **Google Sheets** per la preparazione iniziale

Dal file XLSX sono stati estratti **3 file CSV distinti**, relativi alle **case rifugio**.

I dataset puliti sono poi stati importati in un database **SQLite** per la fase di analisi SQL.

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

# Output finale

Il risultato della fase di data cleaning è un insieme di dataset:

- coerenti tra loro  
- più semplici da interrogare  
- adatti all’analisi SQL  
- riproducibili tramite notebook  

---

# Riproducibilità

I dataset finali sono stati generati rieseguendo i notebook Python e verificando gli output finali.

Per il file XLSX, la preparazione iniziale è stata svolta in **Google Sheets**, da cui sono stati estratti i CSV utilizzati nell’analisi.

Il processo di pulizia è quindi:

- tracciabile  
- documentato  
- riproducibile  

---

# Fase di analisi SQL

Dopo la pulizia dei dati, i dataset sono stati importati in un database **SQLite** e analizzati tramite query SQL.

L’analisi è organizzata in **5 script principali**.

---

## 1. Profilo delle vittime

Script:

`sql/01_victims_profile_analysis.sql`

Questo script costruisce un profilo **territoriale e demografico delle vittime**.

Analisi incluse:

- numero totale di vittime per regione  
- quota percentuale delle regioni sul totale nazionale  
- distribuzione delle vittime per sesso  
- tipologie di violenza più frequenti  
- distribuzione delle vittime per fascia d’età  
- distribuzione per stato civile  
- tipologie di violenza per sesso  

---

## 2. Analisi del servizio 1522

Script:

`sql/02_hotline_1522_analysis.sql`

Questo script analizza l’utilizzo del **numero nazionale antiviolenza 1522**.

Analisi incluse:

- motivi di contatto con il servizio  
- tipologia di utenti che contattano il servizio  
- modalità attraverso cui le persone conoscono il 1522  
- numero totale di contatti per regione e anno  
- contatti normalizzati per **100.000 abitanti**  

---

## 3. Analisi delle case rifugio

Script:

`sql/03_shelter_houses_analysis.sql`

Questo script analizza la **disponibilità e l’utilizzo delle case rifugio nel 2023**.

Analisi incluse:

- numero di posti letto autorizzati per regione  
- livello di utilizzo delle strutture  
- numero di donne accolte  
- posti letto per **100.000 donne**  
- donne accolte per **100.000 donne**  
- esiti dei percorsi nelle case rifugio  

---

## 4. Analisi delle opinioni sociali

Script:

`sql/04_social_attitudes_analysis.sql`

Questo script analizza le **opinioni sociali relative ai ruoli di genere tradizionali** e alle **credenze sulla violenza sessuale**.

Analisi incluse:

- confronto nazionale tra **maschi** e **femmine**
- confronto per **fascia d’età**
- confronto per **titolo di studio**
- confronto per **territorio**
- analisi separata di:
  - stereotipi sui **ruoli tradizionali**
  - stereotipi e credenze sulla **violenza sessuale**

### Nota metodologica
Per rendere i risultati più leggibili, le risposte sono state riclassificate in 3 categorie:

- `molto_d_accordo`
- `intermedio` = `abbastanza_d_accordo` + `poco_d_accordo`
- `per_niente_d_accordo`

La categoria `non_risponde` è stata esclusa dalle tabelle sintetiche.

Nelle query territoriali sono state escluse le categorie aggregate territoriali, come:

- `italia`
- `nord ovest`
- `nord est`
- `centro`
- `sud`
- `isole`
- `trentino alto adige`

in modo da evitare sovrapposizioni con le unità territoriali separate di **Trento** e **Bolzano**.

---

## 5. Confronto integrato regionale

Script:

`sql/05_integrated_regional_comparison.sql`

Questo script integra i principali risultati emersi nei fogli precedenti in una **tabella finale di confronto regionale**.

L’obiettivo è mettere in relazione, per ciascuna regione:

- livello di violenza registrata  
- utilizzo del servizio 1522  
- disponibilità e utilizzo delle case rifugio  
- intensità degli stereotipi di genere  

Analisi incluse:

- vittime per **100.000 donne**
- contatti 1522 per **100.000 donne**
- posti letto nelle case rifugio per **100.000 donne**
- donne accolte nelle case rifugio per **100.000 donne**
- indice regionale degli stereotipi sui **ruoli tradizionali**
- indice regionale degli stereotipi sulla **violenza sessuale**
- indice stereotipico combinato regionale

### Nota metodologica
La tabella finale è costruita solo sulle **regioni presenti in modo coerente in tutti i blocchi informativi**, così da evitare disallineamenti territoriali tra:

- dataset sulle vittime  
- dataset sul 1522  
- dataset sulle case rifugio  
- dataset sulle opinioni sociali  

Gli indicatori territoriali sono stati normalizzati sulla **popolazione femminile regionale**.

L’indice degli stereotipi è stato costruito a partire dalla media regionale della percentuale di `molto_d_accordo` nelle affermazioni considerate.

---

# Principali evidenze emerse dalla fase SQL

L’analisi SQL ha permesso di evidenziare alcuni aspetti rilevanti del fenomeno:

- differenze territoriali significative nella distribuzione delle vittime  
- forte variabilità regionale nell’utilizzo del servizio **1522**  
- differenze marcate nella disponibilità di posti letto e nell’accoglienza delle case rifugio  
- presenza di stereotipi di genere più elevata in alcune aree del Paese  
- relazione non lineare tra violenza registrata, accesso ai servizi e contesto culturale  

L’integrazione finale dei dataset ha reso possibile una lettura comparativa del fenomeno, non limitata a una sola dimensione ma estesa a:

- violenza registrata  
- accesso ai servizi  
- capacità di accoglienza  
- atteggiamenti sociali  

---

# Fase successiva del progetto

La fase successiva sarà dedicata alla **rappresentazione grafica dei risultati** attraverso visualizzazioni e dashboard.

L’obiettivo sarà trasformare gli output SQL in una presentazione visiva chiara e leggibile, utile per:

- evidenziare i principali pattern territoriali  
- confrontare le regioni in modo immediato  
- sintetizzare le relazioni tra violenza, servizi e stereotipi  
- completare il progetto portfolio con una parte di **data visualization**  

---