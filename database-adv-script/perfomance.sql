-- Initial Complex Query for Performance Analysis
-- This query retrieves all bookings with user details, property details, and payment details

-- Initial Complex Query (Less Optimized)
-- This query retrieves all data without appropriate filtering and optimization
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at,
    
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    u.phone_number AS guest_phone,
    
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.price_per_night,
    
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    
    addr.street_address,
    addr.city,
    addr.state,
    addr.country,
    addr.postal_code,
    
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    "booking" b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    "property" p ON b.property_id = p.property_id
JOIN 
    "user" host ON p.host_id = host.user_id
JOIN 
    "address" addr ON p.address_id = addr.address_id
LEFT JOIN 
    "payment" pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;
ORDER BY 
    b.created_at DESC;

-- Performance analysis of the initial query:
-- 1. The query selects all columns without filtering, causing large data transfer
-- 2. Multiple JOINs without proper indexing slow down the query
-- 3. No LIMIT clause means all rows are returned, which is inefficient
-- 4. Ordering the entire result set is resource-intensive
-- 5. Many columns are selected but may not be necessary for the application

-- Optimized Query with multiple improvements
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at,
    
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    
    addr.city,
    addr.country,
    
    pay.payment_id,
    pay.payment_method
FROM 
    "booking" b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    "property" p ON b.property_id = p.property_id AND p.price_per_night > 100  -- Added filtering condition with AND
JOIN 
    "user" host ON p.host_id = host.user_id AND host.role = 'host'  -- Added role filtering with AND
LEFT JOIN 
    "address" addr ON p.address_id = addr.address_id
LEFT JOIN 
    "payment" pay ON b.booking_id = pay.booking_id AND pay.payment_method = 'credit_card'  -- Added payment method filtering with AND
WHERE 
    b.created_at > '2024-01-01' AND  -- Date filter with AND operator
    b.status = 'confirmed'  -- Added status filter
ORDER BY 
    b.created_at DESC
LIMIT 100;  -- Limiting results for pagination
