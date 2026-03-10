-- =========================================================
-- Gender-Based Violence in Italy
-- Support Services Analysis
-- Author: Sara Filiaci
-- Data sources: ISTAT, 1522 Anti-Violence Hotline
-- Database: SQLite
-- =========================================================

-- This SQL script analyzes support services related to
-- gender-based violence in Italy.

-- The analysis focuses on:
-- 1. Shelter house capacity by region
-- 2. Shelter house usage by region
-- 3. Women hosted in shelter houses
-- 4. Reasons for contacting the 1522 hotline
-- 5. Types of users contacting the 1522 hotline
-- 6. How people discover the 1522 hotline


-- =========================================================
-- 1. Shelter houses capacity and usage by region
-- Purpose:
-- Compare authorized beds and used beds in shelter houses
-- and calculate the utilization rate.
-- =========================================================

-- Note:
-- In some regions the number of used beds exceeds the number
-- of authorized beds. This reflects temporary overcapacity
-- or emergency accommodation reported in the ISTAT dataset.

SELECT
    regione AS region,
    totale_posti_letto_autorizzati AS authorized_beds,
    totale_posti_letto_utilizzati AS used_beds,
    ROUND(
        (totale_posti_letto_utilizzati * 100.0) /
        totale_posti_letto_autorizzati,
        2
    ) AS utilization_rate_percent
FROM case_rifugio_2023_posti_letto
WHERE regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige'
)
ORDER BY utilization_rate_percent DESC;


-- =========================================================
-- 2. Women hosted in shelter houses by region
-- Purpose:
-- Analyze how many women are hosted in shelter houses
-- across Italian regions.
-- =========================================================

SELECT
    regione AS region,
    totale_donne_accolte AS women_hosted
FROM case_rifugio_2023_quantita_donne_accolte
WHERE regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige'
)
ORDER BY women_hosted DESC;


-- =========================================================
-- 3. Outcomes of shelter house stays by region
-- Purpose:
-- Show how shelter stays conclude in each region.
-- Values are percentages.
-- =========================================================

SELECT
    regione AS region,
    conclusione_percorso,
    abbandono_o_ritorno_dal_maltrattante,
    trasferimento_o_altri_motivi
FROM case_rifugio_2023_motivo_uscita
WHERE regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige'
)
ORDER BY conclusione_percorso DESC;


-- =========================================================
-- 4. Reasons for contacting the 1522 hotline by region
-- Purpose:
-- Identify the main reasons for contacting the hotline
-- across Italian regions.
-- =========================================================

SELECT
    territorio AS region,
    motivo_chiamata AS reason_for_contact,
    SUM(numero_vittime) AS total_contacts
FROM "1522_motivo_chiamata"
WHERE territorio NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole'
)
AND motivo_chiamata NOT IN (
    'non indicato',
    'non disponibile'
)
GROUP BY territorio, motivo_chiamata
ORDER BY territorio, total_contacts DESC;


-- =========================================================
-- 5. Types of users contacting the 1522 hotline by region
-- Purpose:
-- Analyze who contacts the hotline across Italian regions.
-- =========================================================

SELECT
    territorio AS region,
    tipologia_utenti AS user_type,
    SUM(numero_vittime) AS total_contacts
FROM "1522_tipologia_utenti"
WHERE territorio NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole'
)
AND tipologia_utenti NOT IN (
    'non indicato',
    'non disponibile'
)
GROUP BY territorio, tipologia_utenti
ORDER BY territorio, total_contacts DESC;


-- =========================================================
-- 6. How people discover the 1522 hotline by region
-- Purpose:
-- Analyze how users become aware of the service across regions.
-- =========================================================

SELECT
    territorio AS region,
    modalità_conoscenza_1522 AS discovery_channel,
    SUM(numero_vittime) AS total_contacts
FROM "1522_modalita_conoscenza"
WHERE territorio NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige',
    'non indicato'
)
AND modalità_conoscenza_1522 NOT IN (
    'non indicato',
    'non disponibile',
    'non_risposta'
)
GROUP BY territorio, modalità_conoscenza_1522
ORDER BY territorio, total_contacts DESC;