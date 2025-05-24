-- perfomance.sql
-- Complex query for performance optimization analysis

-- ==============================================================
-- Initial Complex Query - Unoptimized Version
-- ==============================================================
-- This query retrieves all bookings with user, property, and payment details
-- It includes multiple joins and calculated fields

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    bs.status_name AS booking_status,
    
    -- User details
    u.user_id AS user_id,
    u.email AS user_email,
    up.first_name AS user_first_name,
    up.last_name AS user_last_name,
    up.phone_number AS user_phone,
    
    -- Property details
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.price_per_night,
    a.street AS property_street,
    a.city AS property_city,
    a.state AS property_state,
    a.country AS property_country,
    a.postal_code AS property_postal_code,
    a.latitude AS property_latitude,
    a.longitude AS property_longitude,
    
    -- Host details
    host.user_id AS host_id,
    host_profile.first_name AS host_first_name,
    host_profile.last_name AS host_last_name,
    host_profile.phone_number AS host_phone,
    
    -- Payment details
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_date,
    pmethod.method_name AS payment_method,
    
    -- Calculated fields
    (b.end_date - b.start_date) AS stay_duration,
    (b.total_price / NULLIF((b.end_date - b.start_date), 0)) AS price_per_day,
    
    -- Review details if available
    r.review_id,
    r.rating,
    r.comment,
    
    -- Feature list as an aggregated string
    (
        SELECT STRING_AGG(f.feature_name, ', ')
        FROM property_feature pf
        JOIN feature f ON pf.feature_id = f.feature_id
        WHERE pf.property_id = p.property_id
    ) AS property_features,
    
    -- Count of all bookings by this user
    (
        SELECT COUNT(*)
        FROM booking ub
        WHERE ub.user_id = u.user_id
    ) AS user_total_bookings,
    
    -- Average rating for the property
    (
        SELECT COALESCE(AVG(pr.rating), 0)
        FROM review pr
        WHERE pr.property_id = p.property_id
    ) AS average_property_rating
FROM 
    booking b
LEFT JOIN 
    "user" u ON b.user_id = u.user_id
LEFT JOIN 
    user_profile up ON u.user_id = up.user_id
LEFT JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    "user" host ON p.host_id = host.user_id
LEFT JOIN 
    user_profile host_profile ON host.user_id = host_profile.user_id
LEFT JOIN 
    address a ON p.address_id = a.address_id
LEFT JOIN 
    booking_status bs ON b.status_id = bs.status_id
LEFT JOIN 
    payment pm ON b.booking_id = pm.booking_id
LEFT JOIN 
    payment_method pmethod ON pm.method_id = pmethod.method_id
LEFT JOIN 
    review r ON r.booking_id = b.booking_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    b.start_date DESC;

-- ==============================================================
-- Optimized Version 1 - Reduce Joins
-- ==============================================================
-- This version removes unnecessary joins and subqueries

EXPLAIN ANALYZE
WITH user_booking_counts AS (
    SELECT 
        user_id, 
        COUNT(*) AS booking_count
    FROM 
        booking
    GROUP BY 
        user_id
),
property_ratings AS (
    SELECT 
        property_id, 
        COALESCE(AVG(rating), 0) AS avg_rating
    FROM 
        review
    GROUP BY 
        property_id
)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    bs.status_name AS booking_status,
    
    -- User details
    u.user_id AS user_id,
    u.email AS user_email,
    up.first_name AS user_first_name,
    up.last_name AS user_last_name,
    up.phone_number AS user_phone,
    
    -- Property details
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    a.city AS property_city,
    a.state AS property_state,
    
    -- Payment details
    pm.payment_id,
    pm.amount AS payment_amount,
    pmethod.method_name AS payment_method,
    
    -- Calculated fields
    (b.end_date - b.start_date) AS stay_duration,
    
    -- Pre-calculated counts and ratings
    ubc.booking_count AS user_total_bookings,
    pr.avg_rating AS average_property_rating
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    user_profile up ON u.user_id = up.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    address a ON p.address_id = a.address_id
JOIN 
    booking_status bs ON b.status_id = bs.status_id
LEFT JOIN 
    payment pm ON b.booking_id = pm.booking_id
LEFT JOIN 
    payment_method pmethod ON pm.method_id = pmethod.method_id
LEFT JOIN 
    user_booking_counts ubc ON u.user_id = ubc.user_id
LEFT JOIN 
    property_ratings pr ON p.property_id = pr.property_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    b.start_date DESC;

-- ==============================================================
-- Optimized Version 2 - Using LATERAL Joins
-- ==============================================================
-- This version uses LATERAL joins for potentially better performance
-- with subquery calculations

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    bs.status_name AS booking_status,
    
    -- User details
    u.user_id AS user_id,
    u.email AS user_email,
    up.first_name AS user_first_name,
    up.last_name AS user_last_name,
    
    -- Property details
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    a.city AS property_city,
    a.state AS property_state,
    
    -- Payment details
    pm.payment_id,
    pm.amount AS payment_amount,
    pmethod.method_name AS payment_method,
    
    -- Calculated fields
    (b.end_date - b.start_date) AS stay_duration,
    
    -- User booking count via LATERAL
    user_bookings.count AS user_total_bookings,
    
    -- Property rating via LATERAL
    property_rating.avg_rating AS average_property_rating,
    
    -- Features via LATERAL
    property_features.features AS property_features
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    user_profile up ON u.user_id = up.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    address a ON p.address_id = a.address_id
JOIN 
    booking_status bs ON b.status_id = bs.status_id
LEFT JOIN 
    payment pm ON b.booking_id = pm.booking_id
LEFT JOIN 
    payment_method pmethod ON pm.method_id = pmethod.method_id
CROSS JOIN LATERAL (
    SELECT COUNT(*) AS count
    FROM booking ub
    WHERE ub.user_id = u.user_id
) user_bookings
CROSS JOIN LATERAL (
    SELECT COALESCE(AVG(rating), 0) AS avg_rating
    FROM review pr
    WHERE pr.property_id = p.property_id
) property_rating
CROSS JOIN LATERAL (
    SELECT STRING_AGG(f.feature_name, ', ') AS features
    FROM property_feature pf
    JOIN feature f ON pf.feature_id = f.feature_id
    WHERE pf.property_id = p.property_id
) property_features
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    b.start_date DESC;

-- ==============================================================
-- Optimized Version 3 - Use indexes and minimize columns
-- ==============================================================
-- This version assumes that appropriate indexes have been created
-- and only returns the most essential columns

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    bs.status_name AS booking_status,
    
    -- Essential user details
    u.email AS user_email,
    up.first_name || ' ' || up.last_name AS user_name,
    
    -- Essential property details
    p.name AS property_name,
    a.city || ', ' || a.state AS property_location,
    
    -- Essential payment details
    pm.amount AS payment_amount,
    pmethod.method_name AS payment_method,
    
    -- Calculated fields
    (b.end_date - b.start_date) AS stay_duration
FROM 
    booking b
JOIN 
    booking_status bs ON b.status_id = bs.status_id
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    user_profile up ON u.user_id = up.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    address a ON p.address_id = a.address_id
LEFT JOIN 
    payment pm ON b.booking_id = pm.booking_id
LEFT JOIN 
    payment_method pmethod ON pm.method_id = pmethod.method_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    b.start_date DESC
LIMIT 100;
