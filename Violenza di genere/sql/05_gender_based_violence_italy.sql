-- =========================================================
-- Gender-Based Violence in Italy
-- Integrated Regional Comparison
-- Author: Sara Filiaci
-- Data sources: ISTAT, 1522 Anti-Violence Hotline
-- Database: SQLite
-- =========================================================

-- This SQL script integrates the main dimensions explored
-- in the previous sheets at regional level:
-- 1. recorded victims
-- 2. use of the 1522 hotline
-- 3. shelter house availability and use
-- 4. social attitudes and stereotypes

-- The analysis focuses on:
-- 1. victims per 100,000 women
-- 2. 1522 contacts per 100,000 women
-- 3. shelter beds per 100,000 women
-- 4. women hosted in shelter houses per 100,000 women
-- 5. regional stereotype indices
-- 6. final integrated comparison table

-- Methodological note:
-- The final comparison is restricted to the regions
-- that are represented consistently across all source tables.
-- This avoids territorial mismatches between:
-- - victim datasets
-- - 1522 datasets
-- - shelter house datasets
-- - opinion datasets

-- Additional note:
-- - victim and 1522 indicators are cumulative over the available period
-- - shelter house indicators refer to 2023 only
-- - stereotype indices are based on the average percentage of
--   "molto_d_accordo" across statements and sexes
-- - all rate indicators are normalized by female population


-- =========================================================
-- 1. Recorded victims per 100,000 women by region
-- Purpose:
-- Compare the level of recorded violence across regions
-- relative to female population size.
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
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )
    GROUP BY territorio
),
common_regions AS (
    SELECT region
    FROM female_population_by_region

    INTERSECT

    SELECT DISTINCT territorio AS region
    FROM vittime_tipo_violenza
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )

    INTERSECT

    SELECT DISTINCT territorio AS region
    FROM "1522_motivo_chiamata"
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )

    INTERSECT

    SELECT DISTINCT regione AS region
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
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )

    INTERSECT

    SELECT DISTINCT territorio AS region
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )

    INTERSECT

    SELECT DISTINCT territorio AS region
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )
),
victims_by_region AS (
    SELECT
        territorio AS region,
        SUM(numero_vittime) AS total_victims
    FROM vittime_tipo_violenza
    WHERE territorio IN (SELECT region FROM common_regions)
    GROUP BY territorio
)
SELECT
    v.region,
    v.total_victims,
    p.total_female_population,
    ROUND((v.total_victims * 100000.0) / p.total_female_population, 2) AS victims_per_100k_women
FROM victims_by_region AS v
JOIN female_population_by_region AS p
    ON v.region = p.region
ORDER BY victims_per_100k_women DESC;



-- =========================================================
-- 2. 1522 hotline contacts per 100,000 women by region
-- Purpose:
-- Compare the use of the 1522 hotline across regions
-- relative to female population size.
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
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )
    GROUP BY territorio
),
common_regions AS (
    SELECT region
    FROM female_population_by_region

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM vittime_tipo_violenza
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM "1522_motivo_chiamata"
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT regione AS region
    FROM case_rifugio_2023_posti_letto
    WHERE regione NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )
),
hotline_contacts_by_region AS (
    SELECT
        territorio AS region,
        SUM(numero_vittime) AS total_contacts
    FROM "1522_motivo_chiamata"
    WHERE territorio IN (SELECT region FROM common_regions)
      AND motivo_chiamata NOT IN ('non indicato', 'non disponibile')
    GROUP BY territorio
)
SELECT
    h.region,
    h.total_contacts,
    p.total_female_population,
    ROUND((h.total_contacts * 100000.0) / p.total_female_population, 2) AS contacts_per_100k_women
FROM hotline_contacts_by_region AS h
JOIN female_population_by_region AS p
    ON h.region = p.region
ORDER BY contacts_per_100k_women DESC;



-- =========================================================
-- 3. Shelter support indicators per 100,000 women by region
-- Purpose:
-- Compare shelter house capacity and use across regions
-- relative to female population size.
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
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )
    GROUP BY territorio
),
common_regions AS (
    SELECT region
    FROM female_population_by_region

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM vittime_tipo_violenza
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM "1522_motivo_chiamata"
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT regione AS region
    FROM case_rifugio_2023_posti_letto
    WHERE regione NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )
)
SELECT
    s.regione AS region,
    s.totale_posti_letto_autorizzati AS authorized_beds,
    d.totale_donne_accolte AS women_hosted,
    p.total_female_population,
    ROUND((s.totale_posti_letto_autorizzati * 100000.0) / p.total_female_population, 2) AS beds_per_100k_women,
    ROUND((d.totale_donne_accolte * 100000.0) / p.total_female_population, 2) AS women_hosted_per_100k_women
FROM case_rifugio_2023_posti_letto AS s
JOIN case_rifugio_2023_quantita_donne_accolte AS d
    ON s.regione = d.regione
JOIN female_population_by_region AS p
    ON s.regione = p.region
WHERE s.regione IN (SELECT region FROM common_regions)
ORDER BY women_hosted_per_100k_women DESC;



-- =========================================================
-- 4. Regional stereotype indices
-- Purpose:
-- Build synthetic regional indicators of gender stereotypes
-- using the percentage of "molto_d_accordo".
--
-- Interpretation:
-- Higher values indicate stronger agreement with stereotyped
-- or violence-justifying statements.
-- =========================================================

WITH common_regions AS (
    SELECT DISTINCT territorio AS region
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )

    INTERSECT

    SELECT DISTINCT territorio AS region
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio NOT IN (
        'italia',
        'nord ovest',
        'nord est',
        'centro',
        'sud',
        'isole',
        'trentino alto adige',
        'trento',
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )
),
traditional_roles_index AS (
    SELECT
        territorio AS region,
        ROUND(AVG(percentuale), 2) AS traditional_roles_stereotype_index
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio IN (SELECT region FROM common_regions)
      AND grado_accordo = 'molto_d_accordo'
    GROUP BY territorio
),
sexual_violence_index AS (
    SELECT
        territorio AS region,
        ROUND(AVG(percentuale), 2) AS sexual_violence_stereotype_index
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio IN (SELECT region FROM common_regions)
      AND grado_accordo = 'molto_d_accordo'
    GROUP BY territorio
)
SELECT
    t.region,
    t.traditional_roles_stereotype_index,
    s.sexual_violence_stereotype_index,
    ROUND(
        (t.traditional_roles_stereotype_index + s.sexual_violence_stereotype_index) / 2.0,
        2
    ) AS combined_stereotype_index
FROM traditional_roles_index AS t
JOIN sexual_violence_index AS s
    ON t.region = s.region
ORDER BY combined_stereotype_index DESC;



-- =========================================================
-- 5. Final integrated regional comparison table
-- Purpose:
-- Bring together violence, service use, shelter support,
-- and social attitudes in one final comparison table.
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
        'bolzano',
        'non indicato',
        'valle d''aosta'
    )
    GROUP BY territorio
),
common_regions AS (
    SELECT region
    FROM female_population_by_region

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM vittime_tipo_violenza
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM "1522_motivo_chiamata"
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT regione AS region
    FROM case_rifugio_2023_posti_letto
    WHERE regione NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )

    INTERSECT
    SELECT DISTINCT territorio AS region
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio NOT IN (
        'italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole',
        'trentino alto adige', 'trento', 'bolzano', 'non indicato', 'valle d''aosta'
    )
),
victims_by_region AS (
    SELECT
        territorio AS region,
        SUM(numero_vittime) AS total_victims
    FROM vittime_tipo_violenza
    WHERE territorio IN (SELECT region FROM common_regions)
    GROUP BY territorio
),
hotline_contacts_by_region AS (
    SELECT
        territorio AS region,
        SUM(numero_vittime) AS total_contacts
    FROM "1522_motivo_chiamata"
    WHERE territorio IN (SELECT region FROM common_regions)
      AND motivo_chiamata NOT IN ('non indicato', 'non disponibile')
    GROUP BY territorio
),
shelter_support_by_region AS (
    SELECT
        s.regione AS region,
        s.totale_posti_letto_autorizzati AS authorized_beds,
        d.totale_donne_accolte AS women_hosted
    FROM case_rifugio_2023_posti_letto AS s
    JOIN case_rifugio_2023_quantita_donne_accolte AS d
        ON s.regione = d.regione
    WHERE s.regione IN (SELECT region FROM common_regions)
),
traditional_roles_index AS (
    SELECT
        territorio AS region,
        AVG(percentuale) AS traditional_roles_stereotype_index
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio IN (SELECT region FROM common_regions)
      AND grado_accordo = 'molto_d_accordo'
    GROUP BY territorio
),
sexual_violence_index AS (
    SELECT
        territorio AS region,
        AVG(percentuale) AS sexual_violence_stereotype_index
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio IN (SELECT region FROM common_regions)
      AND grado_accordo = 'molto_d_accordo'
    GROUP BY territorio
)
SELECT
    c.region,
    ROUND((v.total_victims * 100000.0) / p.total_female_population, 2) AS victims_per_100k_women,
    ROUND((h.total_contacts * 100000.0) / p.total_female_population, 2) AS contacts_1522_per_100k_women,
    ROUND((s.authorized_beds * 100000.0) / p.total_female_population, 2) AS beds_per_100k_women,
    ROUND((s.women_hosted * 100000.0) / p.total_female_population, 2) AS women_hosted_per_100k_women,
    ROUND(t.traditional_roles_stereotype_index, 2) AS traditional_roles_stereotype_index,
    ROUND(x.sexual_violence_stereotype_index, 2) AS sexual_violence_stereotype_index,
    ROUND(
        (t.traditional_roles_stereotype_index + x.sexual_violence_stereotype_index) / 2.0,
        2
    ) AS combined_stereotype_index
FROM common_regions AS c
JOIN female_population_by_region AS p
    ON c.region = p.region
JOIN victims_by_region AS v
    ON c.region = v.region
JOIN hotline_contacts_by_region AS h
    ON c.region = h.region
JOIN shelter_support_by_region AS s
    ON c.region = s.region
JOIN traditional_roles_index AS t
    ON c.region = t.region
JOIN sexual_violence_index AS x
    ON c.region = x.region
ORDER BY victims_per_100k_women DESC;