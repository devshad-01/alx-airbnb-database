-- subqueries.sql
-- Examples of SQL subqueries (both correlated and non-correlated) for Airbnb clone database

-- =================================================================
-- NON-CORRELATED SUBQUERY: Find properties with average rating > 4.0
-- =================================================================
-- This query uses a non-correlated subquery to calculate average ratings
-- and then finds properties where this average exceeds 4.0
SELECT 
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    a.city,
    a.state,
    AVG_RATING.average_rating
FROM 
    property p
INNER JOIN 
    address a ON p.address_id = a.address_id
INNER JOIN (
    SELECT 
        property_id,
        AVG(rating) AS average_rating
    FROM 
        review
    GROUP BY 
        property_id
    HAVING 
        AVG(rating) > 4.0
) AS AVG_RATING ON p.property_id = AVG_RATING.property_id
ORDER BY 
    AVG_RATING.average_rating DESC;

-- Alternative approach using a WHERE clause with subquery
SELECT 
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    a.city,
    a.state,
    (SELECT AVG(rating) FROM review r WHERE r.property_id = p.property_id) AS average_rating
FROM 
    property p
INNER JOIN 
    address a ON p.address_id = a.address_id
WHERE 
    p.property_id IN (
        SELECT 
            property_id
        FROM 
            review
        GROUP BY 
            property_id
        HAVING 
            AVG(rating) > 4.0
    )
ORDER BY 
    average_rating DESC;

-- =================================================================
-- CORRELATED SUBQUERY: Find users who have made more than 3 bookings
-- =================================================================
-- This query uses a correlated subquery that references the outer query
-- to count bookings for each user and filter those with > 3 bookings
SELECT 
    u.user_id,
    up.first_name,
    up.last_name,
    u.email,
    (
        SELECT 
            COUNT(booking_id)
        FROM 
            booking b
        WHERE 
            b.user_id = u.user_id
    ) AS booking_count
FROM 
    "user" u
INNER JOIN 
    user_profile up ON u.user_id = up.user_id
WHERE 
    (
        SELECT 
            COUNT(booking_id)
        FROM 
            booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    booking_count DESC;

-- Alternative approach using a JOIN and GROUP BY
-- (not a subquery but included for comparison)
SELECT 
    u.user_id,
    up.first_name,
    up.last_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM 
    "user" u
INNER JOIN 
    booking b ON u.user_id = b.user_id
INNER JOIN 
    user_profile up ON u.user_id = up.user_id
GROUP BY 
    u.user_id, up.first_name, up.last_name, u.email
HAVING 
    COUNT(b.booking_id) > 3
ORDER BY 
    booking_count DESC;

-- =================================================================
-- BONUS: Multiple nested subqueries for complex analysis
-- =================================================================
-- Find properties that have higher than average ratings AND 
-- are owned by hosts who have multiple properties
SELECT 
    p.property_id,
    p.name AS property_name,
    h.user_id AS host_id,
    hp.first_name || ' ' || hp.last_name AS host_name,
    a.city,
    a.state,
    (
        SELECT AVG(rating) 
        FROM review r 
        WHERE r.property_id = p.property_id
    ) AS property_avg_rating,
    (
        SELECT AVG(rating) FROM review
    ) AS overall_avg_rating,
    (
        SELECT COUNT(*) 
        FROM property 
        WHERE host_id = p.host_id
    ) AS host_property_count
FROM 
    property p
INNER JOIN 
    "user" h ON p.host_id = h.user_id
INNER JOIN 
    user_profile hp ON h.user_id = hp.user_id
INNER JOIN 
    address a ON p.address_id = a.address_id
WHERE 
    (
        SELECT AVG(rating) 
        FROM review r 
        WHERE r.property_id = p.property_id
    ) > (
        SELECT AVG(rating) FROM review
    )
    AND
    (
        SELECT COUNT(*) 
        FROM property 
        WHERE host_id = p.host_id
    ) > 1
ORDER BY 
    property_avg_rating DESC;
