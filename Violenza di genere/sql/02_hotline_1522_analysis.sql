-- =========================================================
-- Gender-Based Violence in Italy
-- 1522 Hotline Analysis
-- Author: Sara Filiaci
-- Data sources: ISTAT, 1522 Anti-Violence Hotline
-- Database: SQLite
-- =========================================================

-- This SQL script analyzes the use of the 1522 anti-violence hotline
-- across Italian regions.

-- The analysis focuses on:
-- 1. Reasons for contacting the hotline by region
-- 2. Types of users contacting the hotline by region
-- 3. How people discover the hotline by region
-- 4. Total hotline contacts by region and year
-- 5. Hotline contacts per 100,000 inhabitants by region

-- Methodological note:
-- 1522 data are available over multiple years.
-- For this reason, queries 1, 2, 3, and 5 use the cumulative period
-- available in the dataset, while query 4 shows the yearly trend.


-- =========================================================
-- 1. Reasons for contacting the 1522 hotline by region
-- Purpose:
-- Identify the main reasons for contacting the hotline
-- across Italian regions over the available period.
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
    'isole',
    'non indicato'
)
AND motivo_chiamata NOT IN (
    'non indicato',
    'non disponibile'
)
GROUP BY territorio, motivo_chiamata
ORDER BY territorio, total_contacts DESC;



-- =========================================================
-- 2. Types of users contacting the 1522 hotline by region
-- Purpose:
-- Analyze who contacts the hotline across Italian regions
-- over the available period.
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
    'isole',
    'non indicato'
)
AND tipologia_utenti NOT IN (
    'non indicato',
    'non disponibile'
)
GROUP BY territorio, tipologia_utenti
ORDER BY territorio, total_contacts DESC;



-- =========================================================
-- 3. How people discover the 1522 hotline by region
-- Purpose:
-- Analyze how users become aware of the hotline
-- across Italian regions over the available period.
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
    'non indicato',
    'trentino alto adige'
)
AND modalità_conoscenza_1522 NOT IN (
    'non indicato',
    'non disponibile',
    'non_risposta'
)
GROUP BY territorio, modalità_conoscenza_1522
ORDER BY territorio, total_contacts DESC;



-- =========================================================
-- 4. Total 1522 hotline contacts by region and year
-- Purpose:
-- Show the annual volume of hotline contacts in each region.
-- =========================================================

SELECT
    territorio AS region,
    periodo AS year,
    SUM(numero_vittime) AS total_contacts
FROM "1522_motivo_chiamata"
WHERE territorio NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'non indicato'
)
AND motivo_chiamata NOT IN (
    'non indicato',
    'non disponibile'
)
GROUP BY territorio, periodo
ORDER BY territorio, year;


-- =========================================================
-- 5. 1522 hotline contacts per 100,000 inhabitants
--    by region and year
-- Purpose:
-- Compare hotline use across regions relative to population size,
-- keeping the analysis separated by year.
-- =========================================================

WITH population_by_region AS (
    SELECT
        territorio AS region,
        MAX(totale) AS total_population
    FROM popolazione_regione
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige'
    )
    GROUP BY territorio
),
hotline_contacts_by_region_year AS (
    SELECT
        territorio AS region,
        periodo AS year,
        SUM(numero_vittime) AS total_contacts
    FROM "1522_motivo_chiamata"
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'non indicato'
    )
    AND motivo_chiamata NOT IN (
        'non indicato',
        'non disponibile'
    )
    GROUP BY territorio, periodo
)
SELECT
    h.region,
    h.year,
    h.total_contacts,
    p.total_population,
    ROUND((h.total_contacts * 100000.0) / p.total_population, 2) AS contacts_per_100k
FROM hotline_contacts_by_region_year AS h
JOIN population_by_region AS p
    ON h.region = p.region
ORDER BY h.year DESC, contacts_per_100k DESC;