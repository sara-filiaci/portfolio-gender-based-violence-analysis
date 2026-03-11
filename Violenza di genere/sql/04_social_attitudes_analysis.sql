-- =========================================================
-- Gender-Based Violence in Italy
-- Opinions Analysis
-- Author: Sara Filiaci
-- Data source: ISTAT
-- Database: SQLite
-- =========================================================

-- This SQL script analyzes public opinions related to:
-- 1. traditional gender roles
-- 2. beliefs and stereotypes about sexual violence

-- The analysis focuses on:
-- 1. national comparison by gender
-- 2. comparison by age group
-- 3. comparison by education level
-- 4. comparison by region

-- Methodological note:
-- Response categories were recoded to improve readability:
-- - molto_d_accordo
-- - intermedio = abbastanza_d_accordo + poco_d_accordo
-- - per_niente_d_accordo
-- - excluded from analysis: non_risponde

-- Territorial note:
-- Regional queries exclude aggregate territorial categories
-- such as Italy, macro-areas, and Trentino-Alto Adige,
-- in order to avoid overlap with the separate units
-- of Trento and Bolzano.

-- =========================================================
-- 1. RUOLI TRADIZIONALI - ITALIA, CONFRONTO MASCHI/FEMMINE
-- =========================================================

SELECT
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE territorio = 'italia'
      AND grado_accordo != 'non_risponde'
    GROUP BY
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    imput_affermazione,
    categoria_risposta
ORDER BY
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 2. RUOLI TRADIZIONALI - ETA, CONFRONTO MASCHI/FEMMINE
-- =========================================================

SELECT
    età,
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        età,
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_ruoli_tradizionali_eta
    WHERE grado_accordo != 'non_risponde'
    GROUP BY
        età,
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    età,
    imput_affermazione,
    categoria_risposta
ORDER BY
    CASE età
        WHEN '18-29' THEN 1
        WHEN '30-44' THEN 2
        WHEN '45-59' THEN 3
        WHEN '60-74' THEN 4
    END,
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 3. RUOLI TRADIZIONALI - TITOLO DI STUDIO, CONFRONTO MASCHI/FEMMINE
-- =========================================================

SELECT
    titolo_studio,
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        titolo_studio,
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_ruoli_tradizionali_titolo_studio
    WHERE grado_accordo != 'non_risponde'
    GROUP BY
        titolo_studio,
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    titolo_studio,
    imput_affermazione,
    categoria_risposta
ORDER BY
    CASE titolo_studio
        WHEN 'elementare_o_nessun_titolo' THEN 1
        WHEN 'media_inferiore' THEN 2
        WHEN 'diploma_o_equivalente' THEN 3
        WHEN 'laurea' THEN 4
    END,
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 4. RUOLI TRADIZIONALI - TERRITORI
-- Solo regioni e province autonome.
-- Esclusi: italia, nord ovest, nord est, centro, sud, isole
-- =========================================================

SELECT
    territorio,
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        territorio,
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_ruoli_tradizionali_reg
    WHERE grado_accordo != 'non_risponde'
      AND territorio NOT IN ('italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole', 'trentino alto adige')
    GROUP BY
        territorio,
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    territorio,
    imput_affermazione,
    categoria_risposta
ORDER BY
    territorio,
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 5. VIOLENZA SESSUALE - ITALIA, CONFRONTO MASCHI/FEMMINE
-- =========================================================

SELECT
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_violenza_sessuale_reg
    WHERE territorio = 'italia'
      AND grado_accordo != 'non_risponde'
    GROUP BY
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    imput_affermazione,
    categoria_risposta
ORDER BY
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 6. VIOLENZA SESSUALE - ETA, CONFRONTO MASCHI/FEMMINE
-- =========================================================

SELECT
    età,
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        età,
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_violenza_sessuale_eta
    WHERE grado_accordo != 'non_risponde'
    GROUP BY
        età,
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    età,
    imput_affermazione,
    categoria_risposta
ORDER BY
    CASE età
        WHEN '18-29' THEN 1
        WHEN '30-44' THEN 2
        WHEN '45-59' THEN 3
        WHEN '60-74' THEN 4
    END,
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 7. VIOLENZA SESSUALE - TITOLO DI STUDIO, CONFRONTO MASCHI/FEMMINE
-- =========================================================

SELECT
    titolo_studio,
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        titolo_studio,
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_violenza_sessuale_titolo_studio
    WHERE grado_accordo != 'non_risponde'
    GROUP BY
        titolo_studio,
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    titolo_studio,
    imput_affermazione,
    categoria_risposta
ORDER BY
    CASE titolo_studio
        WHEN 'elementare_o_nessun_titolo' THEN 1
        WHEN 'media_inferiore' THEN 2
        WHEN 'diploma_o_equivalente' THEN 3
        WHEN 'laurea' THEN 4
    END,
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;


-- =========================================================
-- 8. VIOLENZA SESSUALE - TERRITORI
-- Solo regioni e province autonome.
-- Esclusi: italia, nord ovest, nord est, centro, sud, isole
-- =========================================================

SELECT
    territorio,
    imput_affermazione,
    categoria_risposta,
    MAX(CASE WHEN sesso = 'maschi' THEN percentuale END) AS maschi,
    MAX(CASE WHEN sesso = 'femmine' THEN percentuale END) AS femmine
FROM (
    SELECT
        territorio,
        imput_affermazione,
        sesso,
        CASE
            WHEN grado_accordo = 'molto_d_accordo' THEN 'molto_d_accordo'
            WHEN grado_accordo IN ('abbastanza_d_accordo', 'poco_d_accordo') THEN 'intermedio'
            WHEN grado_accordo = 'per_niente_d_accordo' THEN 'per_niente_d_accordo'
        END AS categoria_risposta,
        SUM(percentuale) AS percentuale
    FROM Opinioni_violenza_sessuale_reg
    WHERE grado_accordo != 'non_risponde'
      AND territorio NOT IN ('italia', 'nord ovest', 'nord est', 'centro', 'sud', 'isole', 'trentino alto adige')
    GROUP BY
        territorio,
        imput_affermazione,
        sesso,
        categoria_risposta
)
GROUP BY
    territorio,
    imput_affermazione,
    categoria_risposta
ORDER BY
    territorio,
    imput_affermazione,
    CASE categoria_risposta
        WHEN 'molto_d_accordo' THEN 1
        WHEN 'intermedio' THEN 2
        WHEN 'per_niente_d_accordo' THEN 3
    END;