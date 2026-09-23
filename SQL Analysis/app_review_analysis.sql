-- ============================================================
-- APP REVIEW ANALYSIS
-- Business Analyst Portfolio Project
-- Database: app_review_analysis
-- ============================================================

USE app_review_analysis;


-- ============================================================
-- 1. DATASET OVERVIEW
-- ============================================================

SELECT
    COUNT(*) AS total_reviews,
    ROUND(AVG(rating), 2) AS average_rating,
    MIN(rating) AS lowest_rating,
    MAX(rating) AS highest_rating
FROM raw_reviews;


-- ============================================================
-- 2. REVIEW DISTRIBUTION BY RATING
-- ============================================================

SELECT
    rating,
    COUNT(*) AS review_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM raw_reviews),
        2
    ) AS percentage
FROM raw_reviews
GROUP BY rating
ORDER BY rating;


-- ============================================================
-- 3. CRITICAL REVIEWS
-- Ratings 1 and 2
-- ============================================================

SELECT
    rating,
    review_description,
    thumbs_up,
    review_date
FROM review_analysis
WHERE rating <= 2
ORDER BY thumbs_up DESC;


-- ============================================================
-- 4. REVIEW CATEGORY BASED ON RATING
-- ============================================================

SELECT
    review_category,
    COUNT(*) AS review_count
FROM review_analysis
GROUP BY review_category
ORDER BY review_count DESC;


-- ============================================================
-- 5. CRITICAL REVIEWS BY RATING
-- ============================================================

SELECT
    rating,
    COUNT(*) AS review_count
FROM raw_reviews
WHERE rating <= 2
GROUP BY rating
ORDER BY rating;


-- ============================================================
-- 6. KEYWORD-BASED AUTHENTICATION ISSUES
-- ============================================================

SELECT
    CASE
        WHEN LOWER(review_description) LIKE '%password%'
          OR LOWER(review_description) LIKE '%login%'
          OR LOWER(review_description) LIKE '%sign in%'
          OR LOWER(review_description) LIKE '%fingerprint%'
        THEN 'Password'
        ELSE 'Other'
    END AS authentication_issue,
    COUNT(*) AS issue_count
FROM review_analysis
WHERE rating <= 2
  AND (
        LOWER(review_description) LIKE '%password%'
        OR LOWER(review_description) LIKE '%login%'
        OR LOWER(review_description) LIKE '%sign in%'
        OR LOWER(review_description) LIKE '%fingerprint%'
      )
GROUP BY authentication_issue
ORDER BY issue_count DESC;


-- ============================================================
-- 7. OVERALL KPI SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_reviews,

    ROUND(AVG(rating), 2) AS average_rating,

    SUM(
        CASE
            WHEN rating <= 2 THEN 1
            ELSE 0
        END
    ) AS critical_reviews,

    SUM(
        CASE
            WHEN rating = 3 THEN 1
            ELSE 0
        END
    ) AS moderate_reviews,

    SUM(
        CASE
            WHEN rating >= 4 THEN 1
            ELSE 0
        END
    ) AS positive_reviews,

    ROUND(
        SUM(
            CASE
                WHEN rating <= 2 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS critical_percentage

FROM review_analysis;


-- ============================================================
-- 8. CRITICAL COMPLAINT AREAS
-- Keyword-based classification
-- ============================================================

SELECT
    CASE
        WHEN LOWER(review_description) LIKE '%password%'
          OR LOWER(review_description) LIKE '%login%'
          OR LOWER(review_description) LIKE '%sign in%'
          OR LOWER(review_description) LIKE '%fingerprint%'
        THEN 'Login & Password'

        WHEN LOWER(review_description) LIKE '%backup%'
          OR LOWER(review_description) LIKE '%restore%'
          OR LOWER(review_description) LIKE '%transfer%'
          OR LOWER(review_description) LIKE '%switched phone%'
        THEN 'Backup & Migration'

        WHEN LOWER(review_description) LIKE '%crash%'
          OR LOWER(review_description) LIKE '%bug%'
          OR LOWER(review_description) LIKE '%error%'
          OR LOWER(review_description) LIKE '%not working%'
        THEN 'Bugs & Performance'

        WHEN LOWER(review_description) LIKE '%price%'
          OR LOWER(review_description) LIKE '%paid%'
          OR LOWER(review_description) LIKE '%subscription%'
          OR LOWER(review_description) LIKE '%premium%'
        THEN 'Pricing'

        ELSE 'Other'
    END AS complaint_area,

    COUNT(*) AS critical_reviews

FROM review_analysis

WHERE rating <= 2

GROUP BY complaint_area

ORDER BY critical_reviews DESC;


-- ============================================================
-- 9. CRITICAL COMPLAINT AREAS WITH PERCENTAGE
-- ============================================================

SELECT
    CASE
        WHEN LOWER(review_description) LIKE '%password%'
          OR LOWER(review_description) LIKE '%login%'
          OR LOWER(review_description) LIKE '%sign in%'
          OR LOWER(review_description) LIKE '%fingerprint%'
        THEN 'Login & Password'

        WHEN LOWER(review_description) LIKE '%backup%'
          OR LOWER(review_description) LIKE '%restore%'
          OR LOWER(review_description) LIKE '%transfer%'
          OR LOWER(review_description) LIKE '%switched phone%'
        THEN 'Backup & Migration'

        WHEN LOWER(review_description) LIKE '%crash%'
          OR LOWER(review_description) LIKE '%bug%'
          OR LOWER(review_description) LIKE '%error%'
          OR LOWER(review_description) LIKE '%not working%'
        THEN 'Bugs & Performance'

        WHEN LOWER(review_description) LIKE '%price%'
          OR LOWER(review_description) LIKE '%paid%'
          OR LOWER(review_description) LIKE '%subscription%'
          OR LOWER(review_description) LIKE '%premium%'
        THEN 'Pricing'

        ELSE 'Other'
    END AS complaint_area,

    COUNT(*) AS critical_reviews,

    ROUND(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(*)
            FROM review_analysis
            WHERE rating <= 2
        ),
        2
    ) AS percentage

FROM review_analysis

WHERE rating <= 2

GROUP BY complaint_area

ORDER BY critical_reviews DESC;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
