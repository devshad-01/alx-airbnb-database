-- Aggregations and Window Functions for Airbnb Clone database

-- Query to find the total number of bookings made by each user
SELECT u.user_id, u.first_name, u.last_name, u.email, COUNT(b.booking_id) AS total_bookings
FROM "user" u
    LEFT JOIN "booking" b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY total_bookings DESC;

-- Query to rank properties based on the total number of bookings they have received
SELECT
    p.property_id,
    p.name,
    p.price_per_night,
    COUNT(b.booking_id) AS booking_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_dense_rank
FROM "property" p
    LEFT JOIN "booking" b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.price_per_night
ORDER BY booking_count DESC, p.name;
