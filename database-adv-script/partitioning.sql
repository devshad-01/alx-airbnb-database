-- partitioning.sql
-- Implementation of table partitioning for the Booking table based on start_date

-- ==============================================================
-- Original Table Structure (For Reference)
-- ==============================================================

-- The original booking table structure is:
-- CREATE TABLE booking (
--     booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--     property_id UUID NOT NULL REFERENCES property(property_id),
--     user_id UUID NOT NULL REFERENCES "user"(user_id),
--     start_date DATE NOT NULL,
--     end_date DATE NOT NULL,
--     total_price DECIMAL(10, 2) NOT NULL,
--     status_id UUID NOT NULL REFERENCES booking_status(status_id),
--     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
-- );

-- ==============================================================
-- Create Partitioned Table
-- ==============================================================

-- 1. Rename the original table to keep a backup
ALTER TABLE booking RENAME TO booking_old;

-- 2. Create the new partitioned table with the same structure
CREATE TABLE booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL REFERENCES property(property_id),
    user_id UUID NOT NULL REFERENCES "user"(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status_id UUID NOT NULL REFERENCES booking_status(status_id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 3. Create partitions by quarter for the current and next few years
-- Note: Adjust the date ranges as needed for your specific data distribution

-- Past years partition (for historical data)
CREATE TABLE booking_historical PARTITION OF booking
    FOR VALUES FROM (MINVALUE) TO ('2024-01-01');

-- 2024 partitions (by quarter)
CREATE TABLE booking_2024_q1 PARTITION OF booking
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE booking_2024_q2 PARTITION OF booking
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE booking_2024_q3 PARTITION OF booking
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE booking_2024_q4 PARTITION OF booking
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- 2025 partitions (by quarter)
CREATE TABLE booking_2025_q1 PARTITION OF booking
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE booking_2025_q2 PARTITION OF booking
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE booking_2025_q3 PARTITION OF booking
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

CREATE TABLE booking_2025_q4 PARTITION OF booking
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- Future years partition
CREATE TABLE booking_future PARTITION OF booking
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- ==============================================================
-- Transfer data from original table to partitioned table
-- ==============================================================

-- Move data from the old table to the new partitioned table
INSERT INTO booking
SELECT * FROM booking_old;

-- ==============================================================
-- Create indexes on partitioned table
-- ==============================================================

-- Create an index on the partitioning key
CREATE INDEX idx_booking_start_date ON booking (start_date);

-- Recreate other important indexes for the booking table
CREATE INDEX idx_booking_property ON booking (property_id);
CREATE INDEX idx_booking_user ON booking (user_id);
CREATE INDEX idx_booking_status ON booking (status_id);
CREATE INDEX idx_booking_dates ON booking (start_date, end_date);

-- ==============================================================
-- Performance Test Queries
-- ==============================================================

-- 1. Query for bookings in a specific date range (current quarter)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    p.name AS property_name
FROM 
    booking b
JOIN 
    property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2025-04-01' AND '2025-06-30'
ORDER BY 
    b.start_date;

-- 2. Query for bookings in a specific date range (across quarters)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    p.name AS property_name
FROM 
    booking b
JOIN 
    property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2024-12-01' AND '2025-02-28'
ORDER BY 
    b.start_date;

-- 3. Query for bookings in a date range (original table for comparison)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    p.name AS property_name
FROM 
    booking_old b
JOIN 
    property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2025-04-01' AND '2025-06-30'
ORDER BY 
    b.start_date;

-- ==============================================================
-- Cleanup (Comment out if you want to keep both versions)
-- ==============================================================

-- CAUTION: Only run after verifying the partitioned table works correctly
-- DROP TABLE booking_old;
