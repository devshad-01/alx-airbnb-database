-- Database Indexes for Airbnb Clone database
-- Creating indexes on columns frequently used in WHERE, JOIN, and ORDER BY clauses

-- User Table Indexes
-- Index on email for user lookup/authentication
CREATE INDEX idx_user_email ON "user" (email);
-- Index on role for filtering users by role
CREATE INDEX idx_user_role ON "user" (role);

-- Property Table Indexes
-- Index on host_id for filtering properties by host
CREATE INDEX idx_property_host_id ON "property" (host_id);
-- Index on price_per_night for range queries and sorting
CREATE INDEX idx_property_price ON "property" (price_per_night);
-- Index on created_at for sorting by newest properties
CREATE INDEX idx_property_created_at ON "property" (created_at);
-- Composite index for address_id which is used in JOINs
CREATE INDEX idx_property_address ON "property" (address_id);

-- Booking Table Indexes
-- Index on property_id for finding bookings for a specific property
CREATE INDEX idx_booking_property_id ON "booking" (property_id);
-- Index on user_id for finding bookings by user
CREATE INDEX idx_booking_user_id ON "booking" (user_id);
-- Index on status for filtering bookings by status
CREATE INDEX idx_booking_status ON "booking" (status);
-- Composite index on start_date and end_date for date range queries
CREATE INDEX idx_booking_dates ON "booking" (start_date, end_date);

-- Review Table Indexes
-- Index on property_id for finding reviews for a property
CREATE INDEX idx_review_property_id ON "review" (property_id);
-- Index on user_id for finding reviews by a user
CREATE INDEX idx_review_user_id ON "review" (user_id);
-- Index on rating for filtering by rating
CREATE INDEX idx_review_rating ON "review" (rating);

-- Message Table Indexes
-- Indexes for finding messages by sender or recipient
CREATE INDEX idx_message_sender_id ON "message" (sender_id);
CREATE INDEX idx_message_recipient_id ON "message" (recipient_id);
-- Index for finding unread messages
CREATE INDEX idx_message_read_at ON "message" (read_at);

-- Address Table Indexes
-- Indexes for geographic queries
CREATE INDEX idx_address_city ON "address" (city);
CREATE INDEX idx_address_country ON "address" (country);
-- Index for geospatial queries
CREATE INDEX idx_address_coordinates ON "address" (latitude, longitude);
