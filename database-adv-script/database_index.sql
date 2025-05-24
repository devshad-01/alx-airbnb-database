-- database_index.sql
-- SQL commands to create indexes for optimizing the Airbnb database performance

-- =================================================================
-- PERFORMANCE MEASUREMENT - BEFORE INDEXES
-- =================================================================

-- Measuring performance before adding indexes for Query 1 (Available properties in a date range)
EXPLAIN ANALYZE
SELECT p.property_id, p.name, p.price_per_night
FROM property p
WHERE p.property_id NOT IN (
    SELECT property_id
    FROM booking
    WHERE status_id = (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')
    AND (
        (start_date <= '2024-06-15' AND end_date >= '2024-06-10')
        OR
        (start_date >= '2024-06-10' AND start_date <= '2024-06-15')
    )
)
ORDER BY p.price_per_night ASC;

-- Measuring performance before adding indexes for Query 2 (Users with their booking counts)
EXPLAIN ANALYZE
SELECT u.user_id, up.first_name, up.last_name, COUNT(b.booking_id) as booking_count
FROM "user" u
JOIN user_profile up ON u.user_id = up.user_id
LEFT JOIN booking b ON u.user_id = b.user_id
WHERE u.role_id = (SELECT role_id FROM user_role WHERE role_name = 'guest')
GROUP BY u.user_id, up.first_name, up.last_name
ORDER BY booking_count DESC;

-- Measuring performance before adding indexes for Query 3 (Highest-rated properties in a price range)
EXPLAIN ANALYZE
SELECT p.property_id, p.name, a.city,
       AVG(r.rating) as avg_rating,
       COUNT(r.review_id) as review_count
FROM property p
JOIN address a ON p.address_id = a.address_id
LEFT JOIN review r ON p.property_id = r.property_id
WHERE p.price_per_night BETWEEN 100 AND 300
GROUP BY p.property_id, p.name, a.city
HAVING COUNT(r.review_id) > 0
ORDER BY avg_rating DESC, review_count DESC;

-- =================================================================
-- INDEXES FOR THE USER TABLE
-- =================================================================

-- Index on email for fast user lookup during login
-- This is a high-usage column in WHERE clauses
CREATE INDEX IF NOT EXISTS idx_user_email ON "user" (email);

-- Index on role_id for filtering users by role
-- Commonly used in WHERE clauses for access control
CREATE INDEX IF NOT EXISTS idx_user_role ON "user" (role_id);

-- Composite index for user creation date range queries
-- Useful for analytical queries about user registrations
CREATE INDEX IF NOT EXISTS idx_user_created_at ON "user" (created_at);

-- =================================================================
-- INDEXES FOR THE BOOKING TABLE
-- =================================================================

-- Index on property_id for fast property booking lookups
-- Property owners frequently check bookings for their properties
CREATE INDEX IF NOT EXISTS idx_booking_property ON booking (property_id);

-- Index on user_id for retrieving user's booking history
-- High-usage in user profile and dashboard queries
CREATE INDEX IF NOT EXISTS idx_booking_user ON booking (user_id);

-- Index on booking status for filtering bookings
-- Commonly used in WHERE clauses for booking management
CREATE INDEX IF NOT EXISTS idx_booking_status ON booking (status_id);

-- Composite index on booking dates
-- Critical for availability searches and date range queries
CREATE INDEX IF NOT EXISTS idx_booking_dates ON booking (start_date, end_date);

-- =================================================================
-- INDEXES FOR THE PROPERTY TABLE
-- =================================================================

-- Index on host_id for finding properties by host
-- Used when hosts manage their listings
CREATE INDEX IF NOT EXISTS idx_property_host ON property (host_id);

-- Index on price for filtering properties by price range
-- Very common in search queries with price filters
CREATE INDEX IF NOT EXISTS idx_property_price ON property (price_per_night);

-- Index on max_guests for filtering properties by capacity
-- Common filter in property search
CREATE INDEX IF NOT EXISTS idx_property_guests ON property (max_guests);

-- =================================================================
-- INDEXES FOR JOIN OPERATIONS
-- =================================================================

-- Index on address geography for spatial queries
-- Critical for location-based searches
CREATE INDEX IF NOT EXISTS idx_address_geog ON address USING GIST (geog);

-- Index on property features for amenity filtering
-- Improves performance of feature-based searches
CREATE INDEX IF NOT EXISTS idx_property_feature ON property_feature (property_id, feature_id);

-- Index on reviews for property rating calculations
-- Speeds up review aggregation queries
CREATE INDEX IF NOT EXISTS idx_review_property_rating ON review (property_id, rating);

-- =================================================================
-- INDEXES FOR AVAILABILITY SEARCHES
-- =================================================================

-- Index on availability calendar
-- Critical for checking property availability on specific dates
CREATE INDEX IF NOT EXISTS idx_availability_date ON availability (date);

-- Composite index for available properties on specific dates
-- Improves performance of availability search
CREATE INDEX IF NOT EXISTS idx_availability_status_date ON availability (property_id, date, is_available)
WHERE is_available = true;

-- =================================================================
-- INDEXES FOR MESSAGING SYSTEM
-- =================================================================

-- Index for fetching conversation messages
-- Improves performance of message loading
CREATE INDEX IF NOT EXISTS idx_message_conversation ON message (conversation_id);

-- Index for user message retrieval
-- For inbox/sent queries
CREATE INDEX IF NOT EXISTS idx_message_users ON message (sender_id, recipient_id);

-- Index for unread messages
-- Optimizes unread message count queries
CREATE INDEX IF NOT EXISTS idx_message_unread ON message (recipient_id, read_at)
WHERE read_at IS NULL;

-- =================================================================
-- PERFORMANCE MEASUREMENT - AFTER INDEXES
-- =================================================================

-- Measuring performance after adding indexes for Query 1 (Available properties in a date range)
EXPLAIN ANALYZE
SELECT p.property_id, p.name, p.price_per_night
FROM property p
WHERE p.property_id NOT IN (
    SELECT property_id
    FROM booking
    WHERE status_id = (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')
    AND (
        (start_date <= '2024-06-15' AND end_date >= '2024-06-10')
        OR
        (start_date >= '2024-06-10' AND start_date <= '2024-06-15')
    )
)
ORDER BY p.price_per_night ASC;

-- Measuring performance after adding indexes for Query 2 (Users with their booking counts)
EXPLAIN ANALYZE
SELECT u.user_id, up.first_name, up.last_name, COUNT(b.booking_id) as booking_count
FROM "user" u
JOIN user_profile up ON u.user_id = up.user_id
LEFT JOIN booking b ON u.user_id = b.user_id
WHERE u.role_id = (SELECT role_id FROM user_role WHERE role_name = 'guest')
GROUP BY u.user_id, up.first_name, up.last_name
ORDER BY booking_count DESC;

-- Measuring performance after adding indexes for Query 3 (Highest-rated properties in a price range)
EXPLAIN ANALYZE
SELECT p.property_id, p.name, a.city,
       AVG(r.rating) as avg_rating,
       COUNT(r.review_id) as review_count
FROM property p
JOIN address a ON p.address_id = a.address_id
LEFT JOIN review r ON p.property_id = r.property_id
WHERE p.price_per_night BETWEEN 100 AND 300
GROUP BY p.property_id, p.name, a.city
HAVING COUNT(r.review_id) > 0
ORDER BY avg_rating DESC, review_count DESC;
