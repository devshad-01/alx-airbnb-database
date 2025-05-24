-- joins_queries.sql
-- Complex SQL joins demonstrating different join types on Airbnb clone database

-- =================================================================
-- INNER JOIN: Retrieve all bookings and the users who made them
-- =================================================================
-- This query shows complete booking information along with user details
-- Only returns rows where the user has made at least one booking
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    bs.status_name,
    u.user_id,
    up.first_name,
    up.last_name,
    u.email,
    p.name AS property_name,
    p.price_per_night
FROM 
    booking b
INNER JOIN 
    "user" u ON b.user_id = u.user_id
INNER JOIN 
    user_profile up ON u.user_id = up.user_id
INNER JOIN 
    property p ON b.property_id = p.property_id
INNER JOIN 
    booking_status bs ON b.status_id = bs.status_id
ORDER BY 
    b.start_date;

-- =================================================================
-- LEFT JOIN: Retrieve all properties and their reviews
-- =================================================================
-- This query includes all properties, even those without reviews
-- Properties without reviews will have NULL values in review columns
SELECT 
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    a.city,
    a.state,
    r.review_id,
    r.rating,
    r.comment,
    COALESCE(r.created_at, 'No review') AS review_date,
    up.first_name AS reviewer_first_name,
    up.last_name AS reviewer_last_name
FROM 
    property p
LEFT JOIN 
    review r ON p.property_id = r.property_id
LEFT JOIN 
    "user" u ON r.user_id = u.user_id
LEFT JOIN 
    user_profile up ON u.user_id = up.user_id
INNER JOIN 
    address a ON p.address_id = a.address_id
ORDER BY 
    p.name, r.rating DESC;

-- =================================================================
-- FULL OUTER JOIN: Retrieve all users and all bookings
-- =================================================================
-- This query shows all users and all bookings, even if:
-- 1. A user has never made a booking
-- 2. A booking somehow exists without being associated with a user (unlikely in practice)
SELECT 
    u.user_id,
    up.first_name,
    up.last_name,
    u.email,
    ur.role_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    bs.status_name,
    p.name AS property_name,
    CASE 
        WHEN b.booking_id IS NULL THEN 'No bookings'
        ELSE 'Has booking'
    END AS booking_status
FROM 
    "user" u
FULL OUTER JOIN 
    booking b ON u.user_id = b.user_id
LEFT JOIN 
    user_profile up ON u.user_id = up.user_id
LEFT JOIN 
    user_role ur ON u.role_id = ur.role_id
LEFT JOIN 
    booking_status bs ON b.status_id = bs.status_id
LEFT JOIN 
    property p ON b.property_id = p.property_id
ORDER BY 
    ur.role_name, up.last_name, b.start_date;

-- =================================================================
-- BONUS: Complex nested join with aggregation
-- =================================================================
-- This query combines multiple join types to show property hosts and their ratings
-- Demonstrates nested joins with aggregation functions
SELECT 
    host.user_id AS host_id,
    host_profile.first_name || ' ' || host_profile.last_name AS host_name,
    p.property_id,
    p.name AS property_name,
    a.city,
    a.state,
    COUNT(r.review_id) AS review_count,
    COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating,
    COUNT(b.booking_id) AS booking_count,
    COALESCE(SUM(b.total_price), 0) AS total_revenue
FROM 
    "user" host
INNER JOIN 
    user_profile host_profile ON host.user_id = host_profile.user_id
INNER JOIN 
    user_role ur ON host.role_id = ur.role_id AND ur.role_name = 'host'
LEFT JOIN 
    property p ON host.user_id = p.host_id
LEFT JOIN 
    address a ON p.address_id = a.address_id
LEFT JOIN 
    review r ON p.property_id = r.property_id
LEFT JOIN 
    booking b ON p.property_id = b.property_id AND b.status_id = (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')
GROUP BY 
    host.user_id, host_profile.first_name, host_profile.last_name, 
    p.property_id, p.name, a.city, a.state
ORDER BY 
    avg_rating DESC, booking_count DESC;
