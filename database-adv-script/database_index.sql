-- database_index.sql
-- SQL commands to create indexes for optimizing the Airbnb database performance

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
