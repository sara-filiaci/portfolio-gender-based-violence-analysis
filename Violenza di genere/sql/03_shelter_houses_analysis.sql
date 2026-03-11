-- =========================================================
-- 03_shelter_houses_analysis.sql
-- =========================================================
-- Purpose:
-- Analyze shelter houses in Italy for 2023 only, focusing on:
-- 1. availability of shelter beds by region
-- 2. utilization rate of shelter beds by region
-- 3. women hosted by region
-- 4. shelter use relative to female population
-- 5. outcomes of shelter house pathways by region
--
-- Methodological note:
-- This file is intentionally limited to shelter house data for 2023,
-- to keep it temporally coherent and separate from the broader
-- 2015–2024 analyses used in the other SQL sheets.
-- =========================================================



-- =========================================================
-- 1. Shelter beds available by region
-- Purpose:
-- Identify where shelter houses have the highest number
-- of authorized beds in 2023.
-- =========================================================

SELECT
    regione AS region,
    totale_posti_letto_autorizzati AS authorized_beds
FROM case_rifugio_2023_posti_letto
WHERE regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige',
	'trento',
    'bolzano'
)
ORDER BY authorized_beds DESC;



-- =========================================================
-- 2. Shelter bed utilization rate by region
-- Purpose:
-- Measure how intensively shelter capacity is used in each region.
-- Note:
-- Utilized beds can be higher than authorized beds, reflecting
-- over-capacity use rather than a SQL anomaly.
-- =========================================================

SELECT
    regione AS region,
    totale_posti_letto_autorizzati AS authorized_beds,
    totale_posti_letto_utilizzati AS utilized_beds,
    ROUND(
        (totale_posti_letto_utilizzati * 100.0) /
        NULLIF(totale_posti_letto_autorizzati, 0),
        2
    ) AS utilization_rate_pct
FROM case_rifugio_2023_posti_letto
WHERE regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige',
	'trento',
    'bolzano'
)
ORDER BY utilization_rate_pct DESC;



-- =========================================================
-- 3. Women hosted by region
-- Purpose:
-- Show how many women were hosted in shelter houses
-- in each region in 2023.
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
    'trentino alto adige',
	'trento',
    'bolzano'
)
ORDER BY women_hosted DESC;



-- =========================================================
-- 4a. Authorized shelter beds per 100,000 women by region
-- Purpose:
-- Compare shelter bed availability across regions relative
-- to female population size.
--
-- Method note:
-- popolazione_regione contains multiple rows per region,
-- so MAX(totale_femmine) is used to retrieve the correct
-- regional female population.
-- =========================================================

WITH female_population_by_region AS (
    SELECT
        territorio AS region,
        MAX(totale_femmine) AS total_female_population
    FROM popolazione_regione
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano'
    )
    GROUP BY territorio
)
SELECT
    s.regione AS region,
    s.totale_posti_letto_autorizzati AS authorized_beds,
    p.total_female_population,
    ROUND(
        (s.totale_posti_letto_autorizzati * 100000.0) /
        p.total_female_population,
        2
    ) AS beds_per_100k_women
FROM case_rifugio_2023_posti_letto AS s
JOIN female_population_by_region AS p
    ON s.regione = p.region
WHERE s.regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige'
)
ORDER BY beds_per_100k_women DESC;



-- =========================================================
-- 4b. Women hosted per 100,000 women by region
-- Purpose:
-- Compare shelter use across regions relative
-- to female population size.
--
-- Method note:
-- popolazione_regione contains multiple rows per region,
-- so MAX(totale_femmine) is used to retrieve the correct
-- regional female population.
-- =========================================================

WITH female_population_by_region AS (
    SELECT
        territorio AS region,
        MAX(totale_femmine) AS total_female_population
    FROM popolazione_regione
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano'
    )
    GROUP BY territorio
)
SELECT
    d.regione AS region,
    d.totale_donne_accolte AS women_hosted,
    p.total_female_population,
    ROUND(
        (d.totale_donne_accolte * 100000.0) /
        p.total_female_population,
        2
    ) AS women_hosted_per_100k_women
FROM case_rifugio_2023_quantita_donne_accolte AS d
JOIN female_population_by_region AS p
    ON d.regione = p.region
WHERE d.regione NOT IN (
    'italia',
    'nord ovest',
    'nord est',
    'centro',
    'sud',
    'isole',
    'trentino alto adige'
)
ORDER BY women_hosted_per_100k_women DESC;



-- =========================================================
-- 5. Shelter pathway outcomes by region
-- Purpose:
-- Show how pathways in shelter houses conclude by region.
--
-- Important:
-- These values are already percentages, so they must be
-- displayed directly and not aggregated.
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
    'trentino alto adige',
	'trento',
    'bolzano'
)
ORDER BY conclusione_percorso DESC;