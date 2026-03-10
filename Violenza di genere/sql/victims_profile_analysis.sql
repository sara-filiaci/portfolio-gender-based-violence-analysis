-- =========================================================
-- Gender-Based Violence in Italy
-- Victims Profile Analysis
-- Author: Sara Filiaci
-- Data sources: ISTAT, 1522 Anti-Violence Hotline
-- Database: SQLite
-- =========================================================

-- This SQL script explores the profile of victims of violence
-- in Italy using several datasets describing demographic and
-- contextual characteristics of victims.

-- The analysis focuses on:
-- 1. Geographic distribution of victims
-- 2. Gender distribution
-- 3. Types of violence
-- 4. Age distribution
-- 5. Marital status
-- 6. Types of violence by gender


-- =========================================================
-- 1. Total victims by region (regions only)
-- Purpose:
-- Rank Italian regions by the total number of recorded victims
-- and show each region's percentage share of the total.
-- =========================================================

WITH victims_by_region AS (
    SELECT 
        territorio AS region,
        SUM(numero_vittime) AS total_victims
    FROM vittime_tipo_violenza
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
    GROUP BY territorio
),
total_victims_all_regions AS (
    SELECT 
        SUM(total_victims) AS grand_total
    FROM victims_by_region
)
SELECT 
    v.region,
    v.total_victims,
    ROUND((v.total_victims * 100.0) / t.grand_total, 2) AS percentage_share
FROM victims_by_region AS v
CROSS JOIN total_victims_all_regions AS t
ORDER BY percentage_share DESC;



-- =========================================================
-- 2. Victims by gender and region
-- Purpose:
-- Analyze the gender distribution of victims across regions
-- and calculate the percentage share within each region.
-- =========================================================

WITH victims_by_gender AS (
    SELECT 
        territorio AS region,
        sesso AS gender,
        SUM(numero_vittime) AS total_victims
    FROM vittime_tipo_violenza
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
    AND sesso != 'non indicato'
    GROUP BY territorio, sesso
),
regional_totals AS (
    SELECT
        region,
        SUM(total_victims) AS region_total
    FROM victims_by_gender
    GROUP BY region
)
SELECT 
    v.region,
    v.gender,
    v.total_victims,
    ROUND((v.total_victims * 100.0) / r.region_total, 2) AS percentage_within_region
FROM victims_by_gender AS v
JOIN regional_totals AS r
    ON v.region = r.region
ORDER BY v.region, percentage_within_region DESC;



-- =========================================================
-- 3. Types of violence by region
-- Purpose:
-- Identify the most common forms of violence reported
-- across Italian regions and calculate their distribution
-- within each region.
-- =========================================================

WITH violence_by_region AS (
    SELECT 
        territorio AS region,
        tipo_violenza AS violence_type,
        SUM(numero_vittime) AS total_victims
    FROM vittime_tipo_violenza
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
    AND tipo_violenza NOT IN (
        'non disponibile',
        'non risponde'
    )
    GROUP BY territorio, tipo_violenza
),
regional_totals AS (
    SELECT
        region,
        SUM(total_victims) AS region_total
    FROM violence_by_region
    GROUP BY region
)
SELECT 
    v.region,
    v.violence_type,
    v.total_victims,
    ROUND((v.total_victims * 100.0) / r.region_total, 2) AS percentage_within_region
FROM violence_by_region AS v
JOIN regional_totals AS r
    ON v.region = r.region
ORDER BY v.region, percentage_within_region DESC;



-- =========================================================
-- 4. Victims by age group and region
-- Purpose:
-- Analyze the age distribution of victims across Italian regions
-- and calculate the percentage share of each age group.
-- =========================================================

WITH victims_by_age AS (
    SELECT 
        territorio AS region,
        età AS age_group,
        SUM(numero_vittime) AS total_victims
    FROM vittime_eta
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
    AND età NOT IN (
        'non disponibile',
        'non indicato'
    )
    GROUP BY territorio, età
),
regional_totals AS (
    SELECT
        region,
        SUM(total_victims) AS region_total
    FROM victims_by_age
    GROUP BY region
)
SELECT 
    v.region,
    v.age_group,
    v.total_victims,
    ROUND((v.total_victims * 100.0) / r.region_total, 2) AS percentage_within_region
FROM victims_by_age AS v
JOIN regional_totals AS r
    ON v.region = r.region
ORDER BY v.region, percentage_within_region DESC;



-- =========================================================
-- 5. Victims by marital status and region
-- Purpose:
-- Analyze the marital status distribution of victims across regions.
-- =========================================================

WITH victims_by_marital_status AS (
    SELECT 
        territorio AS region,
        stato_civile AS marital_status,
        SUM(numero_vittime) AS total_victims
    FROM vittime_stato_civile
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
    AND stato_civile NOT IN (
        'non indicato',
        'non disponibile'
    )
    GROUP BY territorio, stato_civile
),
regional_totals AS (
    SELECT
        region,
        SUM(total_victims) AS region_total
    FROM victims_by_marital_status
    GROUP BY region
)
SELECT 
    v.region,
    v.marital_status,
    v.total_victims,
    ROUND((v.total_victims * 100.0) / r.region_total, 2) AS percentage_within_region
FROM victims_by_marital_status AS v
JOIN regional_totals AS r
    ON v.region = r.region
ORDER BY v.region, percentage_within_region DESC;



-- =========================================================
-- 6. Types of violence by gender
-- Purpose:
-- Analyze how different forms of violence are distributed
-- between female and male victims.
-- =========================================================

WITH violence_by_gender AS (
    SELECT
        sesso AS gender,
        tipo_violenza AS violence_type,
        SUM(numero_vittime) AS total_victims
    FROM vittime_tipo_violenza
    WHERE sesso != 'non indicato'
    AND tipo_violenza NOT IN (
        'non disponibile',
        'non risponde'
    )
    GROUP BY sesso, tipo_violenza
),
gender_totals AS (
    SELECT
        gender,
        SUM(total_victims) AS gender_total
    FROM violence_by_gender
    GROUP BY gender
)
SELECT
    v.gender,
    v.violence_type,
    v.total_victims,
    ROUND((v.total_victims * 100.0) / g.gender_total, 2) AS percentage_within_gender
FROM violence_by_gender AS v
JOIN gender_totals AS g
    ON v.gender = g.gender
ORDER BY v.gender, percentage_within_gender DESC;

-- =========================================================
-- Methodological note
-- =========================================================
-- The dataset allows separate analyses by gender, age group,
-- marital status, and type of violence.
--
-- However, it does not provide a single table combining
-- violence type with age group or marital status at row level.
-- For this reason, cross-analyses such as:
-- - violence type by age group
-- - violence type by marital status
-- are not included, in order to avoid unreliable joins
-- between already aggregated tables.