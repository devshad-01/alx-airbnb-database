-- aggregations_and_window_functions.sql
-- Examples of SQL aggregation functions and window functions for the Airbnb clone database

-- =================================================================
-- AGGREGATION: Count bookings per user with GROUP BY
-- =================================================================
-- This query counts the total number of bookings made by each user
-- and includes their profile information for better context
SELECT 
    u.user_id,
    up.first_name,
    up.last_name,
    u.email,
    COUNT(b.booking_id) AS booking_count,
    SUM(b.total_price) AS total_spent,
    MAX(b.start_date) AS last_booking_date
FROM 
    "user" u
LEFT JOIN 
    booking b ON u.user_id = b.user_id
LEFT JOIN 
    user_profile up ON u.user_id = up.user_id
WHERE 
    u.role_id = (SELECT role_id FROM user_role WHERE role_name = 'guest')
GROUP BY 
    u.user_id, up.first_name, up.last_name, u.email
ORDER BY 
    booking_count DESC, total_spent DESC;

-- Alternative with HAVING clause to filter only users with at least one booking
SELECT 
    u.user_id,
    up.first_name,
    up.last_name,
    u.email,
    COUNT(b.booking_id) AS booking_count,
    AVG(b.total_price) AS avg_booking_price
FROM 
    "user" u
INNER JOIN 
    booking b ON u.user_id = b.user_id
LEFT JOIN 
    user_profile up ON u.user_id = up.user_id
GROUP BY 
    u.user_id, up.first_name, up.last_name, u.email
HAVING 
    COUNT(b.booking_id) >= 1
ORDER BY 
    booking_count DESC;

-- =================================================================
-- WINDOW FUNCTIONS: Rank properties by number of bookings
-- =================================================================
-- This query uses ROW_NUMBER() and RANK() window functions to rank
-- properties based on the total number of bookings they have received

SELECT 
    p.property_id,
    p.name AS property_name,
    a.city,
    a.state,
    COUNT(b.booking_id) AS booking_count,
    SUM(b.total_price) AS total_revenue,
    -- ROW_NUMBER assigns unique sequential integers (no ties)
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank_unique,
    -- RANK leaves gaps in the sequence when there are ties
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    -- DENSE_RANK doesn't leave gaps in the sequence
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_dense_rank,
    -- Window function partitioned by city to rank properties within each city
    RANK() OVER (PARTITION BY a.city ORDER BY COUNT(b.booking_id) DESC) AS city_booking_rank
FROM 
    property p
LEFT JOIN 
    booking b ON p.property_id = b.property_id
INNER JOIN 
    address a ON p.address_id = a.address_id
GROUP BY 
    p.property_id, p.name, a.city, a.state
ORDER BY 
    booking_count DESC, total_revenue DESC;

-- =================================================================
-- BONUS: Advanced window functions with frames
-- =================================================================
-- This query calculates running totals, moving averages, 
-- and percentages using window function frames

-- Calculate running totals and moving averages for booking revenue by date
SELECT 
    b.start_date,
    COUNT(b.booking_id) AS daily_bookings,
    SUM(b.total_price) AS daily_revenue,
    -- Running total of bookings over time
    SUM(COUNT(b.booking_id)) OVER (ORDER BY b.start_date) AS cumulative_bookings,
    -- Running total of revenue over time
    SUM(SUM(b.total_price)) OVER (ORDER BY b.start_date) AS cumulative_revenue,
    -- 7-day moving average of revenue
    AVG(SUM(b.total_price)) OVER (
        ORDER BY b.start_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS seven_day_avg_revenue,
    -- Percentage of revenue compared to total
    SUM(b.total_price) / SUM(SUM(b.total_price)) OVER () * 100 AS pct_of_total_revenue
FROM 
    booking b
GROUP BY 
    b.start_date
ORDER BY 
    b.start_date;

-- Calculate various metrics for properties using window functions
SELECT 
    p.property_id,
    p.name AS property_name,
    a.city,
    COUNT(b.booking_id) AS booking_count,
    -- Percent of bookings within city
    ROUND(
        COUNT(b.booking_id) * 100.0 / 
        NULLIF(SUM(COUNT(b.booking_id)) OVER (PARTITION BY a.city), 0),
        1
    ) AS pct_of_city_bookings,
    -- Percentile rank for price per night
    PERCENT_RANK() OVER (ORDER BY p.price_per_night) AS price_percentile,
    -- Difference from city average price
    p.price_per_night - AVG(p.price_per_night) OVER (PARTITION BY a.city) AS price_vs_city_avg,
    -- Running total of bookings for host
    SUM(COUNT(b.booking_id)) OVER (
        PARTITION BY p.host_id 
        ORDER BY COUNT(b.booking_id) DESC
        ROWS UNBOUNDED PRECEDING
    ) AS host_running_total_bookings
FROM 
    property p
LEFT JOIN 
    booking b ON p.property_id = b.property_id
INNER JOIN 
    address a ON p.address_id = a.address_id
GROUP BY 
    p.property_id, p.name, p.price_per_night, p.host_id, a.city
ORDER BY 
    a.city, booking_count DESC;
