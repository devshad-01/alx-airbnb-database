-- Partitioning for large Booking table in Airbnb Clone database
-- This script implements range partitioning based on the start_date column

-- First, we need to create a new partitioned table with the same structure as the original booking table
CREATE TABLE booking_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES "property"(property_id),
    user_id UUID NOT NULL REFERENCES "user"(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP NOT NULL
) PARTITION BY RANGE (start_date);

-- Create partitions by quarters to efficiently manage booking data
-- Past bookings - 2024 First Quarter (January-March)
CREATE TABLE booking_2024_q1 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

-- Past bookings - 2024 Second Quarter (April-June)
CREATE TABLE booking_2024_q2 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

-- Current bookings - 2024 Third Quarter (July-September)
CREATE TABLE booking_2024_q3 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

-- Current bookings - 2024 Fourth Quarter (October-December)
CREATE TABLE booking_2024_q4 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Future bookings - 2025 First Quarter (January-March)
CREATE TABLE booking_2025_q1 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

-- Future bookings - 2025 Second Quarter (April-June)
CREATE TABLE booking_2025_q2 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

-- Future bookings - 2025 Third Quarter (July-September)
CREATE TABLE booking_2025_q3 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

-- Future bookings - 2025 Fourth Quarter (October-December)
CREATE TABLE booking_2025_q4 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- Create a default partition for any bookings outside the defined ranges
CREATE TABLE booking_default PARTITION OF booking_partitioned DEFAULT;

-- Migrate data from the existing booking table to the partitioned one
INSERT INTO booking_partitioned SELECT * FROM booking;

-- Create the same indexes on the partitioned table as we had on the original
CREATE INDEX idx_booking_partitioned_property_id ON booking_partitioned (property_id);
CREATE INDEX idx_booking_partitioned_user_id ON booking_partitioned (user_id);
CREATE INDEX idx_booking_partitioned_status ON booking_partitioned (status);
CREATE INDEX idx_booking_partitioned_dates ON booking_partitioned (start_date, end_date);

-- If we want to replace the original table with the partitioned one, we can use:
-- BEGIN;
-- DROP TABLE booking CASCADE;
-- ALTER TABLE booking_partitioned RENAME TO booking;
-- COMMIT;

-- Performance testing queries for comparing partitioned vs non-partitioned tables

-- Test Query 1: Find all bookings for a specific date range
-- On original table
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date >= '2025-05-01' AND start_date < '2025-07-01';

-- On partitioned table
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date >= '2025-05-01' AND start_date < '2025-07-01';

-- Test Query 2: Count bookings by status for a specific quarter
-- On original table
EXPLAIN ANALYZE
SELECT status, COUNT(*) 
FROM booking
WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
GROUP BY status;

-- On partitioned table
EXPLAIN ANALYZE
SELECT status, COUNT(*) 
FROM booking_partitioned
WHERE start_date >= '2025-01-01' AND start_date < '2025-04-01'
GROUP BY status;

-- Test Query 3: Find all bookings for a specific property in a date range
-- On original table
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE property_id = 'pppppppp-1111-pppp-1111-pppppppppppp'
AND start_date >= '2025-04-01' AND start_date < '2025-10-01';

-- On partitioned table
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE property_id = 'pppppppp-1111-pppp-1111-pppppppppppp'
AND start_date >= '2025-04-01' AND start_date < '2025-10-01';

-- Test Query 4: Calculate occupancy rate by month for 2025
-- On original table
EXPLAIN ANALYZE
SELECT 
    EXTRACT(MONTH FROM start_date) AS month,
    COUNT(*) AS total_bookings
FROM booking
WHERE start_date >= '2025-01-01' AND start_date < '2026-01-01'
GROUP BY EXTRACT(MONTH FROM start_date)
ORDER BY month;

-- On partitioned table
EXPLAIN ANALYZE
SELECT 
    EXTRACT(MONTH FROM start_date) AS month,
    COUNT(*) AS total_bookings
FROM booking_partitioned
WHERE start_date >= '2025-01-01' AND start_date < '2026-01-01'
GROUP BY EXTRACT(MONTH FROM start_date)
ORDER BY month;