-- Front Street Pizza: Customer Review Analytics
USE pizza_analytics;

-- Distribution of customer rating stars
SELECT
    star_rating,
    COUNT(*) AS review_count
FROM reviews
GROUP BY star_rating
ORDER BY star_rating DESC;

-- Calculate the overall average customer rating
SELECT
    ROUND(AVG(star_rating), 2) AS average_rating
FROM reviews;

-- Classify reviews and calculate percentages
SELECT
    CASE
        WHEN star_rating >= 4 THEN 'Positive'
        WHEN star_rating <= 2 THEN 'Negative'
        ELSE 'Neutral'
    END AS classification,
    COUNT(*) AS review_count,
    ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM reviews),
    2
) AS percentage_of_reviews
FROM reviews
GROUP BY classification
ORDER BY review_count DESC;

-- Retrieve written feedback from negative reviews
SELECT
    review_id,
    star_rating,
    review_text
FROM reviews
WHERE
    star_rating <= 2
    AND review_text IS NOT NULL;

-- Identify potential external-incident references for manual review
SELECT
    review_id,
    star_rating,
    review_text
FROM reviews
WHERE
    review_text LIKE '%reporter%'
    OR review_text LIKE '%record%'
    OR review_text LIKE '%confront%'
    OR review_id = 1;
-- Flag reviews manually identified as discussing the external incident
UPDATE reviews
SET
    incident_related = 1,
    primary_topic = 'External Incident'
WHERE review_id IN (1, 8);

-- Verify manually assigned incident classifications
SELECT
    review_id,
    incident_related,
    primary_topic
FROM reviews
WHERE review_id = 8 OR review_id = 1;

-- Topic classification
SELECT
    review_id,
    star_rating,
    review_text,
    CASE
        WHEN review_text LIKE '%delivery%' THEN 'Delivery & Wait Time'
        WHEN review_text LIKE '%staff%' 
            OR review_text LIKE '%employees%' 
            OR review_text LIKE '%service%'
        THEN 'Customer Service'
        WHEN review_text LIKE '%slice%' 
            OR review_text LIKE '%pizza%' 
            OR review_text LIKE '%food%'
            OR review_text LIKE '%taste%'
            OR review_text LIKE '%pie%'

        THEN 'Food Quality'
        ELSE 'Other / Unclear'
    END AS suggested_topic
FROM reviews
ORDER BY suggested_topic DESC;

-- Distribution of reviews across assigned topics
WITH categorized_reviews AS (

    SELECT
        review_id,
        star_rating,
        review_text,

        CASE
            WHEN incident_related = 1
                THEN 'External Incident'

            WHEN review_text LIKE '%delivery%'
                THEN 'Delivery & Wait Time'

            WHEN review_text LIKE '%staff%'
                OR review_text LIKE '%employees%'
                OR review_text LIKE '%service%'
                OR review_text LIKE '%demeanor%'
                OR review_text LIKE '%atmosphere%'
                THEN 'Customer Service'

            WHEN review_text LIKE '%slice%'
                OR review_text LIKE '%pizza%'
                OR review_text LIKE '%food%'
                OR review_text LIKE '%taste%'
                OR review_text LIKE '%pie%'
                OR review_text LIKE '%spaghetti%'
                THEN 'Food Quality'

            ELSE 'Other / Unclear'

        END AS suggested_topic

    FROM reviews

)

-- Count reviews within each topic
SELECT
    suggested_topic,
    COUNT(*) AS review_count

FROM categorized_reviews

GROUP BY suggested_topic

ORDER BY review_count DESC;

-- Refine classification to distinguish reviews
WITH categorized_reviews AS (

    SELECT
        review_id,
        star_rating,
        review_text,

        CASE
            WHEN incident_related = 1
                THEN 'External Incident'
            WHEN review_text IS NULL
                OR TRIM(review_text) = ''
                THEN 'No Written Review'

            WHEN review_text LIKE '%delivery%'
                THEN 'Delivery & Wait Time'

            WHEN review_text LIKE '%staff%'
                OR review_text LIKE '%employees%'
                OR review_text LIKE '%service%'
                OR review_text LIKE '%demeanor%'
                OR review_text LIKE '%atmosphere%'
                THEN 'Customer Service'

            WHEN review_text LIKE '%slice%'
                OR review_text LIKE '%pizza%'
                OR review_text LIKE '%food%'
                OR review_text LIKE '%taste%'
                OR review_text LIKE '%pie%'
                OR review_text LIKE '%spaghetti%'
                THEN 'Food Quality'

            ELSE 'Other / Unclear'

        END AS suggested_topic

    FROM reviews

)
SELECT
    review_id,
    star_rating,
    review_text,
    suggested_topic
FROM categorized_reviews
WHERE suggested_topic = 'Other / Unclear'
ORDER BY star_rating ASC;

-- Display the final review topic classifications
SELECT *
FROM review_topics;

-- Negative reviews by topic
SELECT
    suggested_topic,
    COUNT(*) AS negative_reviews
FROM review_topics
WHERE star_rating <= 2
GROUP BY suggested_topic
ORDER BY negative_reviews DESC;

-- Positive reviews by topic
SELECT
    suggested_topic,
    COUNT(*) AS positive_reviews
FROM review_topics
WHERE star_rating >= 4
GROUP BY suggested_topic
ORDER BY positive_reviews DESC;

-- Topic Distribution
SELECT
    suggested_topic,
    COUNT(*) AS review_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM reviews),
        2
    ) AS percentage_of_reviews
FROM review_topics
GROUP BY suggested_topic
ORDER BY percentage_of_reviews DESC;

-- Average Rating by Topic
SELECT
    suggested_topic,
    COUNT(*) AS review_count,
    ROUND(AVG(star_rating), 2) AS average_rating
FROM review_topics
GROUP BY suggested_topic
ORDER BY average_rating ASC;