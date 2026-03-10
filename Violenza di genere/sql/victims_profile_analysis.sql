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


-- =========================================================
-- 1. Total victims by region (regions only)
-- This query ranks Italian regions by the total number
-- of recorded victims of violence.
--
-- NOTE:
-- Results represent absolute counts, therefore larger
-- regions may appear higher due to population size.
-- =========================================================

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
ORDER BY total_victims DESC;



-- =========================================================
-- 2. Victims by gender and region (regions only)
-- Purpose:
-- Analyze the gender distribution of victims across Italian regions.
-- Aggregate territorial categories and unspecified values are excluded.
-- =========================================================

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
ORDER BY region, total_victims DESC;


-- =========================================================
-- 3. Types of violence by region
-- Purpose:
-- Identify the most common forms of violence reported
-- across Italian regions.
--
-- Notes:
-- - National aggregates and macro-areas are excluded
-- - Unspecified categories are removed
-- =========================================================

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
ORDER BY region, total_victims DESC;



-- =========================================================
-- 4. Victims by age group and region
-- Purpose:
-- Analyze the age distribution of victims across Italian regions.
--
-- Notes:
-- - National aggregates and macro-areas are excluded
-- - Unspecified age categories are removed
-- =========================================================

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
ORDER BY region, total_victims DESC;



-- =========================================================
-- 5. Victims by marital status and region
-- Purpose:
-- Analyze the marital status distribution of victims across Italian regions.
--
-- Notes:
-- - National aggregates and macro-areas are excluded
-- - Unspecified marital status categories are removed
-- =========================================================

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
ORDER BY region, total_victims DESC;